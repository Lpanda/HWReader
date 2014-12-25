//
//  HHCNode.m
//  HWReader
//
//  Created by zhaochao on 14-12-25.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "HHCNode.h"

@implementation HHCNode
@synthesize name;
@synthesize localHref;
@synthesize children;

-(id)initWithXmlNode:(xmlNode* ) node
{
    self = [super init];
    if (self) {
        _depth = 0;
        _xmlnode = node;
        children = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
