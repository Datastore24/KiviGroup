//
//  TravelController.m
//  TravelTogether
//
//  Created by Виктор Мишустин on 07/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "TravelController.h"
#import "TravelView.h"
#import "HumanDetailController.h"

@interface TravelController () <TravelViewDelegate>

@property (strong, nonatomic) NSArray * dataArray;

@end

@implementation TravelController

- (void) viewDidLoad
{
    [super viewDidLoad];    
    //Пареметры кнопки меню------------------------------------
    UIButton * buttonBack = [UIButton createButtonBack];
    [buttonBack addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * backButton =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = backButton;
    
    [self setCustomTitle:@"ПОПУТЧИКИ/РЕЙС RTX 5456"]; //Ввод заголовка
    [self.navigationController setNavigationBarHidden:NO];
    
    self.dataArray = [self setTravelArray];
    
    
#pragma mark - View
    
    TravelView * mainView = [[TravelView alloc] initWithView:self.view andData:self.dataArray];
    mainView.delegate = self;
    [self.view addSubview:mainView];
    
}

- (void) backAction: (UIButton*) button {
    [self.navigationController popViewControllerAnimated:YES];
}

//создадим тестовый массив-----------
- (NSMutableArray *) setTravelArray
{
    NSMutableArray * temporaryArray = [[NSMutableArray alloc] init];
    

    
    NSArray * arrayName = [NSArray arrayWithObjects:
                                 @"Сидоров Иван", @"Мельников Петр",
                                 @"Путинцева Яна", @"Серафимова Оля",
                                 @"Петров Виктор", @"Сидоров Иван", nil];
    NSArray * arrayImage = [NSArray arrayWithObjects:
                            @"imagePhoto1.png", @"imagePhoto2.png",
                            @"imagePhoto3.png", @"imagePhoto4.png",
                            @"imagePhoto5.png", @"imagePhoto6.png", nil];
    
    
    NSArray * arrayColorMessage =  [NSArray arrayWithObjects:
                                   [NSNumber numberWithBool:YES], [NSNumber numberWithBool:NO],
                                   [NSNumber numberWithBool:NO], [NSNumber numberWithBool:YES],
                                   [NSNumber numberWithBool:YES], [NSNumber numberWithBool:NO], nil];
    
    NSArray * arrayAge = [NSArray arrayWithObjects:
                                     @"27", @"29", @"30", @"18", @"27", @"55", nil];
    
    NSArray * arrayCity= [NSArray arrayWithObjects:
                                      @"Москва", @"Тагил",@"Москва",@"Таганрог",@"Москва",@"Москва", nil];
    
    NSArray * arrayMessages =  [NSArray arrayWithObjects:
                                @"3", @"2",@"5",@"7",@"3",@"",nil];
    
    
    for (int i = 0; i < arrayName.count; i++) {
        
        NSDictionary * dictOrder =  [NSDictionary dictionaryWithObjectsAndKeys:
                                     [arrayName objectAtIndex:i],           @"name",
                                     [arrayColorMessage objectAtIndex:i],   @"colorMessage",
                                     [arrayAge objectAtIndex:i],            @"age",
                                     [arrayCity objectAtIndex:i],           @"city",
                                     [arrayMessages objectAtIndex:i],       @"message",
                                     [arrayImage objectAtIndex:i],          @"image", nil];
        
        [temporaryArray addObject:dictOrder];
    }
    
    return temporaryArray;
}

#pragma mark - TravelViewDelegate

- (void) pushToHumanDetail: (TravelView*) travelView andID:(NSString *)identifier {
    HumanDetailController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"HumanDetailController"];
    [self.navigationController pushViewController:detail animated:YES];
}



@end
