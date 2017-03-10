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

@property (weak, nonatomic) IBOutlet UIButton *userPhoto;
@property (weak, nonatomic) IBOutlet UILabel *userFLName;


@property (weak, nonatomic) IBOutlet UIButton *buttonKinopro;
@property (weak, nonatomic) IBOutlet UIButton *buttonVacancies;

- (IBAction)actionButtonKinopro:(id)sender;
- (IBAction)actionButtonVacancies:(id)sender;
- (IBAction)actionButtonCastings:(id)sender;
- (IBAction)actionButtonBookmark:(id)sender;



@end
