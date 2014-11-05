//
//  OutlineVC.m
//  HWReader
//
//  Created by LPanda on 14-6-30.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "OutlineVC.h"
#import "UIViewController+ViewControllerCategory.h"

#define OutLineTableOrignY  searchTF.frame.size.height + searchTF.frame.origin.y + 5
#define iOS6OutlineTableHeight self.view.frame.size.height - searchTF.frame.size.height + searchTF.frame.origin.y + 5

static CGFloat outlineTableCellHeight = 45.0f;
static CGFloat outlineSearchTFOrignY =  3.0f;

@interface OutlineVC ()

@property (weak, nonatomic) IBOutlet UITextField *searchTF;

@end

@implementation OutlineVC

@synthesize outlines;
@synthesize outlineTable;
@synthesize searchTF;

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
    
    outlineTable.backgroundColor = [UIColor whiteColor];
    outlineTable.delegate = self;
    outlineTable.dataSource = self;
}

-(void)viewDidAppear:(BOOL)animated{
    [self changeLayout];
}

-(void)changeLayout{
    if (IOS_7) {
        outlineTable.separatorInset = UIEdgeInsetsZero;
    }else{
        
        searchTF.frame = CGRectMake(searchTF.frame.origin.x,
                                    outlineSearchTFOrignY,
                                    searchTF.frame.size.width,
                                    searchTF.frame.size.height);
        
        outlineTable.frame = CGRectMake(outlineTable.frame.origin.x,
                                        OutLineTableOrignY,
                                        outlineTable.frame.size.width,
                                       iOS6OutlineTableHeight);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return outlineTableCellHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"ShowReadView" sender:self];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OutlineTableCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeTableCell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
    
    return cell;
}

@end
