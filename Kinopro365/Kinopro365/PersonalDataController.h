//
//  PersonalDataController.h
//  Kinopro365
//
//  Created by Виктор Мишустин on 11.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "MainViewController.h"

@interface PersonalDataController : MainViewController

@property (weak, nonatomic) IBOutlet UIView *mainViewPersonalData;
@property (weak, nonatomic) IBOutlet UIButton *buttonNext;
@property (weak, nonatomic) IBOutlet UIView *viewRedRound;
@property (weak, nonatomic) IBOutlet UIButton *buttonChoiceProfession;



- (IBAction)actionButtonHelp:(UIButton *)sender;




@end
