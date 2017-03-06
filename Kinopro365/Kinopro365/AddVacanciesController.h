//
//  AddVacanciesController.h
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 02.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "MainViewController.h"
#import "UIPlaceHolderTextView.h"


@interface AddVacanciesController : MainViewController

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (weak, nonatomic) IBOutlet UITextField *textFildName;
@property (weak, nonatomic) IBOutlet UIButton *buttonAddImage;
@property (weak, nonatomic) IBOutlet UIButton *buttonDate;
@property (weak, nonatomic) IBOutlet UIButton *buttonProfession;
@property (weak, nonatomic) IBOutlet UIButton *buttonCountry;
@property (weak, nonatomic) IBOutlet UIButton *buttonCity;
@property (weak, nonatomic) IBOutlet UIButton *buttonCreate;

@property (weak, nonatomic) IBOutlet UIView *viewForComment;
@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *textView;

//Actions-----

- (IBAction)actionButtonBack:(id)sender;
- (IBAction)actionButtonAddImage:(id)sender;
- (IBAction)actionButtonDate:(id)sender;
- (IBAction)actionButtonProfession:(id)sender;
- (IBAction)actionButtonCountry:(id)sender;
- (IBAction)actionButtonCity:(id)sender;
- (IBAction)actionButtonCreate:(id)sender;

@end
