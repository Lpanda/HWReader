//
//  SmallPackageFilter.h
//  HWReader
//
//  Created by zhaochao on 14-12-31.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHCNode.h"
@interface SmallPackageFilter : NSObject
+(BOOL)isSmallPackage:(HHCNode*) node;
+(NSMutableArray*)getOutlineNodes:(HHCNode*)root;
@end
