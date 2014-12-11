//
//  LoginRequest.m
//  HWReader
//
//  Created by zhaochao on 14-12-11.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "LoginRequest.h"
#import "ASIFormDataRequest.h"

@interface LoginRequest()
{
    ASIFormDataRequest* _loginRequest;
}
@end

@implementation LoginRequest

-(BOOL)isSuccess
{
    return _success;
}

-(id)initWithUrl:(NSURL*) url
{
    self = [super init];
    if (self) {
        _loginRequest = [[ASIFormDataRequest alloc] initWithURL:url];
        _loginRequest.delegate = self;
        [_loginRequest setDidFinishSelector:@selector(requestFinish:)];
        [_loginRequest setDidFailSelector:@selector(requestFailed:)];
    }
    return self;
}

-(void)setPostForm:(NSDictionary *)postForm
{
    _postForm = postForm;
    [postForm enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [_loginRequest setPostValue: postForm[key] forKey:key];
    }];
}


-(void)loginAsync
{
    [ASIFormDataRequest setSessionCookies:nil];
    [_loginRequest startAsynchronous];
}


-(void)requestFinish:(ASIHTTPRequest *)request
{
    if (200 == [request responseStatusCode]) {
        NSArray *arr = [request responseCookies];
        NSLog(@"%@", arr);
        for (NSHTTPCookie*cookie in arr) {
            NSDictionary *cookieDic = [cookie properties];
            NSString *name = cookieDic[@"Name"];
            NSString *value = cookieDic[@"Value"];
            if ([name isEqualToString:@"logFlag"]
                && [value isEqualToString:@"in"]) {
                _success = YES;
                break;
            }
        }
    }
    if (!_success) {
        [self requestFailed:request];
    }
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"%@", [request responseString]);
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录失败" message:@"请重新登录" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    });
    _success = NO;
}

@end
