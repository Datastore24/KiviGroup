//
//  UnderRepairDetailsView.m
//  ITDolgopa
//
//  Created by Viktor on 18.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "UnderRepairDetailsView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "FontSizeChanger.h"

@implementation UnderRepairDetailsView
//основное вью
- (instancetype)initWithView: (UIView*) view
                   andDevice: (NSString *) device
                       andSN: (NSString*) sN
                  andCreated: (NSString*) created
                 andBreaking: (NSString*) breaking
                   andStatus: (NSString*) status
              andStatusColor: (NSString*) statusColor
                andReadiness: (NSString*) readiness
               andFactRepair: (NSString*) factRepair
{
    self = [super init];
    if (self) {
        self.frame = view.frame;
        
        NSDictionary * fontSize = [FontSizeChanger changeFontSize];
        
        //Создание не изменяемых строк----------------------------
        //Устройство----------------------------------------------
        UILabel * labelDevice = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 100, 40)];
        labelDevice.text = @"Устройство:";
        labelDevice.textColor = [UIColor colorWithHexString:COLORLITEGRAY];
        labelDevice.font = [UIFont fontWithName:FONTREGULAR size:[[fontSize objectForKey:@"sizeRepairDetails"] intValue]];
        [labelDevice sizeToFit];
        [self addSubview:labelDevice];
        
        //Устройство-----------------------------------------------------
        UILabel * labelDeviceAction = [[UILabel alloc] initWithFrame:CGRectMake(20 + labelDevice.frame.size.width + 5, 100, 100, 40)];
        labelDeviceAction.text = device;
        labelDeviceAction.textColor = [UIColor colorWithHexString:COLORLITELITEGRAY];
        labelDeviceAction.font = [UIFont fontWithName:FONTLITE size:[[fontSize objectForKey:@"sizeRepairDetails"] intValue]];
        [labelDeviceAction sizeToFit];
        [self addSubview:labelDeviceAction];
        
        //Серийный номер---------------------------------------------
        UILabel * labelSN = [[UILabel alloc] initWithFrame:
                             CGRectMake(20, labelDevice.frame.size.height + labelDevice.frame.origin.y + 10, 100, 40)];
        labelSN.text = @"Серийный номер:";
        labelSN.textColor = [UIColor colorWithHexString:COLORLITEGRAY];
        labelSN.font = [UIFont fontWithName:FONTREGULAR size:[[fontSize objectForKey:@"sizeRepairDetails"] intValue]];
        [labelSN sizeToFit];
        [self addSubview:labelSN];
        
        //Серийный номер-------------------------------------------------
        UILabel * labelSNAction = [[UILabel alloc] initWithFrame:
                                   CGRectMake(20 + labelSN.frame.size.width + 5, labelDevice.frame.size.height + labelDevice.frame.origin.y + 10, 100, 40)];
        labelSNAction.text = sN;
        labelSNAction.textColor = [UIColor colorWithHexString:COLORLITELITEGRAY];
        labelSNAction.font = [UIFont fontWithName:FONTLITE size:[[fontSize objectForKey:@"sizeRepairDetails"] intValue]];
        [labelSNAction sizeToFit];
        [self addSubview:labelSNAction];
        
        //Дата поступления-------------------------------------------
        UILabel * labelCreated = [[UILabel alloc] initWithFrame:
                                  CGRectMake(20, labelSN.frame.size.height + labelSN.frame.origin.y + 10, 100, 40)];
        labelCreated.text = @"Дата поступления:";
        labelCreated.textColor = [UIColor colorWithHexString:COLORLITEGRAY];
        labelCreated.font = [UIFont fontWithName:FONTREGULAR size:[[fontSize objectForKey:@"sizeRepairDetails"] intValue]];
        [labelCreated sizeToFit];
        [self addSubview:labelCreated];
        
        //Дата поступления-----------------------------------------------
        UILabel * labelCreatedAction = [[UILabel alloc] initWithFrame:
                                        CGRectMake(20 + labelCreated.frame.size.width + 5, labelSN.frame.size.height + labelSN.frame.origin.y + 10, 100, 40)];
        labelCreatedAction.text = created;
        labelCreatedAction.textColor = [UIColor colorWithHexString:COLORLITELITEGRAY];
        labelCreatedAction.font = [UIFont fontWithName:FONTLITE size:[[fontSize objectForKey:@"sizeRepairDetails"] intValue]];
        [labelCreatedAction sizeToFit];
        [self addSubview:labelCreatedAction];
        
        //Неисправность----------------------------------------------
        UILabel * labelBreaking = [[UILabel alloc] initWithFrame:
                                   CGRectMake(20, labelCreated.frame.size.height + labelCreated.frame.origin.y + 10, 100, 40)];
        labelBreaking.text = @"Неисправность:";
        labelBreaking.textColor = [UIColor colorWithHexString:COLORLITEGRAY];
        labelBreaking.font = [UIFont fontWithName:FONTREGULAR size:[[fontSize objectForKey:@"sizeRepairDetails"] intValue]];
        [labelBreaking sizeToFit];
        [self addSubview:labelBreaking];
        
        //Неисправность--------------------------------------------------
        UILabel * labelBreakingAction = [[UILabel alloc] initWithFrame:
                                         CGRectMake(20, labelCreated.frame.size.height + labelCreated.frame.origin.y + 10, view.frame.size.width - 40, 40)];
        labelBreakingAction.numberOfLines = 0;
        labelBreakingAction.text = [NSString stringWithFormat:@"                                   %@",breaking];
        labelBreakingAction.textColor = [UIColor colorWithHexString:COLORLITELITEGRAY];
        labelBreakingAction.font = [UIFont fontWithName:FONTLITE size:[[fontSize objectForKey:@"sizeRepairDetails"] intValue]];
        [labelBreakingAction sizeToFit];
        [self addSubview:labelBreakingAction];
        
        //Статус------------------------------------------------------
        UILabel * labelStatus = [[UILabel alloc] initWithFrame:
                                 CGRectMake(20, labelBreakingAction.frame.size.height + labelBreakingAction.frame.origin.y + 10, 100, 40)];
        labelStatus.text = @"Статус:";
        labelStatus.textColor = [UIColor colorWithHexString:COLORLITEGRAY];
        labelStatus.font = [UIFont fontWithName:FONTREGULAR size:[[fontSize objectForKey:@"sizeRepairDetails"] intValue]];
        [labelStatus sizeToFit];
        [self addSubview:labelStatus];
        
        //Статус---------------------------------------------------------
        UILabel * labelStatusAction = [[UILabel alloc] initWithFrame:
                                       CGRectMake(20 + labelStatus.frame.size.width + 5, labelBreakingAction.frame.size.height + labelBreakingAction.frame.origin.y + 10, 100, 40)];
        labelStatusAction.text = status;
        labelStatusAction.textColor = [UIColor colorWithHexString:statusColor];
        labelStatusAction.font = [UIFont fontWithName:FONTLITE size:[[fontSize objectForKey:@"sizeRepairDetails"] intValue]];
        [labelStatusAction sizeToFit];
        [self addSubview:labelStatusAction];
        
        //Ориентировочная дата оконьчания ремонта----------------------
        UILabel * labelReadiness = [[UILabel alloc] initWithFrame:
                                    CGRectMake(20, labelStatus.frame.size.height + labelStatus.frame.origin.y + 10, 100, 40)];
        labelReadiness.text = @"Ориентировочная дата оконьчания ремонта:";
        labelReadiness.textColor = [UIColor colorWithHexString:COLORLITEGRAY];
        labelReadiness.font = [UIFont fontWithName:FONTREGULAR size:[[fontSize objectForKey:@"sizeRepairDetails"] intValue]];
        [labelReadiness sizeToFit];
        [self addSubview:labelReadiness];
        
        //Ориентировочная дата оконьчания ремонта----------------------
        UILabel * labelReadinessAction = [[UILabel alloc] initWithFrame:
                                          CGRectMake(20 + labelReadiness.frame.size.width + 5, labelStatus.frame.size.height + labelStatus.frame.origin.y + 10, 100, 40)];
        labelReadinessAction.text = readiness;
        labelReadinessAction.textColor = [UIColor colorWithHexString:COLORLITELITEGRAY];
        labelReadinessAction.font = [UIFont fontWithName:FONTLITE size:[[fontSize objectForKey:@"sizeRepairDetails"] intValue]];
        [labelReadinessAction sizeToFit];
        [self addSubview:labelReadinessAction];
        
        //Фактическая дата ремонта-------------------------------------
        UILabel * labelFactRepair = [[UILabel alloc] initWithFrame:
                                    CGRectMake(20, labelReadiness.frame.size.height + labelReadiness.frame.origin.y + 10, 100, 40)];
        labelFactRepair.text = @"Фактическая дата ремонта:";
        labelFactRepair.textColor = [UIColor colorWithHexString:COLORLITEGRAY];
        labelFactRepair.font = [UIFont fontWithName:FONTREGULAR size:[[fontSize objectForKey:@"sizeRepairDetails"] intValue]];
        [labelFactRepair sizeToFit];
        [self addSubview:labelFactRepair];
        
        //Ориентировочная дата оконьчания ремонта----------------------
        UILabel * labelFactRepairAction = [[UILabel alloc] initWithFrame:
                                           CGRectMake(20 + labelFactRepair.frame.size.width + 5, labelReadiness.frame.size.height + labelReadiness.frame.origin.y + 10, 100, 40)];
        labelFactRepairAction.text = factRepair;
        labelFactRepairAction.textColor = [UIColor colorWithHexString:COLORLITELITEGRAY];
        labelFactRepairAction.font = [UIFont fontWithName:FONTLITE size:[[fontSize objectForKey:@"sizeRepairDetails"] intValue]];
        [labelFactRepairAction sizeToFit];
        [self addSubview:labelFactRepairAction];
        
        self.frame = CGRectMake(0, 0, view.frame.size.width, labelFactRepairAction.frame.origin.y + labelFactRepairAction.frame.size.height);
  
    }
    return self;
}
//Скрол----------------------
- (instancetype)initWithCustomFrame:(CGRect)customFrame
                         andNameJob: (NSString*) nameJob
                        andPriceJob: (NSString*) priceJob
                            andView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = customFrame;
        self.backgroundColor = [UIColor colorWithHexString:@"373737"];
        
        UILabel * labelJobName = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, view.frame.size.width, 30)];
        labelJobName.text = nameJob;
        labelJobName.textColor = [UIColor colorWithHexString:@"929597"];
        labelJobName.font = [UIFont fontWithName:FONTREGULAR size:18];
        labelJobName.textAlignment = NSTextAlignmentCenter;
        [self addSubview:labelJobName];
        
        UILabel * labelJobPrice = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, view.frame.size.width, 30)];
        labelJobPrice.text = [NSString stringWithFormat:@"Стоимость: %@ руб.", priceJob];
        labelJobPrice.textColor = [UIColor whiteColor];
        labelJobPrice.font = [UIFont fontWithName:FONTLITE size:18];
        [self addSubview:labelJobPrice];
        
        
        
    }
    return self;
}
//отчет о финансах-----------------
- (instancetype)initWithCuntomFrame: (CGRect) rect
                         andInTotal: (NSString*) inTotal
                      andPrepayment: (NSString*) prepayment
                           andToPay: (NSString*) toPay
                            andView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = rect;
        
        //Итого----------------------------
        UILabel * labelInTotal = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width - 200, 10, 200, 20)];
        labelInTotal.text = [NSString stringWithFormat:@"Итого: %@ руб.", inTotal];
        labelInTotal.textColor = [UIColor whiteColor];
        labelInTotal.font = [UIFont fontWithName:FONTLITE size:15];
        [self addSubview:labelInTotal];
        
        //Предоплата-----------------------
        UILabel * labelPrepayment = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width - 200, labelInTotal.frame.origin.y + labelInTotal.frame.size.height, 200, 20)];
        if (!prepayment) {
            labelPrepayment.text = [NSString stringWithFormat:@"Предоплата: 0 руб."];
        } else {
            labelPrepayment.text = [NSString stringWithFormat:@"Предоплата: %@ руб.", prepayment];
        }
        labelPrepayment.textColor = [UIColor whiteColor];
        labelPrepayment.font = [UIFont fontWithName:FONTLITE size:15];
        [self addSubview:labelPrepayment];
        
        //Итого к оплате-------------------
        UILabel * labelToPay = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width - 200, labelPrepayment.frame.origin.y + labelPrepayment.frame.size.height, 200, 20)];
        labelToPay.text = [NSString stringWithFormat:@"Итого к оплате: %@ руб.", toPay];
        labelToPay.textColor = [UIColor whiteColor];
        labelToPay.font = [UIFont fontWithName:FONTLITE size:15];
        [self addSubview:labelToPay];
    }
    return self;
}
@end
