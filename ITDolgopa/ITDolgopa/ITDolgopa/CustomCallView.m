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
          andCreated: (NSString*) created
         andBreaking: (NSString*) breaking
        andReadiness: (NSString*) readiness
           andPPrice: (NSString*) pPrice
           andPrepay: (NSString*) prepay
           andStatus: (NSString*) status
      andColorStatus: (NSString*) color
             andView: (UIView*) view

{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, 150);
        
        NSDictionary * fontSize = [FontSizeChanger changeFontSize];
        
        //Создание не изменяемых строк----------------------------
        UILabel * labelDevice = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 40)];
        if (isiPhone5) {
            labelDevice.frame = CGRectMake(20, 20, 100, 40);
        }
        labelDevice.text = @"Устройство:";
        labelDevice.textColor = [UIColor colorWithHexString:COLORLITEGRAY];
        labelDevice.font = [UIFont fontWithName:FONTREGULAR size:[[fontSize objectForKey:@"sizeText"] intValue]];
        [labelDevice sizeToFit];
        [self addSubview:labelDevice];
        
        UILabel * labelCreated = [[UILabel alloc] initWithFrame:
                                   CGRectMake(20, labelDevice.frame.size.height + labelDevice.frame.origin.y, 100, 40)];
        labelCreated.text = @"Дата приёма:";
        labelCreated.textColor = [UIColor colorWithHexString:COLORLITEGRAY];
        labelCreated.font = [UIFont fontWithName:FONTREGULAR size:[[fontSize objectForKey:@"sizeText"] intValue]];
        [labelCreated sizeToFit];
        [self addSubview:labelCreated];

        UILabel * labelBreaking = [[UILabel alloc] initWithFrame:
                  CGRectMake(20, labelCreated.frame.size.height + labelCreated.frame.origin.y, 100, 40)];
        labelBreaking.text = @"Неисправность:";
        labelBreaking.textColor = [UIColor colorWithHexString:COLORLITEGRAY];
        labelBreaking.font = [UIFont fontWithName:FONTREGULAR size:[[fontSize objectForKey:@"sizeText"] intValue]];
        [labelBreaking sizeToFit];
        [self addSubview:labelBreaking];

        UILabel * labelReadiness = [[UILabel alloc] initWithFrame:
                                   CGRectMake(20, labelBreaking.frame.size.height + labelBreaking.frame.origin.y, 100, 40)];
        labelReadiness.text = @"Готовность:";
        labelReadiness.textColor = [UIColor colorWithHexString:COLORLITEGRAY];
        labelReadiness.font = [UIFont fontWithName:FONTREGULAR size:[[fontSize objectForKey:@"sizeText"] intValue]];
        [labelReadiness sizeToFit];
        [self addSubview:labelReadiness];
        
        UILabel * labelPPrice = [[UILabel alloc] initWithFrame:
                                 CGRectMake(20, labelReadiness.frame.size.height + labelReadiness.frame.origin.y, 100, 40)];
        labelPPrice.text = @"Стоимость ремонта:";
        labelPPrice.textColor = [UIColor colorWithHexString:COLORLITEGRAY];
        labelPPrice.font = [UIFont fontWithName:FONTREGULAR size:[[fontSize objectForKey:@"sizeText"] intValue]];
        [labelPPrice sizeToFit];
        [self addSubview:labelPPrice];
        
        UILabel * labelPrepay = [[UILabel alloc] initWithFrame:
                                 CGRectMake(20, labelPPrice.frame.size.height + labelPPrice.frame.origin.y, 100, 40)];
        labelPrepay.text = @"Предоплата:";
        labelPrepay.textColor = [UIColor colorWithHexString:COLORLITEGRAY];
        labelPrepay.font = [UIFont fontWithName:FONTREGULAR size:[[fontSize objectForKey:@"sizeText"] intValue]];
        [labelPrepay sizeToFit];
        [self addSubview:labelPrepay];

        UILabel * labelStatus = [[UILabel alloc] initWithFrame:
                                    CGRectMake(20, labelPrepay.frame.size.height + labelPrepay.frame.origin.y, 100, 40)];
        labelStatus.text = @"Статус:";
        labelStatus.textColor = [UIColor colorWithHexString:COLORLITEGRAY];
        labelStatus.font = [UIFont fontWithName:FONTREGULAR size:[[fontSize objectForKey:@"sizeText"] intValue]];
        [labelStatus sizeToFit];
        [self addSubview:labelStatus];
        
        //Создание изменяемых строк-------------------------------------
        UILabel * labelDeviceAction = [[UILabel alloc] initWithFrame:CGRectMake(20 + labelDevice.frame.size.width + 5, 10, 100, 40)];
        if (isiPhone5) {
            labelDeviceAction.frame = CGRectMake(20 + labelDevice.frame.size.width + 5, 20, 100, 40);
        }
        labelDeviceAction.text = device;
        labelDeviceAction.textColor = [UIColor colorWithHexString:COLORLITELITEGRAY];
        labelDeviceAction.font = [UIFont fontWithName:FONTLITE size:[[fontSize objectForKey:@"sizeText"] intValue]];
        [labelDeviceAction sizeToFit];
        [self addSubview:labelDeviceAction];
        
        UILabel * labelCreatedAction = [[UILabel alloc] initWithFrame:
                                         CGRectMake(20 + labelCreated.frame.size.width + 5, labelDevice.frame.size.height + labelDevice.frame.origin.y, 100, 40)];
        labelCreatedAction.text = created;
        labelCreatedAction.textColor = [UIColor colorWithHexString:COLORLITELITEGRAY];
        labelCreatedAction.font = [UIFont fontWithName:FONTLITE size:[[fontSize objectForKey:@"sizeText"] intValue]];
        [labelCreatedAction sizeToFit];
        [self addSubview:labelCreatedAction];
        
        UILabel * labelBreakingAction = [[UILabel alloc] initWithFrame:
                                   CGRectMake(20 + labelBreaking.frame.size.width + 5, labelCreated.frame.size.height + labelCreated.frame.origin.y, 80, 40)];
        labelBreakingAction.text = breaking;
        labelBreakingAction.textColor = [UIColor colorWithHexString:COLORLITELITEGRAY];
        labelBreakingAction.font = [UIFont fontWithName:FONTLITE size:[[fontSize objectForKey:@"sizeText"] intValue]];
        [labelBreakingAction sizeToFit];
        CGRect rect = labelBreakingAction.frame;
        rect.size.width = 200;
        labelBreakingAction.frame = rect;
        [self addSubview:labelBreakingAction];
        
        UILabel * labelReadinessAction = [[UILabel alloc] initWithFrame:
                                    CGRectMake(20 + labelReadiness.frame.size.width + 5, labelBreaking.frame.size.height + labelBreaking.frame.origin.y, 100, 40)];
        labelReadinessAction.text = readiness;
        labelReadinessAction.textColor = [UIColor colorWithHexString:COLORLITELITEGRAY];
        labelReadinessAction.font = [UIFont fontWithName:FONTLITE size:[[fontSize objectForKey:@"sizeText"] intValue]];
        [labelReadinessAction sizeToFit];
        [self addSubview:labelReadinessAction];
        
        UILabel * labelPPriceAction = [[UILabel alloc] initWithFrame:
                                       CGRectMake(20 + labelPPrice.frame.size.width + 5, labelReadiness.frame.size.height + labelReadiness.frame.origin.y, 100, 40)];
        labelPPriceAction.text = pPrice;
        labelPPriceAction.textColor = [UIColor colorWithHexString:COLORLITELITEGRAY];
        labelPPriceAction.font = [UIFont fontWithName:FONTLITE size:[[fontSize objectForKey:@"sizeText"] intValue]];
        [labelPPriceAction sizeToFit];
        [self addSubview:labelPPriceAction];
        
        UILabel * labelPrepayAction = [[UILabel alloc] initWithFrame:
                                       CGRectMake(20 + labelPrepay.frame.size.width + 5, labelPPrice.frame.size.height + labelPPrice.frame.origin.y, 100, 40)];
        if (!prepay) {
            labelPrepayAction.text = @"0";
        } else {
            labelPrepayAction.text = prepay;
        }
    
        labelPrepayAction.textColor = [UIColor colorWithHexString:COLORLITELITEGRAY];
        labelPrepayAction.font = [UIFont fontWithName:FONTLITE size:[[fontSize objectForKey:@"sizeText"] intValue]];
        [labelPrepayAction sizeToFit];
        [self addSubview:labelPrepayAction];
        
        UILabel * labelStatusAction = [[UILabel alloc] initWithFrame:
                                 CGRectMake(20 + labelStatus.frame.size.width + 5, labelPrepay.frame.size.height + labelPrepay.frame.origin.y, 100, 40)];
        labelStatusAction.text = status;
        labelStatusAction.textColor = [UIColor colorWithHexString:color];
        labelStatusAction.font = [UIFont fontWithName:FONTLITE size:[[fontSize objectForKey:@"sizeText"] intValue]];
        [labelStatusAction sizeToFit];
        [self addSubview:labelStatusAction];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 149.5f, view.frame.size.width, 0.5f)];
        lineView.backgroundColor = [UIColor whiteColor];
        [self addSubview:lineView];
        
    }
    return self;
}

@end
