//
//  FeedbackController.h
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 12.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import <MMDrawerController.h>
#import <MMDrawerBarButtonItem.h>
#import <UIViewController+MMDrawerController.h>

@interface FeedbackController : MainViewController <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textViewAddInformation;
@property (weak, nonatomic) IBOutlet UILabel *labelCustomPlaceholder;
@property (weak, nonatomic) IBOutlet UIButton *buttonSave;
@property (weak, nonatomic) IBOutlet UIView *viewForText;

//Actions-----

- (IBAction)ActionButtonMenu:(id)sender;
- (IBAction)actionButtonSave:(UIButton *)sender;

@end
