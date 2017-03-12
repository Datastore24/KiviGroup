//
//  AddInfoemationController.h
//  Kinopro365
//
//  Created by Виктор Мишустин on 20.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "MainViewController.h"
#import "HexColors.h"
#import "Macros.h"

@interface AddInfoemationController : MainViewController <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textViewAddInformation;
@property (weak, nonatomic) IBOutlet UILabel *labelCustomPlaceholder;
@property (weak, nonatomic) IBOutlet UIButton *buttonSave;
@property (weak, nonatomic) IBOutlet UIView *viewForText;

//Actions-----
- (IBAction)actionBackBarButton:(id)sender;
- (IBAction)actionButtonSave:(UIButton *)sender;

@end
