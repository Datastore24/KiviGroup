//
//  AppDelegate.m
//  Sadovod
//
//  Created by Виктор Мишустин on 18/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "AppDelegate.h"
#import "HexColors.h"
#import "Macros.h"
#import <MagicalRecord/MagicalRecord.h>
#import "SingleTone.h"


@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"UserModel.sqlite"];

    //Настройки NavigationBar
    [UINavigationBar appearance].barTintColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_800];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    
    //Тестовый синглтон для проверки авторизованного пользователя
    [[SingleTone sharedManager] setTypeMenu:@"0"]; //Если 0 то не авторизован
 

    
    return YES;
}




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
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
