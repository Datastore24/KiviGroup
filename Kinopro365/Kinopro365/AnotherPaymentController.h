//
//  AnotherPaymentController.h
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 11.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "MainViewController.h"

@interface AnotherPaymentController : MainViewController

- (IBAction)actionButtonBack:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *textFildID;
@property (weak, nonatomic) IBOutlet UIButton *buttonTime;
@property (weak, nonatomic) IBOutlet UIButton *buttonConfirm;

- (IBAction)actionButtonTime:(id)sender;
- (IBAction)actionButtonConfirm:(id)sender;

@end
