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

#define SEND_ADDR    @"sendAddr"
#define SEND_PWD @"sendPwd"
#define FEEDBACK_ADDR    @"feedBackAddr"

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
        [userDefaults setObject:@"testjavamail5566@163.com" forKey:SEND_ADDR];
        [userDefaults setObject:@"wirelessdoc@huawei.com" forKey:FEEDBACK_ADDR];
        [userDefaults setObject:@"testmail5566" forKey:SEND_PWD];
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

-(BaseNaviBar *)drawTopNaviBar{
    return [[NormalNaviBar alloc]initWithDelegate:self HideBtn:All Title:@"其它"];
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
