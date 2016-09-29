//
//  BuyView.h
//  Sadovod
//
//  Created by Виктор Мишустин on 26/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BuyViewDelegate;

@interface BuyView : UIView

@property (weak, nonatomic) id <BuyViewDelegate> deleagte;
//TableSize

@property (strong, nonatomic) UITableView * tableSize;

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data
                     andCart: (NSArray *) cart;

@end

@protocol BuyViewDelegate <NSObject>




- (void) hideCountOrder: (BuyView*) buyView;

- (void) showBasketView: (BuyView*) buyView;

- (void) getApiAddToBasket: (NSString *) sizeID;
- (void) getApiDelToBasket: (NSString *) sizeID;
- (void) getApiClearSizeToBasket: (NSString *) sizeID;
- (void) getApiClearAllSizeToBasket;
- (void) getApiAddAllSizeToBasket;
- (void) getApiDelAllSizeToBasket;


@end
