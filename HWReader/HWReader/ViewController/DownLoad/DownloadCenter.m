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
        _downloadQueue.maxConcurrentOperationCount = 1;
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

- (ASIHTTPRequest *)createRequestWithUrl:(NSString *)urlStr{
    NSString *fileName =@"test.zip";
    NSString *documentPath = [DocManager getDocumentPath];
    NSString *downloadDestinationPath = [NSString stringWithFormat:@"%@/%@",documentPath,fileName];
    //NSString *temporaryFileDownloadPath = [NSString stringWithFormat:@"%@/temp/%@",documentPath,fileName];
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:urlStr]];
    request.delegate = self;
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    [request setDownloadDestinationPath:downloadDestinationPath];
    //[request setTemporaryFileDownloadPath:temporaryFileDownloadPath];
    [request setDidFinishSelector:@selector(downloadFinished:)];
    [request setDownloadProgressDelegate:self];
    [request setNumberOfTimesToRetryOnTimeout:2];
    [request setShouldContinueWhenAppEntersBackground:YES];
    [request setAllowResumeForFileDownloads:YES];//支持断点续传
    
    return request;
}

- (void)addDownloadUrl:(NSString *)urlStr{
    ASIHTTPRequest *request = [self createRequestWithUrl:urlStr];
    
    [_downloadQueue addOperation:request];
    [_downloadingList addObject:request];
}

- (void)start{
    [_downloadQueue go];
}

- (void)stop:(ASIHTTPRequest *)request{
    [request cancel];
}

-(void)downloadFinished :(ASIHTTPRequest *)req
{
    NSLog(@"%@", req.downloadDestinationPath);
}

- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders {
    NSLog(@"didReceiveResponseHeaders-%@",[responseHeaders valueForKey:@"Content-Length"]);
    NSLog(@"%@", [responseHeaders valueForKey:@"Content-Disposition"] );
    NSLog(@"Content-Disposition: %@", [responseHeaders valueForKey:@"Content-Disposition"]);
    NSLog(@"contentlength=%f",request.contentLength/1024.0/1024.0);
    
}

@end
