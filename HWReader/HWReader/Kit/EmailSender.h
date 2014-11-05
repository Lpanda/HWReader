//
//  EmailSender.h
//  HWReader
//
//  Created by LPanda on 14-9-10.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKPSMTPMessage.h"
#import "FeedBackEmail.h"

@interface EmailSender : NSObject

+ (BOOL)sendMail:(FeedBackEmail *)mail Delegate:(id)delegate;

@end
