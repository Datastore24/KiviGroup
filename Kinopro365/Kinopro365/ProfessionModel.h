//
//  ProfessionModel.h
//  Kinopro365
//
//  Created by Виктор Мишустин on 13.02.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProfessionModelDelegate <NSObject>

- (void) loadProfession:(NSDictionary *) profDict;

@end

@interface ProfessionModel : NSObject

@property (assign, nonatomic) id <ProfessionModelDelegate> delegate;

-(void) loadProfessionFromServerOffset: (NSString *) offset
                              andCount: (NSString *) count
                             andProfID:(NSString *) profID;

@end
