//
//  ChooseProfessionalModel.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 16.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "ChooseProfessionalModel.h"
#import "SingleTone.h"
#import "APIManger.h"

@implementation ChooseProfessionalModel

@synthesize delegate;



- (void) getProfessionalArrayToTableView: (void (^) (void)) compitionBack{
    NSMutableArray * array = [[NSMutableArray alloc] init];
    NSArray * arrayImages = [NSArray arrayWithObjects:@"actorsImage.png", @"gamersImage.png", @"operatorsImage.png",
                             @"designersImage.png", @"dressersImage.png", @"massActorsImage.png",
                             @"choreographersImage.png", @"productionOperatorImage.png", nil];
   
    
    APIManger * apiManager = [[APIManger alloc] init];
   
    [apiManager getDataFromSeverWithMethod80:@"v1/info/profareas" andParams:nil complitionBlock:^(id response) {
         NSLog(@"PROF %@",response);
        NSArray * arrayNames = response;

        for (int i = 0; i < arrayNames.count; i++) {
            
            NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[arrayNames objectAtIndex:i], @"name",
                                          @"actorsImage.png", @"image", [NSNumber numberWithBool:NO], @"choose", nil];

            [array addObject:dict];
            
        }
        [self.delegate setMainArrayData:array];
        [self.delegate reloadTable];
        compitionBack();
    }];
    
    
}

@end
