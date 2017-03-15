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
#import "UserInformationTable.h"

@implementation CoutryModel
@synthesize delegate;




- (void) getCountryArrayToTableView: (void (^) (void)) compitionBack{
    
    APIManger * apiManager = [[APIManger alloc] init];
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             @"0",@"offset",
                             @"1000",@"count",nil];
    
    [apiManager getDataFromSeverWithMethod:@"info.getCountries" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
        if([response objectForKey:@"error_code"]){
           
            NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                  [response objectForKey:@"error_msg"]);
            NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
        }else{
            NSLog(@"RESPONSE COUNTRY %@",response);
            
            NSDictionary *dictResponse = [response objectForKey:@"response"];
            NSArray *dictCountry = [dictResponse objectForKey:@"items"];
            
            NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"name"
                                                                         ascending:YES];
            NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
            NSArray *sortedArray = [dictCountry sortedArrayUsingDescriptors:sortDescriptors];
            NSMutableArray * resultArray =[(NSArray *) sortedArray mutableCopy];
            [self.delegate setCountryArray:resultArray];
            compitionBack();
        }
    }];

    
    
}

- (void) putCountryIdToProfle: (NSString *) countryID{
  
    RLMResults *profTableDataArray = [UserInformationTable allObjects];
    
    if(profTableDataArray.count>0){
        
        UserInformationTable * userTable = [profTableDataArray objectAtIndex:0];
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        userTable.country_id = [NSString stringWithFormat:@"%@",countryID];
        [realm commitWriteTransaction];
        
    }
    
}

- (void) getCityArrayToTableView: (NSString *) countryID block: (void (^) (void)) compitionBack{
    
    APIManger * apiManager = [[APIManger alloc] init];
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             countryID,@"country_id",
                             @"0",@"offset",
                             @"1000",@"count",nil];
    
    [apiManager getDataFromSeverWithMethod:@"info.getCities" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
        if([response objectForKey:@"error_code"]){
            
            NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                  [response objectForKey:@"error_msg"]);
            NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
        }else{
            NSLog(@"RESPONSE CITY %@",response);
            
            NSDictionary *dictResponse = [response objectForKey:@"response"];
            NSArray *dictCountry = [dictResponse objectForKey:@"items"];
            
            NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"name"
                                                                         ascending:YES];
            NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
            NSArray *sortedArray = [dictCountry sortedArrayUsingDescriptors:sortDescriptors];
            NSMutableArray * resultArray =[(NSArray *) sortedArray mutableCopy];
            [self.delegate setCountryArray:resultArray];
            compitionBack();
        }
    }];
    
    
}

- (void) putCityIdToProfle: (NSString *) cityID{
    
    RLMResults *profTableDataArray = [UserInformationTable allObjects];
    
    if(profTableDataArray.count>0){
        
        UserInformationTable * userTable = [profTableDataArray objectAtIndex:0];
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        userTable.city_id = [NSString stringWithFormat:@"%@",cityID];
        [realm commitWriteTransaction];
        
    }
    
}


@end
