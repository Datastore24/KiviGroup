//
//  CatalogListView.h
//  Sadovod
//
//  Created by Виктор Мишустин on 19/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CatalogListViewDelegate;

@interface CatalogListView : UIView

@property (weak, nonatomic) id <CatalogListViewDelegate> delegate;


- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data;

@end

@protocol CatalogListViewDelegate <NSObject>

@optional

- (void) pushToCatalogDetail: (CatalogListView*) catalogListView;

@end
