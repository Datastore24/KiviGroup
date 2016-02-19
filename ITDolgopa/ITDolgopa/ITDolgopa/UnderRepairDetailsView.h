//
//  UnderRepairDetailsView.h
//  ITDolgopa
//
//  Created by Viktor on 18.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnderRepairDetailsView : UIView

- (instancetype)initWithView: (UIView*) view
                   andDevice: (NSString *) device
                       andSN: (NSString*) sN
                  andCreated: (NSString*) created
                 andBreaking: (NSString*) breaking
                   andStatus: (NSString*) status
              andStatusColor: (NSString*) statusColor
                andReadiness: (NSString*) readiness
               andFactRepair: (NSString*) factRepair;

- (instancetype)initWithCustomFrame:(CGRect)customFrame
                         andNameJob: (NSString*) nameJob
                        andPriceJob: (NSString*) priceJob
                            andView: (UIView*) view;

- (instancetype)initWithCuntomFrame: (CGRect) rect
                         andInTotal: (NSString*) inTotal
                      andPrepayment: (NSString*) prepayment
                           andToPay: (NSString*) toPay
                            andView: (UIView*) view;


@end
