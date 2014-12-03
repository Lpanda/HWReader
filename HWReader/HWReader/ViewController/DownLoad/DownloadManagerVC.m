//
//  DownloadManagerVC.m
//  HWReader
//
//  Created by LPanda on 14-8-11.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "DownloadManagerVC.h"
#import "SegmentedNaviBar.h"
#import "DownloadCell.h"

@interface DownloadManagerVC ()

@end

@implementation DownloadManagerVC

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
    downloadStatus = Downloading;
    [self.naviBar setBehavior:[NSNumber numberWithInt:downloadStatus]];
    [self.tableSource addObjectsFromArray:@[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BaseNaviBar *)drawTopNaviBar{
    return [[SegmentedNaviBar alloc]initWithDelegate:self HideBtn:Right
                                                                Segments:@[@"正在下载",@"下载历史"]];
}

# pragma mark 按钮方法
- (void)leftBtnAction{
    [AnimationKit showTransitionByType:TRANSITION_TYPE_PUSH
                               subType:TRANSITION_FROM_BOTTOM
                              duration:BASEANIMATION_DURATION
                        timingFunction:TRANSITION_TIMING_EASEINEASEOUT
                               atLayer:self.view.layer
                            animations:^{
                                self.view.hidden = YES;}];
}

- (void)naviAction:(id)sender{
    NSNumber *senderNum = sender;
    downloadStatus = [senderNum intValue];
    [self.tableView reloadData];
}

# pragma mark 表格视图代理方法

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BASETABLECELL_HEIGHT / 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"DownloadCellId";
    DownloadCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[DownloadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    downloadStatus == Downloading ? [cell showDownloadingContent] : [cell showDownloadHistory];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

# pragma mark UITableView 滑动删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
        forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableSource removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView
          editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView
            titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"你大爷";
}

@end
