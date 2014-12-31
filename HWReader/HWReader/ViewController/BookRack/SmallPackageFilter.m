//
//  SmallPackageFilter.m
//  HWReader
//
//  Created by zhaochao on 14-12-31.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "SmallPackageFilter.h"
#import "HHCNode.h"
@implementation SmallPackageFilter

//小包的判断规则：
//1.包含 "变更说明"的父节点
//2.包含如下关键字的节点
//      告警参考, 事件参考,MML命令参考,BSC6900 产品概述,BSC6910 产品概述,BSC6900 Product Description
//      BSC6910 Product Description  ,性能指标参考,参数参考 , EBC参考,MO参考,MO和参数参考
//      Alarm Reference ,Event Reference,MML Reference,Performance Counter Reference
//      EBC Reference,MO Reference,MO and Parameter Reference



+(BOOL)isSmallPackage:(HHCNode*) node
{
    NSAssert(node, @"hhcnode can't be nil");
    if ([node.children count]) {
        HHCNode* firstChild = node.children[0];
        if ([firstChild.name rangeOfString:@"变更说明" options: NSCaseInsensitiveSearch ].length) {
            return YES;
        }
    }

    NSArray *KEY_WORDS = @[@"告警参考", @"事件参考",@"MML命令参考",@"BSC6900 产品概述",@"BSC6910 产品概述",@"BSC6900 Product Description",@"BSC6910 Product Description"  ,@"性能指标参考",@"参数参考" , @"EBC参考",@"MO参考",@"MO和参数参考",@"Alarm Reference",@"Event Reference",@"MML Reference",@"Performance Counter Reference",@"EBC Reference",@"MO Reference",@"MO and Parameter Reference"];
    for (NSString*keyword in KEY_WORDS) {
        if ([node.children count] > 0
            && [node.name rangeOfString:keyword options:NSCaseInsensitiveSearch].length) {
            return YES;
        }
    }
    return NO;
}
+(NSMutableArray*)getOutlineNodes:(HHCNode*)root
{
    NSMutableArray *smallPackages = [[NSMutableArray alloc] init];
    [SmallPackageFilter getSmallPackagesNodeUnderRoot:root writeToResult:smallPackages];
    //父节点添上去
    NSMutableOrderedSet *outlineNodes = [[NSMutableOrderedSet alloc] init];
    [self addParents:outlineNodes withSmallPacages:smallPackages];
    NSMutableArray *res = [NSMutableArray arrayWithArray:[outlineNodes array]];
    return   res;
}

+(void)getSmallPackagesNodeUnderRoot: (HHCNode*) root writeToResult:(NSMutableArray*) res
{
    if ([SmallPackageFilter isSmallPackage:root]) {
        [res addObject:root];
    }
    for (HHCNode *child in root.children) {
        [SmallPackageFilter getSmallPackagesNodeUnderRoot:child writeToResult:res];
    }
}

+(void)addParents:(NSMutableOrderedSet*)nodes withSmallPacages:(NSMutableArray*)smallpacages
{
    for (__strong HHCNode *hhcChild in smallpacages) {
        //从自己一直到根节点经过的节点  不包括根节点
        NSMutableArray *toRootNodes = [[NSMutableArray alloc] init];
        while (hhcChild->parent) {
            [toRootNodes addObject:hhcChild];
            hhcChild = hhcChild->parent;
        }
        [toRootNodes removeObjectAtIndex:0]; //删掉自己
        //逆序插入orderedset 自动去掉重复的
        NSEnumerator *iter = [toRootNodes reverseObjectEnumerator];
        id node;
        while (node = [iter nextObject]) {
            [nodes addObject:node];
        }
    }
}
@end
