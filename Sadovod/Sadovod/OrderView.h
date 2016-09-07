//
//  OrderView.h
//  Sadovod
//
//  Created by Виктор Мишустин on 22/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderViewDelegate;

@interface OrderView : UIView

@property (weak, nonatomic) id <OrderViewDelegate> delegate;

- (instancetype)initWithView: (UIView*) view
                     andData: (NSDictionary*) data;

@end

@protocol OrderViewDelegate <NSObject>

@required

- (void) pushTuBiyView: (OrderView*) orderView;

@end
