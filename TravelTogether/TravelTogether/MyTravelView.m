//
//  MyTravelView.m
//  TravelTogether
//
//  Created by Виктор Мишустин on 02/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "MyTravelView.h"
#import "HexColors.h"
#import "Macros.h"
#import "CustomLabels.h"
#import "UIView+BorderView.h"

@implementation MyTravelView

+ (UIView*) customCellTableTravelHistoryWithCellView: (UIView*) cellView //Окно ячейки
                                      andNameFlight: (NSString*) nameFlight //Название рейса
                                      andTravelName: (NSString*) travelName //Куда летит и откуда
                                     andBuyOrSearch: (BOOL) buyOrSearch //Кубить билет или поиск попутчика
                                  andLabelTimeStart: (NSString*) labelTimeStart //Время отправления
                                  andLabelTimeFinish: (NSString*) labelTimeFinish //Время прибытия
                                         andStraight: (BOOL) straight //Прямой или нет
                                       andFlightTime: (NSString*) flightTime //Время полета
{
    
    UIView * cellTable = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, cellView.frame.size.width, 80.f)];
    
    CustomLabels * labelNameFlight = [[CustomLabels alloc] initLabelWithWidht:13.f andHeight:12.5f andColor:VM_COLOR_PINK
                                                                      andText:nameFlight andTextSize:12 andLineSpacing:0.f
                                                                     fontName:VM_FONT_SF_DISPLAY_REGULAR];
    [cellTable addSubview:labelNameFlight];
    
    CustomLabels * labelTravelName = [[CustomLabels alloc] initLabelWithWidht:13.f andHeight:27.5f andColor:VM_COLOR_TEXT_GREY
                                                                      andText:travelName andTextSize:9 andLineSpacing:0.f
                                                                     fontName:VM_FONT_SF_DISPLAY_REGULAR];
    [cellTable addSubview:labelTravelName];
    
    //Buy view----------
    UIView * viewBuy = [[UIView alloc] initWithFrame:CGRectMake(13.f, 42.f, 94.f, 21.25f)];
    viewBuy.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK];
    [self customRadiusWithView:viewBuy andRadius:10.625f];
    [cellTable addSubview:viewBuy];
    
    UIView * viewBuyInput = [[UIView alloc] initWithFrame:CGRectMake(14.f, 43.f, 92.f, 19.25f)];
    viewBuyInput.backgroundColor = [UIColor whiteColor];
    [self customRadiusWithView:viewBuyInput andRadius:9.625f];
    [cellTable addSubview:viewBuyInput];
    
    CustomLabels * labelBuy = [[CustomLabels alloc] initLabelTableWithWidht:13.f andHeight:41.f andSizeWidht:94.f
                                                              andSizeHeight:21.25f andColor:VM_COLOR_PINK andText:@"Купить билет"];
    labelBuy.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:8];
    labelBuy.textAlignment = NSTextAlignmentCenter;
    if (buyOrSearch) {
        labelBuy.textColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_WHITE];
        viewBuyInput.alpha = 0.f;
    }
    
    [cellTable addSubview:labelBuy];
    
    //Search view-----------
    UIView * viewSearch = [[UIView alloc] initWithFrame:CGRectMake(13.f + viewBuy.frame.size.width + 5.f, 42.f, 94.f, 21.25f)];
    viewSearch.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK];
    [self customRightRadiusWithView:viewSearch andRadius:10.625f];
    [cellTable addSubview:viewSearch];
    
    UIView * viewSearchInput = [[UIView alloc] initWithFrame:CGRectMake(13.f + viewBuy.frame.size.width + 6.f, 43.f, 92.f, 19.25f)];
    viewSearchInput.backgroundColor = [UIColor whiteColor];
    [self customRightRadiusWithView:viewSearchInput andRadius:9.625f];
    viewSearchInput.alpha = 0.f;
    [cellTable addSubview:viewSearchInput];
    
    CustomLabels * labelSearch = [[CustomLabels alloc] initLabelTableWithWidht:13.f + viewBuy.frame.size.width + 5.f
                                                                     andHeight:41.f andSizeWidht:94.f andSizeHeight:21.25f
                                                                      andColor:VM_COLOR_WHITE andText:@"Искать попутчиков"];
    labelSearch.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:8];
    labelSearch.textAlignment = NSTextAlignmentCenter;
    if (buyOrSearch) {
        labelSearch.textColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK];
        viewSearchInput.alpha = 1.f;
    }
    
    [cellTable addSubview:labelSearch];
    
    //Lables time start--------
    CustomLabels * labelTimeStartInd = [[CustomLabels alloc] initLabelWithWidht:130.f andHeight:13.75f andColor:VM_COLOR_BLACK
                                                                       andText:@"OVB" andTextSize:11 andLineSpacing:0.f
                                                                      fontName:VM_FONT_SF_DISPLAY_REGULAR];
    [cellTable addSubview:labelTimeStartInd];
    
    CustomLabels * labelStartTime = [[CustomLabels alloc] initLabelWithWidht:130.f andHeight:27.5f andColor:VM_COLOR_TEXT_GREY
                                                                        andText:labelTimeStart andTextSize:9 andLineSpacing:0.f
                                                                       fontName:VM_FONT_SF_DISPLAY_REGULAR];
    [cellTable addSubview:labelStartTime];
    
    
    //Lables time finish--------
    CustomLabels * labelTimeFinishInd = [[CustomLabels alloc] initLabelWithWidht:cellTable.frame.size.width - 31.25f andHeight:13.75f
                                                                        andColor:VM_COLOR_BLACK andText:@"AER" andTextSize:11
                                                                  andLineSpacing:0.f fontName:VM_FONT_SF_DISPLAY_REGULAR];
    [cellTable addSubview:labelTimeFinishInd];
    
    CustomLabels * labelFinishTime = [[CustomLabels alloc] initLabelWithWidht:cellTable.frame.size.width - 32.5f andHeight:27.5f
                                                                     andColor:VM_COLOR_TEXT_GREY andText:labelTimeFinish andTextSize:9
                                                               andLineSpacing:0.f fontName:VM_FONT_SF_DISPLAY_REGULAR];
    [cellTable addSubview:labelFinishTime];
    
    //Image straight----------
    UIImageView * imageStraight = [[UIImageView alloc] initWithFrame:CGRectMake(cellTable.frame.size.width - 160.f, 21.25, 120.f, 6.f)];
    NSString * stringImageTravel;
    NSString * textStraight;
    if (straight) {
        stringImageTravel = @"imageTravelStraightYES.png";
        textStraight = @"прямой";
    } else {
        stringImageTravel = @"imageTravelStraightNO.png";
        textStraight = @"с пересадкой";
    }
    imageStraight.image = [UIImage imageNamed:stringImageTravel];
    [cellTable addSubview:imageStraight];
    
    CustomLabels * labelTextStraight = [[CustomLabels alloc] initLabelTableWithWidht:cellTable.frame.size.width - 160.f andHeight:27.f
                                                                        andSizeWidht:120.f andSizeHeight:10 andColor:VM_COLOR_PINK
                                                                             andText:textStraight];
    labelTextStraight.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:8];
    labelTextStraight.textAlignment = NSTextAlignmentCenter;
    [cellTable addSubview:labelTextStraight];
    
    
    CustomLabels * labelTextFlidht = [[CustomLabels alloc] initLabelTableWithWidht:cellTable.frame.size.width - 160.f andHeight:12.f
                                                                        andSizeWidht:120.f andSizeHeight:10 andColor:VM_COLOR_TEXT_GREY
                                                                             andText:[self createFlightLabelTextWithString:flightTime]];
    labelTextFlidht.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:8];
    labelTextFlidht.textAlignment = NSTextAlignmentCenter;
    [cellTable addSubview:labelTextFlidht];
    
    [UIView borderViewWithHeight:79.5f andWight:13.f andView:cellTable andColor:VM_COLOR_LIGHT_GREY];
    
    return cellTable;
}

//Два метода для создания загругления------

+ (void) customRadiusWithView: (UIView*) view
                 andRadius: (CGFloat) radius
{
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                     byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft)
                                           cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

+ (void) customRightRadiusWithView: (UIView*) view
                    andRadius: (CGFloat) radius
{
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                     byRoundingCorners:(UIRectCornerTopRight | UIRectCornerBottomRight)
                                           cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

//Создаем строку полета--------------------------

+ (NSString *) createFlightLabelTextWithString: (NSString*) flightText
{
    NSString * stringHaurs;
    NSString * stringMinutes;
    
    if ([[flightText substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"0"]) {
        stringHaurs = [flightText substringWithRange:NSMakeRange(1, 1)];
        stringMinutes = [flightText substringWithRange:NSMakeRange(4, 1)];
    } else {
       stringHaurs = [flightText substringWithRange:NSMakeRange(0, 2)];
        stringMinutes = [flightText substringWithRange:NSMakeRange(3, 2)];
    }
    
    NSString * stringTimeFlight = [NSString stringWithFormat:@"%@ ч %@ мин",stringHaurs, stringMinutes];
    return stringTimeFlight;

}

@end





