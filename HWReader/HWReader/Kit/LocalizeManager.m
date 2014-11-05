//
//  LocalizeManager.m
//  HWReader
//
//  Created by LPanda on 14-7-2.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "LocalizeManager.h"

@implementation LocalizeManager

+ (NSString *)getCurrentSysLanguage{
    
    NSArray *languages = [NSLocale preferredLanguages];
    
    NSString *currentLanguage = [languages firstObject];
    
    return currentLanguage;
    
}

@end
