//
//  VacanciesListController.h
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 02.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "MainViewController.h"
#import <MMDrawerController.h>
#import <MMDrawerBarButtonItem.h>
#import <UIViewController+MMDrawerController.h>
#import "AppDelegate.h"

@interface VacanciesListController : MainViewController

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;


@property (weak, nonatomic) IBOutlet UIButton *buttonCountry;
@property (weak, nonatomic) IBOutlet UIButton *buttonCity;
@property (weak, nonatomic) IBOutlet UILabel *labelListVacancies;
@property (strong, nonatomic) UIImage * vacanciesImage;




- (IBAction)leftSideButtonMenu:(id)sender;
- (IBAction)pushMyVocansies:(id)sender;
- (IBAction)actionButtonCountry:(id)sender;
- (IBAction)actionButtonCity:(id)sender;

@end
