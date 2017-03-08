//
//  AddVacanciesController.h
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 02.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "MainViewController.h"
#import "UIPlaceHolderTextView.h"
#import "CustomButton.h"


@interface AddVacanciesController : MainViewController

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (assign, nonatomic) BOOL isEditor;
@property (strong, nonatomic) NSString * vacancyID;
@property (strong, nonatomic) NSString * nameVacancy;
@property (strong, nonatomic) NSString * textViewVacancy;
@property (strong, nonatomic) UIImage * mainImageVacancy;
@property (strong, nonatomic) NSString * endAtVacancy;
@property (strong, nonatomic) NSString * professionNameVacancy;
@property (strong, nonatomic) NSString * professionIDVacancy;
@property (strong, nonatomic) NSString * countryNameVacancy;
@property (strong, nonatomic) NSString * cityNameVacancy;
@property (strong, nonatomic) NSString * countryIDVacancy;
@property (strong, nonatomic) NSString * cityIDVacancy;



@property (weak, nonatomic) IBOutlet UITextField *textFildName;
@property (weak, nonatomic) IBOutlet UIButton *buttonAddImage;
@property (weak, nonatomic) IBOutlet UIButton *buttonDate;
@property (weak, nonatomic) IBOutlet CustomButton *buttonProfession;
@property (weak, nonatomic) IBOutlet UIButton *buttonCountry;
@property (weak, nonatomic) IBOutlet UIButton *buttonCity;
@property (weak, nonatomic) IBOutlet UIButton *buttonCreate;

@property (weak, nonatomic) IBOutlet UIView *viewForComment;
@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *textView;

@property (weak, nonatomic) IBOutlet UIButton *createButton;


//Actions-----

- (IBAction)actionButtonBack:(id)sender;
- (IBAction)actionButtonAddImage:(id)sender;
- (IBAction)actionButtonDate:(id)sender;
- (IBAction)actionButtonProfession:(id)sender;
- (IBAction)actionButtonCountry:(id)sender;
- (IBAction)actionButtonCity:(id)sender;
- (IBAction)actionButtonCreate:(id)sender;

@end
