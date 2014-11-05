//
//  BaseTableVC.h
//  HWReader
//
//  Created by LPanda on 14-8-7.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "BaseVC.h"

@interface BaseTableVC : BaseVC<UITableViewDataSource,UITableViewDelegate>

@property (strong,  nonatomic)  UITableView *tableView;
@property (strong,  nonatomic)  NSMutableArray  *tableSource;
@property (assign,  nonatomic)  BOOL canLoadRefresh;

- (CGRect)setTableViewRect;

- (UITableViewStyle)setTableViewStyle;

@end
