//
//  UIViewController+ViewControllerCategory.m
//  HWReader
//
//  Created by LPanda on 14-6-30.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "UIViewController+ViewControllerCategory.h"
#import "AppDelegate.h"

@implementation UIViewController (ViewControllerCategory)

- (void)changeLayout{
    
}

- (void)closeAdjustScrollViewInsets{
    if (IOS_7) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

-(void)applicationCanRotation:(BOOL)enabled{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.isRotationEnabled = enabled;
}

@end
