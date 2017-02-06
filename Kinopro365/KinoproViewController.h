//
//  TwoViewController.h
//  Kinopro365
//
//  Created by Виктор Мишустин on 18.11.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MMDrawerController.h>
#import <MMDrawerBarButtonItem.h>
#import <UIViewController+MMDrawerController.h>
#import "MainViewController.h"
#import "AppDelegate.h"

@interface KinoproViewController : MainViewController <UITableViewDataSource, UITableViewDelegate>

- (IBAction)leftSideButtonMenu:(id)sender;
@property (strong, nonatomic) NSMutableArray * arrayData;


@end
