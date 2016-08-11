//
//  SearchDetailView.h
//  TravelTogether
//
//  Created by Виктор Мишустин on 07/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchDetailViewDelegate;

@interface SearchDetailView : UIView

@property (weak, nonatomic) id <SearchDetailViewDelegate> delegate;

- (instancetype)initWithView: (UIView*) view andData: (NSArray*) data;

@end

@protocol SearchDetailViewDelegate <NSObject>

@required

- (void) pushToTravel: (SearchDetailView*) searchDetailView;

@end