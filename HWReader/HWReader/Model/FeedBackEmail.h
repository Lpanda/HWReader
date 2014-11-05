//
//  FeedBackEmail.h
//  HWReader
//
//  Created by LPanda on 14-9-10.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface FeedBackEmail : NSObject

@property (strong   ,nonatomic) User    *user;
@property (copy ,nonatomic) NSString *sendAddr;
@property (copy ,nonatomic) NSString *sendPwd;
@property (copy ,nonatomic) NSString *feedBackAddr;
@property (copy ,nonatomic) NSString *subject;
@property (copy ,nonatomic) NSString *content;

- (id)initWithContent:(NSString *)content Subject:(NSString *)subject;

@end
