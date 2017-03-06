//
//  VacanciesDetailsController.h
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 02.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "MainViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface VacanciesDetailsController : MainViewController

@property (strong, nonatomic) NSString * vacancyID;
@property (strong, nonatomic) NSString * vacancyName;
@property (strong, nonatomic) NSString * vacancyURL;
@property (strong, nonatomic) UIImage * vacancyImage;
@property (weak, nonatomic) IBOutlet UIButton *buttonApply;
@property (weak, nonatomic) IBOutlet UIView *mainWhiteView;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UIView *twoWithView;



@property (weak, nonatomic) IBOutlet UILabel *mainTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *viewForMainText;

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *ProffesionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *activeLabel;
@property (weak, nonatomic) IBOutlet UILabel *counterLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@property (weak, nonatomic) IBOutlet UIButton *buttonVK;
@property (weak, nonatomic) IBOutlet UIButton *buttonFacebook;





//ArrayForAnimation (массив вьюх которые ндао сдвигать при большом описании)

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *arrayForAnimation;


- (IBAction)actionButtonBack:(id)sender;
- (IBAction)actionButtonVK:(id)sender;
- (IBAction)actionButtonFacebook:(id)sender;
- (IBAction)actionButtonApply:(id)sender;


@end
