//
//  LeftSideViewController.h
//  Kinopro365
//
//  Created by Виктор Мишустин on 17.11.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MMDrawerController.h>
#import <MMDrawerBarButtonItem.h>
#import <UIViewController+MMDrawerController.h>

@interface MenuViewController : UIViewController
- (IBAction)actionFirstViewButton:(id)sender;
- (IBAction)actionSecondViewButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *userPhoto;
@property (weak, nonatomic) IBOutlet UILabel *userFLName;


@property (weak, nonatomic) IBOutlet UIButton *buttonKinopro;

- (IBAction)actionButtonKinopro:(id)sender;
- (IBAction)actionVacanciesButton:(id)sender;

@end
