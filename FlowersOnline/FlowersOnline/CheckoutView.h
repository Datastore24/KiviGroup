//
//  CheckoutView.h
//  FlowersOnline
//
//  Created by Viktor on 20.06.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CheckoutViewDelegate; 

@interface CheckoutView : UIView

@property (weak, nonatomic) id <CheckoutViewDelegate> delegate;

- (instancetype)initWithView: (UIView*) view;

@end

@protocol CheckoutViewDelegate <NSObject>

@required

- (void) sendToServer: (CheckoutView*) bouquetsView withDict: (NSDictionary*) sendDict;

@end
