//
//  LoadRefreshTableView.m
//  HWReader
//
//  Created by LPanda on 14-8-8.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#define LoadCriticalPoint   ((scrollView.contentSize.height - scrollView.frame.size.height) + 40)
#define LoadFootViewHeight  (isPad ? 100 : 50)
#define LoadTextHeight  (isPad ? 80.0f : 40.0f)
#define LoadTextFontSize    (isPad ? 24 :14)
#define LoadMoreText    @"加载更多"
#define NoMoreData  @"已全部加载"

#import "LoadRefreshTableView.h"

@interface LoadRefreshTableView(){
    UIView *loadFootView;
    UILabel *loadText;
}

//- (void)CreateTableFootView;

- (void)LoadDataBegin;

@end

@implementation LoadRefreshTableView

@synthesize tableSource;
@synthesize canRefreshLoad;

-(void)dealloc{
    self.tableSource = nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.tableSource = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"3", nil];
        
        loadRefreshTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        loadRefreshTable.delegate = self;
        loadRefreshTable.dataSource = self;
        loadRefreshTable.backgroundColor = [UIColor whiteColor];
        [self addSubview:loadRefreshTable];
        
        //[self CreateTableFootView];
        
    }
    return self;
}

# pragma mark UITableView   代理

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BASETABLECELL_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [tableSource count];
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

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    if (canRefreshLoad) {
        if(scrollView.contentOffset.y > LoadCriticalPoint){
            [self LoadDataBegin];
        }
    }
}

# pragma mark 上拉加载

-(void)LoadDataBegin{
    [tableSource addObjectsFromArray:[NSArray arrayWithObjects:@"1",@"2",@"3", nil]];
    [loadRefreshTable reloadData];
}

@end
