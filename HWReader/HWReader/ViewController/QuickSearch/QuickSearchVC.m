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
#import "SystemChooseView.h"

static const CGFloat VIEW_ORIGN_X = 60.0f;
static const CGFloat SYSCHOOSEVIEW_ORIGN_Y = 56.0f;
static const CGFloat SYSCHOOSEVIEW_WIDTH = 240.0f;

@interface QuickSearchVC ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *searchTF;

@end

@implementation QuickSearchVC

@synthesize scrollView = _scrollView;
@synthesize searchTF = _searchTF;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _scrollView.contentSize = CGSizeMake(SELF_VIEW_WIDTH, _scrollView.frame.size.height - TABBAR_HEIGHT);
    
    SystemChooseView *sysChooseView = [[SystemChooseView alloc]initWithFrame:CGRectMake(VIEW_ORIGN_X, SYSCHOOSEVIEW_ORIGN_Y, SYSCHOOSEVIEW_WIDTH, 184)];
    [_scrollView addSubview:sysChooseView];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BaseNaviBar *)drawTopNaviBar{
    return [[NormalNaviBar alloc]initWithDelegate:self HideBtn:All Title:@"快速搜索"];
}

-(void)drawBarItem{
    self.tabBarItem= [self createBarItemWithSelectedImg:QUICKSEARCHICON_SELECTED
                                          UnSelectedImg:QUICKSEARCHICON_UNSELECTED
                                                    Tag:QUICKSEARCH_MODULE];
}

# pragma mark UITextField 代理

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (![textField.text isEmptyOrNull]) {
        // do search....
    }
    
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}

@end
