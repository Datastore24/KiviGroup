//
//  VKAPI.h
//  Kinopro365
//
//  Created by Кирилл Ковыршин on 21.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VKAPI : NSObject
- (void) getUserWithParams: (NSString *) userId andVkToken: (NSString *) vkToken complitionBlock: (void (^) (id response)) compitionBack;
@end
