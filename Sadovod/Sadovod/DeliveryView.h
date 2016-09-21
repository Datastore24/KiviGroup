//
//  DeliveryView.h
//  Sadovod
//
//  Created by Виктор Мишустин on 09/09/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DeliveryViewDelegate;

@interface DeliveryView : UIView

@property (weak, nonatomic) id <DeliveryViewDelegate> delegate;

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data;

@end

@protocol DeliveryViewDelegate <NSObject>

@required

- (void) pushToQuestion: (DeliveryView*) deliveryView;
- (void) pushToFAQ: (DeliveryView*) deliveryView;
- (void) backToMain: (DeliveryView*) deliveryView;

@end
