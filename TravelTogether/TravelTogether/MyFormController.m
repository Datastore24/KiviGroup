//
//  MyFormController.m
//  TravelTogether
//
//  Created by Виктор Мишустин on 24/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "MyFormController.h"
#import "MyFormView.h"
#import "ListMessegesController.h"
#import "YouLikedController.h"

@interface MyFormController () <MyFormViewDelegate>

@property (strong, nonatomic) NSArray * arrayData;

@end

@implementation MyFormController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self initializeCartBarButton]; //Инициализация кнопок навигации
    [self setCustomTitle:@"АНКЕТА"]; //Ввод заголовка
    self.arrayData = [self setTravelArray];
    
#pragma mark - View
    
    MyFormView * mainView = [[MyFormView alloc] initWithView:self.view andData:self.arrayData];
    mainView.delegate = self;
    [self.view addSubview:mainView];
    
}


#pragma mark - Custom Array
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
    
    NSArray * arrayImege = [NSArray arrayWithObjects: @"addButtonNew.png",
                            @"photo1", @"photo2", @"photo3",
                            @"photo4", @"photo2", @"photo1",
                            @"photo4", @"photo3", @"photo1", @"photo2", @"photo4", nil];
    
    
    
    NSMutableArray * mainArray = [[NSMutableArray alloc] init];
    NSDictionary * dictImage = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"humanDetailAvaImage.png", @"image", @"Дженивер Энистон", @"name",
                                @"Moscow", @"city", arrayText, @"array", @"15", @"countLike",
                                @"5", @"countMessage", arrayImege, @"arrayImage", nil];
    [mainArray addObject:dictImage];
    return mainArray;
}

#pragma mark - MyFormViewDelegate

- (void) pushToMessegerController:(MyFormView *)myFormView {
    ListMessegesController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"ListMessegesController"];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void) pushToLikedController:(MyFormView *)myFormView {
    YouLikedController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"YouLikedController"];
    [self.navigationController pushViewController:detail animated:YES];
}


@end
