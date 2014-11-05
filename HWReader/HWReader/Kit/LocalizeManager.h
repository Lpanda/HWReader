//
//  LocalizeManager.h
//  HWReader
//
//  Created by LPanda on 14-7-2.
//  Copyright (c) 2014年 huawei. All rights reserved.
//
//  本地化管理类，提供查看系统语言版本等功能

#import <Foundation/Foundation.h>

@interface LocalizeManager : NSObject

+ (NSString *)getCurrentSysLanguage;

@end
