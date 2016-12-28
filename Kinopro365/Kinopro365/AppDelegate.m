//
//  AppDelegate.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 17.11.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "UserInformationTable.h"
#import "VkLoginViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "VKAPI.h"


@interface AppDelegate ()

@property (strong, nonatomic) UserInformationTable * selectedDataObject;
@property (strong, nonatomic) RLMResults *tableDataArray;
@property (strong, nonatomic) NSDictionary * dictResponse;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    
    if([self checkAuthFB]){
        [self authCheck:YES];
    }else{
        [self checkAuthVK];
    }
   
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

#pragma mark - CHECK VK & FB
-(BOOL) checkAuthFB{
    if ([FBSDKAccessToken currentAccessToken]) {
        [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
        return YES;
    }else{
        return  NO;
    }
}

-(void) checkAuthVK {
    NSLog(@"CHECK VK START");
    self.tableDataArray=[UserInformationTable allObjects];
    if (self.tableDataArray.count >0 ){
        
        
        self.selectedDataObject = [self.tableDataArray objectAtIndex:0];
        NSLog(@"FETCH %@",self.selectedDataObject);
        NSString * userID = self.selectedDataObject.vkID;
        NSString * vkToken = self.selectedDataObject.vkToken;
        
        VKAPI * vkAPI = [[VKAPI alloc] init];
        [vkAPI getUserWithParams:userID andVkToken:vkToken complitionBlock:^(id response) {
            self.dictResponse = (NSDictionary*) response;
            
            if (![[self.dictResponse objectForKey:@"error"] isKindOfClass: [NSDictionary class]]){
                NSLog(@"DICT %@",self.dictResponse);
                [self authCheck:YES];
            }else{
                [self authCheck:NO];
            }
            
        }];
        
        //    //Теперь попробуем вытяныть некую информацию
        
        
    }
}

-(void) authCheck: (BOOL) check{
    UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    NSString * controller;
    if(check){
        controller = @"PersonalDataController";
    }else{
        controller = @"LoginViewController";
    }
    NSLog(@"CONTROLLER %@",controller);
    UIViewController * centerViewController =
    [mainStoryboard instantiateViewControllerWithIdentifier:controller];
    UIViewController * leftViewController =
    [mainStoryboard instantiateViewControllerWithIdentifier:@"LeftSideViewController"];
    
    
    
    UINavigationController * leftSideNav = [[UINavigationController alloc]
                                            initWithRootViewController:leftViewController];
    UINavigationController * centerNav = [[UINavigationController alloc]
                                          initWithRootViewController:centerViewController];
    
    
    self.centerContainer = [[MMDrawerController alloc]
                            initWithCenterViewController:centerNav
                            leftDrawerViewController:leftSideNav];
    
    //    self.centerContainer.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    //    self.centerContainer.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    //    [centerContainer setShowsShadow:NO];
    
    [self.window setRootViewController:self.centerContainer];
    [self.window makeKeyAndVisible];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor hx_colorWithHexRGBAString:COLOR_ALERT_BUTTON_COLOR]];
    
    
    [[SingleTone sharedManager] setStringAletForWebView:@"0"];
    

}


@end
