//
//  BookmarksController.h
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 10.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import <MMDrawerController.h>
#import <MMDrawerBarButtonItem.h>
#import <UIViewController+MMDrawerController.h>

@interface BookmarksController : MainViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)actionButtonMenu:(id)sender;

@end
