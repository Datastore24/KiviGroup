//
//  CastingDetailsModel.h
//  Kinopro365
//
//  Created by Кирилл Ковыршин on 10.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CastingDetailsModelDelegate <NSObject>

-(void) loadCasting: (NSDictionary *) catingDict;

@end

@interface CastingDetailsModel : NSObject

@property (strong, nonatomic) id <CastingDetailsModelDelegate> delegate;

-(void) loadCasting: (NSString *) castingID;
-(void)sendCastings: (NSString *) castingID complitionBlock: (void (^) (id response)) compitionBack;

@end
