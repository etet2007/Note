//
//  AppDelegate.m
//  Note
//
//  Created by Stephen Lau on 2017/10/28.
//  Copyright © 2017年 Stephen Lau. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTableViewController.h"
#import "NoteStore.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //initialize UIWindow
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];

    //initialize MainTableViewController
    MainTableViewController *mainViewController=[[MainTableViewController alloc] init];
    
    // 创建UINavigationController对象
    // 该对象的栈只包含mainViewController
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:mainViewController];
    // 将UINavigationController对象设置为UIWindow对象的根视图控制器，
    self.window.rootViewController=navController;
    self.window.backgroundColor=[UIColor blackColor];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    BOOL success=[[NoteStore getNoteStore] saveChanges];
    if (success) {
        NSLog(@"Saved all of the notes");
    } else {
        NSLog(@"Could not save any of the notes");
    }
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
