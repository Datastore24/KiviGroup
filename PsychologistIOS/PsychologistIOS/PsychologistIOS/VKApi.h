//
//  VKApi.h
//  PsychologistIOS
//
//  Created by Кирилл Ковыршин on 14.05.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VKApi : NSObject
-(void) getUserWithParams: (NSDictionary *) params complitionBlock: (void (^) (id response)) compitionBack;

@end
