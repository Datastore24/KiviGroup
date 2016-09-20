//
//  BottomBasketView.h
//  Sadovod
//
//  Created by Виктор Мишустин on 19.09.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BottomBasketViewDelegate;

@interface BottomBasketView : UIView

@property (weak,nonatomic) id <BottomBasketViewDelegate> delegate;
@property (strong, nonatomic) UIButton * buttonBasket;

- (instancetype)initBottomBasketViewWithPrice: (NSString*) price andCount: (NSString*) count andView: (UIView*) view;

@end

@protocol BottomBasketViewDelegate <NSObject>

@required

- (void) actionBasket: (BottomBasketView*) bottomBasketView;
- (void) actionFormalization: (BottomBasketView*) bottomBasketView;

@end
