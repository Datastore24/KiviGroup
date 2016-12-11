//
//  LoginViewController.h
//  Kinopro365
//
//  Created by Виктор Мишустин on 08.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "MainViewController.h"
#import <NYAlertViewController/NYAlertViewController.h>
#import "PersonalDataController.h"
#import "UITextField+CheckNumber.h"




@interface LoginViewController : MainViewController <UITextFieldDelegate>

//Buttons--
@property (weak, nonatomic) IBOutlet UIButton *buttonSendCode;
@property (weak, nonatomic) IBOutlet UIButton *buttonEntrance;


//Labels--
@property (weak, nonatomic) IBOutlet UILabel *labelTimerDontActive;
@property (weak, nonatomic) IBOutlet UILabel *labelTimerActive;

//TextFilds--
@property (weak, nonatomic) IBOutlet UITextField *textFildPhone;
@property (weak, nonatomic) IBOutlet UITextField *textFildPassword;



//--------------------------------------------------------------------

- (IBAction)actionButtonSendCode:(UIButton *)sender;
- (IBAction)actionButtonEntrance:(UIButton *)sender;
- (IBAction)actionButtonFacebook:(UIButton *)sender;
- (IBAction)actionButtonVK:(UIButton *)sender;



@end
