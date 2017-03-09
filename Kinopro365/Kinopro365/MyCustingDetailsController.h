//
//  MyCustingDetailsController.h
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 08.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "MainViewController.h"

@interface MyCustingDetailsController : MainViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UILabel *activelyLabel;

@property (weak, nonatomic) IBOutlet CustomButton *buttonHide;

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@end
