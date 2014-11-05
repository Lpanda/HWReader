//
//  UIViewController+ViewControllerCategory.h
//  HWReader
//
//  Created by LPanda on 14-6-30.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NaviBarFactory.h"


@interface UIViewController (ViewControllerCategory)

- (void)changeLayout;       //  改变布局

- (void)closeAdjustScrollViewInsets;        //  ios7中关闭scrollView自动适配

- (void)applicationCanRotation:(BOOL)enabled;

@end
