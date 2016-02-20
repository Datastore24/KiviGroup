//
//  BalanceView.h
//  ITDolgopa
//
//  Created by Viktor on 20.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BalanceView : UIView

- (instancetype)initWithView: (UIView*) view
                   andInWork: (NSString*) inWork
                    andReady: (NSString*) ready
                     andDone: (NSString*) done
                      andAll: (NSString*) all
                 andAllMoney: (NSString*) allMoney
                     andDolg: (NSString*) dolg;

- (instancetype)initWithView:(UIView*) view
            andInworkVendors: (NSString*) inworkVendors
             andInworkPprice: (NSString*) inworkPprice;

@end
