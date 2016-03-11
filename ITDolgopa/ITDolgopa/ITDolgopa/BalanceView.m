//
//  BalanceView.m
//  ITDolgopa
//
//  Created by Viktor on 20.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "BalanceView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "FontSizeChanger.h"

@implementation BalanceView

- (instancetype)initWithView: (UIView*) view
                   andInWork: (NSString*) inWork
                    andReady: (NSString*) ready
                     andDone: (NSString*) done
                      andAll: (NSString*) all
                 andAllMoney: (NSString*) allMoney
                     andDolg: (NSString*) dolg
{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        
        NSDictionary * fontSize = [FontSizeChanger changeFontSize];
        
        //Устройств в ремонт не изменяемая
        //Создание не изменяемых строк----------------------------
        UILabel * labelInWork = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 100, 40)];
        if (isiPhone5) {
            labelInWork.frame = CGRectMake(20, 20, 100, 40);
        }
        labelInWork.text = @"Устройств в ремонте:";
        labelInWork.textColor = [UIColor colorWithHexString:COLORLITEGRAY];
        labelInWork.font = [UIFont fontWithName:FONTREGULAR size:[[fontSize objectForKey:@"sizeText"] intValue]];
        [labelInWork sizeToFit];
        [self addSubview:labelInWork];
        
        UILabel * labelReady = [[UILabel alloc] initWithFrame:
                                  CGRectMake(20, labelInWork.frame.size.height + labelInWork.frame.origin.y + 20, 100, 40)];
        labelReady.text = @"Устройств к выдаче:";
        labelReady.textColor = [UIColor colorWithHexString:COLORLITEGRAY];
        labelReady.font = [UIFont fontWithName:FONTREGULAR size:[[fontSize objectForKey:@"sizeText"] intValue]];
        [labelReady sizeToFit];
        [self addSubview:labelReady];
        
        UILabel * labelDone = [[UILabel alloc] initWithFrame:
                                   CGRectMake(20, labelReady.frame.size.height + labelReady.frame.origin.y + 20, 100, 40)];
        labelDone.text = @"Выданных устройств:";
        labelDone.textColor = [UIColor colorWithHexString:COLORLITEGRAY];
        labelDone.font = [UIFont fontWithName:FONTREGULAR size:[[fontSize objectForKey:@"sizeText"] intValue]];
        [labelDone sizeToFit];
        [self addSubview:labelDone];
        
        UILabel * labelAll = [[UILabel alloc] initWithFrame:
                                    CGRectMake(20, labelDone.frame.size.height + labelDone.frame.origin.y + 20, 100, 40)];
        labelAll.text = @"Всего устройств:";
        labelAll.textColor = [UIColor colorWithHexString:COLORLITEGRAY];
        labelAll.font = [UIFont fontWithName:FONTREGULAR size:[[fontSize objectForKey:@"sizeText"] intValue]];
        [labelAll sizeToFit];
        [self addSubview:labelAll];
        
        UILabel * labelAllMoney = [[UILabel alloc] initWithFrame:
                                 CGRectMake(20, labelAll.frame.size.height + labelAll.frame.origin.y + 20, 100, 40)];
        labelAllMoney.text = @"Потрачено денег:";
        labelAllMoney.textColor = [UIColor colorWithHexString:COLORLITEGRAY];
        labelAllMoney.font = [UIFont fontWithName:FONTREGULAR size:[[fontSize objectForKey:@"sizeText"] intValue]];
        [labelAllMoney sizeToFit];
        [self addSubview:labelAllMoney];
        
        UILabel * labelDolg = [[UILabel alloc] initWithFrame:
                                 CGRectMake(20, labelAllMoney.frame.size.height + labelAllMoney.frame.origin.y + 20, 100, 40)];
        if ([inWork integerValue] > 0) {
            labelDolg.text = @"Ваш баланс:";
        } else {
            labelDolg.text = @"Ваш долг:";
        }
        labelDolg.textColor = [UIColor colorWithHexString:COLORLITEGRAY];
        labelDolg.font = [UIFont fontWithName:FONTREGULAR size:[[fontSize objectForKey:@"sizeText"] intValue]];
        [labelDolg sizeToFit];
        [self addSubview:labelDolg];
        
        //Создание изменяемых строк-------------------------------------
        UILabel * labelInWorkAction = [[UILabel alloc] initWithFrame:CGRectMake(20 + labelInWork.frame.size.width + 5, 30, 100, 40)];
        if (isiPhone5) {
            labelInWorkAction.frame = CGRectMake(20 + labelInWork.frame.size.width + 5, 20, 100, 40);
        }
        labelInWorkAction.text = inWork;
        labelInWorkAction.textColor = [UIColor colorWithHexString:COLORLITELITEGRAY];
        labelInWorkAction.font = [UIFont fontWithName:FONTLITE size:[[fontSize objectForKey:@"sizeText"] intValue]];
        [labelInWorkAction sizeToFit];
        [self addSubview:labelInWorkAction];
        
        UILabel * labelReadyAction = [[UILabel alloc] initWithFrame:
                                        CGRectMake(20 + labelReady.frame.size.width + 5, labelInWork.frame.size.height + labelInWork.frame.origin.y + 20, 100, 40)];
        labelReadyAction.text = ready;
        labelReadyAction.textColor = [UIColor colorWithHexString:COLORLITELITEGRAY];
        labelReadyAction.font = [UIFont fontWithName:FONTLITE size:[[fontSize objectForKey:@"sizeText"] intValue]];
        [labelReadyAction sizeToFit];
        [self addSubview:labelReadyAction];
        
        UILabel * labelDoneAction = [[UILabel alloc] initWithFrame:
                                         CGRectMake(20 + labelDone.frame.size.width + 5, labelReady.frame.size.height + labelReady.frame.origin.y + 20, 80, 40)];
        labelDoneAction.text = done;
        labelDoneAction.textColor = [UIColor colorWithHexString:COLORLITELITEGRAY];
        labelDoneAction.font = [UIFont fontWithName:FONTLITE size:[[fontSize objectForKey:@"sizeText"] intValue]];
        [labelDoneAction sizeToFit];
        CGRect rect = labelDoneAction.frame;
        rect.size.width = 200;
        labelDoneAction.frame = rect;
        [self addSubview:labelDoneAction];
        
        UILabel * labelAllAction = [[UILabel alloc] initWithFrame:
                                          CGRectMake(20 + labelAll.frame.size.width + 5, labelDone.frame.size.height + labelDone.frame.origin.y + 20, 100, 40)];
        labelAllAction.text = all;
        labelAllAction.textColor = [UIColor colorWithHexString:COLORLITELITEGRAY];
        labelAllAction.font = [UIFont fontWithName:FONTLITE size:[[fontSize objectForKey:@"sizeText"] intValue]];
        [labelAllAction sizeToFit];
        [self addSubview:labelAllAction];
        
        UILabel * labelAllMoneyAction = [[UILabel alloc] initWithFrame:
                                       CGRectMake(20 + labelAllMoney.frame.size.width + 5, labelAll.frame.size.height + labelAll.frame.origin.y + 20, 100, 40)];
        labelAllMoneyAction.text = allMoney;
        labelAllMoneyAction.textColor = [UIColor colorWithHexString:COLORLITELITEGRAY];
        labelAllMoneyAction.font = [UIFont fontWithName:FONTLITE size:[[fontSize objectForKey:@"sizeText"] intValue]];
        [labelAllMoneyAction sizeToFit];
        [self addSubview:labelAllMoneyAction];
        
        UILabel * labelDolgAction = [[UILabel alloc] initWithFrame:
                                       CGRectMake(20 + labelDolg.frame.size.width + 5, labelAllMoney.frame.size.height + labelAllMoney.frame.origin.y + 20, 100, 40)];
        labelDolgAction.text = dolg;
        labelDolgAction.textColor = [UIColor colorWithHexString:COLORLITELITEGRAY];
        labelDolgAction.font = [UIFont fontWithName:FONTLITE size:[[fontSize objectForKey:@"sizeText"] intValue]];
        [labelDolgAction sizeToFit];
        [self addSubview:labelDolgAction];



    }
    return self;
}

- (instancetype)initWithView:(UIView*) view
            andInworkVendors: (NSString*) inworkVendors
             andInworkPprice: (NSString*) inworkPprice
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 300, view.frame.size.width, 80);
        self.backgroundColor = [UIColor colorWithHexString:@"363636"];
        
        UILabel * labelInworkVendors = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, view.frame.size.width, 40)];
        labelInworkVendors.text = inworkVendors;
        labelInworkVendors.textColor = [UIColor whiteColor];
        labelInworkVendors.font = [UIFont fontWithName:FONTREGULAR size:15];
        [self addSubview:labelInworkVendors];
        
        UILabel * labelInworkPprice = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width - 80, 20, 80, 40)];
        labelInworkPprice.text = inworkPprice;
        labelInworkPprice.textColor = [UIColor whiteColor];
        labelInworkPprice.font = [UIFont fontWithName:FONTREGULAR size:15];
        [self addSubview:labelInworkPprice];
        
    }
    return self;
}

@end
