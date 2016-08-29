//
//  YouLikedView.m
//  TravelTogether
//
//  Created by Виктор Мишустин on 29/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "YouLikedView.h"
#import "CustomLabels.h"
#import "HexColors.h"
#import "UIButton+ButtonImage.h"
#import "UIView+BorderView.h"
#import "Macros.h"

@interface YouLikedView ()

//Main
@property (strong, nonatomic) NSDictionary * dictData;

//NewLiked
@property (strong, nonatomic) UIView * viewNewLiked;

@end

@implementation YouLikedView

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 64.f, view.frame.size.width, view.frame.size.height - 64.f);
        self.dictData = [data objectAtIndex:0];
        
        self.viewNewLiked = [self createNewLikedView];
        [self addSubview:self.viewNewLiked];
        
        [self addSubview:[self createAllLikedView]];
    }
    return self;
}

#pragma mark - NewLiked

- (UIView*) createNewLikedView {
    UIView * newLikedView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 45.f, self.frame.size.width, 117.5f)];
    
    CustomLabels * labelTitl = [[CustomLabels alloc] initLabelWithWidht:20.f andHeight:5.f andColor:@"525251" andText:@"Новые симпатии" andTextSize:8 andLineSpacing:0.f fontName:VM_FONT_SF_DISPLAY_REGULAR];
    [newLikedView addSubview:labelTitl];
    
    NSArray * arrayNew = [self.dictData objectForKey:@"new"];
    
    for (int i = 0; i < arrayNew.count; i++) {
        NSDictionary * dictNew = [arrayNew objectAtIndex:i];
        
        UIButton * buttonImage = [UIButton createButtonWithImage:[dictNew objectForKey:@"image"] anfFrame:CGRectMake(20.f + 102.5f * i, 24.f, 72.5f, 72.5f)];
        buttonImage.tag = 10 + i;
        [buttonImage addTarget:self action:@selector(buttonImageAction) forControlEvents:UIControlEventTouchUpInside];
        [newLikedView addSubview:buttonImage];
        
        CustomLabels * labelDate = [[CustomLabels alloc] initLabelWithWidht:20.f andHeight:104.f andColor:@"8d8d8b" andText:[dictNew objectForKey:@"date"] andTextSize:8 andLineSpacing:0.f fontName:VM_FONT_SF_DISPLAY_REGULAR];
        CGPoint centr = buttonImage.center;
        centr.y += 44.f;
        labelDate.center = centr;
        [newLikedView addSubview:labelDate];
    }
    
    [UIView borderViewWithHeight:116.5f andWight:17.5f andView:newLikedView andColor:@"c1c1c1"];
    
    return newLikedView;
}

#pragma mark - AllLiked

- (UIView*) createAllLikedView {
    UIView * allLikedView = [[UIView alloc] initWithFrame:CGRectMake(0, self.viewNewLiked.frame.origin.y + self.viewNewLiked.frame.size.height, self.frame.size.width, self.frame.size.height - (self.viewNewLiked.frame.origin.y + self.viewNewLiked.frame.size.height))];
    
    CustomLabels * labelTitl = [[CustomLabels alloc] initLabelWithWidht:20.f andHeight:11.f andColor:@"525251" andText:@"Взаимные симпатии" andTextSize:8 andLineSpacing:0.f fontName:VM_FONT_SF_DISPLAY_REGULAR];
    [allLikedView addSubview:labelTitl];
    
    NSArray * allArray = [self.dictData objectForKey:@"all"];
    //Создаем параметр таблицы
    NSInteger line = 0; //Строка
    NSInteger column = 0; //Столбец
    
    for (int i = 0; i < allArray.count; i++) {
        NSDictionary * dictAll = [allArray objectAtIndex:i];
        
        UIButton * buttonAll = [UIButton createButtonWithImage:[dictAll objectForKey:@"image"] anfFrame:CGRectMake(20.f + 77.f * column, 25.f + 89 * line, 47.5f, 47.5f)];
        buttonAll.tag = 100 + i;
        [buttonAll addTarget:self action:@selector(buttonImageAction) forControlEvents:UIControlEventTouchUpInside];
        [allLikedView addSubview:buttonAll];
        
        
        CustomLabels * labelName = [[CustomLabels alloc] initLabelWithWidht:20.f andHeight:104.f andColor:@"60605e" andText:[dictAll objectForKey:@"name"] andTextSize:8 andLineSpacing:0.f fontName:VM_FONT_SF_DISPLAY_REGULAR];
        CGPoint centr = buttonAll.center;
        centr.y += 31.f;
        labelName.center = centr;
        [allLikedView addSubview:labelName];
        
        
        CustomLabels * labelDate = [[CustomLabels alloc] initLabelWithWidht:20.f andHeight:104.f andColor:@"8d8d8b" andText:[dictAll objectForKey:@"date"] andTextSize:7 andLineSpacing:0.f fontName:VM_FONT_SF_DISPLAY_REGULAR];
        centr.y += 10.f;
        labelDate.center = centr;
        [allLikedView addSubview:labelDate];
        
        
        
        
        column += 1;
        if (column > 3) {
            column = 0;
            line += 1;
        }
    }
    
    
    return allLikedView;
}

#pragma mark - Actions
//действие тача на фото
- (void) buttonImageAction {
    [self.delegate pushToHumanDetail:self];
}


@end
