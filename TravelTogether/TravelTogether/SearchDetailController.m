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

@interface SearchDetailController () <SearchDetailViewDelegate>

@end

@implementation SearchDetailController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [self initializeCartBarButton]; //Инициализация кнопок навигации
    [self setCustomTitle:@"ИСКАТЬ ПОПУТЧИКОВ"]; //Ввод заголовка
    [self.navigationController setNavigationBarHidden:NO];
    
    SearchDetailView * mainView = [[SearchDetailView alloc] initWithView:self.view andData:[self setTemporaryArray]];
    mainView.delegate = self;
    [self.view addSubview:mainView];

    
}


#pragma mark - SearchDetailViewDelegate

- (void) pushToTravel: (SearchDetailView*) searchDetailView {
    TravelController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"TravelController"];
    [self.navigationController pushViewController:detail animated:YES];
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
