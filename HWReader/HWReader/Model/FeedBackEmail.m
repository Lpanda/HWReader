//
//  FeedBackEmail.m
//  HWReader
//
//  Created by LPanda on 14-9-10.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "FeedBackEmail.h"

#define SEND_ADDR    @"sendAddr"
#define SEND_PWD @"sendPwd"
#define FEEDBACK_ADDR    @"feedBackAddr"

@implementation FeedBackEmail

@synthesize user;
@synthesize sendAddr;
@synthesize sendPwd;
@synthesize feedBackAddr;
@synthesize subject = _subject;
@synthesize content = _content;

-(id)initWithContent:(NSString *)content Subject:(NSString *)subject{
    if (self = [super init]) {
        
        _content = content;
        _subject = subject;
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        self.sendAddr = [userDefaults objectForKey:SEND_ADDR];
        self.sendPwd = [userDefaults objectForKey:SEND_PWD];
        self.feedBackAddr = [userDefaults objectForKey:FEEDBACK_ADDR];
        self.user = [[User alloc]init];
    }
    
    return self;
}

@end
