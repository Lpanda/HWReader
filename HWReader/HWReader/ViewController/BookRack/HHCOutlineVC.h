//
//  HHCOutlineVC.h
//  HWReader
//
//  Created by zhaochao on 14-12-30.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DDMenuController;
#define CLICK_ON_OUTLINE_NODE @"CLICK_ON_OUTLINE_NODE"

@interface HHCOutlineVC : UITableViewController
@property(nonatomic ,copy) NSMutableArray *hhcNodes;
@property(nonatomic, weak) DDMenuController *menu;
@end
