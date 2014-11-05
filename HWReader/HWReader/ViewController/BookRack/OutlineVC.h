//
//  OutlineVC.h
//  HWReader
//
//  Created by LPanda on 14-6-30.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OutlineVC : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong,  nonatomic)  NSMutableArray  *outlines;
@property (weak, nonatomic) IBOutlet UITableView *outlineTable;

@end
