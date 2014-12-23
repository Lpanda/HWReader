//
//  LoginRequest.m
//  HWReader
//
//  Created by zhaochao on 14-12-11.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "LoginRequest.h"
#import "ASIFormDataRequest.h"

#define kLOGIN_USERNAME_KEY @"uid"
#define kLOGIN_PASSWORD_KEY @"password"
#define kLOGIN_URL @"https://uniportal.huawei.com/uniportal/login.do"



//actionFlag:loginAuthenticate
//lang:en
//redirect:http://support.huawei.com/support/index.jsp?isFirstLogin=true
//redirect_local:
//redirect_modify:
//uid:zwx164408
//password:zc_123654@@@

@interface LoginRequest()<UIAlertViewDelegate>
{
    ASIFormDataRequest* _loginRequest;
    NSMutableDictionary *_supportLoginDicForm;
    UIActivityIndicatorView *_activitor;

}
@end

@implementation LoginRequest

-(BOOL)isSuccess
{
    return _success;
}

-(id)init
{
    self = [super init];
    if (self) {
        
        _loginRequest = [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:kLOGIN_URL]];
        _loginRequest.delegate = self;
        [_loginRequest setDidFinishSelector:@selector(requestFinish:)];
        [_loginRequest setDidFailSelector:@selector(requestFailed:)];
        _supportLoginDicForm = [NSMutableDictionary dictionaryWithDictionary:
                                @{kLOGIN_USERNAME_KEY : @"" ,
                                  kLOGIN_PASSWORD_KEY : @"",
                                  @"lang": @"en",
                                  @"actionFlag": @"loginAuthenticate",
                                  @"redirect": @"http://support.huawei.com/support/index.jsp?isFirstLogin=true",
                                  @"redirect_modify": @"",
                                  @"redirect_local": @""}];


        
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
    NSLog(@"%d", [request responseStatusCode]);
    NSLog(@"%@", [request responseString]);
    if (200 == [request responseStatusCode]) {
        NSArray *arr = [request responseCookies];
        for (NSHTTPCookie*cookie in arr) {
            NSDictionary *cookieDic = [cookie properties];
            NSString *name = cookieDic[@"Name"];
            NSString *value = cookieDic[@"Value"];
            if ([name isEqualToString:@"logFlag"]
                && [value isEqualToString:@"in"]) {
                _success = YES;
                [[NSNotificationCenter defaultCenter] postNotificationName:kUSER_ALREADY_LOGIN_MSG object:nil];
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


-(void)askUserToLogin
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录" message:@"下载需要登录support"
                                       delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (0 == buttonIndex) {  //取消按钮
        return;
    }
    UITextField *username = [alertView textFieldAtIndex:0];
    UITextField *password = [alertView textFieldAtIndex:1];
    if (![username.text isEmptyOrNull]
        && ![password.text isEmptyOrNull]) {
        NSLog(@"username: %@, password : %@", username.text, password.text);
        [_supportLoginDicForm setValue:username.text forKey:kLOGIN_USERNAME_KEY];
        [_supportLoginDicForm setValue:password.text forKey:kLOGIN_PASSWORD_KEY];
        self.postForm = _supportLoginDicForm;
        [self loginAsync];
    }
}

@end
