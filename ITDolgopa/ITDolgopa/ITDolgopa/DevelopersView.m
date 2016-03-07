//
//  DevelopersView.m
//  ITDolgopa
//
//  Created by Viktor on 05.03.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "DevelopersView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"

@implementation DevelopersView

- (instancetype)initWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        self.backgroundColor =[UIColor colorWithHexString:MAINBACKGROUNDCOLOR];
    }
    return self;
}

@end
