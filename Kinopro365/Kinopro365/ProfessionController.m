//
//  ProfessionController.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 13.02.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "ProfessionController.h"
#import "ProfessionCellView.h"
#import "ProfessionModel.h"
#import "KinoproSearchController.h"
#import "ViewForScroll.h"
#import "Macros.h"
#import "ProfessionDetailController.h"
#import "UIView+BorderView.h"
#import "HexColors.h"


@interface ProfessionController () <ViewForScrollDelegate, ProfessionCellViewDelegate,ProfessionModelDelegate,KinoproSearchControllerDelegate>

@property (strong, nonatomic) NSMutableArray * arrayScrollsView;
@property (strong, nonatomic) ViewForScroll * viewForScroll;

@property (assign, nonatomic) NSInteger stepX;
@property (assign, nonatomic) NSInteger stepY;
@property (strong, nonatomic) ProfessionModel * profModel;


@end

@implementation ProfessionController

- (void) loadView {
    [super loadView];
    
    UILabel * customText = [[UILabel alloc]initWithTitle:self.professionName];
    self.navigationItem.titleView = customText;
    
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.scrollEnabled = NO;
    
    UIImage *myImage = [UIImage imageNamed:@"magnifying-glass"];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *glassButton = [[UIBarButtonItem alloc] initWithImage:myImage style:UIBarButtonItemStylePlain
                                                                   target:self action:@selector(actionGlassButton:)];
    self.navigationItem.rightBarButtonItem = glassButton;
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayScrollsView = [NSMutableArray array];
    [self createActivitiIndicatorAlertWithView];
    self.profModel = [[ProfessionModel alloc] init];
    self.profModel.delegate = self;
    [self.profModel loadProfessionFromServerOffset:@"0" andCount:@"50" andProfID:self.professionID andFilterArray:nil];
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.mainScrollView.contentOffset = CGPointZero;
    if(self.isFiltered){
        [self loadWithFilter:self.filterArray];
    }
    
}

-(void) loadWithFilter:(NSMutableDictionary *) filterArray{
    NSLog(@"FILTER %@",filterArray);
    NSDictionary * resultArray = [[NSDictionary alloc] initWithDictionary:filterArray];
    for(UIView * view in self.mainScrollView.subviews){
        [view removeFromSuperview];
    }
    
    [self.profModel loadProfessionFromServerOffset:@"0" andCount:@"50"
                                    andProfID:self.professionID
                               andFilterArray:resultArray];
}

- (void) loadProfession:(NSDictionary *) profDict{
    
    
    self.stepX = 0;
    self.stepY = 0;
    
    for (UIView * view in self.mainScrollView.subviews) {
        [view removeFromSuperview];
    }
    
    for (UIView * view in self.viewForScroll.subviews) {
        [view removeFromSuperview];
    }
    
    NSArray * itemsArray = [profDict objectForKey:@"items"];
    int counter = (int)itemsArray.count;
    int step;
    
    if (counter % 50 == 0) {
        step = counter / 50;
    } else {
        step = counter / 50 + 1;
    }
    UIScrollView * scrolView;
    UILabel * labelCount;
    for (int i = 0; i < step; i++) {
        scrolView = [[UIScrollView alloc] initWithFrame:CGRectMake(0 + CGRectGetWidth(self.view.bounds) * i,
                                                                                  0.f, self.mainScrollView.frame.size.width,
                                                                                  self.mainScrollView.frame.size.height)];
        scrolView.showsVerticalScrollIndicator = NO;
        [self.mainScrollView addSubview:scrolView];
        [self.arrayScrollsView addObject:scrolView];
        
        labelCount = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, CGRectGetWidth(self.view.bounds), 16)];
        
        
        labelCount.text =  [NSString stringWithFormat:@"Всего: %@ анкет",
                            [profDict objectForKey:@"count"]];
        labelCount.textColor = [[UIColor hx_colorWithHexRGBAString:@"343536"] colorWithAlphaComponent:0.75];
        labelCount.textAlignment = NSTextAlignmentCenter;
        labelCount.font = [UIFont fontWithName:FONT_ISTOK_REGULAR size:12];
        [scrolView addSubview:labelCount];
        
    }
        for (int j = 0; j < itemsArray.count; j++) {
            
            NSDictionary * itemDict = [itemsArray objectAtIndex:j];
            
            NSString * resultName = [NSString stringWithFormat:@"%@ %@",
                                     [itemDict objectForKey:@"first_name"],
                                     [itemDict objectForKey:@"last_name"]];
            
            UIView * upBorderView = [UIView createGrayBorderViewWithView:scrolView andHeight:CGRectGetMaxY(labelCount.frame) + 7 endType:NO];
            [scrolView addSubview:upBorderView];
            
            
            
            //Для Кирилла Пописать булевые параметры в конце метода !!---------
            
            ProfessionCellView * cellView = [[ProfessionCellView alloc]
                                             initCellProfessionWithMainView:self.view andHeight:
                                             (125.f * self.stepX) + 34.f andOrignX:0
                                             andImageAvart: [itemDict objectForKey:@"photo_url"]
                                             andNameText: resultName
                                             andCountryText:[NSString stringWithFormat:@"%@ (%@)",
                                                             [itemDict objectForKey:@"city_name"],
                                                             [itemDict objectForKey:@"country_name"]]
                                             andAgeText:[NSString stringWithFormat:@"Возраст: %@",
                                                         [itemDict objectForKey:@"age"]]
                                             andGrowthText:@""
                                             andStarsNumber:[itemDict objectForKey:@"count_rewards"]
                                             andLikeNumber:[itemDict objectForKey:@"count_likes"]
                                             andProfileID:[itemDict objectForKey:@"id"]
                                             andIsFavourite:[NSString stringWithFormat:@"%@", [itemDict objectForKey:@"is_favourite"]] endReward:NO endLike:NO];
            //-----------------------------------------------------------------------
            
            cellView.deleagte = self;
            [scrolView addSubview:cellView];
            self.stepX += 1;
        }
        scrolView.contentSize = CGSizeMake(0, (125.f * itemsArray.count) + 64.f + 34.f);
        self.stepX = 0;
        self.stepY += 1;
    
    self.mainScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds) * (step), 0);
    
    
    self.viewForScroll = [[ViewForScroll alloc] initWithCustonView:self.view andRect:
                          CGRectMake(0.f, CGRectGetHeight(self.view.bounds) - 45,
                                     CGRectGetWidth(self.view.bounds), 45.f) andCountScrolls:self.stepY];
    self.viewForScroll.delegate = self;
    [self.view addSubview:self.viewForScroll];
    [self deleteActivitiIndicator];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)actionBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) actionGlassButton: (UIBarButtonItem*) button {
    
    KinoproSearchController * searchController = [self.storyboard instantiateViewControllerWithIdentifier:@"KinoproSearchController"];
    searchController.profID = self.professionID;
    [self.navigationController pushViewController:searchController animated:YES];
    
}


#pragma mark - ViewForScrollDelegate

- (void) actionMoveLeftWithView: (ViewForScroll*) viewForScroll andButton: (UIButton*) sender
                andArrayButtons:(NSMutableArray *)arrayButtons {
    
    if (self.mainScrollView.contentOffset.x > 0) {
        [UIView animateWithDuration:0.3 animations:^{
            self.mainScrollView.contentOffset =
            CGPointMake(self.mainScrollView.contentOffset.x - CGRectGetWidth(self.view.bounds),
                        self.mainScrollView.contentOffset.y);
        }];
        
        UIButton * button = [arrayButtons objectAtIndex:0];
        [self animationButtonsWithArrayButtons:arrayButtons andSize:button.frame.size.width];
    }
}

- (void) actionMoveRightWithView: (ViewForScroll*) viewForScroll andButton: (UIButton*) sender
                 andArrayButtons:(NSMutableArray *)arrayButtons {
    
    if (self.mainScrollView.contentOffset.x < CGRectGetWidth(self.view.bounds) * (self.stepY - 1)) {
        [UIView animateWithDuration:0.3 animations:^{
            self.mainScrollView.contentOffset =
            CGPointMake(self.mainScrollView.contentOffset.x + CGRectGetWidth(self.view.bounds),
                        self.mainScrollView.contentOffset.y);
        }];
        
        UIButton * button = [arrayButtons objectAtIndex:0];
        [self animationButtonsWithArrayButtons:arrayButtons andSize:-button.frame.size.width];
    }
}

- (void) actionButtonLablCount: (ViewForScroll*) viewForScroll andButton: (UIButton*) sender {
    
    NSInteger mainTag = 0;
    CGFloat sizeButton = 0.0;
    UIButton * buttonForSize = [self.viewForScroll.arayButtons objectAtIndex:0];
    
    for (UIButton * button in self.viewForScroll.arayButtons) {
        if (button.userInteractionEnabled == NO) {
            mainTag = button.tag;
        }
    }
    if (mainTag > sender.tag) {
        [UIView animateWithDuration:0.3 animations:^{
            self.mainScrollView.contentOffset =
            CGPointMake(self.mainScrollView.contentOffset.x - CGRectGetWidth(self.view.bounds),
                        self.mainScrollView.contentOffset.y);
        }];
       sizeButton = buttonForSize.bounds.size.width;
    } else {
       sizeButton = -buttonForSize.bounds.size.width;
        [UIView animateWithDuration:0.3 animations:^{
            self.mainScrollView.contentOffset =
            CGPointMake(self.mainScrollView.contentOffset.x + CGRectGetWidth(self.view.bounds),
                        self.mainScrollView.contentOffset.y);
        }];
    }
    [self animationButtonsWithArrayButtons:self.viewForScroll.arayButtons andSize:sizeButton];

}

#pragma mark - ProfessionCellViewDelegate

- (void) actionBookMark: (ProfessionCellView*) professionCellView withButton: (CustomButton*) button {
    ProfessionModel * profModel =[[ProfessionModel alloc] init];
    if (!button.isBool) {
        
        [profModel sendIsFavourite:NO andProfileID:button.customID complitionBlock:^{
            [button setImage:[UIImage imageNamed:@"professionImageBookmarkOn"]
                    forState:UIControlStateNormal];
            button.isBool = YES;
        }];
        
        
        
    } else {
        
        [profModel sendIsFavourite:YES andProfileID:button.customID complitionBlock:^{
            [button setImage:[UIImage imageNamed:@"professionImageBookmark"]
                    forState:UIControlStateNormal];
            button.isBool = NO;
        }];
        
    }
}

- (void) actionButtonCell: (ProfessionCellView*) professionCellView withButton: (CustomButton*) button {
    
    ProfessionDetailController * profController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfessionDetailController"];
    
    profController.profileID = button.customID;
    profController.profName = self.professionName;
    profController.profID = self.professionID;
    profController.buttonBookmarkBack = button.customButton;
    
    [self.navigationController pushViewController:profController animated:YES];
    
    
}

- (void) actionLike: (ProfessionCellView*) professionCellView withButton: (CustomButton*) button {
    
    if (button.isBool) {
        [button setImage:[UIImage imageNamed:@"professionImageLike"] forState:UIControlStateNormal];
        NSInteger count = [professionCellView.labelNumberLike.text integerValue];
        count -= 1;
        professionCellView.labelNumberLike.text = [NSString stringWithFormat:@"%ld", count];
        button.isBool = NO;
    } else {
        [button setImage:[UIImage imageNamed:@"isLikeImageOn"] forState:UIControlStateNormal];
        NSInteger count = [professionCellView.labelNumberLike.text integerValue];
        count += 1;
        professionCellView.labelNumberLike.text = [NSString stringWithFormat:@"%ld", count];
        button.isBool = YES;
    }
    
}
- (void) actionReward: (ProfessionCellView*) professionCellView withButton: (CustomButton*) button {
    
    if (button.isBool) {
        [button setImage:[UIImage imageNamed:@"professionImageStar"] forState:UIControlStateNormal];
        NSInteger count = [professionCellView.labelNumberStars.text integerValue];
        count -= 1;
        professionCellView.labelNumberStars.text = [NSString stringWithFormat:@"%ld", count];
        button.isBool = NO;
    } else {
        [button setImage:[UIImage imageNamed:@"isRewarImageOn"] forState:UIControlStateNormal];
        NSInteger count = [professionCellView.labelNumberStars.text integerValue];
        count += 1;
        professionCellView.labelNumberStars.text = [NSString stringWithFormat:@"%ld", count];
        button.isBool = YES;
    } 
}



#pragma mark - Animation

- (void) animationButtonsWithArrayButtons: (NSMutableArray*) arrayButtons andSize: (CGFloat) size {
    
    NSInteger tagCenter = 0;
    for (UIButton * button in arrayButtons) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect buttonRect = button.frame;
            buttonRect.origin.x += size;
            button.frame = buttonRect;
        }];
        if (button.userInteractionEnabled == NO) {
           tagCenter = button.tag;
        }
    }
    UIButton * buttonNext;
    if (size < 0) {
        buttonNext = [self.viewForScroll viewWithTag:tagCenter + 1];
    } else {
        buttonNext = [self.viewForScroll viewWithTag:tagCenter - 1];
    }
    for (UIButton * button in arrayButtons) {
        if ([button isEqual:buttonNext]) {
            [UIView animateWithDuration:0.3 animations:^{
                    button.titleLabel.font = [UIFont fontWithName:FONT_ISTOK_BOLD size:18];
                    button.userInteractionEnabled = NO;
            }];
        } else {
            button.titleLabel.font = [UIFont fontWithName:FONT_ISTOK_REGULAR size:16];
            button.userInteractionEnabled = YES;
        }
    }
    
}




@end
