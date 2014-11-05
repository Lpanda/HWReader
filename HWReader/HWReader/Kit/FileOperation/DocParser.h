//
//  DocParser.h
//  HWReader
//
//  Created by LPanda on 14-7-3.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DocManager.h"

@interface DocParser : NSObject

- (NSMutableArray *)getAllFilesByType:(NSString *)type;

- (NSMutableDictionary *)parseFile;

@end
