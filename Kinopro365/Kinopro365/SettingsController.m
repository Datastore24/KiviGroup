//
//  SettingsController.m
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 11.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "SettingsController.h"

@interface SettingsController ()

@end

@implementation SettingsController

- (void) loadView {
    [super loadView];
    
    self.navigationController.navigationBarHidden = NO;
    
    UILabel * customText = [[UILabel alloc]initWithTitle:@"Настройки"];
    self.navigationItem.titleView = customText;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)actionSettingsController:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.centerContainer toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
}

- (IBAction)actionButtonNotification:(id)sender {
    
    [self pushCountryControllerWithIdentifier:@"SettingsDetailsController"];
    
}
@end
