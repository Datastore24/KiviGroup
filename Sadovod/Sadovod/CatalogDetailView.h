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
@property (strong, nonatomic) NSArray * arrayData;
@property (strong, nonatomic) NSString * catID;
- (void) pushToOrderController: (CatalogDetailView*) catalogDetailView;
- (void) pushToOrderFilters: (CatalogDetailView*) catalogDetailView andCatID: (NSString*) catID;
- (void) getApiCatalog:(CatalogDetailView*) catalogDetailView andBlock: (void (^)(void))block andSort:(NSString *) sort;

@end
