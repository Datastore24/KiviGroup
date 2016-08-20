//
//  TravelView.h
//  TravelTogether
//
//  Created by Виктор Мишустин on 07/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TravelViewDelegate;

@interface TravelView : UIView

@property (weak, nonatomic) id <TravelViewDelegate> delegate;

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data;

@end

@protocol TravelViewDelegate <NSObject>

@required

- (void) pushToHumanDetail: (TravelView*) travelView andID: (NSString*) identifier;

@end
