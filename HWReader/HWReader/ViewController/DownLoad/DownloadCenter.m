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

- (void)addDownloadUrl:(NSString *)urlStr{
    NSString *fileName = [urlStr pathExtension];
    NSString *documentPath = [DocManager getDocumentPath];
    NSString *downloadPath = [NSString stringWithFormat:@"%@/%@",documentPath,fileName];
    NSString *tempPath = [NSString stringWithFormat:@"%@/temp/%@",documentPath,fileName];
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:urlStr]];
    request.delegate = self;
    [request setDownloadDestinationPath:downloadPath];
    [request setTemporaryFileDownloadPath:tempPath];
    [request setDownloadProgressDelegate:self];
    [request setNumberOfTimesToRetryOnTimeout:2];
    [request setAllowResumeForFileDownloads:YES];//支持断点续传
    
    [_downloadQueue addOperation:request];
    [_downloadingList addObject:request];
}

- (void)start{
    [_downloadQueue go];
}

- (void)stop:(ASIHTTPRequest *)request{
    [request cancel];
}

@end
