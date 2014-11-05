//
//  BaseVC.h
//  HWReader
//
//  Created by LPanda on 14-7-30.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNaviBar.h"

@interface BaseVC : UIViewController<NaviActionDelegate>{
    
}

- (void)drawTopNaviBar;

- (UITabBarItem *)createBarItemWithSelectedImg:(NSString *)selected
                                 UnSelectedImg:(NSString *)unSelected
                                           Tag:(NSInteger)tag;

- (void)drawBarItem;

@end
