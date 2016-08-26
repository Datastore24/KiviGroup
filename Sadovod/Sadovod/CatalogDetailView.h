//
//  CatalogDetailView.h
//  Sadovod
//
//  Created by Виктор Мишустин on 19/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CatalogDetailViewDelegate;

@interface CatalogDetailView : UIView

@property (weak, nonatomic) id <CatalogDetailViewDelegate> delegate;

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data;

@end

@protocol CatalogDetailViewDelegate <NSObject>

@required

- (void) pushToOrderController: (CatalogDetailView*) catalogDetailView;
- (void) pushToOrderFilters: (CatalogDetailView*) catalogDetailView;

@end
