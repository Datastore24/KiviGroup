//
//  CustomCallView.m
//  ITDolgopa
//
//  Created by Viktor on 17.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "CustomCallView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "FontSizeChanger.h"

@implementation CustomCallView

- (id)initWithDevice: (NSString*) device
         andBreaking: (NSString*) breaking
        andReadiness: (NSString*) readiness
           andStatus: (NSString*) status
      andColorStatus: (NSString*) color
             andView: (UIView*) view

{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, 120);
        
        NSDictionary * fontSize = [FontSizeChanger changeFontSize];
        
        //Создание не изменяемых строк----------------------------
        UILabel * labelDevice = [[UILabel alloc] initWithFrame:CGRectMake(40, 16, 100, 40)];
        if (isiPhone5) {
            labelDevice.frame = CGRectMake(40, 30, 100, 40);
        }
        labelDevice.text = @"Устройство:";
        labelDevice.textColor = [UIColor colorWithHexString:COLORLITEGRAY];
        labelDevice.font = [UIFont fontWithName:FONTREGULAR size:[[fontSize objectForKey:@"sizeText"] intValue]];
        [labelDevice sizeToFit];
        [self addSubview:labelDevice];

        UILabel * labelBreaking = [[UILabel alloc] initWithFrame:
                  CGRectMake(40, labelDevice.frame.size.height + labelDevice.frame.origin.y, 100, 40)];
        labelBreaking.text = @"Неисправность:";
        labelBreaking.textColor = [UIColor colorWithHexString:COLORLITEGRAY];
        labelBreaking.font = [UIFont fontWithName:FONTREGULAR size:[[fontSize objectForKey:@"sizeText"] intValue]];
        [labelBreaking sizeToFit];
        [self addSubview:labelBreaking];

        UILabel * labelReadiness = [[UILabel alloc] initWithFrame:
                                   CGRectMake(40, labelBreaking.frame.size.height + labelBreaking.frame.origin.y, 100, 40)];
        labelReadiness.text = @"Готовность:";
        labelReadiness.textColor = [UIColor colorWithHexString:COLORLITEGRAY];
        labelReadiness.font = [UIFont fontWithName:FONTREGULAR size:[[fontSize objectForKey:@"sizeText"] intValue]];
        [labelReadiness sizeToFit];
        [self addSubview:labelReadiness];

        UILabel * labelStatus = [[UILabel alloc] initWithFrame:
                                    CGRectMake(40, labelReadiness.frame.size.height + labelReadiness.frame.origin.y, 100, 40)];
        labelStatus.text = @"Статус:";
        labelStatus.textColor = [UIColor colorWithHexString:COLORLITEGRAY];
        labelStatus.font = [UIFont fontWithName:FONTREGULAR size:[[fontSize objectForKey:@"sizeText"] intValue]];
        [labelStatus sizeToFit];
        [self addSubview:labelStatus];
        
        //Создание изменяемых строк-------------------------------------
        UILabel * labelDeviceAction = [[UILabel alloc] initWithFrame:CGRectMake(40 + labelDevice.frame.size.width + 5, 16, 100, 40)];
        if (isiPhone5) {
            labelDeviceAction.frame = CGRectMake(40 + labelDevice.frame.size.width + 5, 30, 100, 40);
        }
        labelDeviceAction.text = device;
        labelDeviceAction.textColor = [UIColor colorWithHexString:COLORLITELITEGRAY];
        labelDeviceAction.font = [UIFont fontWithName:FONTLITE size:[[fontSize objectForKey:@"sizeText"] intValue]];
        [labelDeviceAction sizeToFit];
        [self addSubview:labelDeviceAction];
        
        UILabel * labelBreakingAction = [[UILabel alloc] initWithFrame:
                                   CGRectMake(40 + labelBreaking.frame.size.width + 5, labelDevice.frame.size.height + labelDevice.frame.origin.y, 100, 40)];
        labelBreakingAction.text = breaking;
        labelBreakingAction.textColor = [UIColor colorWithHexString:COLORLITELITEGRAY];
        labelBreakingAction.font = [UIFont fontWithName:FONTLITE size:[[fontSize objectForKey:@"sizeText"] intValue]];
        [labelBreakingAction sizeToFit];
        [self addSubview:labelBreakingAction];
        
        UILabel * labelReadinessAction = [[UILabel alloc] initWithFrame:
                                    CGRectMake(40 + labelReadiness.frame.size.width + 5, labelBreaking.frame.size.height + labelBreaking.frame.origin.y, 100, 40)];
        labelReadinessAction.text = readiness;
        labelReadinessAction.textColor = [UIColor colorWithHexString:COLORLITELITEGRAY];
        labelReadinessAction.font = [UIFont fontWithName:FONTLITE size:[[fontSize objectForKey:@"sizeText"] intValue]];
        [labelReadinessAction sizeToFit];
        [self addSubview:labelReadinessAction];
        
        UILabel * labelStatusAction = [[UILabel alloc] initWithFrame:
                                 CGRectMake(40 + labelStatus.frame.size.width + 5, labelReadiness.frame.size.height + labelReadiness.frame.origin.y, 100, 40)];
        labelStatusAction.text = status;
        labelStatusAction.textColor = [UIColor colorWithHexString:color];
        labelStatusAction.font = [UIFont fontWithName:FONTLITE size:[[fontSize objectForKey:@"sizeText"] intValue]];
        [labelStatusAction sizeToFit];
        [self addSubview:labelStatusAction];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 119.5f, view.frame.size.width, 0.5f)];
        lineView.backgroundColor = [UIColor whiteColor];
        [self addSubview:lineView];
        
    }
    return self;
}

@end
