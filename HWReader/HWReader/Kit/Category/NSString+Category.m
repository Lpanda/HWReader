//
//  NSString+Category.m
//  HWReader
//
//  Created by LPanda on 14-9-11.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "NSString+Category.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5String)

#define RESULT_INDEX 16

-(NSString *)md5String{
    const char *cStr = [self UTF8String];
    
    unsigned char result[RESULT_INDEX];
    
    CC_MD5( cStr, strlen(cStr), result ); // This is the md5 call
    
    return [NSString stringWithFormat:
             
             @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
             
             result[0], result[1], result[2], result[3],
             
             result[4], result[5], result[6], result[7],
             
             result[8], result[9], result[10], result[11],
             
             result[12], result[13], result[14], result[15]
             
             ];
}

@end

@implementation NSString (isEmptyOrNull)

-(BOOL)isEmptyOrNull{
    
    NSString *trimed = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (!self || trimed.length == 0) {
        return YES;
    }
    
    return NO;
    
}

@end

