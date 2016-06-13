//
//  DeliveryView.m
//  FlowersOnline
//
//  Created by Виктор Мишустин on 10.06.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "DeliveryView.h"
#import "CustomLabels.h"
#import "UIColor+HexColor.h"
#import "Macros.h"

@implementation DeliveryView

- (instancetype)initWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 64, view.frame.size.width, view.frame.size.height - 64);
        
        //Лейбл первого заголовка-------------------------------
        CustomLabels * labelTitleOne = [[CustomLabels alloc] initLabelTableWithWidht:20 andHeight:30 andSizeWidht:self.frame.size.width - 40 andSizeHeight:35 andColor:COLORTEXTGRAY andText:@"Цены на доставку по Москве и Московской Области :"];
        if (isiPhone4s) {
            labelTitleOne.frame = CGRectMake(20, 10, self.frame.size.width - 40, 35);
        }
        labelTitleOne.numberOfLines = 0;
        labelTitleOne.font = [UIFont fontWithName:FONTBOND size:14];
        labelTitleOne.textAlignment = NSTextAlignmentLeft;
        [self addSubview:labelTitleOne];
        
        //Основной текст первая часть---------------------------
        CustomLabels * labelTextOne = [[CustomLabels alloc] initLabelTableWithWidht:20 andHeight:70 andSizeWidht:self.frame.size.width - 40 andSizeHeight:140 andColor:COLORTEXTGRAY andText:
                                       @"Курьером по Москве в пределах МКАД - 500 руб.\nКурьером по Москве и Московской области за МКАД - 1000 руб. (в пределах 30 км. от МКАД).\nАвтотранспортом по Москве в пределах МКАД - 2 500 руб.\nАвтотранспортом по Москве и Московской области за МКАД - 2 500 руб. + 30 руб.\\км. за МКАД оплачивается в две стороны."];
        labelTextOne.numberOfLines = 0;
        labelTextOne.font = [UIFont fontWithName:FONTREGULAR size:14];
        if (isiPhone5) {
            labelTextOne.frame = CGRectMake(20, 70, self.frame.size.width - 40, 120);
            labelTextOne.font = [UIFont fontWithName:FONTREGULAR size:12];
        } else if (isiPhone4s) {
            labelTextOne.frame = CGRectMake(20, 50, self.frame.size.width - 40, 120);
            labelTextOne.font = [UIFont fontWithName:FONTREGULAR size:12];
        }
        labelTextOne.textAlignment = NSTextAlignmentLeft;
        [self addSubview:labelTextOne];
        
        //Первая граница-------------------
        UIView * viewBorder = [[UIView alloc] initWithFrame:CGRectMake(20, 222, self.frame.size.width - 40, 0.5)];
        if (isiPhone5) {
            viewBorder.frame = CGRectMake(20, 212, self.frame.size.width - 40, 0.5);
        } else if (isiPhone4s) {
            viewBorder.frame = CGRectMake(20, 182, self.frame.size.width - 40, 0.5);
        }
        viewBorder.backgroundColor = [UIColor colorWithHexString:COLORTEXTGRAY];
        [self addSubview:viewBorder];
        
        //Лейбл второго заголовка-------------------------------
        CustomLabels * labelTitleTwo = [[CustomLabels alloc] initLabelTableWithWidht:20 andHeight:235 andSizeWidht:self.frame.size.width - 40 andSizeHeight:20 andColor:COLORTEXTGRAY andText:@"Мы гарантируем:"];
        if (isiPhone4s) {
            labelTitleTwo.frame = CGRectMake(20, 195, self.frame.size.width - 40, 20);
        }
        labelTitleTwo.numberOfLines = 0;
        labelTitleTwo.font = [UIFont fontWithName:FONTBOND size:14];
        labelTitleTwo.textAlignment = NSTextAlignmentLeft;
        [self addSubview:labelTitleTwo];
        
        //Основной текст вторая часть---------------------------
        CustomLabels * labelTextTwo = [[CustomLabels alloc] initLabelTableWithWidht:20 andHeight:260 andSizeWidht:self.frame.size.width - 40 andSizeHeight:165 andColor:COLORTEXTGRAY andText:
                                       @"Полный контроль качества.\nОформление всех документов с компанией-перевозчиком для транспортировки груза в Амстердам.\nДальнейшая транспортировка груза до Амстердама (или до нужного вам города).\nПрекулинг (размещение цветов в вакуумной установке по нагнетанию необходимой температуры для хранения).\nРазмещение цветов в холодильных складах до момента выдачи груза вашей транспортной компании."];
        if (isiPhone6) {
            labelTextTwo.frame = CGRectMake(20, 260, self.frame.size.width - 40, 210);
        }
        labelTextTwo.numberOfLines = 0;
        labelTextTwo.font = [UIFont fontWithName:FONTREGULAR size:14];
        if (isiPhone5) {
            labelTextTwo.frame = CGRectMake(20, 260, self.frame.size.width - 40, 180);
            labelTextTwo.font = [UIFont fontWithName:FONTREGULAR size:12];
        } else if (isiPhone4s) {
            labelTextTwo.frame = CGRectMake(20, 220, self.frame.size.width - 40, 180);
            labelTextTwo.font = [UIFont fontWithName:FONTREGULAR size:12];
        }
        labelTextTwo.textAlignment = NSTextAlignmentLeft;
        [self addSubview:labelTextTwo];
        
    }
    return self;
}

@end
