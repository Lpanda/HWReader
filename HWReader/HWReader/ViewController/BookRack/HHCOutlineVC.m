//
//  HHCOutlineVC.m
//  HWReader
//
//  Created by zhaochao on 14-12-30.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "HHCOutlineVC.h"
#import "HHCNode.h"
#import "PacketVC.h"

@interface HHCOutlineVC ()

@end

@implementation HHCOutlineVC
@synthesize hhcNodes;
@synthesize menu;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hhcNodesParseDone:) name:HHCNODES_PARSE_DONE_NOTIFY object:nil];
    self.tableView.separatorColor = [UIColor colorWithWhite:0.15f alpha:0.2f];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HHCNode *node = hhcNodes[indexPath.row];
    NSMutableArray *chilren = [node getPreOrderChilren];
    [[NSNotificationCenter defaultCenter] postNotificationName:CLICK_ON_OUTLINE_NODE object:chilren];
    //收回去
    [menu showLeftController:NO];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [hhcNodes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"OUTLINE_CELL_ID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    HHCNode *node = hhcNodes[indexPath.row];
    cell.indentationLevel = node.depth;
    cell.textLabel.text = node.name;
    return cell;
}


-(void)hhcNodesParseDone:(NSNotification *) noti
{
    hhcNodes = noti.object;
    [self.tableView reloadData];
}
@end
