//
//  ReadSearchVC.m
//  HWReader
//
//  Created by LPanda on 14-9-22.
//  Copyright (c) 2014年 huawei. All rights reserved.
//


#define LOAD_CRITICALPOINT  ((scrollView.contentSize.height - scrollView.frame.size.height) + 40)

#import "ReadSearchVC.h"
#import "AppDelegate.h"

@interface ReadSearchVC ()

@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@end

@implementation ReadSearchVC

@synthesize tableData = _tableData;
@synthesize backBtn = _backBtn;
@synthesize cancelBtn = _cancelBtn;
@synthesize delegate = _delegate;
@synthesize curDirection = _curDirection;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self applicationCanRotation:YES];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableData = (NSMutableArray *)@[@"1",@"2",@"3",@"4"];
    
}

-(void)viewWillAppear:(BOOL)animated{
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark 按钮方法
- (IBAction)quitSearch:(UIButton *)sender {
    [AnimationKit showTransitionByType:TRANSITION_TYPE_PUSH
                               subType:TRANSITION_FROM_BOTTOM
                              duration:BASEANIMATION_DURATION
                        timingFunction:TRANSITION_TIMING_EASEINEASEOUT
                               atLayer:self.view.layer
                            animations:^{
                                self.view.hidden = YES;
                            }
                          completion:^{
                              [_delegate cancelSearch];
                              [self.view removeFromSuperview];
                              [self removeFromParentViewController];
                          }];
}


# pragma mark UITableView   代理

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BASETABLECELL_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIndentifier = @"HomeTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    if(scrollView.contentOffset.y > LOAD_CRITICALPOINT){
        [self loadDataBegin];
    }
}

- (void)loadDataBegin{
    [_tableData addObjectsFromArray:@[@"1",@"2"]];
}

-(BOOL)shouldAutorotate{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

@end
