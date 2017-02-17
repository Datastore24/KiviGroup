//
//  ProfessionDetailController.h
//  Kinopro365
//
//  Created by Виктор Мишустин on 14.02.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "MainViewController.h"

@interface ProfessionDetailController : MainViewController

@property (weak, nonatomic) IBOutlet UIView *viewForPhoto;


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
@property (weak, nonatomic) IBOutlet UIButton *buttonLike;
@property (weak, nonatomic) IBOutlet UIButton *buttonStar;
@property (weak, nonatomic) IBOutlet UIButton *buttonPhoneOne;
@property (weak, nonatomic) IBOutlet UIButton *buttonPhoneTwo;

//Labels
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelCountry;
@property (weak, nonatomic) IBOutlet UILabel *labelAge;
@property (weak, nonatomic) IBOutlet UILabel *labelGrowth;
@property (weak, nonatomic) IBOutlet UILabel *labelStarCount;
@property (weak, nonatomic) IBOutlet UILabel *labelLikeCount;
@property (weak, nonatomic) IBOutlet UIImageView *imageAvatar;


- (IBAction)actionButtonBack:(UIBarButtonItem *)sender;
- (IBAction)actionButtonBookmark:(CustomButton*)sender;
- (IBAction)actionButtonLike:(id)sender;
- (IBAction)actionButtomStar:(id)sender;

@end
