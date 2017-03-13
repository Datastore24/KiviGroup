//
//  MyCustingDetailsModel.h
//  Kinopro365
//
//  Created by Кирилл Ковыршин on 10.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MyCustingDetailsModelDelegate <NSObject>

-(void) loadMyCastings:(NSDictionary *) vacanciesDict;

@end

@interface MyCustingDetailsModel : NSObject

@property (strong,nonatomic) id <MyCustingDetailsModelDelegate> delegate;

-(void) loadCastings: (NSString *) castingID;
-(void) loadOffersProfile:(NSString *) castingID andOffset: (NSString *) offset andCount: (NSString *) count complitionBlock: (void (^) (id response)) compitionBack;
-(void) loadApprovedProfile:(NSString *) castingID andOffset: (NSString *) offset andCount: (NSString *) count complitionBlock: (void (^) (id response)) compitionBack;
- (void) decideCastings: (NSString *) castingID andDecision: (NSString *) decision complitionBlock: (void (^) (id response)) compitionBack;
@end
