//
//  EmailSender.m
//  HWReader
//
//  Created by LPanda on 14-9-10.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "EmailSender.h"


//sendto  wirelessdoc@huawei.com

@implementation EmailSender

+(BOOL)sendMail:(FeedBackEmail *)mail Delegate:(id)delegate{
    
    SKPSMTPMessage *smtpMessage = [[SKPSMTPMessage alloc]init];
    smtpMessage.login = mail.sendAddr;
    smtpMessage.pass = mail.sendPwd;
    smtpMessage.fromEmail = mail.sendAddr;
    smtpMessage.toEmail = mail.feedBackAddr;
    smtpMessage.subject = mail.subject;
    smtpMessage.ccEmail = mail.user.receiveAddr;
    NSDictionary *plainPart = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"text/plain; charset=UTF-8",kSKPSMTPPartContentTypeKey,
                              mail.content,kSKPSMTPPartMessageKey,
                               @"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
    smtpMessage.parts = @[plainPart];
    smtpMessage.relayHost = @"smtp.163.com";
    smtpMessage.requiresAuth = YES;
    smtpMessage.wantsSecure = YES;
    smtpMessage.delegate = delegate;
    return [smtpMessage send];
}


@end
