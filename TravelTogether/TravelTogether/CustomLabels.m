//
//  CustomLabels.m
//  FlowersOnline
//
//  Created by Виктор Мишустин on 10.06.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "CustomLabels.h"
#import "HexColors.h"
#import "Macros.h"

@implementation CustomLabels

+ (UILabel*) labelWithWidht: (CGFloat) widht
                  andHeight: (CGFloat) height
                   andColor: (NSString*) hexColor
                    andText: (NSString*) text
                andTextSize: (NSInteger) textSize
             andLineSpacing: (CGFloat) lineSpacing
                   fontName: (NSString*) font
{
    
    UILabel * labelMethod = [[UILabel alloc] init];

        labelMethod.frame = CGRectMake(widht, height, 100, 16);
        labelMethod.text = text;
        labelMethod.textColor = [UIColor hx_colorWithHexRGBAString:hexColor];
        labelMethod.font = [UIFont fontWithName:font size:textSize];
        [labelMethod sizeToFit];
        
        
        

    return labelMethod;
}

- (instancetype)initLabelWithWidht: (CGFloat) widht
                               andHeight: (CGFloat) height
                               andColor: (NSString*) hexColor
                               andText: (NSString*) text
                           andTextSize: (NSInteger) textSize
                        andLineSpacing: (CGFloat) lineSpacing
                              fontName: (NSString*) font
{
    self = [super init];
    if (self) {

        
        self.frame = CGRectMake(widht, height, 100, 16);
        self.text = text;
        self.textColor = [UIColor hx_colorWithHexRGBAString:hexColor];
        self.font = [UIFont fontWithName:font size:textSize];
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
        self.textColor = [UIColor hx_colorWithHexRGBAString:hexColor];
        self.textAlignment = NSTextAlignmentCenter;

        
    }
    return self;
}



@end
