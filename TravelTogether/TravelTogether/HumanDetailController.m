//
//  HumanDetailController.m
//  TravelTogether
//
//  Created by Виктор Мишустин on 20/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "HumanDetailController.h"
#import "HumanDetailView.h"

@interface HumanDetailController () <HumanDetailViewDelegate>

@property (strong, nonatomic) NSArray * arrayData;

@end

@implementation HumanDetailController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self initializeCartBarButton]; //Инициализация кнопок навигации
    [self setCustomTitle:@"АНКЕТА"]; //Ввод заголовка
    [self.navigationController setNavigationBarHidden:NO];
    
    self.arrayData = [self setTravelArray];
    
#pragma mark - View
    
    HumanDetailView * mainView = [[HumanDetailView alloc] initWithView:self.view andData:self.arrayData];
    mainView.delegate = self;
    [self.view addSubview:mainView];
    
}


//создадим тестовый массив-----------
- (NSMutableArray *) setTravelArray
{
    NSArray * arrayText = [NSArray arrayWithObjects:
                            @"Обожаю путешествовать и приобретать новые знакомства. Люблю интересные фильмы, сериалы и хорошую музыку.",
                            @"25 лет",
                            @"Женский",
                            @"Найти интересных друзей для совместного путешествия",
                            @"Свободна",
                            @"Гетеро",
                            @"Спортивное телосложение, шатенка с карими глазами))", nil];
    

    
    NSMutableArray * mainArray = [[NSMutableArray alloc] init];
    NSDictionary * dictImage = [NSDictionary dictionaryWithObjectsAndKeys:@"humanDetailAvaImage.png", @"image", @"Дженивер Энистон", @"name", @"Moscow", @"city", arrayText, @"array", nil];
    [mainArray addObject:dictImage];
    return mainArray;
}

#pragma mark - HumanDetailViewDelegate

- (void) pushToMessegerController: (HumanDetailView*) humanDetailView {
    
}


@end
