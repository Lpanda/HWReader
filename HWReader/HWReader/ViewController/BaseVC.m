//
//  BaseVC.m
//  HWReader
//
//  Created by LPanda on 14-7-30.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC (){
    
    UITabBarItem *barItem;
}

@end

@implementation BaseVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self drawBarItem];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self drawTopNaviBar];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawTopNaviBar{
    
}

-(void)drawBarItem{
    
}

-(UITabBarItem *)createBarItemWithSelectedImg:(NSString *)selected
                                UnSelectedImg:(NSString *)unSelected
                                          Tag:(NSInteger)tag
{
    UITabBarItem *tabBarItem =[[UITabBarItem alloc]initWithTitle:nil
                                                         image:nil tag:tag];
    
    UIImage *selectedImg = [[UIImage imageNamed:selected]
                            imageWithFitInSize:TABBAR_ICON_SIZE];
    UIImage *unSelectedImg = [[UIImage imageNamed:unSelected]
                              imageWithFitInSize:TABBAR_ICON_SIZE];
    
    [tabBarItem setFinishedSelectedImage:selectedImg
           withFinishedUnselectedImage:unSelectedImg];
    
    tabBarItem.imageInsets = TABBAR_ICONIMG_INSETS;
    
    return tabBarItem;
}

-(void)rightBtnAction{
    NSLog(@"super right");
}

-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)naviAction:(id)sender{
    
}

@end
