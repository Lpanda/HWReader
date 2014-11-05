//
//  ChmParser.m
//  HWReader
//
//  Created by LPanda on 14-7-3.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "ChmParser.h"
#import "DocManager.h"
#import "TFHpple.h"
#import "TFHppleElement.h"

#define HHCEX    @"hhc"
#define ULElEMENT_INDEX  IOS_7 ? 1 : 0

//void getAllTreeNodes(NSMutableArray *result, TFHppleElement *node)
//{
//    [result addObject:node];
//    NSArray *children = [node children];
//    for (TFHppleElement* child in children) {
//        
//        getAllTreeNodes(result, child);
//    }
//}

@implementation ChmParser

+(void)testConstCharPtr:(NSString *)achar{
    const char *ktr = [achar UTF8String];
    printf("%s",ktr);
}

+(void)getAllTreeNodesWithArr:(NSMutableArray *)result Root:(TFHppleElement *)node{
    [result addObject:node];
    NSArray *children = [node children];
    for (TFHppleElement* child in children) {
        [[self class] getAllTreeNodesWithArr:result Root:child];
    }
}

#pragma mark 解析文件
-(NSMutableDictionary *)parseFile{
   
    NSArray *hhcPaths = [self getAllFilesByType:HHCEX];
    
    NSMutableDictionary *firstMenuDic = [[NSMutableDictionary alloc]init];
    
    NSMutableArray *infos = [[NSMutableArray alloc]init];
    
    NSMutableArray *infoTitles = [[NSMutableArray alloc]init];
    
    for (NSString *currentPath in hhcPaths) {
        
        NSData *hhcData = [NSData dataWithContentsOfFile:currentPath];
        
        //  解析hhc，分出层次结构
        TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:hhcData];
        
        NSArray *ulTFs = [xpathParser searchWithXPathQuery:@"//ul"];
        
        TFHppleElement *first = [ulTFs firstObject];
        
        TFHppleElement *ulEle = [first.children objectAtIndex: ULElEMENT_INDEX];
        
        NSArray *firstChilds = ulEle.children;
        
        TFHppleElement *titleEle = [firstChilds firstObject];
        
        TFHppleElement *attributesEle = [firstChilds objectAtIndex:1];
        
        [infos addObject:[self getTFHppleElementInfo:attributesEle]];
        
        [infoTitles addObject:[self getTFHppleElementTitle:titleEle]];
        
    }
    
    [firstMenuDic setObject:infoTitles forKey:@"titles"];
    
    [firstMenuDic setObject:infos forKey:@"infos"];
    
    return firstMenuDic;
    
}

#pragma mark 解析某个节点
- (NSMutableArray *)getTFHppleElementInfo:(TFHppleElement *)tfEle{
    
    NSMutableArray *infos = [[NSMutableArray alloc]init];
    
    NSArray *childArr = tfEle.children;
    
    for (int i = 0; i != [childArr count]; ++ i) {
        
        TFHppleElement *firstEle = [childArr objectAtIndex:i];
        
        if (![firstEle isTextNode]) {
            
            TFHppleElement *firstChild = [firstEle.children firstObject];
            
            NSMutableArray *contents = [[NSMutableArray alloc]init];
            
            for (int j = 0; j != [firstChild.children count]; ++ j) {
                
                    TFHppleElement *nodeEle = [firstChild.children objectAtIndex:j];
                
                if (![nodeEle isTextNode]) {
                    NSDictionary *nodeEleDic = nodeEle.attributes;
                    [contents addObject:[nodeEleDic objectForKey:@"value"]];
                }
                
            }

            TFHppleElement *subEle = [firstEle.children objectAtIndex:1];
            
                if (![subEle isTextNode]) {
                    [contents addObject:subEle];
                }
            
            [infos addObject:contents];
            
        }
        
    }
    
    return infos;
    
}

- (NSString *)getTFHppleElementTitle:(TFHppleElement *)titleEle{
    
     TFHppleElement *titleSubEle = [titleEle.children firstObject];
    
    return [titleSubEle.attributes objectForKey:@"value"];
    
}

@end
