//
//  BaseTableVC.m
//  HWReader
//
//  Created by LPanda on 14-8-7.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "BaseTableVC.h"

@interface BaseTableVC (){
    CGRect  tableRect;
    UITableViewStyle    tableStyle;
}

@end

@implementation BaseTableVC

@synthesize tableSource = _tableSource;
@synthesize tableView = _tableView;
@synthesize canLoadRefresh;

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
    
    _tableSource = [[NSMutableArray alloc]init];
    
    tableRect = [self setTableViewRect];
    
    tableStyle = [self setTableViewStyle];

    _tableView = [[UITableView alloc]initWithFrame:tableRect style:tableStyle];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [self closeAdjustScrollViewInsets];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGRect)setTableViewRect{
    return CGRectMake(0, BAR_HEIGHT, SELF_VIEW_WIDTH, SELF_VIEW_HEIGHT - BAR_HEIGHT - TABBAR_HEIGHT);
}

-(UITableViewStyle)setTableViewStyle{
    return UITableViewStylePlain;
}

# pragma mark UITableView 代理和数据源

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BASETABLECELL_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_tableSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIndentifier = @"HomeTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
    
    return cell;
}

@end
