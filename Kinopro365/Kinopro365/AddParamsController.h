//
//  AddParamsController.h
//  Kinopro365
//
//  Created by Виктор Мишустин on 20.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "MainViewController.h"

@interface AddParamsController : MainViewController

@property (weak, nonatomic) IBOutlet UIView *mainTopView;
@property (weak, nonatomic) IBOutlet UIButton *buttonSave;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonsInternationalPass;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonsChooseParams;
@property (weak, nonatomic) IBOutlet UIButton *buttonLanguages;

//Actions
- (IBAction)actionButtonInternationalPass:(id)sender;
- (IBAction)actionBackBarButton:(id)sender;
- (IBAction)actionButtonSave:(UIButton *)sender;
- (IBAction)actionButtonsChooseParams:(UIButton *)sender;

- (IBAction)actionButtonLanguages:(UIButton *)sender;


@end
