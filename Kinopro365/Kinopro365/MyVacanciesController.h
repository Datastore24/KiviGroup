//
//  MyVacanciesController.h
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 02.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "MainViewController.h"

@interface MyVacanciesController : MainViewController


@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UILabel *labelListVacancies;



- (IBAction)actionButtonBack:(id)sender;
- (IBAction)actionAddVacancies:(id)sender;


@end
