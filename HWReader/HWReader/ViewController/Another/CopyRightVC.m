//
//  CopyRightVC.m
//  HWReader
//
//  Created by LPanda on 14-8-18.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "CopyRightVC.h"
#import "NormalNaviBar.h"

@interface CopyRightVC ()

@end

@implementation CopyRightVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BaseNaviBar *)drawTopNaviBar{
    return [[NormalNaviBar alloc]initWithDelegate:self HideBtn:Right Title:@"版本信息"];
}

- (void)leftBtnAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
