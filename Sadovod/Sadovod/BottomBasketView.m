//
//  BottomBasketView.m
//  Sadovod
//
//  Created by Виктор Мишустин on 19.09.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "BottomBasketView.h"
#import "HexColors.h"
#import "Macros.h"
#import "CustomLabels.h"
#import "MainViewController.h"

@interface BottomBasketView ()

@property (strong, nonatomic) MainViewController * mainController;

@end

@implementation BottomBasketView

- (instancetype)initBottomBasketViewWithPrice: (NSString*) price andCount: (NSString*) count andView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, view.frame.size.height - 50.f, view.frame.size.width, 50.f);
        self.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"4C4C4C" alpha:0.8];
        
        self.mainController = [[MainViewController alloc] init];
        
        
        self.buttonBasket = [UIButton buttonWithType:UIButtonTypeSystem];
        self.buttonBasket.frame = CGRectMake(10.f, 0.f, view.frame.size.width - 110.f, 50.f);
        [self.buttonBasket setTitle:[NSString stringWithFormat:@"Итого %@ шт на %@ руб", count, price] forState:UIControlStateNormal];
        [self.buttonBasket setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.buttonBasket.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
        self.buttonBasket.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.buttonBasket addTarget:self action:@selector(buttonBasketAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.buttonBasket];
        
        UIView * backgroundView = [[UIView alloc] initWithFrame:CGRectMake(view.frame.size.width - 100.f, 0.f, 1.f, 50.f)];
        backgroundView.backgroundColor = [UIColor blackColor];
        [self addSubview:backgroundView];
        
        UIButton * buttonContents = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonContents.frame = CGRectMake(view.frame.size.width - 99.f, 0.f, 99.f, 50.f);
        [buttonContents setTitle:@"Оформить" forState:UIControlStateNormal];
        [buttonContents setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonContents.titleLabel.font = [UIFont fontWithName:VM_FONT_BOLD size:15];
        [buttonContents addTarget:self action:@selector(buttonContentsAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonContents];
        
        self.alpha = 0.f;
    }
    return self;
}



#pragma mark - Actions
//Действие нажатия на вью с данными
- (void) buttonBasketAction {
    [self.delegate actionBasket:self];
}
//Действие нажатия на кнопку оформить
- (void) buttonContentsAction {
    [self.delegate actionFormalization:self];
}

@end
