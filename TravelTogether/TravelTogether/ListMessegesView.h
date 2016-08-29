//
//  ListMessegesView.h
//  TravelTogether
//
//  Created by Виктор Мишустин on 29/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ListMessegesViewDelegate;

@interface ListMessegesView : UIView

@property (weak, nonatomic) id <ListMessegesViewDelegate> delegate;

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data;

@end

@protocol ListMessegesViewDelegate <NSObject>

@required

- (void) pushToMesseger: (ListMessegesView*) listMessegesView;

@end
