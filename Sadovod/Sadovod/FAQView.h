//
//  FAQView.h
//  Sadovod
//
//  Created by Виктор Мишустин on 08/09/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FAQViewDelegate;

@interface FAQView : UIView

@property (weak, nonatomic) id <FAQViewDelegate> delegate;

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data;

@end

@protocol FAQViewDelegate <NSObject>

@required

- (void) pushTuQuestion: (FAQView*) fAQView;

@end
