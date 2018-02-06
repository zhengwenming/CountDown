//
//  AppDelegate.h
//  倒计时
//
//  Created by 郑文明 on 16/1/7.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, unsafe_unretained) UIBackgroundTaskIdentifier backtaskIdentifier;

@end

