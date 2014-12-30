//
//  DownloadCenter.m
//  HWReader
//
//  Created by LPanda on 14-12-2.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "DownloadCenter.h"
#import "DocManager.h"
static DownloadCenter *downloadCenter = nil;

@implementation DownloadCenter

@synthesize downloadQueue = _downloadQueue;
@synthesize downloadingList = _downloadingList;
@synthesize finishedList = _finishedList;

-(instancetype)init{
    if (self = [super init]) {
        _finishedList = [[NSMutableArray alloc]init];
        _downloadingList = [[NSMutableArray alloc]init];
        _downloadQueue = [[ASINetworkQueue alloc]init];
        _downloadQueue.maxConcurrentOperationCount = 5;
        [_downloadQueue setShowAccurateProgress:YES]; // 进度精确显示
    }
    
    return self;
}

+ (DownloadCenter *)getInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        downloadCenter = [[DownloadCenter alloc]init];
    });
    
    return downloadCenter;
}

- (ASIHTTPRequest *)createRequestWithTaskDic:(NSDictionary *)taskDic{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSLog(@"document path: %@", path);
    //下载路径
    NSString *bookName = taskDic[@"name"];
    NSString *downloadPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.zip",bookName]];
    NSString *tmpName = [NSString  stringWithFormat:@"tmp%@.zip",bookName];
    //要支持断点续传，缓存路径是不能少的。
    
    NSString *tempPath = [path stringByAppendingPathComponent:tmpName];
    
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:taskDic[@"url"]]];
    request.delegate = self;
    request.showAccurateProgress = YES;
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    [request setDownloadDestinationPath:downloadPath];
    [request setTemporaryFileDownloadPath:tempPath];
    [request setDidFinishSelector:@selector(downloadFinished:)];
    [request setDidStartSelector:@selector(downloadStart:)];
    [request setDownloadProgressDelegate:self];
    [request setNumberOfTimesToRetryOnTimeout:2];
    [request setShouldContinueWhenAppEntersBackground:YES];
    [request setAllowResumeForFileDownloads:YES];//支持断点续传
    
    return request;
}


-(void)addDownloadRequest: (ASIHTTPRequest *)reqeust
{
    [_downloadQueue addOperation:reqeust];
    [_downloadingList addObject:reqeust];
}


- (void)start{
    [_downloadQueue go];
}

- (void)stop:(ASIHTTPRequest *)request{
    [request cancel];
}

-(void)downloadStart: (ASIHTTPRequest*)req
{
    NSLog(@"down load start, destinationPath : %@\n tmpPath: %@",
          req.downloadDestinationPath, req.temporaryFileDownloadPath);
}





+ (NSData *) toUTF8:(NSData *)sourceData
{
    CFStringRef gbkStr = CFStringCreateWithBytes(NULL, [sourceData bytes], [sourceData length], kCFStringEncodingGB_18030_2000, false);
    
    if (gbkStr == NULL) {
        NSLog(@"GBK is null");
        return nil;
    }
    else
    {
        NSString *gbkString = (__bridge NSString *)gbkStr;
        
        NSString *utf8_string = [gbkString
                                 stringByReplacingOccurrencesOfString:@"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=gb2312\">"
                                 withString:@"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">"];
        
        return [utf8_string dataUsingEncoding:NSUTF8StringEncoding];
        
    }
}


-(void)TestWritePlist
{
    NSString* unzipPath = @"/Users/zhaochao/Library/Application Support/iPhone Simulator/7.0.3-64/Applications/A40BE93B-A8A9-47C7-BDA7-7F31809A071A/Documents/unZipFiles/BSC6900 UMTS 产品文档 V900R015C00/bsc6900-documents--new-15.0-ZH-app";
    
    NSLog(@"unzip done, the unzippath is : %@", unzipPath);
    NSString *hhcPath = [DocManager findFileInFloder:unzipPath withExtention:@"hhc"];
    NSString *absHHCPath = [unzipPath stringByAppendingPathComponent:hhcPath];
    NSLog(@"unzip  done , the abshhc file path: %@", absHHCPath);
    NSString *hhpPath = [DocManager findFileInFloder:unzipPath withExtention:@"hhp"];
    NSString *absHHPPath = [unzipPath stringByAppendingPathComponent:hhpPath];
    NSString *hhcBookName = [self getHHPBookName:absHHPPath];
    
    NSMutableArray *localBooks = [DocManager getLocalBooks];
    [localBooks addObject:@{@"bookName" : hhcBookName,
                            @"bookPath" : absHHCPath}];
    [DocManager writeToLocalBooks:localBooks];
    
}

-(NSString*) getHHPBookName :(NSString*) hhpPath
{
    NSString *hhcBookName = @"No Name";
    NSData *asciiData = [NSData dataWithContentsOfFile:hhpPath];
    NSString *utf8String = [[NSString alloc] initWithData: [DownloadCenter toUTF8:asciiData] encoding:NSUTF8StringEncoding];

    NSRange rng = [utf8String rangeOfString:@"Title=" options:NSCaseInsensitiveSearch];
    if (rng.length) {
        NSRange crRng = rng;
        crRng.length = 200;
        crRng = [utf8String rangeOfString:@"\r\n" options:NSLiteralSearch range:crRng];
        NSRange bookNameRng = NSMakeRange(rng.location+rng.length, crRng.location -( rng.location+rng.length ));
        hhcBookName = [utf8String substringWithRange:bookNameRng];
        NSLog(@"%@", hhcBookName);
        NSLog(@"get the book name is : %@", hhcBookName);
    }
    return hhcBookName;
}

-(void)downloadFinished :(ASIHTTPRequest *)req
{
    //准备开始解压，解析出hhc，hhp写到书架上, 解压操作耗时长，开异步
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"download finished , file at: %@", req.downloadDestinationPath);
        NSLog(@"======unzipping======");
        NSString* unzipPath = [DocManager unzipFileToDefaulfFloder:req.downloadDestinationPath];
        
        NSLog(@"unzip done, the unzippath is : %@", unzipPath);
        NSString *hhcPath = [DocManager findFileInFloder:unzipPath withExtention:@"hhc"];
        NSString *absHHCPath = [unzipPath stringByAppendingPathComponent:hhcPath];
        NSLog(@"unzip  done , the abshhc file path: %@", absHHCPath);
        NSString *hhpPath = [DocManager findFileInFloder:unzipPath withExtention:@"hhp"];
        NSString *absHHPPath = [unzipPath stringByAppendingPathComponent:hhpPath];
        NSString *hhcBookName = [self getHHPBookName:absHHPPath];
        
        NSMutableArray *localBooks = [DocManager getLocalBooks];
        [localBooks addObject:@{@"bookName" : hhcBookName,
                                @"bookPath" : absHHCPath}];
        [DocManager writeToLocalBooks:localBooks];
        //todo:通知书架重画
    });
}

- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders {
    NSLog(@"didReceiveResponseHeaders-%@",[responseHeaders valueForKey:@"Content-Length"]);
    NSLog(@"%@", [responseHeaders valueForKey:@"Content-Disposition"] );
    NSLog(@"Content-Disposition: %@", [responseHeaders valueForKey:@"Content-Disposition"]);
    NSLog(@"大小=%f M",request.contentLength/1024.0/1024.0);
}

@end
