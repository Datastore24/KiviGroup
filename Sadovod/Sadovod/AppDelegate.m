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
#import "Auth.h"
#import "AuthDbClass.h"
#import "APIGetClass.h"
#import "SingleTone.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //Настройки NavigationBar
    [UINavigationBar appearance].barTintColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_800];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    
    
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"Auth.sqlite"];
    [self getKey:^{
        AuthDbClass * authDbClass = [[AuthDbClass alloc] init];
        NSArray * arrayUser = [authDbClass showAllUsers]; //Массив данных CoreData
        if(arrayUser.count>0){
            Auth * authCoreData = [arrayUser objectAtIndex:0];
            NSLog(@"CORE %@",authCoreData.superkey);
        }else{
          NSLog(@"CORE FUCK");
        }
       
    }];
    
    return YES;
}


-(void) getKey:(void (^)(void))block {
    AuthDbClass * authDbClass = [[AuthDbClass alloc] init];
    NSArray * arrayUser = [authDbClass showAllUsers]; //Массив данных CoreData
    NSDictionary * params;
    if(arrayUser.count>0){
        Auth * authCoreData = [arrayUser objectAtIndex:0];
        
        params = [[NSDictionary alloc] initWithObjectsAndKeys: authCoreData.superkey, @"super_key",
                                                            authCoreData.catalogkey,@"catalog_key", nil];
    }else{
        params = nil;
    }

    APIGetClass * api = [APIGetClass new]; //Создаем экземпляр API
    [api getDataFromServerWithParams:params method:@"check_keys" complitionBlock:^(id response) {
     
        NSLog(@"RESPONSE %@",response);
        
        NSDictionary * respDict =(NSDictionary *) response;
        [authDbClass checkKey:[respDict objectForKey:@"super_key"] andCatalogKey:[respDict objectForKey:@"catalog_key"]];
        
        [[SingleTone sharedManager] setSuperKey:[respDict objectForKey:@"super_key"]];
        [[SingleTone sharedManager] setCatalogKey:[respDict objectForKey:@"catalog_key"]];
        
        block();
        
        
    }];
    
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
