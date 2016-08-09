//
//  SearchTravelView.h
//  TravelTogether
//
//  Created by Виктор Мишустин on 04/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchTravelViewDelegate;

@interface SearchTravelView : UIView

@property (weak, nonatomic) id <SearchTravelViewDelegate> delegate;

- (instancetype)initMainViewSearchTravelWithView: (UIView*) view; //Основное вью

@end


@protocol SearchTravelViewDelegate <NSObject>

@required

- (void) pushToSearchList: (SearchTravelView*) searchTravelView;

@end