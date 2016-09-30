//
//  OldOrderView.h
//  Sadovod
//
//  Created by Виктор Мишустин on 29.09.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OldOrderViewDelegate;

@interface OldOrderView : UIView

@property (weak, nonatomic) id <OldOrderViewDelegate> delegate;

- (instancetype)initWithView: (UIView*) view;

@end

@protocol OldOrderViewDelegate <NSObject>

@optional

- (void) puthToFAQ: (OldOrderView*) oldOrderView;

@end
