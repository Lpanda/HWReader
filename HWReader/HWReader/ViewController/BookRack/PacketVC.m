//
//  PacketVC.m
//  HWReader
//
//  Created by LPanda on 14-7-23.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "PacketVC.h"
#import "ReadVC.h"
#import "NormalNaviBar.h"

@interface PacketVC (){
    NormalNaviBar *naviBar;
}

@end

@implementation PacketVC


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"Nib Init");

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)drawTopNaviBar{
    naviBar = [[NormalNaviBar alloc]initWithDelegate:self HideBtn:Right Title:@"BTS3902E"];
    [self.view addSubview:naviBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ReadVC *readVC = [[ReadVC alloc]initWithNibName:@"ReadVC" bundle:nil];
    readVC.hidesBottomBarWhenPushed = YES;
    [self presentViewController:readVC animated:YES completion:nil];
    //[self.navigationController pushViewController:readVC animated:YES];

}

@end
