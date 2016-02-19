//
//  CustomCallView.h
//  ITDolgopa
//
//  Created by Viktor on 17.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCallView : UIView

- (id)initWithDevice: (NSString*) device
          andCreated: (NSString*) created
         andBreaking: (NSString*) breaking
        andReadiness: (NSString*) readiness
           andPPrice: (NSString*) pPrice
           andPrepay: (NSString*) prepay
           andStatus: (NSString*) status
      andColorStatus: (NSString*) color
             andView: (UIView*) view;

@end
