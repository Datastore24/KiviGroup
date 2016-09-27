//
//  BasketView.h
//  Sadovod
//
//  Created by Виктор Мишустин on 30/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BasketViewGelegate;

@interface BasketView : UIView

@property (weak, nonatomic) id <BasketViewGelegate> delegate;

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data;

@end

@protocol BasketViewGelegate <NSObject>

@required

- (void) backTuCatalog: (BasketView*) basketView;
- (void) getApiClearSizeToBasket: (BasketView*) basketView andSizeID: (NSString *) sizeID;
- (void) getApiChangeSizeCountBasket: (BasketView*) basketView andSizeID: (NSString *) sizeID andCount: (NSString *) count;

@end
