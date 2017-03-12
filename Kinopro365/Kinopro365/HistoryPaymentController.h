//
//  HistoryPaymentController.h
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 11.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "MainViewController.h"

@interface HistoryPaymentController : MainViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)actionButtonBack:(id)sender;

@end
