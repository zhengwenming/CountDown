//
//  AppDelegate.m
//  倒计时
//
//  Created by 郑文明 on 16/1/7.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)backgroundHandler {
    __weak __typeof__ (self) weakSelf = self;
    self.backtaskIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        __strong __typeof (weakSelf) strongSelf = weakSelf;
        [[UIApplication sharedApplication] endBackgroundTask:strongSelf.backtaskIdentifier];
        strongSelf.backtaskIdentifier = UIBackgroundTaskInvalid;
        [[UIApplication sharedApplication] clearKeepAliveTimeout];
    }];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UINavigationBar appearance].translucent = NO;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSInteger messageCount= [UIApplication sharedApplication].applicationIconBadgeNumber;
    [UIApplication sharedApplication].applicationIconBadgeNumber= messageCount;
    BOOL backgroundAccepted = [[UIApplication sharedApplication] setKeepAliveTimeout:600 handler:^{
        [self backgroundHandler];
    }];
    if (backgroundAccepted)
    {
        NSLog(@"backgrounding accepted");
    }
    [self backgroundHandler];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
