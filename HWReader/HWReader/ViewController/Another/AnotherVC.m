//
//  AnotherVC.m
//  HWReader
//
//  Created by LPanda on 14-8-13.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "AnotherVC.h"
#import "CopyRightVC.h"
#import "UserSettingVC.h"
#import "NormalNaviBar.h"

@interface AnotherVC ()

- (IBAction)CheckVersion:(id)sender;

- (IBAction)UserSetting:(id)sender;

@end

@implementation AnotherVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:@"testjavamail5566@163.com" forKey:SENDADDR];
        [userDefaults setObject:@"wirelessdoc@huawei.com" forKey:FEEDBACKADDR];
        [userDefaults setObject:@"testmail5566" forKey:SENDPWD];
        [userDefaults synchronize];
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

-(void)drawTopNaviBar{
    NormalNaviBar *naviBar = [[NormalNaviBar alloc]initWithDelegate:self HideBtn:All Title:@"其它"];
    [self.view addSubview:naviBar];
}

-(void)drawBarItem{
    self.tabBarItem= [self createBarItemWithSelectedImg:ANOTHERICON_SELECTED
                                          UnSelectedImg:ANOTHERICON_UNSELECTED
                                                    Tag:ANOTHER_MODULE];
}

- (IBAction)CheckVersion:(id)sender {
    CopyRightVC *copyRightVC = [[CopyRightVC alloc]initWithNibName:@"CopyRightVC" bundle:nil];
    [self presentViewController:copyRightVC animated:YES completion:nil];
}

- (IBAction)UserSetting:(id)sender {
    UserSettingVC *userSettingVC = [[UserSettingVC alloc]initWithNibName:@"UserSettingVC" bundle:nil];
    [self presentViewController:userSettingVC animated:YES completion:nil];
}

@end
