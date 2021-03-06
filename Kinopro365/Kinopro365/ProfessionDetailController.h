//
//  ProfessionDetailController.h
//  Kinopro365
//
//  Created by Виктор Мишустин on 14.02.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "MainViewController.h"
#import <MMDrawerController.h>
#import <MMDrawerBarButtonItem.h>
#import <UIViewController+MMDrawerController.h>
#import "AppDelegate.h"

@interface ProfessionDetailController : MainViewController

@property (weak, nonatomic) IBOutlet UIView *viewForPhoto;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButtonID;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *arrayCollectionNo;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *arrayCollectionYES;

@property (strong, nonatomic) NSString * profileID;
@property (strong, nonatomic) NSString * profName;
@property (strong, nonatomic) NSString * profID;


//Scrolls
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *photoScrollView;

//Buttons
@property (weak, nonatomic) IBOutlet CustomButton *buttonBookmark;
@property (weak, nonatomic) IBOutlet CustomButton *buttonBookmarkBack;
@property (weak, nonatomic) IBOutlet CustomButton *buttonLike;
@property (weak, nonatomic) IBOutlet CustomButton *buttonStar;
@property (weak, nonatomic) IBOutlet UIButton *buttonPhoneOne;
@property (weak, nonatomic) IBOutlet UIButton *buttonPhoneTwo;
@property (weak, nonatomic) IBOutlet UIButton *buttonAvatar;


//Labels
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelCountry;
@property (weak, nonatomic) IBOutlet UILabel *labelAge;
@property (weak, nonatomic) IBOutlet UILabel *labelGrowth;
@property (weak, nonatomic) IBOutlet UILabel *labelStarCount;
@property (weak, nonatomic) IBOutlet UILabel *labelLikeCount;
@property (weak, nonatomic) IBOutlet UIView *shadowView;

//Viewvers
@property (weak, nonatomic) IBOutlet UIImageView *viewrsImage;
@property (weak, nonatomic) IBOutlet UILabel *viewrsLabel;



- (IBAction)actionButtonBookmark:(CustomButton*)sender;
- (IBAction)actionButtonLike:(CustomButton*)sender;
- (IBAction)actionButtomStar:(CustomButton*)sender;
- (IBAction)barButtonID:(id)sender;
- (IBAction)actionButtonAvatar:(id)sender;


@end
