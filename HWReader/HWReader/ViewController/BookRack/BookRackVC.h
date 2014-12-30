//
//  BookRackVC.h
//  HWReader
//
//  Created by LPanda on 14-7-23.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableVC.h"
#import "PullDownNaviBar.h"

static const CGFloat  bookrackCellHeight = 90;

@interface BookRackVC : BaseTableVC

- (void)bookClick:(NSNotification *)notifi;

//- (void)pushNextVC;

@end
