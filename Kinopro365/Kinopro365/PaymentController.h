//
//  PaymentControllerController.h
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

@interface PaymentController : MainViewController

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *labelCount;
@property (weak, nonatomic) IBOutlet UIButton *buttonChoosePay;
@property (weak, nonatomic) IBOutlet UIButton *buttonConfirm;
@property (weak, nonatomic) IBOutlet UIButton *buttonAtotherMan;
@property (weak, nonatomic) IBOutlet UIButton *buttonHistory;
@property (weak, nonatomic) IBOutlet UIButton *buttonVK;
@property (weak, nonatomic) IBOutlet UIButton *buttonFacebook;

#pragma mark - Actions

- (IBAction)actionButtonChoosePay:(id)sender;
- (IBAction)actionButtonConfirm:(id)sender;
- (IBAction)actionButtonAnotherMan:(id)sender;
- (IBAction)actionButtonHistory:(id)sender;
- (IBAction)actionButtonVK:(id)sender;
- (IBAction)actionButtonFacebook:(id)sender;
- (IBAction)actionButtonInstagram:(id)sender;
- (IBAction)actionButtonTwitter:(id)sender;

- (IBAction)actionButtonMenu:(id)sender;
@end
