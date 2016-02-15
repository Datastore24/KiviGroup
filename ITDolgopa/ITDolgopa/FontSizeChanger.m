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
                  @"10",@"textSize",
                  @"10",@"buttonSize", nil];
    }else{
        NSLog(@"Iphone 6,6+");
        fonSize= [[NSDictionary alloc] initWithObjectsAndKeys:
                  @"13",@"textSize",
                  @"20",@"buttonSize", nil];
    }
    
    return fonSize;
   
    
}
@end
