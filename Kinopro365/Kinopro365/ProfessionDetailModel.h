//
//  ProfessionDetailModel.h
//  Kinopro365
//
//  Created by Кирилл Ковыршин on 17.02.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProfessionDetailModelDelegate <NSObject>

-(void) loadProfile:(NSDictionary *) profileDict;

@end

@interface ProfessionDetailModel : NSObject

@property (assign, nonatomic) id <ProfessionDetailModelDelegate> delegate;

-(void) loadProfile: (NSString *) profileID andProffesionID:(NSString *) profID;
-(void) loadPhoto:(NSString *) profileID
        andOffset: (NSString *) offset
         andCount: (NSString *) count
  complitionBlock: (void (^) (id response)) compitionBack;
-(void) loadVideo:(NSString *) profileID
        andOffset: (NSString *) offset
         andCount: (NSString *) count
  complitionBlock: (void (^) (id response)) compitionBack;
-(void) sendIsFavourite: (BOOL) isFavourite
           andProfileID:(NSString *) profileID
        complitionBlock: (void (^) (id response)) compitionBack;
-(void) sendIsReward: (BOOL) isReward
        andProfileID:(NSString *) profileID
     complitionBlock: (void (^) (id response)) compitionBack;
-(void) sendIsLike: (BOOL) isReward
      andProfileID:(NSString *) profileID
   complitionBlock: (void (^) (id response)) compitionBack;

@end
