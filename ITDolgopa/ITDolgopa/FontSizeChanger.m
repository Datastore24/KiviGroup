//
//  FontSizeChanger.m
//  ITDolgopa
//
//  Created by Кирилл Ковыршин on 15.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "FontSizeChanger.h"
#import "Macros.h"

@implementation FontSizeChanger
+(NSDictionary*)changeFontSize{
    NSDictionary * fonSize;
    
    if (isiPhone5) {
        NSLog(@"Iphone 5,4");
        fonSize= [[NSDictionary alloc] initWithObjectsAndKeys:
                  @"11",@"textSize",
                  @"11",@"buttonSize",
                  @"15",@"textField", nil];
    }else{
        NSLog(@"Iphone 6,6+");
        fonSize= [[NSDictionary alloc] initWithObjectsAndKeys:
                  @"13",@"textSize",
                  @"16",@"buttonSize",
                  @"20",@"textField",nil];
    }
    
    return fonSize;
   
    
}
@end
