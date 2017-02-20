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
        
        CGFloat heightSelf = [self findHeightForText:secondTextLabel havingWidth:CGRectGetWidth(self.bounds) / 2 - 12 andFont:[UIFont fontWithName:FONT_ISTOK_REGULAR size:16]];
        
        UILabel * secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bounds) / 2, 0.f, CGRectGetWidth(self.bounds) / 2 - 12, heightSelf)];
        secondLabel.numberOfLines = 0;
        secondLabel.text = secondTextLabel;
        secondLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"343536"];
        secondLabel.textAlignment = NSTextAlignmentRight;
        secondLabel.font = [UIFont fontWithName:FONT_ISTOK_REGULAR size:16];
        [self addSubview:secondLabel];
        
    }
    return self;
}

- (CGFloat)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font {
    CGSize size = CGSizeZero;
    if (text) {
        CGRect frame = [text boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:font } context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height + 1);
    }
    return size.height;
}



@end
