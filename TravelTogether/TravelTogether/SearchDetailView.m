//
//  SearchDetailView.m
//  TravelTogether
//
//  Created by Виктор Мишустин on 07/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "SearchDetailView.h"
#import "HexColors.h"
#import "Macros.h"
#import "CustomLabels.h"
#import "UIView+BorderView.h"
#import "UIButton+BackgroundColor.h"

@implementation SearchDetailView

+ (UIView*) customCellTableTravelHistoryWithCellView: (UIView*) cellView //Окно ячейки
                                       andNameFlight: (NSString*) nameFlight //Название рейса
                                       andTravelName: (NSString*) travelName //Куда летит и откуда
                                      andBuyOrSearch: (BOOL) buyOrSearch //Кубить билет или поиск попутчика
                                   andLabelTimeStart: (NSString*) labelTimeStart //Время отправления
                                  andLabelTimeFinish: (NSString*) labelTimeFinish //Время прибытия
                                         andStraight: (BOOL) straight //Прямой или нет
                                       andFlightTime: (NSString*) flightTime //Время полета
                                              andTag: (NSInteger) tag
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
    UIButton * buttonBuy = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonBuy.frame = CGRectMake(13.f, 42.f, 94.f, 21.25f);
    UIImage * imageButtonBoxNO = [UIImage imageNamed:@"buyTikcetSmallImageNO.png"];
    UIImage * imageButtonBoxYES = [UIImage imageNamed:@"buyTicetSmallImageYes.png"];
    [buttonBuy setImage:imageButtonBoxNO forState:UIControlStateNormal];
    [buttonBuy setImage:imageButtonBoxYES forState:UIControlStateHighlighted];
    [cellTable addSubview:buttonBuy];
    
    //Search view-----------
    UIButton * buttonSearch = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonSearch.frame = CGRectMake(13.f + buttonBuy.frame.size.width + 4.f, 42.f, 94.f, 21.25f);
    UIImage * imageButtonSearchBoxNO = [UIImage imageNamed:@"searchFreandsImageNo.png"];
    UIImage * imageButtonSearchBoxYES = [UIImage imageNamed:@"searchFreandsImageYes.png"];
    [buttonSearch setImage:imageButtonSearchBoxNO forState:UIControlStateNormal];
    [buttonSearch setImage:imageButtonSearchBoxYES forState:UIControlStateHighlighted];
    buttonSearch.tag = 10 + tag;
    [cellTable addSubview:buttonSearch];
    
    NSLog(@"%d", buttonSearch.tag);

    //AddBookmark
    UIButton * buttonAdd = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonAdd.frame = CGRectMake(buttonSearch.frame.origin.x + buttonSearch.frame.size.width + 5.f, 42.f, 94.f, 21.25f);
    UIImage * imagebuttonAddNO = [UIImage imageNamed:@"inMyTravelImageNo.png"];
//    UIImage * imageButtonSearchYES = [UIImage imageNamed:@"searchFreandsImageYes.png"];
    [buttonAdd setImage:imagebuttonAddNO forState:UIControlStateNormal];
//    [buttonSearch setImage:imageButtonSearchYES forState:UIControlStateHighlighted];
    [cellTable addSubview:buttonAdd];
    
    
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

- (void) buttonHighlighted: (UIButton*) button {
    [UIView animateWithDuration:0.3 animations:^{
        NSLog(@"ho");
    }];
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
    } else {
        stringHaurs = [flightText substringWithRange:NSMakeRange(0, 2)];
    }
    
    if ([[flightText substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"0"]) {
        stringMinutes = [flightText substringWithRange:NSMakeRange(4, 1)];
    } else {
        stringMinutes = [flightText substringWithRange:NSMakeRange(3, 2)];
    }
    
    NSString * stringTimeFlight = [NSString stringWithFormat:@"%@ ч %@ мин",stringHaurs, stringMinutes];
    return stringTimeFlight;
}




@end
