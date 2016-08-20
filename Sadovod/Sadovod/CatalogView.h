//
//  CatalogView.h
//  Sadovod
//
//  Created by Виктор Мишустин on 18/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CatalogViewDelegate;

@interface CatalogView : UIView

- (instancetype)initWithView: (UIView*) view
                     andData: (NSMutableArray*) data
                     andName:(NSArray*) arrayName;

@property (weak, nonatomic) id <CatalogViewDelegate> delegate;

@end

@protocol CatalogViewDelegate <NSObject>

@required

- (void) getCatalog: (CatalogView*) catalogView;


@end
