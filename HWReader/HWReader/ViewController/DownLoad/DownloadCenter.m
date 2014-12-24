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

-(void)downloadFinished :(ASIHTTPRequest *)req
{
    //准备开始解压，解析出hhc，hhp写到书架上
    NSLog(@"download finished , file at: %@", req.downloadDestinationPath);
    NSLog(@"======unzipping======");
    
}

- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders {
    NSLog(@"didReceiveResponseHeaders-%@",[responseHeaders valueForKey:@"Content-Length"]);
    NSLog(@"%@", [responseHeaders valueForKey:@"Content-Disposition"] );
    NSLog(@"Content-Disposition: %@", [responseHeaders valueForKey:@"Content-Disposition"]);
    NSLog(@"contentlength=%f",request.contentLength/1024.0/1024.0);
    
}

@end
