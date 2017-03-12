//
//  AlertsController.h
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
#import "HVTableView.h"


@interface AlertsController : MainViewController
@property (weak, nonatomic) IBOutlet HVTableView *tableView;

- (IBAction)actionButtonMenu:(id)sender;

@end
