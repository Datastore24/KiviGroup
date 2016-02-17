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
         andBreaking: (NSString*) breaking
        andReadiness: (NSString*) readiness
           andStatus: (NSString*) status
      andColorStatus: (NSString*) color
             andView: (UIView*) view;

@end
