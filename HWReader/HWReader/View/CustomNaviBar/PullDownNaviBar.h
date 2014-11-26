//
//  PullDownNaviBar.h
//  HWReader
//
//  Created by LPanda on 14-7-22.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "BaseNaviBar.h"


@interface PullDownNaviBar : BaseNaviBar

@property (strong,  nonatomic)  UIButton *pullDownBtn;
@property (strong,  nonatomic)  UIImageView *pullDownArrow;

- (void)setTitle:(NSString *)title;

@end
