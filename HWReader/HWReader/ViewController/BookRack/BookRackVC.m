//
//  BookRackVC.m
//  HWReader
//
//  Created by LPanda on 14-7-23.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "BookRackVC.h"
#import "OutlineVC.h"
#import "PacketVC.h"
#import "BookRackCell.h"
#import "DocManager.h"

#define PULLDOWNSELECTBTN_HEIGHT (ISPAD ? 40 : 20)
#define PULLDOWNVIEW_ORIGNX  (ISPAD ? 408 : 100)
#define PULLDOWNVIEW_WIDTH   (ISPAD ? 240 : 120)

#define LIST_ROWCOUNT_PERPAGE   10
#define BOOKRACK_ROWCOUNT_PERPAGE   3

#define LOCALPLIST  @"LocalBook"

static NSString *cellIndentifier = @"BookRackCell";
static const NSInteger COL_LENGTH = 3;

@interface BookRackVC (){
    UIView *pullDownView;
    PullDownNaviBar *naviBar;
    NSMutableArray *sysTexts;
    BOOL    isListShow;
}

- (void)createPullDownView;

@end

@implementation BookRackVC


-(id)init{
    if (self = [super init]) {
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self createPullDownView];
    
    [self.tableSource addObjectsFromArray:[DocManager getZipFileNamesByPlistName:LOCALPLIST]];
}

# pragma mark 视图层

- (void)drawTopNaviBar{
    naviBar = [[PullDownNaviBar alloc]initWithDelegate:self HideBtn:Left Title:@"全部制式"];
    [naviBar.rightBtn setBackgroundImage:[UIImage imageNamed:SWITCH_LIST] forState:UIControlStateNormal];
    [self.view addSubview:naviBar];
}

- (void)drawBarItem{
    
    self.tabBarItem= [self createBarItemWithSelectedImg:BOOKRACKICON_SELECTED
                                          UnSelectedImg:BOOKRACKICON_UNSELECTED
                                                    Tag:READ_MODULE];
}

- (void)createPullDownView{
    
    sysTexts = [NSMutableArray
                arrayWithObjects:@"全部制式",@"WCDMA",@"Small Cell",@"LTE TDD",@"Fuxk",@"Shit", nil];
    
    pullDownView = [[UIView alloc]initWithFrame:
                    CGRectMake(PULLDOWNVIEW_ORIGNX,
                               naviBar.bounds.size.height - 18,
                               PULLDOWNVIEW_WIDTH,
                               PULLDOWNSELECTBTN_HEIGHT * sysTexts.count)];
    pullDownView.backgroundColor = [UIColor blackColor];
    pullDownView.hidden = YES;
    
    for (int i = 0; i != [sysTexts count]; ++ i) {
        UIButton *sysBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sysBtn.frame = CGRectMake(0, PULLDOWNSELECTBTN_HEIGHT * i,
                                  pullDownView.bounds.size.width, PULLDOWNSELECTBTN_HEIGHT);
        [sysBtn setTitle:[sysTexts objectAtIndex:i] forState:UIControlStateNormal];
        sysBtn.tag = i;
        [sysBtn addTarget:self action:@selector(choosDocSys:) forControlEvents:UIControlEventTouchUpInside];
        [pullDownView addSubview:sysBtn];
    }
    [self.view addSubview:pullDownView];
    
}

# pragma mark 逻辑

- (void)naviAction:(id)sender{
    pullDownView.hidden = !pullDownView.hidden;
}

- (void)choosDocSys:(UIButton*)sysBtn{
    NSString *lastTitle = naviBar.pullDownBtn.titleLabel.text;
    
    if (![lastTitle isEqualToString:sysBtn.titleLabel.text]) {
        [naviBar.pullDownBtn setTitle:sysBtn.titleLabel.text forState:UIControlStateNormal];
    }
    pullDownView.hidden = YES;
    
}

-(void)rightBtnAction{
    isListShow = !isListShow;
    if (isListShow) {
        [naviBar.rightBtn setBackgroundImage:[UIImage imageNamed:SWITCH_BOOKRACK]
                                    forState:UIControlStateNormal];
    }else{
        [naviBar.rightBtn setBackgroundImage:[UIImage imageNamed:SWITCH_LIST] forState:UIControlStateNormal];
    }
    [self.tableView reloadData];
}

# pragma mark 表格视图代理方法

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat rowCount;
    
    if (isListShow) {
        rowCount = LIST_ROWCOUNT_PERPAGE;
    }else{
        rowCount = BOOKRACK_ROWCOUNT_PERPAGE;
    }
    return self.tableView.bounds.size.height / rowCount;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PacketVC *packetVC = [[PacketVC alloc]init];
    [self.navigationController pushViewController:packetVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger sum = [self.tableSource count];
    if (isListShow) {
        return sum;
    }else{
        return sum/COL_LENGTH + (sum%COL_LENGTH != 0 ?1 :0);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BookRackCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if (!cell) {
        cell = [[BookRackCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier
                                          BookCnt:COL_LENGTH];
    }else{
        [cell clearContentView];
    }
    
    if (isListShow) {
        cell.textLabel.text = self.tableSource[indexPath.row];
    }else{
        // it is none of my business
        NSInteger sum = [self.tableSource count];
        NSInteger remainBkCnt =  sum -  indexPath.row *COL_LENGTH;
        NSInteger curRowBookCnt = remainBkCnt > COL_LENGTH ? COL_LENGTH : remainBkCnt;
        NSArray *rowBooks = [self.tableSource subarrayWithRange:
                             NSMakeRange(indexPath.row*COL_LENGTH, curRowBookCnt)];
        [cell bookRackShow:rowBooks];
    }
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
