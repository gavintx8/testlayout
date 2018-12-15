//
//  AppDelegate.m
//  TestLoyout
//
//  Created by mac on 2018/12/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "HCollectionViewController.h"
#import "HTableViewController.h"
#import "HViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    GQKeyboardManager * gqkb = [GQKeyboardManager share];
    gqkb.enable = YES;
    gqkb.enableAutoToolbar = YES;
    
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    HCollectionViewController *rootVC=[[HCollectionViewController alloc]init];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:rootVC];
    self.window.rootViewController=nav;
    [self.window makeKeyAndVisible];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {}

- (void)applicationDidEnterBackground:(UIApplication *)application {}

- (void)applicationWillEnterForeground:(UIApplication *)application {}

- (void)applicationDidBecomeActive:(UIApplication *)application {}

- (void)applicationWillTerminate:(UIApplication *)application {}

@end
