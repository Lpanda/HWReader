//
//  MenuBookmarkVC.m
//  HWReader
//
//  Created by LPanda on 14-8-7.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "MenuBookmarkVC.h"
#import "SegmentedNaviBar.h"

#define MENU_SELECTED    0
#define BOOKMARK_SELECTED    1


@interface MenuBookmarkVC (){
    SegmentedNaviBar    *segmentedNaviBar;
}

@end

@implementation MenuBookmarkVC

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
    
    [segmentedNaviBar setDefaultIndex:MENU_SELECTED];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawTopNaviBar{
    segmentedNaviBar = [[SegmentedNaviBar alloc]initWithDelegate:self HideBtn:Right Segments:@[@"目录",@"书签"]];
    [self.view addSubview:segmentedNaviBar];
}

- (void)naviAction:(id)sender{
    
    NSNumber *selectedNum = sender;
    
    [self.tableSource removeAllObjects];
    
    switch ([selectedNum integerValue]) {
        case MENU_SELECTED:{
            [self.tableSource addObjectsFromArray:[NSArray arrayWithObjects:@"1",@"3",@"4",@"4",@"1",nil]];
        }
            break;
            
        case BOOKMARK_SELECTED:{
            [self.tableSource addObjectsFromArray:[NSArray arrayWithObjects:@"1",@"2",@"3",@"4", nil]];
        }
            break;
            
        default:
            break;
    }
    
    [self.tableView reloadData];
    
}

-(void)leftBtnAction{
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [UIView animateWithDuration:BASEANIMATION_DURATION animations:^{
            self.view.frame = CGRectMake(0, 0, -SELF_VIEW_WIDTH, SELF_VIEW_HEIGHT);
        } completion:^(BOOL finished) {
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
        }];
    }
}

# pragma mark 表格视图代理

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIndentifier = @"HomeTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    cell.textLabel.text = [self.tableSource objectAtIndex:indexPath.row];
    
    return cell;
}


@end
