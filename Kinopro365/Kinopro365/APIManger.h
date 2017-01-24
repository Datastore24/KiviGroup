//
//  APIManger.h
//  Hookah Manager
//
//  Created by Кирилл Ковыршин on 26.12.16.
//  Copyright © 2016 Viktor Mishustin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface APIManger : NSObject
- (void) getDataFromSeverWithMethod: (NSString *) method andParams: (NSDictionary *) params andToken: (NSString *) token complitionBlock: (void (^) (id response)) compitionBack;
- (void) postDataFromSeverWithMethod: (NSString *) method andParams: (NSDictionary *) params andToken: (NSString *) token complitionBlock: (void (^) (id response)) compitionBack;
- (void) postImageDataFromSeverWithMethod: (NSString *) method
                               andParams: (NSDictionary *) params
                                andToken: (NSString *) token
                                andImage: (UIImage*) image
                         complitionBlock: (void (^) (id response)) compitionBack;
@end
