//
//  PhotoDetailsController.h
//  Kinopro365
//
//  Created by Виктор Мишустин on 2/6/17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "MainViewController.h"

@interface PhotoDetailsController : MainViewController

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *buttonConfDelete;

- (IBAction)actionButtonBack:(UIBarButtonItem *)sender;
- (IBAction)actionButtonAddPhoto:(UIBarButtonItem *)sender;
- (IBAction)actionDeleteButton:(UIBarButtonItem *)sender;
- (IBAction)actionButtonConfDelete:(UIButton *)sender;

@end
