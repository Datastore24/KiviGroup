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
        self.frame = CGRectMake(0.f, 34.f, view.frame.size.width, view.frame.size.height - 34.f);
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
    if (isiPhone6) {
        newLikedView.frame = CGRectMake(0, 47.5f, self.frame.size.width, 135.f);
    }
    
    CustomLabels * labelTitl = [[CustomLabels alloc] initLabelWithWidht:20.f andHeight:5.f andColor:@"525251" andText:@"Новые симпатии" andTextSize:8 andLineSpacing:0.f fontName:VM_FONT_SF_DISPLAY_REGULAR];
    if (isiPhone6) {
        labelTitl.frame = CGRectMake(25.f, 5.f, 0, 0);
        labelTitl.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:9];
        [labelTitl sizeToFit];
    }
    [newLikedView addSubview:labelTitl];
    
    NSArray * arrayNew = [self.dictData objectForKey:@"new"];
    
    for (int i = 0; i < arrayNew.count; i++) {
        NSDictionary * dictNew = [arrayNew objectAtIndex:i];
        
        UIButton * buttonImage = [UIButton createButtonWithImage:[dictNew objectForKey:@"image"] anfFrame:CGRectMake(20.f + 102.5f * i, 24.f, 72.5f, 72.5f)];
        if (isiPhone6) {
            buttonImage.frame = CGRectMake(25.f + 120.f * i, 25.f, 85.f, 85.f);
        }
        buttonImage.tag = 10 + i;
        [buttonImage addTarget:self action:@selector(buttonImageAction) forControlEvents:UIControlEventTouchUpInside];
        [newLikedView addSubview:buttonImage];
        
        CustomLabels * labelDate = [[CustomLabels alloc] initLabelWithWidht:20.f andHeight:104.f andColor:@"8d8d8b" andText:[dictNew objectForKey:@"date"] andTextSize:8 andLineSpacing:0.f fontName:VM_FONT_SF_DISPLAY_REGULAR];
        CGPoint centr = buttonImage.center;
        if (isiPhone6) {
            centr.y += 52.5f;
            labelDate.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:9];
            [labelDate sizeToFit];
        } else {
            centr.y += 44.f;
        }
        
        labelDate.center = centr;
        [newLikedView addSubview:labelDate];
    }
    
    if (isiPhone6) {
        [UIView borderViewWithHeight:134.5f andWight:21.f andView:newLikedView andColor:@"c1c1c1"];
    } else {
        [UIView borderViewWithHeight:116.5f andWight:17.5f andView:newLikedView andColor:@"c1c1c1"];
    }
    
    
    return newLikedView;
}

#pragma mark - AllLiked

- (UIView*) createAllLikedView {
    UIView * allLikedView = [[UIView alloc] initWithFrame:CGRectMake(0, self.viewNewLiked.frame.origin.y + self.viewNewLiked.frame.size.height, self.frame.size.width, self.frame.size.height - (self.viewNewLiked.frame.origin.y + self.viewNewLiked.frame.size.height))];
    if (isiPhone6) {
        allLikedView.frame = CGRectMake(0, 135.5f + 47.f, self.frame.size.width, self.frame.size.height - (135.5f + 47.f));
    }
    
    CustomLabels * labelTitl = [[CustomLabels alloc] initLabelWithWidht:20.f andHeight:11.f andColor:@"525251" andText:@"Взаимные симпатии" andTextSize:8 andLineSpacing:0.f fontName:VM_FONT_SF_DISPLAY_REGULAR];
    if (isiPhone6) {
        labelTitl.frame = CGRectMake(25.f, 15.f, 0.f, 0.f);
        labelTitl.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:9];
        [labelTitl sizeToFit];
    }
    [allLikedView addSubview:labelTitl];
    
    NSArray * allArray = [self.dictData objectForKey:@"all"];
    //Создаем параметр таблицы
    NSInteger line = 0; //Строка
    NSInteger column = 0; //Столбец
    
    for (int i = 0; i < allArray.count; i++) {
        NSDictionary * dictAll = [allArray objectAtIndex:i];
        
        UIButton * buttonAll = [UIButton createButtonWithImage:[dictAll objectForKey:@"image"] anfFrame:CGRectMake(20.f + 77.f * column, 25.f + 89 * line, 47.5f, 47.5f)];
        if (isiPhone6) {
            buttonAll.frame = CGRectMake(25.f + 90 * column, 30.f + 105.f * line, 55.f, 55.f);
        }
        buttonAll.tag = 100 + i;
        [buttonAll addTarget:self action:@selector(buttonImageAction) forControlEvents:UIControlEventTouchUpInside];
        [allLikedView addSubview:buttonAll];
        
        
        CustomLabels * labelName = [[CustomLabels alloc] initLabelWithWidht:20.f andHeight:104.f andColor:@"60605e" andText:[dictAll objectForKey:@"name"] andTextSize:8 andLineSpacing:0.f fontName:VM_FONT_SF_DISPLAY_REGULAR];
        CGPoint centr = buttonAll.center;
        if (isiPhone6) {
            centr.y += 37.5f;
            labelName.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:9];
            [labelName sizeToFit];
        } else {
           centr.y += 31.f;
        }
        labelName.center = centr;
        [allLikedView addSubview:labelName];
        
        
        CustomLabels * labelDate = [[CustomLabels alloc] initLabelWithWidht:20.f andHeight:104.f andColor:@"8d8d8b" andText:[dictAll objectForKey:@"date"] andTextSize:7 andLineSpacing:0.f fontName:VM_FONT_SF_DISPLAY_REGULAR];
        if (isiPhone6) {
            centr.y += 10.f;
            labelDate.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:8];
            [labelDate sizeToFit];
        } else {
            centr.y += 10.f;
        }
        labelDate.center = centr;
        [allLikedView addSubview:labelDate];
        
        
        
        
        column += 1;
        if (column > 3) {
            column = 0;
            line += 1;
        }
    }
    
    if (isiPhone6) {
        [UIView borderViewWithHeight:225.f - 1.f andWight:21.f andView:allLikedView andColor:@"c1c1c1"];
    } else {
        [UIView borderViewWithHeight:192.5f - 1 andWight:17.5f andView:allLikedView andColor:@"c1c1c1"];
    }
    
    return allLikedView;
}

#pragma mark - Actions
//действие тача на фото
- (void) buttonImageAction {
    [self.delegate pushToHumanDetail:self];
}


@end
