//
//  DownloadMainVC.m
//  HWReader
//
//  Created by LPanda on 14-8-11.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "DownloadMainVC.h"
#import "DownloadTaskVC.h"
#import "NormalNaviBar.h"
#import "DownloadLinkCell.h"
#import "LoginRequest.h"
#import "SegmentedNaviBar.h"

#define SCRLIST_WIDTH   80
#define SYSBTN_SIZE 80
#define HEADVIEW_HEIGHT BASETABLECELL_HEIGHT / 4
#define FOOTVIEW_HEIGHT 1.0f
#define DOWNLOADCELL_HEIGHT BASETABLECELL_HEIGHT / 2
#define TITLE_COLOR  [UIColor colorWithRed:213.0/255.0 green:213.0/255.0 blue:213.0/255.0 alpha:1.0]

#define DOCUMENT_NAME    @"name"
#define DOCUMENT_URL    @"url"




@interface DownloadMainVC ()<UIAlertViewDelegate>{
    DownloadTaskVC   *downloadManagerVC;
    UIScrollView *scrollView;
    NSArray *sysTitles;
    NSArray *typeTitles;
    NSDictionary *linkStructs;
    NSString *curSys;
    BOOL isAlreadyLogin;
    LoginRequest *_loginRequest;
    BOOL isChineseLink;
}

- (UIScrollView *)drawSysList;

- (NSString *)getTypeKeyInSection:(NSInteger)section;

@end

@implementation DownloadMainVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        downloadList = [NSDictionary dictionaryWithContentsOfFile:
                        [[NSBundle mainBundle] pathForResource:@"DownLoadList" ofType:@"plist"]];
        sysTitles = [NSArray arrayWithContentsOfFile:
                     [[NSBundle mainBundle] pathForResource:@"SysList" ofType:@"plist"]];
        linkStructs = [NSDictionary dictionaryWithContentsOfFile:
                               [[NSBundle mainBundle] pathForResource:@"LinkNameList" ofType:@"plist"]];
        isAlreadyLogin = NO;
        
        isChineseLink = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLoginNotification) name:kUSER_ALREADY_LOGIN_MSG object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:[self drawSysList]];
    
    downloadManagerVC = [[DownloadTaskVC alloc]init];
    
    [self addChildViewController:downloadManagerVC];
    
    [self.view addSubview:downloadManagerVC.view];

    downloadManagerVC.view.hidden = YES;
}

# pragma mark 视图绘制
-(UITableViewStyle)setTableViewStyle{
    return UITableViewStyleGrouped;
}

-(CGRect)setTableViewRect{
    return CGRectMake(SCRLIST_WIDTH, BAR_HEIGHT,
                      SELF_VIEW_WIDTH - SCRLIST_WIDTH, SELF_VIEW_HEIGHT - BAR_HEIGHT - TABBAR_HEIGHT);
}

-(UIScrollView *)drawSysList{
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, BAR_HEIGHT,
                                                                             SCRLIST_WIDTH, SELF_VIEW_HEIGHT - BAR_HEIGHT)];
    
    NSString *sysListPath = [[NSBundle mainBundle] pathForResource:@"SysList" ofType:@"plist"];
    
    NSArray *sys = [NSArray arrayWithContentsOfFile:sysListPath];

    for (int i = 0; i != [sys count]; ++ i) {
        NSString *title = sys[i];
        UIButton *curSysBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        curSysBtn.frame = CGRectMake(0, i * SYSBTN_SIZE, SYSBTN_SIZE, SYSBTN_SIZE);
        curSysBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        curSysBtn.tag = i;
        [curSysBtn setTitle:title forState:UIControlStateNormal];
        [curSysBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [curSysBtn addTarget:self action:@selector(loadSysDetail:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:curSysBtn];
    }
    [self loadSysDetail:scrollView.subviews[0]];
    [scrollView setContentSize:CGSizeMake(0, SYSBTN_SIZE * [sys count] + TABBAR_HEIGHT)];
    scrollView.backgroundColor = TITLE_COLOR;
    return scrollView;
}

-(BaseNaviBar *)drawTopNaviBar{
    
    SegmentedNaviBar *segNavi = [[SegmentedNaviBar alloc]initWithDelegate:self HideBtn:Left
                                            Segments:@[@"中文",@"English"]];
    [segNavi setDefaultIndex:0];
    return segNavi;
}

-(void)naviAction:(id)sender
{
    NSNumber *senderNum = sender;
    isChineseLink = [senderNum intValue] == 0 ;
    [self.tableView reloadData];
}
-(void)drawBarItem{
    self.tabBarItem= [self createBarItemWithSelectedImg:DOWNLOADICON_SELECTED
                                          UnSelectedImg:DOWNLOADICON_UNSELECTED
                                                    Tag:DOWNLOAD_MODULE];
}

# pragma 按钮方法
- (void)rightBtnAction{
    [AnimationKit showTransitionByType:TRANSITION_TYPE_MOVEIN
                               subType:TRANSITION_FROM_TOP
                                duration:BASEANIMATION_DURATION
                            timingFunction:TRANSITION_TIMING_EASEINEASEOUT
                               atLayer:self.view.layer
                            animations:^{
                                downloadManagerVC.view.hidden = NO;}];
}

- (void)loadSysDetail:(UIButton *)btn{
    for (UIView *subView in scrollView.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *anotherBtn = (UIButton *)subView;
            anotherBtn.backgroundColor = [UIColor clearColor];
        }
    }
    btn.backgroundColor = [UIColor whiteColor];
    
    NSDictionary *types = [NSDictionary dictionaryWithContentsOfFile:
                           [[NSBundle mainBundle] pathForResource:@"TypeList" ofType:@"plist"]];
    
    curSys = btn.titleLabel.text;
    
    typeTitles = [types objectForKey:sysTitles[btn.tag]];
    
    [self.tableView reloadData];
}

-(NSString *)getTypeKeyInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"%@%@",curSys,typeTitles[section]];
}

# pragma mark 表格视图代理方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [typeTitles count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *titleLB = [[UILabel alloc]init];
    titleLB.backgroundColor = TITLE_COLOR;
    titleLB.text = typeTitles[section];
    return titleLB;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return HEADVIEW_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return FOOTVIEW_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return DOWNLOADCELL_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isAlreadyLogin) {
        //获取该单元格下载URL，添加到任务队列，切换下载任务视图
        NSDictionary *dic = [self getCellLanguageDicAt:indexPath];
        NSString *url = dic[@"url"];
        if ([url isEmptyOrNull]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该链接尚不能下载" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
            return;
        }
        [downloadManagerVC addDownloadTask:dic];
        [self rightBtnAction];
    }
    else{
        _loginRequest = [[LoginRequest alloc] init];
        [_loginRequest askUserToLogin];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString *key = [self getTypeKeyInSection:section];
    return [[linkStructs objectForKey:key]count];
}

- (NSDictionary *)getCellLanguageDicAt:(NSIndexPath *)indexPath {
    static NSString *LANG[2] = {@"en",@"cn"};
    NSString *key = [self getTypeKeyInSection:indexPath.section];
    NSArray *links = linkStructs[key];
    NSDictionary *encnDic = [links objectAtIndex:indexPath.row];
    NSString *lang = LANG[isChineseLink];
    NSDictionary *langDic = encnDic[lang];
    return langDic;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"DownloadMainCell";
    
    DownloadLinkCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[DownloadLinkCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    
    NSDictionary *langDic;
    langDic = [self getCellLanguageDicAt:indexPath];
    cell.textLabel.text = langDic[DOCUMENT_NAME];
    //看有有效链接没，没有改掉img的图片
    if ([langDic[@"url"] isEmptyOrNull]) {
        [cell hideDownloadImg];
    }
    else
    {
        [cell showDownLoadImg];
    }
    return cell;
}


-(void)userLoginNotification
{
    isAlreadyLogin = YES;
}

@end
