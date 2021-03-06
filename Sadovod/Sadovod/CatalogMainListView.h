//
//  CatalogMainListView.h
//  Sadovod
//
//  Created by Виктор Мишустин on 19/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CatalogMainListViewDelegate;

@interface CatalogMainListView : UIView

@property (weak, nonatomic) id <CatalogMainListViewDelegate> delegate;
@property (strong, nonatomic) UITableView * tableCatalog;

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data;

@end

@protocol CatalogMainListViewDelegate <NSObject>

@required
- (void) pushToCatalogListController: (CatalogMainListView*) catalogMainListView andCatId:(NSString *) catID
                          andCatName:(NSString *) catName;

@end
