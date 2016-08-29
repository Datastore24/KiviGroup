//
//  YouLikedController.m
//  TravelTogether
//
//  Created by Виктор Мишустин on 29/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "YouLikedController.h"
#import "YouLikedView.h"
#import "UIButton+ButtonImage.h"
#import "HumanDetailController.h"

@interface YouLikedController () <YouLikedViewDelegate>

@property (strong, nonatomic) NSArray * arrayData;

@end

@implementation YouLikedController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self initializeCartBarButton]; //Инициализация кнопок навигации
    [self setCustomTitle:@"ВЫ ПОНРАВИЛИСЬ"]; //Ввод заголовка
    self.arrayData = [self setLikedArray];
    
    
    if (self.navigationController.viewControllers.count > 1) {
        //Кнопка Назад---------------------------------------------
        UIButton * buttonBack = [UIButton createButtonBack];
        [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
        self.navigationItem.leftBarButtonItem = mailbuttonBack;
    }
    

    
#pragma mark - View
    
    YouLikedView * mainView = [[YouLikedView alloc] initWithView:self.view andData:self.arrayData];
    mainView.delegate = self;
    [self.view addSubview:mainView];
    

}

//создадим тестовый массив-----------
- (NSMutableArray *) setLikedArray
{
    NSMutableArray * likedArray = [[NSMutableArray alloc] init];
    //------
    NSMutableArray * allLikedArray = [[NSMutableArray alloc] init];
    
    NSArray * arrayAllImage = [NSMutableArray arrayWithObjects:
                               @"likeImage3.png", @"likeImage2.png", @"likeImage1.png", @"likeImage3.png",
                               @"likeImage1.png", @"likeImage3.png", @"likeImage2.png", @"likeImage4.png", nil];
    
    NSArray * arrayAllName = [NSMutableArray arrayWithObjects:
                               @"Оля", @"Марина", @"Иван", @"Оля",
                               @"Иван", @"Оля", @"Марина", @"Петр", nil];
    
    NSArray * arrayAllDate = [NSMutableArray arrayWithObjects:
                              @"1 день назад", @"3 дня назад", @"15 мая", @"4 дня назад",
                              @"15 мая", @"1 день назад", @"3 дня назад", @"25 апреля", nil];
    
    for (int i = 0; i < arrayAllImage.count; i++) {
        NSDictionary * dictAll = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [arrayAllImage objectAtIndex:i], @"image",
                                  [arrayAllName objectAtIndex:i], @"name", [arrayAllDate objectAtIndex:i], @"date", nil];
        
        [allLikedArray addObject:dictAll];
    }
    //------
    NSMutableArray * newLikedArray = [[NSMutableArray alloc] init];
    
    NSArray * arrayNewImage = [NSArray arrayWithObjects:@"likeBigImage3.png", @"likeBigImage2.png", @"likeBigImage1.png", nil];
    NSArray * arrayNewDate = [NSArray arrayWithObjects:@"1 день назад", @"2 дня назад", @"3 дня назад", nil];
    
    for (int i = 0; i < arrayNewImage.count; i++) {
        NSDictionary * dictNew = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [arrayNewImage objectAtIndex:i], @"image", [arrayNewDate objectAtIndex:i], @"date", nil];
        
        [newLikedArray addObject:dictNew];
    }
    
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:allLikedArray, @"all", newLikedArray, @"new", nil];
    [likedArray addObject:dict];
    
    return likedArray;
}

- (void) buttonBackAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - YouLikedViewDelegate

- (void) pushToHumanDetail: (YouLikedView*) youLikedView {
    HumanDetailController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"HumanDetailController"];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
