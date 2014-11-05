//
//  FeedBackEmail.m
//  HWReader
//
//  Created by LPanda on 14-9-10.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "FeedBackEmail.h"

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
        self.sendAddr = [userDefaults objectForKey:@"sendAddr"];
        self.sendPwd = [userDefaults objectForKey:@"sendPwd"];
        self.feedBackAddr = [userDefaults objectForKey:@"feedBackAddr"];
        self.user = [[User alloc]init];
    }
    
    return self;
}

@end
