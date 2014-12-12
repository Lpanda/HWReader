//
//  LoginRequest.h
//  HWReader
//
//  Created by zhaochao on 14-12-11.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#define  kUSER_ALREADY_LOGIN_MSG @"USER_ALREADY_LOGIN"
@interface LoginRequest : NSObject
@property (nonatomic, strong) NSDictionary *postForm;
@property (nonatomic, assign,getter = isSuccess) BOOL success;
-(void)loginAsync;
-(void)popLoginDlg;
@end
