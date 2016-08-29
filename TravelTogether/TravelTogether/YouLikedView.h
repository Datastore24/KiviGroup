//
//  YouLikedView.h
//  TravelTogether
//
//  Created by Виктор Мишустин on 29/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YouLikedViewDelegate;

@interface YouLikedView : UIView

@property (weak, nonatomic) id <YouLikedViewDelegate> delegate;

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data;

@end

@protocol YouLikedViewDelegate <NSObject>

@required

- (void) pushToHumanDetail: (YouLikedView*) youLikedView;

@end
