//
//  SegmentedNaviBar.h
//  HWReader
//
//  Created by LPanda on 14-7-23.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "BaseNaviBar.h"

@interface SegmentedNaviBar : BaseNaviBar{
    UIButton *segmentedBtn[2];
}

@property (strong,  nonatomic) UISegmentedControl   *segmentedControl;

- (id)initWithDelegate:(id)delegate HideBtn:(TopBtnHideStyle)hideStyle Segments:(NSArray *)segMents;

- (void)setDefaultIndex:(int)index;

@end
