//
//  DownloadCenter.h
//  HWReader
//
//  Created by LPanda on 14-12-2.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"

@interface DownloadCenter : NSObject<ASIHTTPRequestDelegate>{
}

@property (strong,  nonatomic) ASINetworkQueue *downloadQueue;
@property (strong,  nonatomic) NSMutableArray *downloadingList;
@property (strong,  nonatomic) NSMutableArray *finishedList;

+ (DownloadCenter *)getInstance;

//- (void)addDownloadUrl:(NSString *)urlStr;

- (void)start;

- (void)stop:(ASIHTTPRequest *)request;

- (ASIHTTPRequest *)createRequestWithTaskDic:(NSDictionary *)taskDic;
-(void)addDownloadRequest: (ASIHTTPRequest *)reqeust;
@end
