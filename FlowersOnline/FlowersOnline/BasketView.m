//
//  BasketView.m
//  FlowersOnline
//
//  Created by Viktor on 13.06.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "BasketView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "CustomLabels.h"

@implementation BasketView
{
    UITableView * mainTableView;
    NSMutableArray * mainArray;
    UIScrollView * mainScrollView;
    
    NSMutableArray * arrayAllData;
}

- (instancetype)initWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        
        mainArray = [self setArrayTest];
        arrayAllData = [NSMutableArray new];

        //Создание таблицы заказов----
        mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 230)];
        mainScrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:mainScrollView];
        mainScrollView.contentSize = CGSizeMake(0, 120 * mainArray.count);
        
        for (int i = 0; i < mainArray.count; i++) {
            
            NSDictionary * dictCount = [mainArray objectAtIndex:i];
            
            //Основная картинка-----------------------------------
            UIImageView * imageTableCell = [[UIImageView alloc] initWithFrame:CGRectMake(15, 25 + 120 * i, 70, 70)];
            imageTableCell.image = [UIImage imageNamed:[dictCount objectForKey:@"image"]];
            [mainScrollView addSubview:imageTableCell];
            
            //Заголовок ячейки------------------------------------
            CustomLabels * titleCell = [[CustomLabels alloc] initLabelTableWithWidht:95 andHeight:22 + 120 * i andSizeWidht:400 andSizeHeight:18 andColor:COLORTEXTGRAY andText:[dictCount objectForKey:@"name"]];
            titleCell.font = [UIFont fontWithName:FONTBOND size:16];
            titleCell.textAlignment = NSTextAlignmentLeft;
            [mainScrollView addSubview:titleCell];
            
            //Основной текст---------------------------------------
            CustomLabels * textCell = [[CustomLabels alloc] initLabelTableWithWidht:95 andHeight:40 + 120 * i  andSizeWidht:self.frame.size.width - 180 andSizeHeight:40 andColor:COLORTEXTGRAY andText:[dictCount objectForKey:@"text"]];
            textCell.numberOfLines = 2;
            textCell.font = [UIFont fontWithName:FONTREGULAR size:14];
            textCell.textAlignment = NSTextAlignmentLeft;
            [mainScrollView addSubview:textCell];
            
            //Кастомный разделитель ячеек-------------------------
            UIView * viewBorderCell = [[UIView alloc] initWithFrame:CGRectMake(20, 119.5 + 120 * i, self.frame.size.width - 40, 0.5)];
            viewBorderCell.backgroundColor = [UIColor colorWithHexString:COLORTEXTGRAY];
            [mainScrollView addSubview:viewBorderCell];
            
            //Цена букета-----------------------------------------
            NSString * stringPrice = [NSString stringWithFormat:@"%ld р", (long)[[dictCount objectForKey:@"price"] integerValue]];
            CustomLabels * labelCellPrice = [[CustomLabels alloc] initLabelTableWithWidht:95 andHeight:77 + 120 * i andSizeWidht:400 andSizeHeight:18 andColor:COLORPINCK andText:stringPrice];
            labelCellPrice.font = [UIFont fontWithName:FONTBOND size:16];
            labelCellPrice.textAlignment = NSTextAlignmentLeft;
            [mainScrollView addSubview:labelCellPrice];
            
            //Создаем кнопку увеличения числа товара--------------
            UIButton * buttonUp = [UIButton buttonWithType:UIButtonTypeCustom];
            buttonUp.tag = 10 + i;
            UIImage * imageButtonUp = [UIImage imageNamed:@"buttomInageUp.png"];
            buttonUp.frame = CGRectMake(self.frame.size.width - 75, (120 / 2 - 10) + 120 * i, 20, 20);
            [buttonUp setImage:imageButtonUp forState:UIControlStateNormal];
            [buttonUp addTarget:self action:@selector(upCountAction:) forControlEvents:UIControlEventTouchUpInside];
            [mainScrollView addSubview:buttonUp];
            
            //Создаем кнопку уменьшения числа товара-----------------
            UIButton * buttonDown = [UIButton buttonWithType:UIButtonTypeCustom];
            buttonDown.tag = 20 + i;
            UIImage * imageButtonDown = [UIImage imageNamed:@"ButtonImageDown.png"];
            buttonDown.frame = CGRectMake(self.frame.size.width - 35, (120 / 2 - 10) + 120 * i, 20, 20);
            [buttonDown setImage:imageButtonDown forState:UIControlStateNormal];
            [buttonDown addTarget:self action:@selector(downCountAction:) forControlEvents:UIControlEventTouchUpInside];
            [mainScrollView addSubview:buttonDown];
            
            //Лейбл числа--------------------------------------------
            CustomLabels * labelCount = [[CustomLabels alloc] initLabelTableWithWidht:self.frame.size.width - 55 andHeight:(120 / 2 - 10) + 120 * i andSizeWidht:20 andSizeHeight:20 andColor:@"a0a0a0" andText:[NSString stringWithFormat:@"%d", 1]];
            labelCount.tag = 30 + i;
            labelCount.font = [UIFont fontWithName:FONTBOND size:18];
            [mainScrollView addSubview:labelCount];
            

            
            
        }
        

    }
    return self;
}

#pragma mark - Action Buttons

- (void) upCountAction: (UIButton*) button
{
    for (int i = 0; i < mainArray.count; i++) {
        if (button.tag == 10 + i) {
            UILabel * label = (UILabel*)[self viewWithTag:30 + i];
            NSInteger intCount = [label.text integerValue];
            intCount += 1;
            label.text = [NSString stringWithFormat:@"%ld", (long)intCount];
        }
    }
}

- (void) downCountAction: (UIButton*) button
{
    for (int i = 0; i < mainArray.count; i++) {
//        NSDictionary * dictData = [arrayAllData objectAtIndex:i];
        if (button.tag == 20 + i) {
            UILabel * label = (UILabel*)[self viewWithTag:30 + i];
            NSInteger intCount = [label.text integerValue];
            intCount -= 1;
            label.text = [NSString stringWithFormat:@"%ld", (long)intCount];
        }
    }
}


#pragma mark - Other Code
//создадим тестовый массив-----------
- (NSMutableArray *) setArrayTest
{
    NSMutableArray * arrayOrder = [[NSMutableArray alloc] init];
    
    NSArray * arrayImage = [NSArray arrayWithObjects:
                           @"bouquets1.png", @"bouquets2.png", @"bouquets3.png",
                           @"bouquets4.png", @"bouquets5.png", nil];
    
    NSArray * arrayText = [NSArray arrayWithObjects:
                           @"Красивый букет из 5 алых роз перевязанный ленточкой",
                           @"Насыщенный цветом букет, способен удивить любого!",
                           @"Насыщенный цветом букет, способен покорить любого!",
                           @"Красивый букет из 4 белых грузинов перевязанный ленточкой",
                           @"Насыщенный цветом букет, способен влюбить любого!", nil];
    
    
    NSArray * arrayName = [NSArray arrayWithObjects:
                           @"Букет “Сатурн”", @"Букет “7 роз”", @"Букет “Палитра”",
                           @"Букет “9 роз”", @"Букет “3 розы”", nil];
    
    NSArray * arrayPrice = [NSArray arrayWithObjects:
                            [NSNumber numberWithInteger:3000],
                            [NSNumber numberWithInteger:4500],
                            [NSNumber numberWithInteger:1300],
                            [NSNumber numberWithInteger:2500],
                            [NSNumber numberWithInteger:1700], nil];
    
    
    for (int i = 0; i < arrayImage.count; i++) {
        
        NSDictionary * dictOrder = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [arrayImage objectAtIndex:i], @"image",
                                    [arrayText objectAtIndex:i], @"text",
                                    [arrayName objectAtIndex:i], @"name",
                                    [arrayPrice objectAtIndex:i], @"price", nil];
        
        [arrayOrder addObject:dictOrder];
    }
    
    return arrayOrder;
}



@end
