//
//  LeftSideViewController.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 17.11.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuViewModel.h"
#import "AppDelegate.h"
#import "SingleTone.h"

@interface MenuViewController () <MenuViewModelDelegate>

@end

@implementation MenuViewController

- (void) loadView{
    [super loadView];
    MenuViewModel * menuViewModel = [[MenuViewModel alloc] init];
    menuViewModel.delegate=self;
    [menuViewModel loadUserInformation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (IBAction)actionButtonKinopro:(id)sender {
    
    [self pushMethodWithIdentifier:@"KinoproViewController"];
    
}

- (IBAction)actionVacanciesButton:(id)sender {
    
    [[SingleTone sharedManager] setTypeView:@"0"];
    
    [self pushMethodWithIdentifier:@"VacanciesListController"];
}

- (IBAction)actionButtonCastings:(id)sender {
    
    [[SingleTone sharedManager] setTypeView:@"1"];
    
    [self pushMethodWithIdentifier:@"VacanciesListController"];
}

//редактирование профиля
- (IBAction)editProfileAction:(id)sender {
    [self pushMethodWithIdentifier:@"PersonalDataController"];
    
}


@end
