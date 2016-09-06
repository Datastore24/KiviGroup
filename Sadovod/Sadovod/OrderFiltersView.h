//
//  OrderFiltersView.h
//  Sadovod
//
//  Created by Виктор Мишустин on 25/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderFiltersViewDelegate;

@interface OrderFiltersView : UIView

@property (weak, nonatomic) id <OrderFiltersViewDelegate> delegate;

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data;

@end

@protocol OrderFiltersViewDelegate <NSObject>

@required

- (void) backTuCatalog: (OrderFiltersView*) orderFiltersView andCost:(NSString*) cost andString:(NSString*) string;

@end
