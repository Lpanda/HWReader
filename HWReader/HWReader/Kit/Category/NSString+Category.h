//
//  NSString+Category.h
//  HWReader
//
//  Created by LPanda on 14-9-11.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5String)

- (NSString *)md5String;

@end

@interface NSString (isEmptyOrNull)

- (BOOL)isEmptyOrNull;

@end
