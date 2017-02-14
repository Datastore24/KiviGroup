//
//  KinoproSearchController.h
//  Kinopro365
//
//  Created by Виктор Мишустин on 2/1/17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "MainViewController.h"

@interface KinoproSearchController : MainViewController

@property (weak, nonatomic) IBOutlet UIView *topView;

//ImageView
@property (weak, nonatomic) IBOutlet UIImageView *arrowAgeOn;
@property (weak, nonatomic) IBOutlet UIImageView *arrowCountry;
@property (weak, nonatomic) IBOutlet UIImageView *arrowCity;
@property (weak, nonatomic) IBOutlet UIImageView *arrowAgeTo;

//Labels

@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelSurname;
@property (weak, nonatomic) IBOutlet UILabel *labelGender;
@property (weak, nonatomic) IBOutlet UILabel *labelAge;
@property (weak, nonatomic) IBOutlet UILabel *labelCountry;
@property (weak, nonatomic) IBOutlet UILabel *labelCity;

//TextFilds

@property (weak, nonatomic) IBOutlet UITextField *textFildName;
@property (weak, nonatomic) IBOutlet UITextField *textFildSurname;

//Buttons

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonsGender;
@property (weak, nonatomic) IBOutlet CustomButton *buttonAgeOn;
@property (weak, nonatomic) IBOutlet CustomButton *byttonAgeTo;
@property (weak, nonatomic) IBOutlet UIButton *buttonCountry;
@property (weak, nonatomic) IBOutlet UIButton *buttonCity;
@property (weak, nonatomic) IBOutlet UIButton *buttonAddParams;
@property (weak, nonatomic) IBOutlet UIButton *buttonClearFilter;
@property (weak, nonatomic) IBOutlet UIButton *buttonSearch;





//Actions

- (IBAction)actionButtonBack:(UIBarButtonItem *)sender;
- (IBAction)actionButtonsGender:(UIButton *)sender;

- (IBAction)actionButtonAgeOn:(id)sender;
- (IBAction)actionButtonAgeTo:(id)sender;

- (IBAction)actionButtonCountry:(id)sender;
- (IBAction)actionButtonCity:(id)sender;

- (IBAction)actionButtonAddParams:(id)sender;
- (IBAction)actionButtonClearFilter:(id)sender;

- (IBAction)actionButtonSearch:(id)sender;


@end
