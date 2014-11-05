//
//  ChmParser.h
//  HWReader
//
//  Created by LPanda on 14-7-3.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "DocParser.h"
#import "TFHpple.h"
#import "TFHppleElement.h"

//void getAllTreeNodes(NSMutableArray *result, TFHppleElement *node);


@interface ChmParser : DocParser

- (NSMutableArray *)getTFHppleElementInfo:(TFHppleElement*)tfEle;

- (NSString *)getTFHppleElementTitle:(TFHppleElement*)titleEle;

+ (void)getAllTreeNodesWithArr:(NSMutableArray *)result Root:(TFHppleElement *)node;

+ (void)testConstCharPtr:(NSString *)achar;

@end
