//
//  MyFormView.h
//  TravelTogether
//
//  Created by Виктор Мишустин on 24/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyFormViewDelegate;

@interface MyFormView : UIView

@property (weak, nonatomic) id <MyFormViewDelegate> delegate;

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data;

@end

@protocol MyFormViewDelegate <NSObject>

@required

- (void) pushToMessegerController: (MyFormView*) myFormView;

- (void) pushToLikedController: (MyFormView*) myFormView;

@end
