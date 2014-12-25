//
//  HHCNode.h
//  HWReader
//
//  Created by zhaochao on 14-12-25.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libxml/HTMLparser.h>
#import <libxml/HTMLtree.h>

@interface HHCNode : NSObject
{
    @public
    xmlNode *_xmlnode;
    HHCNode *preSibling;
    HHCNode *nextSibling;
    HHCNode *parent;
}
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *localHref;
@property (nonatomic, copy) NSMutableArray *children;
@property (nonatomic, assign) int depth;
-(id)initWithXmlNode:(xmlNode* ) node;
@end
