//
//  ReadSearchVC.h
//  HWReader
//
//  Created by LPanda on 14-9-22.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ReadSearchVCDelegate <NSObject>

- (void)cancelSearch;

@end

@interface ReadSearchVC : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong,  nonatomic) NSMutableArray *tableData;
@property (assign,  nonatomic)  id<ReadSearchVCDelegate>    delegate;
@property (assign,  nonatomic) UIInterfaceOrientation   curDirection;

- (IBAction)quitSearch:(UIButton *)sender;

@end
