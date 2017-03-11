//
//  CastingDetailsController.h
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 07.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "MainViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface CastingDetailsController : MainViewController

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (strong, nonatomic) NSString * castingID;
@property (strong, nonatomic) NSString * castingName;
@property (strong, nonatomic) NSString * castingURL;
@property (strong, nonatomic) UIImage * castingImage;

//topView
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UILabel *labelType;
@property (weak, nonatomic) IBOutlet UILabel *labelActively;
@property (weak, nonatomic) IBOutlet UILabel *labelBidCount;

//titleView
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

//Hide view (данные открываются только если человека пригласили на кастинг)
@property (assign, nonatomic) BOOL openHideLabel;
@property (weak, nonatomic) IBOutlet UIView *viewForHide;
@property (weak, nonatomic) IBOutlet UILabel *labelForHide;

//descripthionView
@property (weak, nonatomic) IBOutlet UIView *viewDescription;
@property (weak, nonatomic) IBOutlet UILabel *labelDescription;

//paramsView
@property (weak, nonatomic) IBOutlet UIView *viewForParams;

//shareView
@property (weak, nonatomic) IBOutlet UIView *viewForShare;
@property (weak, nonatomic) IBOutlet UIButton *buttonVK;
@property (weak, nonatomic) IBOutlet UIButton *buttonFacebook;

//creationView
@property (weak, nonatomic) IBOutlet UIView *creationView;
@property (weak, nonatomic) IBOutlet UIButton *buttonAddBit;

//Массив вьюх, необходим для анимации
//0 - description
//1 - params
//2 - share
//3 - creation
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *arrayViews;

//Actions

- (IBAction)actionBackButton:(id)sender;
- (IBAction)actionButtonVK:(id)sender;
- (IBAction)actionButtonFacebook:(id)sender;
- (IBAction)actionButtonAddBit:(id)sender;

@end
