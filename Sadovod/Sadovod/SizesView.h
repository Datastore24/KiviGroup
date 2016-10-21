//
//  SizesView.h
//  Sadovod
//
//  Created by Виктор Мишустин on 13.09.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SizesViewDelegate;

@interface SizesView : UIView

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data;

@property (weak, nonatomic) id <SizesViewDelegate> delegate;

@end

@protocol SizesViewDelegate <NSObject>

@optional

- (void) pushToWebSize: (SizesView*) sizesView;

@end
