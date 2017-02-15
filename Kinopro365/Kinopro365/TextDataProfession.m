//
//  TextDataProfession.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 15.02.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "TextDataProfession.h"
#import "HexColors.h"
#import "Macros.h"

@implementation TextDataProfession

- (instancetype)initWithHeight: (CGFloat) height antFirstTextLabel: (NSString*) firstTextLabel
            andSecondTextLabel: (NSString*) secondTextLabel {
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, height, [[UIScreen mainScreen] bounds].size.width, 25);
        
        UILabel * firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(12.f, 0.f, CGRectGetWidth(self.bounds) / 2, 25)];
        firstLabel.text = firstTextLabel;
        firstLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"343536"];
        firstLabel.font = [UIFont fontWithName:FONT_ISTOK_REGULAR size:16];
        [self addSubview:firstLabel];
        
        UILabel * secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bounds) / 2, 0.f, CGRectGetWidth(self.bounds) / 2 - 12, 25)];
        secondLabel.text = secondTextLabel;
        secondLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"343536"];
        secondLabel.textAlignment = NSTextAlignmentRight;
        secondLabel.font = [UIFont fontWithName:FONT_ISTOK_REGULAR size:16];
        [self addSubview:secondLabel];
        
    }
    return self;
}



@end
