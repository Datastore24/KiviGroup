//
//  AppDelegate.m
//  ITDolgopa
//
//  Created by Кирилл Ковыршин on 01.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "AppDelegate.h"
#import <MagicalRecord/MagicalRecord.h>
#import "AuthCoreDataClass.h"
#import "UserInfo.h"
#import "SingleTone.h"
#import "Macros.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //Строка скрывает НСЛОГИ Базы данных (для включения убрать коммент)------------------
    [MagicalRecord setLoggingLevel:0];
    
    //Задаем параметр выбора ячнйки на еденицу-----
    [[SingleTone sharedManager] setTableChange:YES];
    
    //---------
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBadge:) name:@"NOTIFICATIONPUSHBADGEONAPPDELEGATE" object:nil];
    
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    self.window.clipsToBounds = YES;
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleLightContent];
    self.window.frame =  CGRectMake(0,20,self.window.frame.size.width,self.window.frame.size.height-20);
    self.window.bounds = CGRectMake(0, 20, self.window.frame.size.width, self.window.frame.size.height);
    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//        UIView *addStatusBar = [[UIView alloc] init];
//        addStatusBar.frame = CGRectMake(0, 0, 320, 20);
//        //change this to match your navigation bar or view color or tool bar
//        //You can also use addStatusBar.backgroundColor = [UIColor BlueColor]; or any other color
//        addStatusBar.backgroundColor = [UIColor colorWithRed:0.973/255. green:0.973/255. blue:0.973/255. alpha:1];
//        [self.window.rootViewController.view addSubview:addStatusBar];
//    }
    
    
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"UserInfo.sqlite"];
    
//    NSLog(@"badge: %ld",(long)application.applicationIconBadgeNumber);
    
////    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleBlackOpaque];
    
    // Для iOS 7 и ниже
    // [[UIApplication sharedApplication] registerForRemoteNotificationTypes: (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    // Для iOS 8 и выше
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    return YES;
}

//Для получение push
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken  {
    
    AuthCoreDataClass * auth = [AuthCoreDataClass new];
    NSString * deviceTokenString = [[[[deviceToken description]
                                      stringByReplacingOccurrencesOfString: @"<" withString: @""]
                                     stringByReplacingOccurrencesOfString: @">" withString: @""]
                                    stringByReplacingOccurrencesOfString: @" " withString: @""];
//    NSLog(@"My token is: %@", deviceTokenString);
    [[SingleTone sharedManager] setDeviceToken:deviceTokenString];
    
    if(![auth checkDeviceToken:deviceTokenString]){
        
        [auth putDeviceToken:deviceTokenString];
        UserInfo * userInfo = [[auth showAllUsers] objectAtIndex:0];
        NSLog(@"ADD TOKEN: %@",userInfo.deviceToken);
        
    }else{
        [auth updateToken:deviceTokenString];
        UserInfo * userInfo = [[auth showAllUsers] objectAtIndex:0];
        NSLog(@"UPDATE TOKEN: %@",userInfo.deviceToken);
    }
    
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
//    NSLog(@"Failed to get token, error: %@", error);
}

- (void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    NSLog(@"Received notification: %@", userInfo);
    if([[userInfo objectForKey:@"info"] isEqualToString:@"badge_null"]){
//        application.applicationIconBadgeNumber=0;
    }
    
    if([[userInfo objectForKey:@"info"] isEqualToString:@"rch"]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadChat" object:self];
    }
}
//

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadChat" object:self];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [MagicalRecord cleanUp];
}


- (void) changeBadge: (NSNotification*) notification
{
    NSString * strinhBadge = (NSString*)notification.object;
    NSLog(@"strinhBadge - %@", strinhBadge);
    
    NSInteger intBadge = [strinhBadge integerValue];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:intBadge];
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
