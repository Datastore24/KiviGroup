//
//  CoutryModel.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 15.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "CoutryModel.h"
#import "SingleTone.h"
#import "APIManger.h"

@implementation CoutryModel
@synthesize delegate;




- (void) getCountryArrayToTableView: (void (^) (void)) compitionBack{
    
    APIManger * apiManager = [[APIManger alloc] init];
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:@"json",@"_format", nil];
    [apiManager getDataFromSeverWithMethod:@"info.getCountries" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
        if([response objectForKey:@"error_code"]){
           
            NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                  [response objectForKey:@"error_msg"]);
            NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
        }else{
            NSLog(@"RESPONSE COUNTRY %@",response);
//            NSDictionary *dictCountry = response;
//            NSMutableArray * arrayCountry = [[NSMutableArray alloc] init];
//            
//            for (id item in dictCountry) {
//                NSDictionary * finalDict = [[NSDictionary alloc] initWithObjectsAndKeys:
//                                            item, @"country_id",
//                                            [dictCountry objectForKey:item],@"name",nil];
//                [arrayCountry addObject:finalDict];
//            }
//            NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"name"
//                                                                         ascending:YES];
//            NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
//            NSArray *sortedArray = [arrayCountry sortedArrayUsingDescriptors:sortDescriptors];
//            [self.delegate setCountryArray:sortedArray];
            compitionBack();
        }
    }];

    
    
}

- (void) putCountryIdToProfle: (NSString *) countryID block: (void (^) (void)) compitionBack{
    APIManger * apiManager = [[APIManger alloc] init];
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             
                             
                             countryID, @"country_id",
                             @"json",@"_format",nil];


//    [apiManager putDataFromSeverWithMethod:userURL andParams:params complitionBlock:^(id response) {
//        NSLog(@"DATA %@",response);
//        compitionBack();
//    }];
    
}

- (void) getCityArrayToTableView: (NSString *) countryID block: (void (^) (void)) compitionBack{
    
    APIManger * apiManager = [[APIManger alloc] init];
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             countryID,@"country_id",nil];
    [apiManager getDataFromSeverWithMethod:@"info.getCities" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
        
        if([response objectForKey:@"error_code"]){
            
            NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                  [response objectForKey:@"error_msg"]);
            NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
        }else{
            NSLog(@"RESPONSE COUNTRY %@",response);
        }
        
//        NSDictionary *dictCity = response;
//        NSMutableArray * arrayCity = [[NSMutableArray alloc] init];
//        
//        for (id item in dictCity) {
//            NSDictionary * finalDict = [[NSDictionary alloc] initWithObjectsAndKeys:
//                                        item, @"city_id",
//                                        [dictCity objectForKey:item],@"name",nil];
//            [arrayCity addObject:finalDict];
//        }
//        NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"name"
//                                                                     ascending:YES];
//        NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
//        NSArray *sortedArray = [arrayCity sortedArrayUsingDescriptors:sortDescriptors];
//        [self.delegate setCountryArray:sortedArray];
        compitionBack();
        
    }];
    
    
    
}


@end
