//
//  PriceView.h
//  Sadovod
//
//  Created by Виктор Мишустин on 09/09/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PriceViewDelegate;

@interface PriceView : UIView

@property (weak, nonatomic) id <PriceViewDelegate> delegate;

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data;

@end

@protocol PriceViewDelegate <NSObject>

@required

- (void) pushToQuestion: (PriceView*) priceView;
- (void) pushToFAQ: (PriceView*) priceView;
- (void) backToMain: (PriceView*) priceView;

@end
