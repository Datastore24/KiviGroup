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
#import <VK-ios-sdk/VKSdk.h>

#import "VKAPI.h"

#import "SingleTone.h"
#import "APIManger.h"


@interface AppDelegate ()

@property (strong, nonatomic) UserInformationTable * selectedDataObject;
@property (strong, nonatomic) RLMResults *tableDataArray;
@property (strong, nonatomic) NSDictionary * dictResponse;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    
  
    
    NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSLog(@"LOCATION %@",language);
    NSString * finalLanguageAPI;
    if([language isEqualToString:@"ru-US"]){
        finalLanguageAPI = @"ru-RU";
    }else if([language isEqualToString:@"ru-RU"]){
        finalLanguageAPI = @"ru-RU";
    }else{
        finalLanguageAPI = @"en-US";
    }
    [[SingleTone sharedManager] setLocalization:finalLanguageAPI];
    [self checkSiteToken];
    
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
    [VKSdk processOpenURL:url fromApplication:sourceApplication];
    [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    
    return YES;
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
                [self authCheck:YES andController:@"PersonalDataController"];
            }else{
                [self authCheck:NO andController:@"LoginViewController"];
            }
            
        }];
        
        //    //Теперь попробуем вытяныть некую информацию
        
        
    }else{
        [self authCheck:NO andController:@"LoginViewController"];
    }
}

-(void) checkSiteToken {
    // Get the current date/time in timestamp format.
    
    
    self.tableDataArray=[UserInformationTable allObjects];
    if (self.tableDataArray.count >0 ){
        self.selectedDataObject = [self.tableDataArray objectAtIndex:0];
      
        NSString * token = self.selectedDataObject.siteToken;
        APIManger * apiManager = [[APIManger alloc] init];
        [apiManager getDataFromSeverWithMethod:@"account.validateToken" andParams:nil andToken:token complitionBlock:^(id response) {
            
            NSDictionary * respDict = [response objectForKey:@"response"];
            
            if ([[response objectForKey:@"error_code"] integerValue] == 2){
                NSLog(@"ERROR TOKEN");
                if([self checkAuthFB]){
                    [self authCheck:YES andController:@"PersonalDataController"];
                }else{
                    [self checkAuthVK];
                }
                
            }else{
                if ([[respDict objectForKey:@"status"] integerValue] == 0){
                    [self authCheck:YES andController:@"PersonalDataController"];
                }else if ([[respDict objectForKey:@"status"] integerValue] == 10){
                    [self authCheck:YES andController:@"KinoproViewController"];
                }
            }

            
        }];
        [[SingleTone sharedManager] setToken:token];
        
    }else{
        if([self checkAuthFB]){
            [self authCheck:YES andController:@"PersonalDataController"];
        }else{
            [self checkAuthVK];
        }
    }
    
  
    
}

-(void) authCheck: (BOOL) check andController:(NSString *) controller{
    UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    

    NSLog(@"CONTROLLER %@",controller);
    UIViewController * centerViewController =
    [mainStoryboard instantiateViewControllerWithIdentifier:controller];
    UIViewController * leftViewController =
    [mainStoryboard instantiateViewControllerWithIdentifier:@"LeftSideViewController"];
    
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor hx_colorWithHexRGBAString:COLOR_ALERT_BUTTON_COLOR]];

    
    UINavigationController * leftSideNav = [[UINavigationController alloc]
                                            initWithRootViewController:leftViewController];
    UINavigationController * centerNav = [[UINavigationController alloc]
                                          initWithRootViewController:centerViewController];
    
    leftSideNav.navigationBar.layer.shadowColor = [[UIColor darkGrayColor] CGColor];
    leftSideNav.navigationBar.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    leftSideNav.navigationBar.layer.shadowRadius = 3.0f;
    leftSideNav.navigationBar.layer.shadowOpacity = 1.0f;
    leftSideNav.navigationBar.layer.masksToBounds=NO;
    
    centerNav.navigationBar.layer.shadowColor = [[UIColor darkGrayColor] CGColor];
    centerNav.navigationBar.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    centerNav.navigationBar.layer.shadowRadius = 3.0f;
    centerNav.navigationBar.layer.shadowOpacity = 1.0f;
    centerNav.navigationBar.layer.masksToBounds=NO;
    
    
    
    
    
    self.centerContainer = [[MMDrawerController alloc]
                            initWithCenterViewController:centerNav
                            leftDrawerViewController:leftSideNav];
    
    //    self.centerContainer.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    //    self.centerContainer.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    //    [centerContainer setShowsShadow:NO];
    
    [self.window setRootViewController:self.centerContainer];
    [self.window makeKeyAndVisible];
    
    
    [[SingleTone sharedManager] setStringAletForWebView:@"0"];
    

}


@end
