//
//  MyVacanciesDetailsController.h
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 02.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "MainViewController.h"
#import "CustomButton.h"

@interface MyVacanciesDetailsController : MainViewController

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UIView *viewForPerson;
@property (weak, nonatomic) IBOutlet UITextView *mainTextView;
@property (weak, nonatomic) IBOutlet CustomButton *buttonAddText;
@property (weak, nonatomic) IBOutlet UIView *viewForMainText;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewForVacansies;

@property (weak, nonatomic) IBOutlet UIImageView *mainImageVacancies;
@property (weak, nonatomic) IBOutlet UILabel *titleVacancies;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UILabel *activelyLabel;
@property (weak, nonatomic) IBOutlet UILabel *labelNumberRecall;

- (IBAction)actionBackButton:(id)sender;
- (IBAction)actionButtonTextAdd:(CustomButton*)sender;
- (IBAction)actionEditButton:(id)sender;
- (IBAction)actionDeleteButton:(id)sender;


@end
