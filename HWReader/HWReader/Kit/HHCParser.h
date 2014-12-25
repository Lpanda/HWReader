//
//  HHCParser.h
//  HWReader
//
//  Created by zhaochao on 14-12-25.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHCNode.h"

//只接受utf-8编码  
@interface HHCParser : NSObject
{
    xmlDoc * _xmlDoc;
}
@property (nonatomic, copy) HHCNode *hhcRoot;
-(id)initWithString:(NSString*)string error:(NSError**)error;
-(NSMutableArray*)getPreOrderTreeNodes;
@end
