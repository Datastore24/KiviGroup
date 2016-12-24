//
//  PersonalDataController.h
//  Kinopro365
//
//  Created by Виктор Мишустин on 11.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "MainViewController.h"
#import <NYAlertViewController/NYAlertViewController.h>
#import "UITextField+CheckNumber.h"

@interface PersonalDataController : MainViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *mainTopView;
@property (strong, nonatomic) NSString * tmpStringTest; //Сохранение строкового параметра

//Labels-----------
@property (weak, nonatomic) IBOutlet UILabel *labelCountPhoto;

//Buttons----------
@property (weak, nonatomic) IBOutlet UIButton *buttonAvatar;
@property (weak, nonatomic) IBOutlet UIButton *buttonCountry;
@property (weak, nonatomic) IBOutlet UIButton *buttonCity;
@property (weak, nonatomic) IBOutlet UIButton *buttonQuestion;
@property (weak, nonatomic) IBOutlet UIButton *buttonProfession;
@property (weak, nonatomic) IBOutlet UIButton *buttonPhoto;
@property (weak, nonatomic) IBOutlet UIButton *buttonVideo;
@property (weak, nonatomic) IBOutlet UIButton *bittonAddInformation;
@property (weak, nonatomic) IBOutlet UIButton *buttonAddParams;
@property (weak, nonatomic) IBOutlet UIButton *buttonNext;
@property (weak, nonatomic) IBOutlet UIButton *buttonBirthday;

//TextFilds------------
@property (weak, nonatomic) IBOutlet UITextField *textFildName;
@property (weak, nonatomic) IBOutlet UITextField *textFildLastName;
@property (weak, nonatomic) IBOutlet UITextField *textFildNameEN;
@property (weak, nonatomic) IBOutlet UITextField *textFildLastNameEN;
@property (weak, nonatomic) IBOutlet UITextField *textFildPhone1;
@property (weak, nonatomic) IBOutlet UITextField *textFildEmail;

//ImageView-------------
@property (weak, nonatomic) IBOutlet UIImageView *imageButtonProffecional;


//Actions----------------
- (IBAction)actionButtonAvatar:(UIButton *)sender;
- (IBAction)actionButtonCountry:(UIButton *)sender;
- (IBAction)actionButtonCity:(UIButton *)sender;
- (IBAction)actionButtonBirthday:(UIButton *)sender;
- (IBAction)actionButtonQuestion:(UIButton *)sender;
- (IBAction)actionButtonProfession:(UIButton *)sender;
- (IBAction)actionButtonPhoto:(UIButton *)sender;
- (IBAction)actionButtonVideo:(UIButton *)sender;
- (IBAction)actionButtonAddInfo:(UIButton *)sender;
- (IBAction)actionButtonAddParams:(UIButton *)sender;
- (IBAction)actionButtonNext:(UIButton *)sender;



@end
