//
//  PacketVC.m
//  HWReader
//
//  Created by LPanda on 14-7-23.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "PacketVC.h"
#import "ReadVC.h"
#import "NormalNaviBar.h"
#import "HHCParser.h"
#import "OutlineVC.h"
#import "DDMenuController.h"

@interface PacketVC (){
    NormalNaviBar *naviBar;
    NSMutableArray *_hhcNodes;
    OutlineVC *_outlineVC;
    DDMenuController *_menuVC;
    
}

@end

@implementation PacketVC

- (NSData *) toUTF8:(NSData *)sourceData
{
    CFStringRef gbkStr = CFStringCreateWithBytes(NULL, [sourceData bytes], [sourceData length], kCFStringEncodingGB_18030_2000, false);
    
    if (gbkStr == NULL) {
        NSLog(@"GBK is null");
        return nil;
    }
    else
    {
        NSString *gbkString = (__bridge NSString *)gbkStr;
        
        NSString *utf8_string = [gbkString
                                 stringByReplacingOccurrencesOfString:@"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=gb2312\">"
                                 withString:@"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">"];
        
        return [utf8_string dataUsingEncoding:NSUTF8StringEncoding];
        
    }
}


-(NSMutableArray* )getBookHHCNodes
{
    //这里要判断文件的编码格式
    NSData *htmlData = [NSData dataWithContentsOfFile:_book[@"bookPath"]];
    htmlData = [self toUTF8:htmlData];
    if (!htmlData) {  //如果本身就是utf8，toUTF8会失败,那就不用转换了
        htmlData = [NSData dataWithContentsOfFile:_book[@"bookPath"]];
    }
    NSString *html = [[NSString alloc] initWithData:htmlData encoding:NSUTF8StringEncoding];
    HHCParser *hhcParser = [[HHCParser alloc] initWithString:html error:nil];
    NSMutableArray *nodes = [hhcParser getPreOrderTreeNodes];
    return nodes;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"Nib Init");

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //解析自身的路径下带的bookPath (hhc文件)
    NSLog(@"enter the pacakge view ,the hhc path is :%@", _book[@"bookPath"]);
    __weak PacketVC *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.tableSource = [[NSMutableArray alloc] init];
        _hhcNodes = [weakSelf getBookHHCNodes];
        //把nodes拆成想要的格式
        for (HHCNode* hhcNode in _hhcNodes) {
            if (!hhcNode.localHref) {
                hhcNode.localHref = @"";
            }
            NSDictionary *dic = @{@"bookName": hhcNode.name,
                                             @"bookPath" : hhcNode.localHref};
            [weakSelf.tableSource addObject:dic];
        }
        [weakSelf.tableView reloadData];
        //_outlineVC = [[OutlineVC alloc] init];
        _menuVC = [[DDMenuController alloc] initWithRootViewController:self.navigationController];
        _menuVC.leftViewController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
       // [self.view addSubview:_outlineVC.view];
        self.navigationController.navigationBarHidden = NO;
       // [_menuVC.view addSubview:_outlineVC.view];
        
    });


}


- (BaseNaviBar *)drawTopNaviBar{
    return [[NormalNaviBar alloc]initWithDelegate:self HideBtn:Right Title:_book[@"bookName"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSString *hhcpath = _book[@"bookPath"];
//    NSString *hhcDir = [hhcpath substringWithRange:NSMakeRange(0, [hhcpath rangeOfString:@"/" options:NSBackwardsSearch].location)];
//    NSLog(@"%@", hhcDir);
//    NSString *path = _hhcNodes[indexPath.row][@"bookPath"];
//   // path = [_book[@"bookPath"] appendString:<#(NSString *)#>]
//    ReadVC *readVC = [[ReadVC alloc]initWithNibName:@"ReadVC" bundle:nil];
//    readVC.url = path;
//    readVC.hidesBottomBarWhenPushed = YES;
//    [self presentViewController:readVC animated:YES completion:nil];
    //[self pushNextVC];
}

//-(void)pushNextVC{
//  
//}

-(void)bookClick:(NSNotification *)notifi{
    NSLog(@"%@",notifi);
    NSString *pagePath = notifi.object[@"bookPath"];
    NSString *hhcpath = _book[@"bookPath"];
    NSString *hhcDir = [hhcpath substringWithRange:NSMakeRange(0, [hhcpath rangeOfString:@"/" options:NSBackwardsSearch].location)];
    NSLog(@"%@", hhcDir);
    NSString *absolutePath = [hhcDir stringByAppendingPathComponent:pagePath];
    absolutePath = [NSString stringWithFormat:[absolutePath stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"%@", absolutePath);
    ReadVC *readVC = [[ReadVC alloc]initWithNibName:@"ReadVC" bundle:nil];
    readVC.url = absolutePath;
    readVC.baseUrl = hhcDir;
    readVC.hidesBottomBarWhenPushed = YES;
    [self presentViewController:readVC animated:YES completion:nil];
}

@end
