//
//  SettingsController.h
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 11.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import <MMDrawerController.h>
#import <MMDrawerBarButtonItem.h>
#import <UIViewController+MMDrawerController.h>

@interface SettingsController : MainViewController

@property (weak, nonatomic) IBOutlet UIButton *buttonNotification;

- (IBAction)actionSettingsController:(id)sender;
- (IBAction)actionButtonNotification:(id)sender;

@end
