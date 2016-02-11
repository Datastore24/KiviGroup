//
//  ParsingResponseNamePrice.m
//  Weddup
//
//  Created by Кирилл Ковыршин on 15.10.15.
//  Copyright © 2015 datastore24. All rights reserved.
//

#import "ParsingResponseNamePrice.h"
#import "ParserMethod.h"
#import "ParserPrice.h"

@implementation ParsingResponseNamePrice
- (NSMutableArray *)parsing:(id)response{
    ParserMethod * parserMethod = [[ParserMethod alloc] init];
    //Если это обновление удаляем все объекты из массива и грузим заного
    
    //
    
    if ([response isKindOfClass:[NSArray class]]) {
        NSArray *resonse = (NSArray *)response;
         NSMutableArray * arrayResponse = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < resonse.count; i++) {
            
            ParserPrice *parserPrice = [[ParserPrice alloc] init];
            [parserPrice mts_setValuesForKeysWithDictionary:[response objectAtIndex:i]];
            
            //работаем с анатоцией
            
            //Работа с анотацией
            parserPrice.price_name = [parserMethod stringByStrippingHTML:parserPrice.price_name];
            
            
            
            
            //
            
            

            [arrayResponse addObject:parserPrice];
            
            
        }
        
        return arrayResponse;
        
        //Конец цикла
        
        
    }else if ([response isKindOfClass:[NSDictionary class]]) {
        
        
    }
    return nil;
}

@end
