//
//  NaviBarFactory.m
//  HWReader
//
//  Created by LPanda on 14-7-22.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "NaviBarFactory.h"
#import "SegmentedNaviBar.h"
#import "PullDownNaviBar.h"
#import "NormalNaviBar.h"

@implementation NaviBarFactory

+(BaseNaviBar *)createBar:(BarStatus)status{
    
    BaseNaviBar *custormBar = [self createBar:status Delegate:nil];
    
    return custormBar;
}

+ (BaseNaviBar *)createBar:(BarStatus)status Delegate:(id)BarDelegate{
    
    BaseNaviBar *custormBar = nil;
    
    switch (status) {
        case Normal:{
            custormBar = [[NormalNaviBar alloc]init];
        }
            break;
            
        case PullDown:{
            custormBar = [[PullDownNaviBar alloc]init];
        }
            break;
            
        case Segmented:{
            custormBar= [[SegmentedNaviBar alloc]init];
        }
            break;
            
        default:
            break;
    }
    
    custormBar.NaviDelegate = BarDelegate;
    
    return custormBar;
}


@end
