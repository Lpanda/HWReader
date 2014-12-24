//
//  DownloadManagerVC.m
//  HWReader
//
//  Created by LPanda on 14-8-11.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "DownloadTaskVC.h"
#import "SegmentedNaviBar.h"
#import "DownloadCell.h"
#import "DownloadCenter.h"


@interface DownloadTaskVC ()
@end

@implementation DownloadTaskVC

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
    [(SegmentedNaviBar*)self.naviBar setDefaultIndex:0];
    [self.naviBar setBehavior:[NSNumber numberWithInt:downloadStatus]];
    [self.tableView reloadData];
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
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
    cell.textLabel.text = self.tableSource[indexPath.row][@"name"];
    NSDictionary *taskDic = self.tableSource[indexPath.row];
    ASIHTTPRequest *request = [[DownloadCenter getInstance] createRequestWithTaskDic: taskDic];
    [[DownloadCenter getInstance]addDownloadRequest:request];
    [request setDownloadProgressDelegate:cell.downloadProgress];
    cell.request = request;
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
    return @"删除";  
}


-(void)addDownloadTask: (NSDictionary *) taskDic
{
    [self.tableView beginUpdates];
    [self.tableSource addObject:taskDic];
    NSArray *arrInsertRows = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:[self.tableSource count]-1 inSection:0]];
    [self.tableView insertRowsAtIndexPaths:arrInsertRows withRowAnimation:UITableViewRowAnimationBottom];
    [self.tableView endUpdates];
    [[DownloadCenter getInstance]start];
}

@end
