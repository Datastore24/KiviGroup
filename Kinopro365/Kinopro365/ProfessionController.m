//
//  ProfessionController.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 13.02.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "ProfessionController.h"
#import "ProfessionCellView.h"
#import "KinoproSearchController.h"
#import "ViewForScroll.h"
#import "Macros.h"
#import "ProfessionDetailController.h"


@interface ProfessionController () <ViewForScrollDelegate, ProfessionCellViewDelegate>

@property (strong, nonatomic) NSMutableArray * arrayScrollsView;
@property (strong, nonatomic) ViewForScroll * viewForScroll;

@property (assign, nonatomic) NSInteger stepX;
@property (assign, nonatomic) NSInteger stepY;


@end

@implementation ProfessionController

- (void) loadView {
    [super loadView];
    
    UILabel * customText = [[UILabel alloc]initWithTitle:@"Актеры"];
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
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.mainScrollView.contentOffset = CGPointZero;
    
    self.stepX = 0;
    self.stepY = 0;
    
    for (UIView * view in self.mainScrollView.subviews) {
        [view removeFromSuperview];
    }
    
    for (UIView * view in self.viewForScroll.subviews) {
        [view removeFromSuperview];
    }
    
    NSString * avatarImage = @"imagePhotoProf.png";
    NSString * name = @"Елизавета Филатова";
    NSString * country = @"Россия";
    NSString * city = @"Москва";
    NSString * age = @"25";
    NSString * growth = @"168";
    NSString * starCount = @"5";
    NSString * likeCount = @"15";
    int counter = 38;
    int step;
    int step2;
    
        if (counter % 5 == 0) {
            step = counter / 5;
        } else {
            step = counter / 5 + 1;
        }
        for (int i = 0; i < step; i++) {
            UIScrollView * scrolView = [[UIScrollView alloc] initWithFrame:CGRectMake(0 + CGRectGetWidth(self.view.bounds) * i,
                                                                                      0.f, self.mainScrollView.frame.size.width,
                                                                                      self.mainScrollView.frame.size.height)];
            scrolView.showsVerticalScrollIndicator = NO;
            [self.mainScrollView addSubview:scrolView];
            [self.arrayScrollsView addObject:scrolView];
            
            if (i != step - 1) {
                step2 = 5;
            } else {
                step2 = counter % 5;
            }
            for (int j = 0; j < step2; j++) {
                
                UILabel * labelCount = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, CGRectGetWidth(self.view.bounds), 16)];
                labelCount.text = @"Всего: 9485 анкет";
                labelCount.textAlignment = NSTextAlignmentCenter;
                labelCount.font = [UIFont fontWithName:FONT_ISTOK_REGULAR size:12];
                [scrolView addSubview:labelCount];
                
                ProfessionCellView * cellView = [[ProfessionCellView alloc]
                                                 initCellProfessionWithMainView:self.view andHeight:
                                                 (125.f * self.stepX) + 34.f andOrignX:0
                                                 andImageAvart: avatarImage andNameText:
                                                 name andCountryText:[NSString stringWithFormat:@"%@ (%@)", country, city]
                                                 andAgeText:[NSString stringWithFormat:@"%@ лет", age]
                                                 andGrowthText:[NSString stringWithFormat:@"рост: %@ см", growth]
                                                 andStarsNumber:starCount andLikeNumber:likeCount];
                cellView.deleagte = self;
                [scrolView addSubview:cellView];
                self.stepX += 1;
            }
            scrolView.contentSize = CGSizeMake(0, (125.f * step2) + 64.f + 34.f);
            self.stepX = 0;
            self.stepY += 1;
        }
        self.mainScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds) * (step), 0);
    
    
    self.viewForScroll = [[ViewForScroll alloc] initWithCustonView:self.view andRect:
                                     CGRectMake(0.f, CGRectGetHeight(self.view.bounds) - 45,
                                                CGRectGetWidth(self.view.bounds), 45.f) andCountScrolls:self.stepY];
    self.viewForScroll.delegate = self;
    [self.view addSubview:self.viewForScroll];
    
    
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
    [self pushCountryControllerWithIdentifier:@"KinoproSearchController"];
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
    if (!button.isBool) {
        [button setImage:[UIImage imageNamed:@"professionImageBookmarkOn"] forState:UIControlStateNormal];
        button.isBool = YES;
    } else {
        [button setImage:[UIImage imageNamed:@"professionImageBookmark"] forState:UIControlStateNormal];
        button.isBool = NO;
    }
}

- (void) actionButtonCell: (ProfessionCellView*) professionCellView withButton: (CustomButton*) button {
    
    [self pushCountryControllerWithIdentifier:@"ProfessionDetailController"];
    
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
