//
//  NaviBarFactory.h
//  HWReader
//
//  Created by LPanda on 14-7-22.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseNaviBar.h"

typedef enum {
    Normal,
    PullDown,
    Segmented
}BarStatus;

@interface NaviBarFactory : NSObject{
    BarStatus   barStatus;
}

+ (BaseNaviBar *)createBar:(BarStatus)status;

+ (BaseNaviBar *)createBar:(BarStatus)status Delegate:(id)BarDelegate;

@end
