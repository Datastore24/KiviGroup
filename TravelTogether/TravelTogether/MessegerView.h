//
//  MessegerView.h
//  TravelTogether
//
//  Created by Виктор Мишустин on 23/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MessegerViewDelegate;

@interface MessegerView : UIView

@property (weak, nonatomic) id <MessegerViewDelegate> delegate;

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data;

@end

@protocol MessegerViewDelegate <NSObject>

@required

- (void) addImage: (MessegerView*) messegerView;

@end
