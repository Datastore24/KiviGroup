//
//  SearchDetailController.m
//  TravelTogether
//
//  Created by Виктор Мишустин on 07/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "SearchDetailController.h"
#import "SearchDetailView.h"
#import "TravelController.h"
#import "Macros.h"

@interface SearchDetailController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView * tableTravelList;
@property (strong, nonatomic) NSArray * temporaryArray; //Временный массив


@property (assign, nonatomic) NSInteger counter;

@end

@implementation SearchDetailController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [self initializeCartBarButton]; //Инициализация кнопок навигации
    [self setCustomTitle:@"ИСКАТЬ ПОПУТЧИКОВ"]; //Ввод заголовка
    [self.navigationController setNavigationBarHidden:NO];
    self.temporaryArray = [NSArray arrayWithArray:[self setTemporaryArray]];
    
    self.counter = 0;
    
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToTravel)
//                                                 name:NOTIFICATION_SEARCH_DETAIL_VIEW_PUSH_TO_TRAVEL object:nil];
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.tableTravelList = [[UITableView alloc] initWithFrame:self.view.frame];
    //Убираем полосы разделяющие ячейки------------------------------
//    self.tableTravelList.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableTravelList.backgroundColor = nil;
    self.tableTravelList.dataSource = self;
    self.tableTravelList.delegate = self;
    self.tableTravelList.showsVerticalScrollIndicator = NO;
    //Очень полездное свойство, отключает дествие ячейки-------------
    self.tableTravelList.allowsSelection = NO;
    [self.view addSubview:self.tableTravelList];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        [cell.contentView addSubview:[SearchDetailView customCellTableTravelHistoryWithCellView:cell
                                                                              andNameFlight:[dictDataCell objectForKey:@"nameFlight"]
                                                                              andTravelName:[dictDataCell objectForKey:@"travelName"]
                                                                             andBuyOrSearch:[[dictDataCell objectForKey:@"buyOrSearch"] boolValue]
                                                                          andLabelTimeStart:[dictDataCell objectForKey:@"labelTimeStart"]
                                                                         andLabelTimeFinish:[dictDataCell objectForKey:@"labelTimeFinish"]
                                                                                andStraight:[[dictDataCell objectForKey:@"straight"] boolValue]
                                                                              andFlightTime:flightTime
                                                                                         andTag:indexPath.row]];
        
        UIButton * testButton = (UIButton*)[self.view viewWithTag:10];
        [testButton addTarget:self action:@selector(testMethod) forControlEvents:UIControlEventTouchUpInside];
        
        self.counter += 1;
        
        NSLog(@"%@", testButton);
        
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
    return 80.f;
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

#pragma mark - Custom Array


//создадим тестовый массив-----------
- (NSMutableArray *) setTemporaryArray
{
    NSMutableArray * temporaryArray = [[NSMutableArray alloc] init];
    
    NSArray * arrayNameFlight = [NSArray arrayWithObjects:
                                 @"Рейс № RTX  5456", @"Рейс № 34-567", @"Рейс № RTX  54-56",
                                 @"Рейс № RRX  2856", @"Рейс № Aero 5358", @"Рейс № RFT  5159", nil];
    
    NSArray * arrayTravelName = [NSArray arrayWithObjects:
                                 @"Новосибирск - Сочи", @"Москва - Питер - Анталья",
                                 @"Новосибирск - Сочи", @"Новосибирск - Сочи",
                                 @"Новосибирск - Сочи", @"Новосибирск - Сочи", nil];
    
    
    NSArray * arrayBuyOrSearch =  [NSArray arrayWithObjects:
                                   [NSNumber numberWithBool:NO], [NSNumber numberWithBool:YES],
                                   [NSNumber numberWithBool:NO], [NSNumber numberWithBool:NO],
                                   [NSNumber numberWithBool:NO], [NSNumber numberWithBool:NO], nil];
    
    NSArray * arrayLabelTimeStart = [NSArray arrayWithObjects:
                                     @"12:00", @"12:00", @"12:00", @"12:00", @"12:00", @"12:00", nil];
    
    NSArray * arrayLabelTimeFinish = [NSArray arrayWithObjects:
                                      @"14:30", @"04:30",@"14:30",@"14:30",@"14:30",@"14:30", nil];
    
    NSArray * arrayStraight =  [NSArray arrayWithObjects:
                                [NSNumber numberWithBool:YES], [NSNumber numberWithBool:YES],
                                [NSNumber numberWithBool:NO],  [NSNumber numberWithBool:YES],
                                [NSNumber numberWithBool:NO],  [NSNumber numberWithBool:NO], nil];
    
    
    for (int i = 0; i < arrayNameFlight.count; i++) {
        
        NSDictionary * dictOrder =  [NSDictionary dictionaryWithObjectsAndKeys:
                                     [arrayNameFlight objectAtIndex:i],      @"nameFlight",
                                     [arrayTravelName objectAtIndex:i],      @"travelName",
                                     [arrayBuyOrSearch objectAtIndex:i],     @"buyOrSearch",
                                     [arrayLabelTimeStart objectAtIndex:i],  @"labelTimeStart",
                                     [arrayLabelTimeFinish objectAtIndex:i], @"labelTimeFinish",
                                     [arrayStraight objectAtIndex:i],        @"straight", nil];
        
        [temporaryArray addObject:dictOrder];
    }
    
    return temporaryArray;
}

- (void) testMethod {
    NSLog(@"testMethod");
}


@end
