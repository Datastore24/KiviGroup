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

@interface SearchDetailView () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView * tableTravelHistory;
@property (strong, nonatomic) NSArray * temporaryArray; //Временный массив

@end

@implementation SearchDetailView

- (instancetype)initWithView: (UIView*) view andData: (NSArray*) data
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        
        //Загружаем тестовый массив-----
        self.temporaryArray = data;
        
        
        self.tableTravelHistory = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        //Убираем полосы разделяющие ячейки------------------------------
        self.tableTravelHistory.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableTravelHistory.backgroundColor = nil;
        self.tableTravelHistory.dataSource = self;
        self.tableTravelHistory.delegate = self;
        self.tableTravelHistory.showsVerticalScrollIndicator = NO;
        //Очень полездное свойство, отключает дествие ячейки-------------
        self.tableTravelHistory.allowsSelection = NO;
        [self addSubview:self.tableTravelHistory];
        
        
    }
    return self;
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.temporaryArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"newFriendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    for (UIView * view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    NSDictionary * dictDataCell = [self.temporaryArray objectAtIndex:indexPath.row];
    //Метод вычисления премени полета
    NSString * flightTime = [self flightTimeWirhStartTime:[dictDataCell objectForKey:@"labelTimeStart"]
                                               andEndTime:[dictDataCell objectForKey:@"labelTimeFinish"]];
    
    
    cell.backgroundColor = nil;
    if (self.temporaryArray.count != 0) {
        [cell.contentView addSubview:[self customCellTableTravelHistoryWithCellView:cell
                                                                      andNameFlight:[dictDataCell objectForKey:@"nameFlight"]
                                                                      andTravelName:[dictDataCell objectForKey:@"travelName"]
                                                                     andBuyOrSearch:[[dictDataCell objectForKey:@"buyOrSearch"] boolValue]
                                                                  andLabelTimeStart:[dictDataCell objectForKey:@"labelTimeStart"]
                                                                 andLabelTimeFinish:[dictDataCell objectForKey:@"labelTimeFinish"]
                                                                        andStraight:[[dictDataCell objectForKey:@"straight"] boolValue]
                                                                      andFlightTime:flightTime
                                                                         andCustTag:indexPath.row]];
    } else {
        NSLog(@"Нет категорий");
    }
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
//Анимация нажатия ячейки--------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isiPhone6) {
        return 95.f;
    } else {
        return 80.f;
    }
}


- (UIView*) customCellTableTravelHistoryWithCellView: (UIView*) cellView //Окно ячейки
                                       andNameFlight: (NSString*) nameFlight //Название рейса
                                       andTravelName: (NSString*) travelName //Куда летит и откуда
                                      andBuyOrSearch: (BOOL) buyOrSearch //Кубить билет или поиск попутчика
                                   andLabelTimeStart: (NSString*) labelTimeStart //Время отправления
                                  andLabelTimeFinish: (NSString*) labelTimeFinish //Время прибытия
                                         andStraight: (BOOL) straight //Прямой или нет
                                       andFlightTime: (NSString*) flightTime //Время полета
                                          andCustTag: (NSInteger) custTag
{
    
    UIView * cellTable = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, 80.f)];
    
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
    UIImage * imageButtonNO = [UIImage imageNamed:@"buyTicketNo.png"];
    UIImage * imageButtonYES = [UIImage imageNamed:@"buyTicketYes.png"];
    [buttonBuy setImage:imageButtonNO forState:UIControlStateNormal];
    [buttonBuy setImage:imageButtonYES forState:UIControlStateHighlighted];
    buttonBuy.tag = 10 + custTag;
    [buttonBuy addTarget:self action:@selector(buttonBuyAction:) forControlEvents:UIControlEventTouchUpInside];
    [cellTable addSubview:buttonBuy];
    
    //Search view-----------
    UIButton * buttonSearch = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonSearch.frame = CGRectMake(13.f + buttonBuy.frame.size.width + 5.f, 42.f, 94.f, 21.25f);
    UIImage * imageButtonSearchNO = [UIImage imageNamed:@"searchFreandsImageNo.png"];
    UIImage * imageButtonSearchYES = [UIImage imageNamed:@"searchFreandsImageYes.png"];
    [buttonSearch setImage:imageButtonSearchNO forState:UIControlStateNormal];
    [buttonSearch setImage:imageButtonSearchYES forState:UIControlStateHighlighted];
    buttonSearch.tag = 20 + custTag;
    [buttonSearch addTarget:self action:@selector(buttonSearchAction:) forControlEvents:UIControlEventTouchUpInside];
    [cellTable addSubview:buttonSearch];
    
    //AddBookmark
    UIButton * buttonAdd = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonAdd.frame = CGRectMake(buttonSearch.frame.origin.x + buttonSearch.frame.size.width + 5.f, 42.f, 94.f, 21.25f);
    UIImage * imagebuttonAddNO = [UIImage imageNamed:@"inMyTravelImageNo.png"];
    UIImage * imageButtonAddYES = [UIImage imageNamed:@"inMyTravelNewImageYes.png"];
    [buttonAdd setImage:imagebuttonAddNO forState:UIControlStateNormal];
    [buttonAdd setImage:imageButtonAddYES forState:UIControlStateHighlighted];
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

#pragma mark - Search Time Flight

- (NSString*) flightTimeWirhStartTime: (NSString*) startTime andEndTime: (NSString*) endTime
{
    NSString * flightTime;
    NSDate * dateStartFlight = [self stringToDate:startTime];
    NSDate * datEndFlight = [self stringToDate:endTime];
    NSTimeInterval secondsBetween = [datEndFlight timeIntervalSinceDate:dateStartFlight];
    NSDate * newNow = [NSDate dateWithTimeIntervalSinceReferenceDate:secondsBetween];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd HH:mm"];
    flightTime = [NSString stringWithFormat:@"%@", newNow];
    NSRange range = NSMakeRange(11, 5);
    flightTime = [flightTime substringWithRange:range];
    return flightTime;
}

//Метод превращающий строку в дату----------
- (NSDate*) stringToDate: (NSString*) stringDate
{
    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH:mm"];
    NSDate *date = [dateFormat dateFromString:stringDate];
    return date;
}

//Создаем строку полета--------------------------

- (NSString *) createFlightLabelTextWithString: (NSString*) flightText
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

#pragma mark - Actions

- (void) buttonBuyAction: (UIButton*) button {
    for (int i = 0; i < self.temporaryArray.count; i++) {
        if (button.tag == 10 + i) {
            NSLog(@"buttonBuy %d", i);
        }
    }
}


- (void) buttonSearchAction: (UIButton*) button {
    for (int i = 0; i < self.temporaryArray.count; i++) {
        if (button.tag == 20 + i) {
            [self.delegate pushToTravel:self];
        }
    }
}


@end
