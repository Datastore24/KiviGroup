//
//  LeftSideViewController.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 17.11.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "MenuViewController.h"
#import "AppDelegate.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)actionFirstViewButton:(id)sender {
    
    [self pushMethodWithIdentifier:@"ViewController"];
    
}

- (IBAction)actionSecondViewButton:(id)sender {
    
    [self pushMethodWithIdentifier:@"TwoViewController"];
    
}


- (void) pushMethodWithIdentifier: (NSString*) identifier {
    
    UIViewController * nextController =
    [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    UINavigationController * nextNavNav = [[UINavigationController alloc]
                                          initWithRootViewController:nextController];
    
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.centerContainer.centerViewController = nextNavNav;
    [appDelegate.centerContainer toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
    
}
@end
