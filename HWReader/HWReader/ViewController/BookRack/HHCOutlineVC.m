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
#import "SmallPackageFilter.h"

#define OUTLINE_INDENT_BOUNCE 2

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
    //self.tableView.separatorInset = UIEdgeInsetsMake(0, 30, 0, 0);
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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
    //有的是目录url 应该为空, 去掉 ,这里只展现小包
    NSMutableArray *noEmptyUrlChilren = [[NSMutableArray alloc] init];
    for (HHCNode* node in chilren) {
        if (![node.localHref isEmptyOrNull]
            && [SmallPackageFilter isSmallPackage:node]) {
            [noEmptyUrlChilren addObject:node];
        }
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:CLICK_ON_OUTLINE_NODE object:noEmptyUrlChilren];
    [menu setRootController:menu.rootViewController animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [hhcNodes count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"OUTLINE_CELL_ID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    HHCNode *node = hhcNodes[indexPath.row];
    cell.indentationLevel = node.depth* OUTLINE_INDENT_BOUNCE;
    cell.textLabel.text = node.name;
    cell.textLabel.font = [UIFont systemFontOfSize:10.0f];
    cell.imageView.image = [UIImage imageNamed:@"red_dot.png"];
    return cell;
}


-(void)hhcNodesParseDone:(NSNotification *) noti
{
    hhcNodes = noti.object;
    [self.tableView reloadData];
}
@end
