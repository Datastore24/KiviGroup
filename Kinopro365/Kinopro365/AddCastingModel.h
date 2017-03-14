//
//  AddCastingModel.h
//  Kinopro365
//
//  Created by Кирилл Ковыршин on 13.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddCastingModel : NSObject

- (void) addCastingsParams: (NSDictionary *) params complitionBlock: (void (^) (id response)) compitionBack;

@end
