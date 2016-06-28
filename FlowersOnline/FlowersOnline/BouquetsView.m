//
//  BouquetsView.m
//  FlowersOnline
//
//  Created by Виктор Мишустин on 05.06.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "BouquetsView.h"
#import "UIColor+HexColor.h"
#import "CustomButton.h"
#import "CustomLabels.h"
#import "Macros.h"
#import "SingleTone.h"

@implementation BouquetsView

{
    UIScrollView * mainScrollView;
    NSArray * arrayName;
    NSMutableArray * arrayScroll;
    NSMutableArray * arrayControl;
    NSMutableArray * buttonsArray;
    
    UITableView * tablePrice;
    
    //Временные массивы--------
    NSArray * arrayTableCellName;
    NSArray * arrayData;
    NSArray * arrayTablePrice;
}

- (instancetype)initWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        
        //Тестовые массивы для работы--------------------------------
        
        arrayTableCellName = [NSArray arrayWithObjects:@"Размер Премиум", @"Размер Делюкс", @"Размер Стандарт", nil];
        arrayData = [NSArray arrayWithObjects:
                               @"Соберем и доставим до 15:00",
                               @"Соберем и доставим до 15:00",
                               @"Соберем и доставим до 15:00", nil];
        arrayTablePrice = [NSArray arrayWithObjects:@"9990 p.", @"6990 p.", @"2500 p.", nil];
        
        
        
        
        
        
        
        arrayName = [NSArray arrayWithObjects:@"Букет Сатурн", @"Букет 5 роз", @"Букет Палитра", @"Букет Свадебный", @"Хороший Букет", nil];
        NSArray * array1 = [NSArray arrayWithObjects:@"1.jpg", @"2.jpg", @"3.jpg", nil];
        NSArray * array2 = [NSArray arrayWithObjects:@"4.jpg", @"5.jpg", @"6.jpg", nil];
        NSArray * array3 = [NSArray arrayWithObjects:@"7.jpg", @"8.jpg", @"9.jpg", nil];
        NSArray * array4 = [NSArray arrayWithObjects:@"10.jpg", @"11.jpg", @"12.jpg", nil];
        NSArray * array5= [NSArray arrayWithObjects:@"13.jpg", @"14.jpg", @"15.jpg", nil];
        
        NSArray * arrayText = [NSArray arrayWithObjects:
                               @"Потрясающий космический букет",
                               @"Поднимающий настроение букет из роз",
                               @"Все краски радуги смешались в одном букете",
                               @"Наилучший будет для свадебного торжества",
                               @"Просто хороший букет, красивый и не дорогой", nil];
        
        NSArray * arrayPrice = [NSArray arrayWithObjects:@"от 2000 р.", @"от 3500 р.", @"от 1500 р.", @"от 2200 р.", @"от 1000 р.", nil];
        
        NSArray * allImage = [NSArray arrayWithObjects:array1, array2, array3, array4, array5, nil];
        
        arrayScroll = [NSMutableArray new];
        arrayControl = [NSMutableArray new];
        buttonsArray = [NSMutableArray new];
        
        //Наносим основной скрол вью
        mainScrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        mainScrollView.contentSize = CGSizeMake(0, self.frame.size.width * arrayName.count);
        mainScrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:mainScrollView];
        
        //Создаем циклБукетов
        for (int i = 0; i < arrayName.count; i++) {
            //Инициализация scrollView-----------------------------------------
            UIScrollView * scrollImages = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.frame.size.width * i, self.frame.size.width, self.frame.size.width)];
            [scrollImages setDelegate:self];
            [scrollImages setPagingEnabled:YES];
            [scrollImages setContentSize:CGSizeMake(self.frame.size.width*3, self.frame.size.width)]; // задаем количество слайдов
            scrollImages.showsHorizontalScrollIndicator = NO;
            [scrollImages setBackgroundColor:[UIColor whiteColor]]; // цвет фона скролвью
            [arrayScroll addObject:scrollImages];
            [mainScrollView addSubview:scrollImages];
            
            //Инициализация pageControl-------------------------------------------
            UIPageControl * pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 30, scrollImages.frame.size.height-20 + self.frame.size.width * i, 60, 10)];
            [pageControl setCurrentPageIndicatorTintColor:[UIColor colorWithHexString:@"303f9f"]]; //цвет "точек" при пролистывании экрана приветствия
            pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
            [pageControl setNumberOfPages:3]; // задаем количетсво слайдов приветствия
            [arrayControl addObject:pageControl];
            [mainScrollView addSubview:pageControl];
            
            //Тестовый массив картинок--------------------------------------------
            NSArray * arrayOmageCount = [allImage objectAtIndex:i];
            
            UIImageView * view1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width)];
            view1.image = [UIImage imageNamed:[arrayOmageCount objectAtIndex:0]];
            [scrollImages addSubview:view1];
            
            UIImageView * view2 = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.width)];
             view2.image = [UIImage imageNamed:[arrayOmageCount objectAtIndex:1]];
            [scrollImages addSubview:view2];
            
            UIImageView * view3 = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width * 2, 0, self.frame.size.width, self.frame.size.width)];
             view3.image = [UIImage imageNamed:[arrayOmageCount objectAtIndex:2]];;
            [scrollImages addSubview:view3];
            
            //Загаловок букета----------------------------------------------------
            CustomLabels * labelTitle = [[CustomLabels alloc] initLabelTableWithWidht:20 andHeight:20 + self.frame.size.width * i andSizeWidht:200 andSizeHeight:20 andColor:@"ffffff" andText:[arrayName objectAtIndex:i]];
            labelTitle.font = [UIFont fontWithName:FONTLITE size:16];
            if (isiPhone5 || isiPhone4s) {
                labelTitle.font = [UIFont fontWithName:FONTLITE size:14];
            }
            labelTitle.textAlignment = NSTextAlignmentLeft;
            [mainScrollView addSubview:labelTitle];
            
            //Средняя цена букета--------------------------------------------------
            CustomLabels * labelPrice = [[CustomLabels alloc] initLabelTableWithWidht:self.frame.size.width - 100 andHeight:20 + self.frame.size.width * i andSizeWidht:80 andSizeHeight:20 andColor:@"ffffff" andText:[arrayPrice objectAtIndex:i]];
            labelPrice.font = [UIFont fontWithName:FONTLITE size:16];
            if (isiPhone5 || isiPhone4s) {
                labelPrice.font = [UIFont fontWithName:FONTLITE size:14];
            }
            labelPrice.textAlignment = NSTextAlignmentRight;
            [mainScrollView addSubview:labelPrice];
            
            //Кнопка подарить------------------------------------------------------
            UIButton * buttonToGive = [UIButton buttonWithType:UIButtonTypeSystem];
            buttonToGive.frame = CGRectMake (-5, (self.frame.size.width / 2 - 15) + (self.frame.size.width * i), 100, 30);
            buttonToGive.layer.cornerRadius = 3.f;
            buttonToGive.tag = 20 + i;
            buttonToGive.backgroundColor = [UIColor colorWithHexString:@"f45bd7"];
            [buttonToGive setTitle:@"Подарить" forState:UIControlStateNormal];
            [buttonToGive setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            buttonToGive.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:14];
            if (isiPhone5 || isiPhone4s) {
                buttonToGive.frame = CGRectMake (-5, (self.frame.size.width / 2 - 13) + (self.frame.size.width * i), 90, 26);
                buttonToGive.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:12];
            }
            [buttonToGive addTarget:self action:@selector(buttonToGiveAction:) forControlEvents:UIControlEventTouchUpInside];
            [mainScrollView addSubview:buttonToGive];
            
            
            //Описание букета-------------------------------------------------------
            CustomLabels * labelText = [[CustomLabels alloc] initLabelTableWithWidht:20 andHeight:40 + self.frame.size.width * i andSizeWidht:200 andSizeHeight:20 andColor:@"ffffff" andText:[arrayText objectAtIndex:i]];
            labelText.numberOfLines = 2;
            labelText.font = [UIFont fontWithName:FONTLITE size:12];
            if (isiPhone5 || isiPhone4s) {
                labelText.font = [UIFont fontWithName:FONTLITE size:10];
            }
            labelText.textAlignment = NSTextAlignmentLeft;
            [labelText sizeToFit];
            [mainScrollView addSubview:labelText];
            
            //Создаем кнопку увеличения scrollView
            CustomButton * buttonScroll = [CustomButton buttonWithType:UIButtonTypeSystem];
            buttonScroll.frame = CGRectMake(0, 0, self.frame.size.width * 3, self.frame.size.width);
            buttonScroll.isBool = YES;
            [buttonScroll addTarget:self action:@selector(buttonScrollAction:) forControlEvents:UIControlEventTouchUpInside];
            [buttonsArray addObject:buttonScroll];
            [scrollImages addSubview:buttonScroll];
        }
        
        //Крытая таблица цен----------------------------------------------------
        //Создание таблицы заказов----
        tablePrice = [[UITableView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height - self.frame.size.width - 64)];
        //Убираем полосы разделяющие ячейки------------------------------
        tablePrice.separatorStyle = UITableViewCellSeparatorStyleNone;
        tablePrice.dataSource = self;
        tablePrice.delegate = self;
        tablePrice.showsVerticalScrollIndicator = NO;
        tablePrice.backgroundColor = [UIColor colorWithHexString:COLORGRAY];
        //Очень полездное свойство, отключает дествие ячейки-------------
//        tablePrice.allowsSelection = NO;
        [self addSubview:tablePrice];
        
        
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
        for (int i = 0; i < arrayName.count; i++) {
            if ([scrollView isEqual:[arrayScroll objectAtIndex:i]]) {
                CGFloat pageWidth = CGRectGetWidth(self.bounds);
                UIScrollView * scrol = [arrayScroll objectAtIndex:i];
                UIPageControl * control = [arrayControl objectAtIndex:i];
                CGFloat pageFraction = scrol.contentOffset.x / pageWidth;
                control.currentPage = roundf(pageFraction);
            }
        }
}

#pragma mark - Buttons Action
//Действие тача на букет--------------------------
- (void) buttonScrollAction: (CustomButton*) button
{
    for (int i = 0; i < arrayName.count; i++) {
        if ([button isEqual:[buttonsArray objectAtIndex:i]]) {
            if (button.isBool) {
                mainScrollView.scrollEnabled = NO;
                [UIView animateWithDuration:0.3 animations:^{
                    //Метод оцентровки------------------------------------
                    mainScrollView.contentOffset = CGPointMake(0, ((self.frame.size.width) * i) - 64);
                    
                    CGRect tableRect = tablePrice.frame;
                    tableRect.origin.y -= (self.frame.size.height - self.frame.size.width) - 64;
                    tablePrice.frame = tableRect;
                    
                    [UIView animateWithDuration:0.3 animations:^{
                        UIButton * buttonGive = (UIButton*)[self viewWithTag:20 + i];
                        CGRect rectButton = buttonGive.frame;
                        rectButton.origin.x -= 100;
                        buttonGive.frame = rectButton;
                    }];
                } completion:^(BOOL finished) {
                }];
                button.isBool = NO;
            } else {
                mainScrollView.scrollEnabled = YES;
                [UIView animateWithDuration:0.3 animations:^{
                    //Метод оцентровки------------------------------------
                    if (i == arrayName.count - 1) {
                        mainScrollView.contentOffset = CGPointMake(0, mainScrollView.contentOffset.y - tablePrice.frame.size.height);
                    }
                    CGRect tableRect = tablePrice.frame;
                    tableRect.origin.y += (self.frame.size.height - self.frame.size.width) - 64;
                    tablePrice.frame = tableRect;
                    
                    [UIView animateWithDuration:0.3 animations:^{
                        UIButton * buttonGive = (UIButton*)[self viewWithTag:20 + i];
                        CGRect rectButton = buttonGive.frame;
                        rectButton.origin.x += 100;
                        buttonGive.frame = rectButton;
                    }];
                    
                } completion:^(BOOL finished) {
                }];
                button.isBool = YES;
            }
        }
    }
}
//Действие кнопки подарить----------------------
- (void) buttonToGiveAction: (UIButton*) button
{
    for (int i = 0; i < arrayName.count; i++) {
        if (button.tag == 20 + i) {
            
            mainScrollView.scrollEnabled = NO;
            CustomButton * buttonTup = (CustomButton*)[buttonsArray objectAtIndex:i];
            buttonTup.isBool = NO;
            [UIView animateWithDuration:0.3 animations:^{
                //Метод оцентровки------------------------------------
                mainScrollView.contentOffset = CGPointMake(0, ((self.frame.size.width) * i) - 64);
                CGRect tableRect = tablePrice.frame;
                tableRect.origin.y -= (self.frame.size.height - self.frame.size.width) - 64;
                tablePrice.frame = tableRect;
                [UIView animateWithDuration:0.3 animations:^{
                    UIButton * buttonGive = (UIButton*)[self viewWithTag:20 + i];
                    CGRect rectButton = buttonGive.frame;
                    rectButton.origin.x -= 100;
                    buttonGive.frame = rectButton;
                }];
            }];
        }
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"newFriendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    for (UIView * view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    [cell.contentView addSubview:[self setTableCellWithName:[arrayTableCellName objectAtIndex:indexPath.row]
                                                    andData:[arrayData objectAtIndex:indexPath.row]
                                                   andPrice:[arrayTablePrice objectAtIndex:indexPath.row]]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tablePrice.frame.size.height / 3;
}

//Анимация нажатия ячейки--------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger countOrder = [[[SingleTone sharedManager] labelCountBasket].text integerValue];
    countOrder += 1;
    [[SingleTone sharedManager] labelCountBasket].text = [NSString stringWithFormat:@"%ld", (long)countOrder];
    [UIView animateWithDuration:0.15 animations:^{
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            
        }];
    }];
}

#pragma mark - CustomCell

//Кастомная ячейка---------------------------------------
- (UIView*) setTableCellWithName: (NSString *) name
                         andData: (NSString*) data
                        andPrice: (NSString*) price
{
    //Основное окно ячейки--------------------------------
    UIView * cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, tablePrice.frame.size.height / 3)];
    cellView.backgroundColor = [UIColor colorWithHexString:COLORGRAY];
    
    //Загаловок ячейки-----------------------------------
    CustomLabels * labelTitleCell = [[CustomLabels alloc] initLabelTableWithWidht:20 andHeight:15 andSizeWidht:200
                                                                    andSizeHeight:26 andColor:@"000000" andText:name];
    labelTitleCell.font = [UIFont fontWithName:FONTREGULAR size:20];
    if (isiPhone5) {
        labelTitleCell.frame = CGRectMake(20, 10, 200, 26);
        labelTitleCell.font = [UIFont fontWithName:FONTREGULAR size:18];
    } else if (isiPhone4s) {
        labelTitleCell.frame = CGRectMake(20, 0, 200, 20);
        labelTitleCell.font = [UIFont fontWithName:FONTREGULAR size:14];
    }
    labelTitleCell.textAlignment = NSTextAlignmentLeft;
    [cellView addSubview:labelTitleCell];
    
    //Данные по доставке-------------------------------
    CustomLabels * labelDeliveryCell = [[CustomLabels alloc] initLabelTableWithWidht:20 andHeight:45 andSizeWidht:200 andSizeHeight:20 andColor:@"858383" andText:data];
    labelDeliveryCell.font = [UIFont fontWithName:FONTREGULAR size:12];
    if (isiPhone5) {
        labelDeliveryCell.frame = CGRectMake(20, 35, 200, 20);
        labelDeliveryCell.font = [UIFont fontWithName:FONTREGULAR size:10];
    } else if (isiPhone4s) {
        labelDeliveryCell.frame = CGRectMake(20, 15, 200, 20);
        labelDeliveryCell.font = [UIFont fontWithName:FONTREGULAR size:9];
    }
    labelDeliveryCell.textAlignment = NSTextAlignmentLeft;
    [cellView addSubview:labelDeliveryCell];
    
    //Данные о цене-----------------------------------
    CustomLabels * labelCellPrice = [[CustomLabels alloc] initLabelTableWithWidht:self.frame.size.width - 140 andHeight:0 andSizeWidht:80 andSizeHeight:tablePrice.frame.size.height / 3 andColor:@"000000" andText:price];
    labelCellPrice.font = [UIFont fontWithName:FONTREGULAR size:20];
    if (isiPhone5) {
        labelCellPrice.font = [UIFont fontWithName:FONTREGULAR size:18];
    } else if (isiPhone4s) {
        labelCellPrice.font = [UIFont fontWithName:FONTREGULAR size:16];
    }
    labelCellPrice.textAlignment = NSTextAlignmentRight;
    [cellView addSubview: labelCellPrice];
    
    //Изображение корзинки-------------------------------
    UIImageView * imageBasket = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 50, (tablePrice.frame.size.height / 3) / 2 - 13 , 26, 26)];
    if (isiPhone5) {
        imageBasket.frame = CGRectMake(self.frame.size.width - 50, (tablePrice.frame.size.height / 3) / 2 - 10 , 20, 20);
    } else if (isiPhone4s) {
        imageBasket.frame = CGRectMake(self.frame.size.width - 50, (tablePrice.frame.size.height / 3) / 2 - 8 , 16, 16);
    }
    imageBasket.image = [UIImage imageNamed:@"iconBasketBlack.png"];
    [cellView addSubview:imageBasket];
    
    //Вью границы-----------------------------------------
    UIView * borderView = [[UIView alloc] initWithFrame:CGRectMake(0, (tablePrice.frame.size.height / 3) - 0.5, self.frame.size.width, 0.5f)];
    borderView.backgroundColor = [UIColor whiteColor];
    [cellView addSubview:borderView];
    
    return cellView;
    
}



@end
