//
//  AddCastingController.h
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 09.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "MainViewController.h"

@interface AddCastingController : MainViewController

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UITextField *textFildName;

//Buttons
@property (weak, nonatomic) IBOutlet UIButton *buttonDate;
@property (weak, nonatomic) IBOutlet UIButton *buttonCountry;
@property (weak, nonatomic) IBOutlet UIButton *buttonCity;
@property (weak, nonatomic) IBOutlet UIButton *buttonType;
@property (weak, nonatomic) IBOutlet UIButton *buttonNeed;
@property (weak, nonatomic) IBOutlet CustomButton *buttonAgeFrom;
@property (weak, nonatomic) IBOutlet CustomButton *buttonAgeTo;
@property (weak, nonatomic) IBOutlet UIButton *buttonGender;
@property (weak, nonatomic) IBOutlet UIButton *buttonAddParams;
@property (weak, nonatomic) IBOutlet UIButton *buttonAddPhoto;

//Save
@property (weak, nonatomic) IBOutlet UIView *viewSave;
@property (weak, nonatomic) IBOutlet UIButton *buttonCreate;


//Actions
- (IBAction)actionBackButton:(id)sender;
- (IBAction)actionButtonAddPhoto:(id)sender;
- (IBAction)actionButtonDate:(id)sender;
- (IBAction)actionButtonCountry:(id)sender;
- (IBAction)actionButtonCity:(id)sender;
- (IBAction)actionButtonType:(id)sender;
- (IBAction)actionButtonNeed:(id)sender;
- (IBAction)actionButtonAgeFrom:(id)sender;
- (IBAction)actionButtonAgeTo:(id)sender;
- (IBAction)actionButtonGender:(id)sender;
- (IBAction)actionButtonAddParams:(id)sender;
- (IBAction)actionButtonCreate:(id)sender;


@end
