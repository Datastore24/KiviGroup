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
#import "VacanciesListController.h"
#import "Macros.h"

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
- (IBAction)actionForCheck:(id)sender {
    
    for (int i = 0; i < self.arrayButtons.count; i++) {
        UILabel * label = [self.arrayLabels objectAtIndex:i];
        if ([[self.arrayButtons objectAtIndex:i] isEqual:sender]) {
            label.font = [UIFont fontWithName:FONT_ISTOK_BOLD size:16];
        } else {
            label.font = [UIFont fontWithName:FONT_ISTOK_REGULAR size:16];
        }
    }
}

- (IBAction)actionButtonKinopro:(id)sender {
    [self pushMethodWithIdentifier:@"KinoproViewController"];
    
}

- (IBAction)actionButtonVacancies:(id)sender {
    [[SingleTone sharedManager] setTypeView:@"0"];
    [self pushMethodWithIdentifier:@"VacanciesListController"];
}

- (IBAction)actionButtonCastings:(id)sender {
        [[SingleTone sharedManager] setTypeView:@"1"];
        [self pushMethodWithIdentifier:@"VacanciesListController"];
}

- (IBAction)actionButtonBookmark:(id)sender {
    [self pushMethodWithIdentifier:@"BookmarksController"];
}

- (IBAction)actionButtonSettings:(id)sender {
    [self pushMethodWithIdentifier:@"SettingsController"];  
}

- (IBAction)actionAllertButton:(id)sender {
    [self pushMethodWithIdentifier:@"AlertsController"];  
}

- (IBAction)actionButtonPayment:(id)sender {
   [self pushMethodWithIdentifier:@"PaymentController"];  
}

- (IBAction)actionButtonFeedback:(id)sender {
    [self pushMethodWithIdentifier:@"FeedbackController"];
}

//редактирование профиля
- (IBAction)editProfileAction:(id)sender {
    [self pushMethodWithIdentifier:@"PersonalDataController"];
    
}


@end
