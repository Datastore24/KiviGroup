//
//  SingleTone.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 18.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "SingleTone.h"

@implementation SingleTone

@synthesize country_citi;
@synthesize professionControllerCode;
@synthesize stringAletForWebView;
@synthesize token;
@synthesize countryID;
@synthesize citySearchID;
@synthesize countrySearchID;
@synthesize localization;
@synthesize typeView;
@synthesize myKinosfera;
@synthesize myProfileID;
@synthesize myCountViews;


#pragma mark Singleton Methods

+ (id)sharedManager{
    static SingleTone *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}


@end
