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
#import "DownloadCenter.h"
#import "HtmlTextGetter.h"


@implementation AppDelegate

@synthesize isRotationEnabled = _isRotationEnabled;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSString *HTML_TEST_PATH = @"/Users/zhaochao/Library/Application Support/iPhone Simulator/7.0.3-64/Applications/67D8916F-749E-4A23-9D50-443569D2ED97/Documents/unZipFiles/BSC6900 UMTS 产品文档 V900R015C00/bsc6900-documents--new-15.0-ZH-app/cbb000002/cbb000002_004.html";
    NSString *htmlText = [HtmlTextGetter getTextByHtml:HTML_TEST_PATH];
    NSLog(@"%@", htmlText);
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
