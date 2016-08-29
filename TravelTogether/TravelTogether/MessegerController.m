//
//  MessegerController.m
//  TravelTogether
//
//  Created by Виктор Мишустин on 20/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "MessegerController.h"
#import "MessegerView.h"
#import "UIButton+ButtonImage.h"

@interface MessegerController ()

@property (strong, nonatomic) NSArray * arrayData;

@end

@implementation MessegerController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self initializeCartBarButton]; //Инициализация кнопок навигации
    [self setCustomTitle:@"СООБЩЕНИЯ"]; //Ввод заголовка    
    self.arrayData = [self setTemporaryArray];
    
    if (self.navigationController.viewControllers.count > 1) {
        //Кнопка Назад---------------------------------------------
        UIButton * buttonBack = [UIButton createButtonBack];
        [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
        self.navigationItem.leftBarButtonItem = mailbuttonBack;
    }
    
    
#pragma mark - View
    
    MessegerView * mainView = [[MessegerView alloc] initWithView:self.view andData:self.arrayData];
    [self.view addSubview:mainView];
    
}



#pragma mark - Custom Array
//создадим тестовый массив-----------
- (NSMutableArray *) setTemporaryArray
{
    NSMutableArray * temporaryArray = [[NSMutableArray alloc] init];
    
    NSArray * arrayName = [NSArray arrayWithObjects:
                                 @"Вы", @"Дженифер", @"Вы", @"Дженифер", @"Вы", nil];
    
    NSArray * arrayText = [NSArray arrayWithObjects:
                                 @"Привет! Не желаешь составить нам компанию?",
                                 @"В каком смысле?",
                                 @"Предлагаю весело провести вместе пару дней))",
                                 @"Отличная идея!",
                                 @"Отлично!", nil];
    
    
    NSArray * arrayWho =  [NSArray arrayWithObjects:
                                   [NSNumber numberWithBool:YES], [NSNumber numberWithBool:NO],
                                   [NSNumber numberWithBool:YES], [NSNumber numberWithBool:NO],
                                   [NSNumber numberWithBool:YES], nil];
    
    NSArray * arrayDate = [NSArray arrayWithObjects:
                                     @"Только что", @"17:30", @"17:37", @"17:34", @"17:32", nil];
    
    

    
    
    for (int i = 0; i < arrayName.count; i++) {
        
        NSDictionary * dictOrder =  [NSDictionary dictionaryWithObjectsAndKeys:
                                     [arrayName objectAtIndex:i],      @"name",
                                     [arrayText objectAtIndex:i],      @"text",
                                     [arrayWho objectAtIndex:i],     @"who",
                                     [arrayDate objectAtIndex:i],  @"date",
                                     @"imageAvatarChat.png", @"imageName", nil];
        
        [temporaryArray addObject:dictOrder];
    }
    
    return temporaryArray;
}

- (void) buttonBackAction {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
