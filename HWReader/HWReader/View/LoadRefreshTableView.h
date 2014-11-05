//
//  LoadRefreshTableView.h
//  HWReader
//
//  Created by LPanda on 14-8-8.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadRefreshTableView : UIView<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *loadRefreshTable;    
}

@property (strong,  nonatomic)  NSMutableArray  *tableSource;
@property (assign,  nonatomic)  BOOL    canRefreshLoad;

@end
