//
//  BouquetsView.h
//  FlowersOnline
//
//  Created by Виктор Мишустин on 05.06.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BouquetsViewDelegate;

@interface BouquetsView : UIView <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) id <BouquetsViewDelegate> delegate;

- (instancetype)initWithView: (UIView*) view andArrayData: (NSArray*) array andCategoryData: (NSArray*) catData;

@end

@protocol BouquetsViewDelegate <NSObject>

@required

- (void) setCategiry: (BouquetsView*) bouquetsView withIDString: (NSString*) idString;

@end
