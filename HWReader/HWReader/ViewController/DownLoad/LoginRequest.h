//
//  LoginRequest.h
//  HWReader
//
//  Created by zhaochao on 14-12-11.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginRequest : NSObject
@property (nonatomic, strong) NSDictionary *postForm;
@property (nonatomic, assign,getter = isSuccess) BOOL success;
-(void)loginAsync;
-(id)initWithUrl:(NSURL*) url;
@end
