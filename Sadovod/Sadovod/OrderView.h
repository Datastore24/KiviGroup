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
@property (strong, nonatomic) UIScrollView * mainScrollView;;

@end

@protocol OrderViewDelegate <NSObject>

@required

@property (strong,nonatomic) NSString* productName;
@property (strong,nonatomic) NSString* productPrice;


- (void) pushTuBiyView: (OrderView*) orderView;
- (void) showBottomBar: (OrderView*) orderView;
- (void) getApiAddCart: (OrderView*) orderView andProductID: (NSString *) productID ;
- (void) pushAuthorization: (OrderView*) orderView;


@end
