//
//  CustomLabels.m
//  FlowersOnline
//
//  Created by Виктор Мишустин on 10.06.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "CustomLabels.h"
#import "UIColor+HexColor.h"
#import "Macros.h"

@implementation CustomLabels

- (instancetype)initLabelBondWithWidht: (CGFloat) widht
                               andHeight: (CGFloat) height
                               andColor: (NSString*) hexColor
                                andText: (NSString*) text
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(widht, height, 30, 16);
        self.text = text;
        self.textColor = [UIColor colorWithHexString:hexColor];
        self.font = [UIFont fontWithName:FONTBOND size:15];
        [self sizeToFit];
        
    }
    return self;
}

- (instancetype)initLabelRegularWithWidht: (CGFloat) widht
                             andHeight: (CGFloat) height
                              andColor: (NSString*) hexColor
                               andText: (NSString*) text
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(widht, height, 20, 16);
        self.text = text;
        self.textColor = [UIColor colorWithHexString:hexColor];
        self.font = [UIFont fontWithName:FONTREGULAR size:15];
        [self sizeToFit];
        
    }
    return self;
}

- (instancetype)initLabelTableWithWidht: (CGFloat) widht
                                andHeight: (CGFloat) height
                             andSizeWidht: (CGFloat) sizeWidht
                            andSizeHeight: (CGFloat) sizeHeight
                                 andColor: (NSString*) hexColor
                                  andText: (NSString*) text

{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(widht, height, sizeWidht, sizeHeight);
        self.text = text;
        self.textColor = [UIColor colorWithHexString:hexColor];
        self.textAlignment = NSTextAlignmentCenter;

        
    }
    return self;
}



@end
