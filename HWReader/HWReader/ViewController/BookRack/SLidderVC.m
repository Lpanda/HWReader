//
//  SLidderVC.m
//  HWReader
//
//  Created by zhaochao on 14-12-29.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "SLidderVC.h"
#import "PacketVC.h"
#import "OutlineVC.h"
#import "DDMenuController.h"

@interface SLidderVC ()
{
    PacketVC *_packetVC;
    OutlineVC *_outlineVC;
    DDMenuController *_menuVC;
}
@end

@implementation SLidderVC

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
    _outlineVC = [[OutlineVC alloc] init];
    _packetVC = [[PacketVC alloc] init];
    _packetVC.book = _book;
    UINavigationController *navi = self.navigationController;
    navi.navigationBarHidden = NO;
    DDMenuController *rootController = [[DDMenuController alloc] initWithRootViewController:self.navigationController];
    _menuVC = rootController;
    _menuVC.leftViewController = _outlineVC;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
