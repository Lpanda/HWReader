//
//  QuickSearchVC.m
//  HWReader
//
//  Created by LPanda on 14-8-11.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "QuickSearchVC.h"
#import "QuickSearchResultVC.h"
#import "NormalNaviBar.h"

@interface QuickSearchVC ()

@end

@implementation QuickSearchVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        NSLog(@"Svn Test");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *test = [UIButton buttonWithType:UIButtonTypeCustom];
    test.frame = self.view.bounds;
    [test addTarget:self action:@selector(ShowResult) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:test];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)DrawTopNaviBar{
    NormalNaviBar *naviBar = [[NormalNaviBar alloc]initWithDelegate:self HideBtn:All Title:@"快速搜索"];
    [self.view addSubview:naviBar];
}

-(void)drawBarItem{
    self.tabBarItem= [self createBarItemWithSelectedImg:QUICKSEARCHICON_SELECTED
                                          UnSelectedImg:QUICKSEARCHICON_UNSELECTED
                                                    Tag:QUICKSEARCH_MODULE];
}

- (void)ShowResult{
    QuickSearchResultVC *searchResultVC = [[QuickSearchResultVC alloc]
                                           initWithNibName:@"QuickSearchResultVC" bundle:nil];
    [self presentViewController:searchResultVC animated:YES completion:nil];
}

@end
