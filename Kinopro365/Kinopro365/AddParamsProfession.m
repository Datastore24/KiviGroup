//
//  AddParamsProfession.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 15.02.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "AddParamsProfession.h"
#import "Macros.h"
#import "HexColors.h"

@implementation AddParamsProfession

- (instancetype)initWithHeight: (CGFloat) height andText: (NSString*) text {
    self = [super init];
    if (self) {
        
        UIFont * font = [UIFont fontWithName:FONT_ISTOK_REGULAR size:16];
        CGFloat heightSelf = [self findHeightForText:text havingWidth:294 andFont:font];
        
        self.frame = CGRectMake(0, height, [[UIScreen mainScreen] bounds].size.width, 58 + heightSelf);
        self.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f5f6f6"];
        
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12.f, 12.f, 200, 17)];
        titleLabel.text = @"Доп. информация";
        titleLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"343536"];
        titleLabel.font = [UIFont fontWithName:FONT_ISTOK_REGULAR size:18];
        [self addSubview:titleLabel];
          
        UILabel * labeltext = [[UILabel alloc] initWithFrame:CGRectMake(13.f, 42.f, self.bounds.size.width - 26, heightSelf)];
        labeltext.numberOfLines = 0;
        labeltext.text = text;
        labeltext.textColor = [UIColor hx_colorWithHexRGBAString:@"343536"];
        labeltext.font = [UIFont fontWithName:FONT_ISTOK_REGULAR size:16];
        [self addSubview:labeltext];
        
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
