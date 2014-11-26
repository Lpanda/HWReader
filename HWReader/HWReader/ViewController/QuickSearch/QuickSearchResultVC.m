//
//  QuickSearchResultVC.m
//  HWReader
//
//  Created by LPanda on 14-8-18.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "QuickSearchResultVC.h"
#import "NormalNaviBar.h"

#define SEARCHBAR_HEIGHT (ISPAD ? 80 : 40)

#define SEARCHRESULT_TABLERECT(TABLEFRAME)   CGRectMake(TABLEFRAME.origin.x, \
                                                    TABLEFRAME.origin.y + SEARCHBAR_HEIGHT,\
                                                    SELF_VIEW_WIDTH, \
                                                    SELF_VIEW_HEIGHT - (TABLEFRAME.origin.y + SEARCHBAR_HEIGHT))

@interface QuickSearchResultVC ()

@end

@implementation QuickSearchResultVC

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
    
    self.tableView.frame = SEARCHRESULT_TABLERECT(self.tableView.frame);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BaseNaviBar *)drawTopNaviBar{
    return [[NormalNaviBar alloc]initWithDelegate:self HideBtn:Right Title:@"UMTS-XXX-XXX"];
}

-(void)leftBtnAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
