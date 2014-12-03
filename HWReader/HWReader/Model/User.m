//
//  User.m
//  HWReader
//
//  Created by LPanda on 14-9-10.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "User.h"

#define USERRECEIVEADDR @"userReceiveAddr"
#define USERNICKNAME    @"userNickName"

@implementation User

@synthesize nickName;
@synthesize receiveAddr;

-(id)init{
    
    if (self = [super init]) {
        self.nickName = [[NSUserDefaults standardUserDefaults]objectForKey:USERNICKNAME];
        self.receiveAddr = [[NSUserDefaults standardUserDefaults]objectForKey:USERRECEIVEADDR];
    }
    
    return self;
}

@end
