//
//  HumanDetailView.h
//  TravelTogether
//
//  Created by Виктор Мишустин on 20/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HumanDetailViewDelegate;

@interface HumanDetailView : UIView

@property (weak, nonatomic) id <HumanDetailViewDelegate> delegate;

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data;

@end

@protocol HumanDetailViewDelegate <NSObject>

@required

- (void) pushToMessegerController: (HumanDetailView*) humanDetailView;

- (void) pushToLikedController: (HumanDetailView*) humanDetailView;

@end
