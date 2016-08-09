//
//  MyTravelView.h
//  TravelTogether
//
//  Created by Виктор Мишустин on 02/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyTravelViewDelegate;

@interface MyTravelView : UIView

@property (weak, nonatomic) id <MyTravelViewDelegate> delegate;

- (instancetype)initWithView: (UIView*) view andData: (NSArray*) data;

@end

@protocol MyTravelViewDelegate <NSObject>

@required

- (void) pushTuTravel: (MyTravelView*) myTravelView;

@end
