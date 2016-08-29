//
//  ListMessegesController.m
//  TravelTogether
//
//  Created by Виктор Мишустин on 29/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "ListMessegesController.h"
#import "ListMessegesView.h"
#import "MessegerController.h"

@interface ListMessegesController () <ListMessegesViewDelegate>

@property (strong, nonatomic) NSArray * arrayData;

@end

@implementation ListMessegesController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self initializeCartBarButton]; //Инициализация кнопок навигации
    [self setCustomTitle:@"СООБЩЕНИЯ"]; //Ввод заголовка
    self.arrayData = [self setTravelArray];
    
    if (self.navigationController.viewControllers.count > 1) {
        //Кнопка Назад---------------------------------------------
        UIButton * buttonBack = [UIButton createButtonBack];
        [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
        self.navigationItem.leftBarButtonItem = mailbuttonBack;
    }
    
#pragma mark - View
    
    ListMessegesView * mainView = [[ListMessegesView alloc] initWithView:self.view andData:self.arrayData];
    mainView.delegate = self;
    [self.view addSubview:mainView];
    
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
    
    NSArray * arrayMessege= [NSArray arrayWithObjects:
                          @"Привет! Почему молчишь, я...",
                          @"Ок, договорились!",
                          @"Не интересно, потомучто...",
                          @"А ты сам с какого города бу...",
                          @"Конечно! Нас тут целая компа...",
                          @"Нет", nil];
    
    NSArray * arrayDate = [NSArray arrayWithObjects:
                           @"час назад",
                           @"2 часа назад",
                           @"2,5 часа назад",
                           @"20 июля",
                           @"20 июля",
                           @"15 декабря", nil];
    
    NSArray * arrayMessages =  [NSArray arrayWithObjects:
                                @"3", @"2",@"5",@"7",@"3",@"",nil];
    
    
    for (int i = 0; i < arrayName.count; i++) {
        
        NSDictionary * dictOrder =  [NSDictionary dictionaryWithObjectsAndKeys:
                                     [arrayName objectAtIndex:i],           @"name",
                                     [arrayColorMessage objectAtIndex:i],   @"colorMessage",
                                     [arrayAge objectAtIndex:i],            @"age",
                                     [arrayMessege objectAtIndex:i],        @"textMessege",
                                     [arrayMessages objectAtIndex:i],       @"message",
                                     [arrayImage objectAtIndex:i],          @"image",
                                     [arrayDate objectAtIndex:i],           @"date", nil];
        
        [temporaryArray addObject:dictOrder];
    }
    
    return temporaryArray;
}

- (void) buttonBackAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ListMessegesViewDelegate

- (void) pushToMesseger: (ListMessegesView*) listMessegesView {
    MessegerController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"MessegerController"];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
