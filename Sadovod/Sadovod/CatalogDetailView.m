//
//  CatalogDetailView.m
//  Sadovod
//
//  Created by Виктор Мишустин on 19/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "CatalogDetailView.h"
#import "UIView+BorderView.h"
#import "HexColors.h"
#import "Macros.h"
#import "UIButton+ButtonImage.h"

@interface CatalogDetailView ()

@property (strong, nonatomic) UIView * hideView;
@property (strong, nonatomic) UIButton * buttonSort;
@property (strong, nonatomic) UIButton * buttonColumnOne;
@property (strong, nonatomic) UIButton * buttonColumnTwo;

@end

@implementation CatalogDetailView

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 64.f, view.frame.size.width, view.frame.size.height - 64.f);
        
#pragma mark - TopBar
        
        UIView * topBarView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, 50.f)];
        [self addSubview:topBarView];
        [UIView borderViewWithHeight:49.f andWight:0.f andView:topBarView andColor:VM_COLOR_900];
        
        UITapGestureRecognizer *singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handleSingleTap:)];
        [self addGestureRecognizer:singleFingerTap];
        
        self.buttonSort = [UIButton customButtonSystemWithFrame:CGRectMake(0.f, 0.f, 160.f, 50.f) andColor:nil
                                                      andAlphaBGColor:1.f andBorderColor:nil andCornerRadius:0.f andTextName:@"Сортировать"
                                                         andColorText:VM_COLOR_800 andSizeText:13 andBorderWidht:0.f];
        [self.buttonSort addTarget:self action:@selector(buttonSortAction) forControlEvents:UIControlEventTouchUpInside];
        [topBarView addSubview:self.buttonSort];
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(140.f, 15.f, 20.f, 20.f)];
        imageView.image = [UIImage imageNamed:@"imageArrowDown.png"];
        [self.buttonSort addSubview:imageView];
        
        self.hideView = [[UIView alloc] initWithFrame:CGRectMake(10.f, 10.f, 150.f, 120.f)];
        self.hideView.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_300];
        self.hideView.alpha = 0.f;
        [self addSubview:self.hideView];
        
        //Массив имен кнопок---------
        NSArray * arrayNameButtons = [NSArray arrayWithObjects:@"Сортировать", @"По возрастанию цен",@"По снижению цен",@"По новизне", nil];
        
        for (int i = 0; i < 4; i++) {
            UIButton * buttonSortChange = [UIButton customButtonSystemWithFrame:CGRectMake(0.f, 0.f + 30.f * i, 150.f, 30) andColor:nil
                                                                andAlphaBGColor:1.f andBorderColor:nil andCornerRadius:0.f andTextName:[arrayNameButtons objectAtIndex:i]
                                                                   andColorText:@"000000" andSizeText:13 andBorderWidht:0.f];
            buttonSortChange.tag = 10 + i;
            [buttonSortChange addTarget:self action:@selector(buttonSortChangeAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.hideView addSubview:buttonSortChange];
        }

        self.buttonColumnOne = [UIButton createButtonCustomImageWithImage:@"buttonCollumImageOneNO.png" andRect:CGRectMake(self.frame.size.width / 2 + 40, 15, 20, 20)];
        [self.buttonColumnOne addTarget:self action:@selector(buttonColumnOneAction) forControlEvents:UIControlEventTouchUpInside];
        [topBarView addSubview:self.buttonColumnOne];
        self.buttonColumnTwo = [UIButton createButtonCustomImageWithImage:@"buttonCollumImageYES.png" andRect:CGRectMake((self.frame.size.width / 2 + 40) + 40, 15, 20, 20)];
        [self.buttonColumnTwo addTarget:self action:@selector(buttonColumnTwoAction) forControlEvents:UIControlEventTouchUpInside];
        self.buttonColumnTwo.userInteractionEnabled = NO;
        [topBarView addSubview:self.buttonColumnTwo];
        UIButton * buttonFilter = [UIButton createButtonCustomImageWithImage:@"imageButtonFilter.png" andRect:CGRectMake((self.frame.size.width / 2 + 40) + 40 * 2, 15, 20, 20)];
        [buttonFilter addTarget:self action:@selector(buttonFilterAction) forControlEvents:UIControlEventTouchUpInside];
        [topBarView addSubview:buttonFilter];
        
        
        


    }
    return self;
}


#pragma mark - Actions

- (void) buttonSortAction {
    [UIView animateWithDuration:0.3 animations:^{
        self.hideView.alpha = 1.f;
    }];
}

- (void) buttonSortChangeAction: (UIButton*) button {
    for (int i = 0; i < 4; i++) {
        if (button.tag == 10 + i) {
            [self.buttonSort setTitle:button.titleLabel.text forState:UIControlStateNormal];
            [UIView animateWithDuration:0.3 animations:^{
                self.hideView.alpha = 0.f;
            }];
        }
    }
}

- (void) buttonColumnOneAction {
    [UIView animateWithDuration:0.3 animations:^{
        [self.buttonColumnOne setImage:[UIImage imageNamed:@"buttonCollumImageOneYES.png"] forState:UIControlStateNormal];
        [self.buttonColumnTwo setImage:[UIImage imageNamed:@"buttonCollumImageNO.png"] forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        self.buttonColumnOne.userInteractionEnabled = NO;
        self.buttonColumnTwo.userInteractionEnabled = YES;
    }];
}

- (void) buttonColumnTwoAction {
    [UIView animateWithDuration:0.3 animations:^{
        [self.buttonColumnOne setImage:[UIImage imageNamed:@"buttonCollumImageOneNO.png"] forState:UIControlStateNormal];
        [self.buttonColumnTwo setImage:[UIImage imageNamed:@"buttonCollumImageYES.png"] forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        self.buttonColumnTwo.userInteractionEnabled = NO;
        self.buttonColumnOne.userInteractionEnabled = YES;
    }];
}

- (void) buttonFilterAction {
    NSLog(@"Переход в фильтр");
}


- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.hideView.alpha = 0.f;
    }];
    
}

@end
