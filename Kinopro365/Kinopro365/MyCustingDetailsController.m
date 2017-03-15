//
//  MyCustingDetailsController.m
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 08.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "MyCustingDetailsController.h"
#import "ViewCellMyCasting.h"
#import "MyCustingDetailsModel.h"
#import "DateTimeMethod.h"
#import "AddParamsModel.h"
#import <SDWebImage/UIImageView+WebCache.h> //Загрузка изображения


@interface MyCustingDetailsController () <ViewCellMyCastingDelegate, MyCustingDetailsModelDelegate>

@property (strong, nonatomic) UIScrollView * firstScrollView;
@property (strong, nonatomic) UIScrollView * secondScrollView;
@property (assign, nonatomic) CGFloat heightTextView;
@property (strong, nonatomic) NSDictionary * castingDict;
@property (strong, nonatomic) MyCustingDetailsModel * myCastingDetailsModel;

@end

@implementation MyCustingDetailsController

- (void) loadView {
    [super loadView];
    
    UILabel * CustomText = [[UILabel alloc]initWithTitle:@"Мои кастинги"];
    self.navigationItem.titleView = CustomText;
    
    self.mainScrollView.scrollEnabled = NO;
    self.mainScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.mainScrollView.bounds) * 2, 0);
    self.firstScrollView = [[UIScrollView alloc] initWithFrame:self.mainScrollView.bounds];
    [self.mainScrollView addSubview:self.firstScrollView];
    self.secondScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.mainScrollView.bounds), 0, CGRectGetWidth(self.mainScrollView.bounds), CGRectGetHeight(self.mainScrollView.bounds))];
    [self.mainScrollView addSubview:self.secondScrollView];
    
//    self.heightTextView = self.mainTextView.frame.origin.y;
    self.viewForLabel.layer.cornerRadius = CGRectGetHeight(self.viewForLabel.bounds) / 2;
    self.buttonTextAdd.isBool = YES;
    
    self.buttonConsideration.userInteractionEnabled = NO;
    
    self.myCastingDetailsModel = [[MyCustingDetailsModel alloc] init];
    self.myCastingDetailsModel.delegate = self;
    [self.myCastingDetailsModel loadCastings:self.castingID];
    
    
    
    //работа со скролом текста------------------------------
    
    
    
    NSLog(@"%@", NSStringFromCGRect(self.viewForMainText.frame));

}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    
    [self createActivitiIndicatorAlertWithView];
    
    //На рассмотрение
    
    //Одобренные
   
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loadMyCastings:(NSDictionary *) castingsDict{
    self.castingDict = nil;
    self.castingDict = castingsDict;
    self.textLabel.text = [self.castingDict objectForKey:@"name"];
    
    //Заголовок
    AddParamsModel * addParamsModel = [[AddParamsModel alloc] init];
    
    NSArray * castingType = [addParamsModel getTypeCustings];
    NSDictionary * paramsCasting = [addParamsModel getInformationDictionary:[self.castingDict objectForKey:@"project_type_id"] andProfArray:castingType];
   
    self.titleLabel.text =  [paramsCasting objectForKey:@"name"];
    
    //
    
    NSDate * endDate = [DateTimeMethod timestampToDate:[self.castingDict objectForKey:@"end_at"]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM"];
    NSString *stringDate = [dateFormatter stringFromDate:endDate];
    
    self.activelyLabel.text = [NSString stringWithFormat:@"Активно до: %@ ",stringDate];
    self.countryLabel.text = [NSString stringWithFormat:@"%@ (%@)",[self.castingDict objectForKey:@"city_name"],[self.castingDict objectForKey:@"country_name"]];
    self.labelConsideration.text =[NSString stringWithFormat:@"%@",[self.castingDict objectForKey:@"count_pending_offer"]];

    
    //Тестовые строки---------------------------------------
    NSLog(@"HIDE %@ COM %@",[self.castingDict objectForKey:@"contact_info"],[self.castingDict objectForKey:@"description"]);
    self.hideTextLabel.text = [self.castingDict objectForKey:@"contact_info"];
    self.comTextLabel.text = [self.castingDict objectForKey:@"description"];
    
    if(![[self.castingDict objectForKey:@"logo_url"] isEqual:[NSNull null]]){
        NSURL *imgURL = [NSURL URLWithString:[self.castingDict objectForKey:@"logo_url"]];
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:imgURL
                              options:0
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 // progression tracking code
                             }
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished,
                                        NSURL *imageURL) {
                                
                                if(image){
                                    self.mainImage.contentMode = UIViewContentModeScaleAspectFill;
                                    self.mainImage.clipsToBounds = YES;
                                    self.mainImage.layer.cornerRadius = 5;
                                    self.mainImage.image = image;
                                    [self deleteActivitiIndicator];
                                    
                                    
                                }else{
                                    //Тут обработка ошибки загрузки изображения
                                    [self deleteActivitiIndicator];
                                }
                            }];
    }else{
        [self deleteActivitiIndicator];
    }
    
    [self.myCastingDetailsModel loadOffersProfile:self.castingID andOffset:@"0" andCount:@"1000" complitionBlock:^(id response) {
        if([response isKindOfClass:[NSDictionary class]]){
            NSArray * respOffers = [response objectForKey:@"items"];
            for (UIView * view in self.firstScrollView.subviews) {
                [view removeFromSuperview];
            }
            
            
            
            for (int i = 0; i < respOffers.count; i++) {
                NSDictionary * dictOffers = [respOffers objectAtIndex:i];
                
                
                ViewCellMyCasting * cell = [[ViewCellMyCasting alloc] initWithMainView:self.firstScrollView endHeight:130.f * i endImageName:[dictOffers objectForKey:@"photo_url"] endName:[NSString stringWithFormat:@"%@ %@",[dictOffers objectForKey:@"first_name"],[dictOffers objectForKey:@"last_name"]] endCountry:[NSString stringWithFormat:@"%@ (%@)",[dictOffers objectForKey:@"city_name"],[dictOffers objectForKey:@"country_name"]] endAge:[NSString stringWithFormat:@"%@ лет",[dictOffers objectForKey:@"age"]] endIsReward:[[dictOffers objectForKey:@"is_reward"] boolValue] endRewardNumber:[NSString stringWithFormat:@"%@",[dictOffers objectForKey:@"count_rewards"]] endIsLike:[[dictOffers objectForKey:@"is_like"] boolValue] endLikeNumber:[NSString stringWithFormat:@"%@",[dictOffers objectForKey:@"count_likes"]] endIsBookmark:[[dictOffers objectForKey:@"is_favourite"] boolValue] endProfileID:[NSString stringWithFormat:@"%@",[dictOffers objectForKey:@"id"]] enfGrowth:[NSString stringWithFormat:@"рост: %@ см",[dictOffers objectForKey:@"height"]] endApproved: NO endCastingOfferID: [dictOffers objectForKey:@"casting_offer_id"]];
                    cell.delegate = self;
                    [self.firstScrollView addSubview:cell];
                
                

            }
            self.firstScrollView.contentSize = CGSizeMake(0, 130.f * respOffers.count);
            
        }
    }];
    
    
    
  [self.myCastingDetailsModel loadApprovedProfile:self.castingID andOffset:@"0" andCount:@"1000" complitionBlock:^(id response) {
      if([response isKindOfClass:[NSDictionary class]]){
          NSArray * respApproved = [response objectForKey:@"items"];
          for (UIView * view in self.secondScrollView.subviews) {
              [view removeFromSuperview];
          }
          
          for (int i = 0; i < respApproved.count; i++) {
              NSDictionary * dictApproved = [respApproved objectAtIndex:i];
            
                  ViewCellMyCasting * cell = [[ViewCellMyCasting alloc] initWithMainView:self.firstScrollView endHeight:130.f * i endImageName:[dictApproved objectForKey:@"photo_url"]
                                    endName:[NSString stringWithFormat:@"%@ %@",[dictApproved objectForKey:@"first_name"],[dictApproved objectForKey:@"last_name"]]
                                        endCountry:[NSString stringWithFormat:@"%@ (%@)",[dictApproved objectForKey:@"city_name"],[dictApproved objectForKey:@"country_name"]]
                                        endAge:[NSString stringWithFormat:@"%@ лет",[dictApproved objectForKey:@"age"]]
                                        endIsReward:[[dictApproved objectForKey:@"is_reward"] boolValue]
                                        endRewardNumber:[NSString stringWithFormat:@"%@",[dictApproved objectForKey:@"count_rewards"]]
                                        endIsLike:[[dictApproved objectForKey:@"is_like"] boolValue]
                                        endLikeNumber:[NSString stringWithFormat:@"%@",[dictApproved objectForKey:@"count_likes"]]
                                        endIsBookmark:[[dictApproved objectForKey:@"is_favourite"] boolValue]
                                        endProfileID:[NSString stringWithFormat:@"%@",[dictApproved objectForKey:@"id"]]
                                        enfGrowth:[NSString stringWithFormat:@"рост: %@ см",[dictApproved objectForKey:@"height"]]
                                                                             endApproved: YES
                                        endCastingOfferID: [dictApproved objectForKey:@"casting_offer_id"]];
                  cell.delegate = self;
                  [self.secondScrollView addSubview:cell];
    
             
          }
          
           self.secondScrollView.contentSize = CGSizeMake(0, 130.f * respApproved.count);
          
      }
  }];

}

#pragma mark - ViewCellMyCastingDelegate

- (void) actionWith: (ViewCellMyCasting*) viewCellMyCasting endButtonImage: (CustomButton*) sender {
    
    NSLog(@"Основная картинка ячейки");
}

- (void) actionWith: (ViewCellMyCasting*) viewCellMyCasting endButtonReward: (CustomButton*) sender {
    
    if (sender.isBool) {
        [sender setImage:[UIImage imageNamed:@"professionImageStar"] forState:UIControlStateNormal];
        NSInteger count = [viewCellMyCasting.numberRewar.text integerValue];
        count -= 1;
        viewCellMyCasting.numberRewar.text = [NSString stringWithFormat:@"%ld", count];
        sender.isBool = NO;
    } else {
        [sender setImage:[UIImage imageNamed:@"isRewarImageOn"] forState:UIControlStateNormal];
        NSInteger count = [viewCellMyCasting.numberRewar.text integerValue];
        count += 1;
        viewCellMyCasting.numberRewar.text = [NSString stringWithFormat:@"%ld", count];
        sender.isBool = YES;
    }
}

- (void) actionWith: (ViewCellMyCasting*) viewCellMyCasting endButtonLike: (CustomButton*) sender {
    
    if (sender.isBool) {
        [sender setImage:[UIImage imageNamed:@"professionImageLike"] forState:UIControlStateNormal];
        NSInteger count = [viewCellMyCasting.numberLike.text integerValue];
        count -= 1;
        viewCellMyCasting.numberLike.text = [NSString stringWithFormat:@"%ld", count];
        sender.isBool = NO;
    } else {
        [sender setImage:[UIImage imageNamed:@"isLikeImageOn"] forState:UIControlStateNormal];
        NSInteger count = [viewCellMyCasting.numberLike.text integerValue];
        count += 1;
        viewCellMyCasting.numberLike.text = [NSString stringWithFormat:@"%ld", count];
        sender.isBool = YES;
    }
}

- (void) actionWith: (ViewCellMyCasting*) viewCellMyCasting endButtonBookmark: (CustomButton*) sender {
    
    if (!sender.isBool) {
            [sender setImage:[UIImage imageNamed:@"professionImageBookmarkOn"]
                    forState:UIControlStateNormal];
            sender.isBool = YES;
    } else {
            [sender setImage:[UIImage imageNamed:@"professionImageBookmark"]
                    forState:UIControlStateNormal];
            sender.isBool = NO;
    }
}

- (void) actionWith: (ViewCellMyCasting*) viewCellMyCasting endButtonDelete: (CustomButton*) sender {
    
    NSLog(@"CUSTOMID %@",sender.customID);
    
    NSLog(@"Кнопка удаления");
    [self.myCastingDetailsModel decideCastings:sender.customID andDecision:@"2" complitionBlock:^(id response) {
        if([[response objectForKey:@"response"] integerValue] == 1){
            [self.myCastingDetailsModel loadCastings:self.castingID];
        }
    }];
}

- (void) actionWith: (ViewCellMyCasting*) viewCellMyCasting endButtonConfirm: (CustomButton*) sender {
    
    NSLog(@"Кнопка подтвеждения");
    [self.myCastingDetailsModel decideCastings:sender.customID andDecision:@"1" complitionBlock:^(id response) {
         if([[response objectForKey:@"response"] integerValue] == 1){
             [self.myCastingDetailsModel loadCastings:self.castingID];
         }
    }];
}

#pragma mark - Actions

- (IBAction)actionButtonBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionButtonEdit:(id)sender {
    NSLog(@"Редактировать");
}

- (IBAction)actionButtonDelete:(id)sender {
    NSLog(@"Удалить");
}

- (IBAction)actionButtontextAdd:(CustomButton*)sender {
    
    CGFloat height;
    
    if (sender.isBool) {
        height = self.view.bounds.size.height - self.viewForMainText.frame.origin.y;
        [sender setTitle:@"Свернуть" forState:UIControlStateNormal];
        //        self.imageHide.center = CGPointMake(9.5f, 3.5f);
        //rotate rect
        self.imageHide.transform = CGAffineTransformMakeRotation(M_PI); //rotation in radians
        sender.isBool = NO;
    } else {
        [sender setTitle:@"Развернуть" forState:UIControlStateNormal];
        self.imageHide.transform = CGAffineTransformMakeRotation(0); //rotation in radians
        height = 0;
        sender.isBool = YES;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rectForView = self.viewForMainText.frame;
//        CGRect rectTextView = self.mainTextView.frame;
//        rectTextView.size.height = height;
        rectForView.size.height = height;
//        self.mainTextView.frame = rectTextView;
        self.viewForMainText.frame = rectForView;
        self.scrollForText.frame = self.viewForMainText.bounds;
        
        CGFloat heightHideText = [self getLabelHeight:self.hideTextLabel];
        CGRect rectHideView = self.viewForHideText.frame;
        rectHideView.origin.y = 20.f;
        rectHideView.size.height = heightHideText;
        self.viewForHideText.frame = rectHideView;
        self.hideTextLabel.frame = CGRectMake(14.f, 0.f, self.viewForHideText.frame.size.width - 28.f, self.viewForHideText.frame.size.height);
        
        
        CGFloat heightComText = [self getLabelHeight:self.comTextLabel];
        CGRect rectComView = self.viewForComText.frame;
        rectComView.origin.y = CGRectGetMaxY(self.viewForHideText.frame) + 30;
        rectComView.size.height = heightComText;
        self.viewForComText.frame = rectComView;
        self.comTextLabel.frame = CGRectMake(14.f, 0.f, self.viewForComText.frame.size.width - 28.f, self.viewForComText.frame.size.height);
        self.scrollForText.contentSize = CGSizeMake(0, CGRectGetMaxY(self.viewForComText.frame) + 10.f);

        
    }];
    
}

- (IBAction)actionButtonConsideration:(CustomButton *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.mainScrollView.contentOffset = CGPointMake(0, 0);
        sender.userInteractionEnabled = NO;
        sender.alpha = 1.f;
        
        self.buttonConfirm.alpha = 0.45f;
        self.buttonConfirm.userInteractionEnabled = YES;
    }];
}

- (IBAction)actionButtonConfirm:(CustomButton *)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.mainScrollView.contentOffset = CGPointMake(CGRectGetWidth(self.mainScrollView.bounds), 0);
        sender.userInteractionEnabled = NO;
        sender.alpha = 1.f;
        
        self.buttonConsideration.alpha = 0.45f;
        self.buttonConsideration.userInteractionEnabled = YES;
    }];
}


#pragma mark - Other
- (CGFloat)getLabelHeight:(UILabel*)label
{
    CGSize constraint = CGSizeMake(label.frame.size.width, CGFLOAT_MAX);
    CGSize size;
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [label.text boundingRectWithSize:constraint
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:@{NSFontAttributeName:label.font}
                                                     context:context].size;
    
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    
    return size.height;
}


@end
