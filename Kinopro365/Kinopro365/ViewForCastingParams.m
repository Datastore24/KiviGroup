//
//  ViewForCastingParams.m
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 08.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "ViewForCastingParams.h"
#import "HexColors.h"
#import "Macros.h"

@implementation ViewForCastingParams

- (instancetype)initWithMainView: (UIView*) mainView endHeight: (CGFloat) height endText: (NSString*) text
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, height, CGRectGetWidth(mainView.bounds), 16.f);
        
        UILabel * labelText = [[UILabel alloc] initWithFrame:CGRectMake(12.f, 0.f, 296.f, 16.f)];
        labelText.text = text;
        labelText.textColor = [UIColor hx_colorWithHexRGBAString:@"343536"];
        labelText.font = [UIFont fontWithName:FONT_ISTOK_REGULAR size:16];
        [self addSubview:labelText];
        
    }
    return self;
}



@end
