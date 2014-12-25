//
//  AppDelegate.m
//  HWReader
//
//  Created by LPanda on 14-7-23.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "AppDelegate.h"
#import "BookRackVC.h"
#import "DocManager.h"
#import "DownloadMainVC.h"
#import "QuickSearchVC.h"
#import "AnotherVC.h"
#import "LocalizeManager.h"
#import "ChmParser.h"
#import "HHCParser.h"

#import "HTMLParser.h"

#define HHC_TEST_PATH @"/Users/zhaochao/Library/Application Support/iPhone Simulator/7.0.3-64/Applications/A40BE93B-A8A9-47C7-BDA7-7F31809A071A/Documents/unZipFiles/BSC6900 UMTS 产品文档 V900R015C00/bsc6900-documents--new-15.0-ZH-app/bsc6900-documents--new-15.0.hhc"
@implementation AppDelegate

@synthesize isRotationEnabled = _isRotationEnabled;

- (NSData *) toUTF8:(NSData *)sourceData
{
    CFStringRef gbkStr = CFStringCreateWithBytes(NULL, [sourceData bytes], [sourceData length], kCFStringEncodingGB_18030_2000, false);
    
    if (gbkStr == NULL) {
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


-(NSMutableArray* )testHtmlParser
{
    NSError *error = nil;
    //NSData *data = []
    NSData *htmlData = [NSData dataWithContentsOfFile:HHC_TEST_PATH];
    htmlData = [self toUTF8:htmlData];
    NSString *html = [[NSString alloc] initWithData:htmlData encoding:NSUTF8StringEncoding];
    NSArray *depIndent = @[
                                   @"-",
                                   @"--",
                               @"---",
                               @"----",
                              @"-----",
                              @"------",
                               @"-------",
                                @"--------",
                                 @"--------",
                               @"---------"];
    HHCParser *hhcParser = [[HHCParser alloc] initWithString:html error:nil];
    NSMutableArray *nodes = [hhcParser getPreOrderTreeNodes];
    NSMutableString *string = [[NSMutableString alloc]init];
    for (HHCNode* node in nodes) {
        NSAssert(node.name, @"error with name");
        if (!node.children) {
            NSAssert(node.localHref, @"no children's node must have be linked");
        }
        [string appendFormat:@"%@  %@->%@\n", depIndent[node.depth], node.name, node.localHref];
    }
    return nodes;
    // NSLog(@"%@",string);
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
//    NSString *path = [DocManager getFilePathByName:@"demo" Type:@"hhc" AndPathState:Resource];
//    TFHpple *hpple = [[TFHpple alloc]initWithHTMLData:[NSData dataWithContentsOfFile:path]];
//    NSArray *uls = [hpple searchWithXPathQuery:@"//ul"];
    __weak AppDelegate * weakSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableArray *nodes = [self testHtmlParser];

           // [DocManager unzipFile:@"/Users/zhaochao/Library/Application Support/iPhone Simulator/7.0.3-64/Applications/A40BE93B-A8A9-47C7-BDA7-7F31809A071A/Documents/BSC6900 UMTS 产品文档 V900R015C00.zip" toDestinationPath:nil];
//        NSData *htmlData = [NSData dataWithContentsOfFile:HHC_TEST_PATH];
//        NSData *utf8Data = [self toUTF8:htmlData];
//        
//        TFHpple *hpple =  [[TFHpple alloc]initWithHTMLData:utf8Data];
//        
//        NSArray *uls = [hpple searchWithXPathQuery:@"//ul"];
        //NSLog(@"%@", uls);
    });

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    NSArray *controllers = [NSArray arrayWithObjects:[[BookRackVC alloc]init],[[DownloadMainVC alloc]init],
                                                                [[QuickSearchVC alloc]initWithNibName:@"QuickSearchVC" bundle:nil],
                            [[AnotherVC alloc]initWithNibName:@"AnotherVC" bundle:nil],nil];
    
    NSMutableArray *tabItemControllers = [NSMutableArray array];
    
    for (int i = 0; i != [controllers count]; ++ i) {
        UIViewController *curentVC = [controllers objectAtIndex:i];
        UINavigationController *navi = [[UINavigationController alloc]
                                        initWithRootViewController:curentVC];
        navi.navigationBarHidden = YES;
        [navi supportedInterfaceOrientations];
        
        [tabItemControllers addObject:navi];
    }
    
    UITabBarController *tabBar = [[UITabBarController alloc]init];
    tabBar.viewControllers = tabItemControllers;
    tabBar.tabBar.backgroundImage = [[UIImage imageNamed:TABBAR_BGIMG]
                                     imageWithFitInSize:TABBAR_BGIMG_SIZE];
    
    [self.window setRootViewController:tabBar];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    return _isRotationEnabled ? UIInterfaceOrientationMaskAllButUpsideDown : UIInterfaceOrientationMaskPortrait;
}

@end
