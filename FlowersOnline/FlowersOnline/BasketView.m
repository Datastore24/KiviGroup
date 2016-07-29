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
#import "Animation.h"
#import "SingleTone.h"

@interface BasketView ()

@property (strong, nonatomic) NSMutableArray * mainArray;
@property (strong, nonatomic) NSMutableArray * arrayBasketCount;

@end

@implementation BasketView
{
    UITableView * mainTableView;
    UIScrollView * mainScrollView;
    NSMutableArray * arrayView;
    NSMutableArray * arrayButtonUp;
    NSMutableArray * arrayButtonDown;
    NSMutableArray * arrayLabelOrders;
    NSArray * arrayPriceDelivery;
    //------------------------------
    NSInteger allPrice;
    CustomLabels * allPriceLabelAction;
    
    //-------------------------------
    NSInteger countPrice;
    NSInteger maxCount;
    NSInteger stap;
    
}

- (instancetype)initWithView: (UIView*) view
                     andData: (NSMutableArray*) data;
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        
        self.mainArray = data;
        self.arrayBasketCount = [[SingleTone sharedManager] arrayBasketCount];
        arrayView = [NSMutableArray new];
        arrayButtonUp  = [NSMutableArray new];
        arrayButtonDown = [NSMutableArray new];
        arrayLabelOrders = [NSMutableArray new];
        NSArray * arrayNamesDelivery = [NSArray arrayWithObjects:
                                        @"Курьерская доставка о Москве - ",
                                        @"Курьерская доставка до 10 км от МКАД - ",
                                        @"Самовывоз - ", nil];
        arrayPriceDelivery = [NSArray arrayWithObjects:
                             [NSNumber numberWithInteger:500],
                             [NSNumber numberWithInteger:1000],
                             [NSNumber numberWithInteger:0], nil];
        allPrice = 0;
        countPrice = 0;
        stap = 0;
        maxCount = self.mainArray.count;
        
        for (int i = 0; i < self.mainArray.count; i++) {
            NSNumber * numberCount = [NSNumber numberWithInteger:1];
            [self.arrayBasketCount addObject:numberCount];
        }
        //Создание таблицы заказов----
        mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 200)];
        if (isiPhone5 || isiPhone4s) {
            mainScrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 180);
        }
        mainScrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:mainScrollView];
        
        if (isiPhone5 || isiPhone4s) {
            mainScrollView.contentSize = CGSizeMake(0, 100 * self.mainArray.count);
        } else {
            mainScrollView.contentSize = CGSizeMake(0, 120 * self.mainArray.count);
        }
        for (int i = 0; i < self.mainArray.count; i++) {
            NSDictionary * dictCount = [self.mainArray objectAtIndex:i];
            UIView * mainViewCell = [[UIView alloc] initWithFrame:CGRectMake(0, 0 + 120 * i, self.frame.size.width, 120)];
            if (isiPhone5 || isiPhone4s) {
                mainViewCell.frame = CGRectMake(0, 0 + 100 * i, self.frame.size.width, 100);
            }
            [mainScrollView addSubview:mainViewCell];
            [arrayView addObject:mainViewCell];
            //Основная картинка-----------------------------------
            UIImageView * imageTableCell = [[UIImageView alloc] initWithFrame:CGRectMake(15, 25, 70, 70)];
            if (isiPhone5 || isiPhone4s) {
                imageTableCell.frame = CGRectMake(15, 20, 60, 60);
            }
            NSArray * arrayImages = [dictCount objectForKey:@"img"];
            NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [arrayImages objectAtIndex:0]]];
            UIImage * image = [UIImage imageWithData: imageData];
            imageTableCell.image = image;
            [mainViewCell addSubview:imageTableCell];
            
            //Заголовок ячейки------------------------------------
            CustomLabels * titleCell = [[CustomLabels alloc] initLabelTableWithWidht:95 andHeight:22 andSizeWidht:400 andSizeHeight:18 andColor:COLORTEXTGRAY andText:[dictCount objectForKey:@"name"]];
            titleCell.font = [UIFont fontWithName:FONTBOND size:16];
            titleCell.textAlignment = NSTextAlignmentLeft;
            if (isiPhone5 || isiPhone4s) {
                titleCell.frame = CGRectMake(85, 17, 400, 18);
                titleCell.font = [UIFont fontWithName:FONTBOND size:14];
            }
            [mainViewCell addSubview:titleCell];
            
            //Основной текст---------------------------------------
            CustomLabels * textCell = [[CustomLabels alloc] initLabelTableWithWidht:95 andHeight:40  andSizeWidht:self.frame.size.width - 180 andSizeHeight:40 andColor:COLORTEXTGRAY andText:[dictCount objectForKey:@"body"]];
            textCell.numberOfLines = 2;
            textCell.font = [UIFont fontWithName:FONTREGULAR size:14];
            textCell.textAlignment = NSTextAlignmentLeft;
            if (isiPhone4s || isiPhone5) {
                textCell.frame = CGRectMake(85, 30, self.frame.size.width - 170, 40);
                textCell.font = [UIFont fontWithName:FONTREGULAR size:11];
            }
            [mainViewCell addSubview:textCell];
            
            //Кастомный разделитель ячеек-------------------------
            UIView * viewBorderCell = [[UIView alloc] initWithFrame:CGRectMake(20, 119.5, self.frame.size.width - 40, 0.5)];
            if (isiPhone5 || isiPhone4s) {
                viewBorderCell.frame = CGRectMake(20, 99.5, self.frame.size.width - 40, 0.5);
            }
            viewBorderCell.backgroundColor = [UIColor colorWithHexString:COLORTEXTGRAY];
            [mainViewCell addSubview:viewBorderCell];
            
            //Цена букета-----------------------------------------
            NSArray * arrayVariants = [dictCount objectForKey:@"variants"];
            NSDictionary * dictVariants = [arrayVariants objectAtIndex:0];
            
            NSString * stringPrice = [NSString stringWithFormat:@"%ld р", (long)[[dictVariants objectForKey:@"price"] integerValue]];
            allPrice += [[dictVariants objectForKey:@"price"] integerValue];
            CustomLabels * labelCellPrice = [[CustomLabels alloc] initLabelTableWithWidht:95 andHeight:77 andSizeWidht:400 andSizeHeight:18 andColor:COLORPINCK andText:stringPrice];
            labelCellPrice.font = [UIFont fontWithName:FONTBOND size:16];
            labelCellPrice.textAlignment = NSTextAlignmentLeft;
            if (isiPhone4s || isiPhone5) {
                labelCellPrice.frame = CGRectMake(85, 63, 400, 18);
                labelCellPrice.font = [UIFont fontWithName:FONTBOND size:14];
            }
            [mainViewCell addSubview:labelCellPrice];
            
            //Создаем кнопку увеличения числа товара--------------
            UIButton * buttonUp = [UIButton buttonWithType:UIButtonTypeCustom];
//            buttonUp.tag = 10 + i;
            UIImage * imageButtonUp = [UIImage imageNamed:@"buttomInageUp.png"];
            buttonUp.frame = CGRectMake(self.frame.size.width - 75, (120 / 2 - 10), 20, 20);
            [buttonUp setImage:imageButtonUp forState:UIControlStateNormal];
            [buttonUp addTarget:self action:@selector(upCountAction:) forControlEvents:UIControlEventTouchUpInside];
            if (isiPhone5 || isiPhone4s) {
                buttonUp.frame = CGRectMake(self.frame.size.width - 75, (100 / 2 - 10), 20, 20);
            }
            [mainViewCell addSubview:buttonUp];
            [arrayButtonUp addObject:buttonUp];
            
            //Создаем кнопку уменьшения числа товара-----------------
            UIButton * buttonDown = [UIButton buttonWithType:UIButtonTypeCustom];
//            buttonDown.tag = 20 + i;
            UIImage * imageButtonDown = [UIImage imageNamed:@"ButtonImageDown.png"];
            buttonDown.frame = CGRectMake(self.frame.size.width - 35, (120 / 2 - 10), 20, 20);
            [buttonDown setImage:imageButtonDown forState:UIControlStateNormal];
            [buttonDown addTarget:self action:@selector(downCountAction:) forControlEvents:UIControlEventTouchUpInside];
            if (isiPhone4s || isiPhone5) {
                buttonDown.frame = CGRectMake(self.frame.size.width - 35, (100 / 2 - 10), 20, 20);
            }
            [mainViewCell addSubview:buttonDown];
            [arrayButtonDown addObject:buttonDown];
            
            
            
            //Лейбл числа--------------------------------------------
            NSString * stringCount = [NSString stringWithFormat:@"%ld", (long)[[self.arrayBasketCount objectAtIndex:i] integerValue]];
            CustomLabels * labelCount = [[CustomLabels alloc] initLabelTableWithWidht:self.frame.size.width - 55 andHeight:(120 / 2 - 10) andSizeWidht:20 andSizeHeight:20 andColor:@"a0a0a0" andText:stringCount];
            if (isiPhone5 || isiPhone4s) {
                labelCount.frame = CGRectMake(self.frame.size.width - 55, (100 / 2 - 10), 20, 20);
            }
//            labelCount.tag = 30 + i;
            labelCount.font = [UIFont fontWithName:FONTBOND size:18];
            [mainViewCell addSubview:labelCount];
            [arrayLabelOrders addObject:labelCount];
            
        }
        
        //Доставка----------------------------------------------
        UIView * viewDelivery = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 200, self.frame.size.width, 200)];
        if (isiPhone4s || isiPhone5) {
            viewDelivery.frame = CGRectMake(0, self.frame.size.height - 180, self.frame.size.width, 180);
        }
        viewDelivery.backgroundColor = [UIColor colorWithHexString:COLORLITEGRAY];
        viewDelivery.userInteractionEnabled = YES;
        [self addSubview:viewDelivery];
        
        //Лейболы доставки---------------------------------------
        for (int i = 0; i < 3; i++) {
            CustomLabels * labelDontActive = [[CustomLabels alloc] initLabelTableWithWidht:10 andHeight:20 + 25 * i andSizeWidht:10 andSizeHeight:20 andColor:COLORTEXTGRAY andText:[arrayNamesDelivery objectAtIndex:i]];
            labelDontActive.font = [UIFont fontWithName:FONTREGULAR size:14];
            labelDontActive.textAlignment = NSTextAlignmentLeft;
            [labelDontActive sizeToFit];
            if (isiPhone4s || isiPhone5) {
                labelDontActive.frame = CGRectMake(10, 20 + 20 * i, 10, 20);
                labelDontActive.font = [UIFont fontWithName:FONTREGULAR size:11];
                [labelDontActive sizeToFit];
            }
            [viewDelivery addSubview:labelDontActive];
            
            //Создаем строку цен доставки-----------------------
            NSString * stringPriceDelivery;
            if ([[arrayPriceDelivery objectAtIndex:i] integerValue] == 0) {
                stringPriceDelivery = @"бесплатно";
            } else {
                stringPriceDelivery = [NSString stringWithFormat:@"%ld р.", (long)[[arrayPriceDelivery objectAtIndex:i] integerValue]];
            }
            
            CustomLabels * labelActive = [[CustomLabels alloc] initLabelTableWithWidht:labelDontActive.frame.size.width + 15 andHeight:20 + 25 * i andSizeWidht:10 andSizeHeight:20 andColor:COLORGREEN andText:stringPriceDelivery];
            labelActive.font = [UIFont fontWithName:FONTREGULAR size:14];
            labelActive.textAlignment = NSTextAlignmentLeft;
            [labelActive sizeToFit];
            if (isiPhone5 || isiPhone4s) {
                labelActive.frame = CGRectMake(labelDontActive.frame.size.width + 15, 20 + 20 * i, 10, 20);
                labelActive.font = [UIFont fontWithName:FONTREGULAR size:11];
                [labelActive sizeToFit];
            }
            [viewDelivery addSubview:labelActive];
            
            //Кнопка выбора доставки---------------------------
            UIButton * buttonChangeDelivery = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage * imageButtonDelivery = [UIImage imageNamed:@"imageButtonDelivery.png"];
            buttonChangeDelivery.frame = CGRectMake(self.frame.size.width - 30, ((self.frame.size.height - 200) + 22.5) + 25 * i, 15, 15);
            buttonChangeDelivery.layer.cornerRadius = 7.5f;
            buttonChangeDelivery.tag = 120 + i;
            [buttonChangeDelivery setImage:imageButtonDelivery forState:UIControlStateNormal];
            [buttonChangeDelivery addTarget:self action:@selector(buttonChangeDeliveryAction:) forControlEvents:UIControlEventTouchUpInside];
            if (isiPhone4s || isiPhone5) {
                buttonChangeDelivery.frame = CGRectMake(self.frame.size.width - 30, ((self.frame.size.height - 180) + 20) + 20 * i, 12, 12);
                buttonChangeDelivery.layer.cornerRadius = 6.f;
            }
            [self addSubview:buttonChangeDelivery];
        }
        //Общая цена---------------------------------------
        CustomLabels * allPriceLabelNoAction = [[CustomLabels alloc] initLabelTableWithWidht:self.frame.size.width - 180 andHeight:100 andSizeWidht:20 andSizeHeight:10 andColor:COLORTEXTGRAY andText:@"Итого:"];
        allPriceLabelNoAction.font = [UIFont fontWithName:FONTBOND size:18];
        allPriceLabelNoAction.textAlignment = NSTextAlignmentLeft;
        if (isiPhone5 || isiPhone4s) {
            allPriceLabelNoAction.frame = CGRectMake(self.frame.size.width - 140, 85, 20, 10);
            allPriceLabelNoAction.font = [UIFont fontWithName:FONTBOND size:16];
        }
        [allPriceLabelNoAction sizeToFit];
        [viewDelivery addSubview:allPriceLabelNoAction];
        
        //Общая цена---------------------------------------
        allPriceLabelAction = [[CustomLabels alloc] initLabelTableWithWidht:allPriceLabelNoAction.frame.size.width + allPriceLabelNoAction.frame.origin.x + 5 andHeight:100 andSizeWidht:20 andSizeHeight:10 andColor:COLORPINCK andText:[NSString stringWithFormat:@"%ld р", (long)allPrice]];
        allPriceLabelAction.font = [UIFont fontWithName:FONTBOND size:18];
        allPriceLabelAction.textAlignment = NSTextAlignmentLeft;
        if (isiPhone4s || isiPhone5) {
            allPriceLabelAction.frame = CGRectMake(allPriceLabelNoAction.frame.size.width + allPriceLabelNoAction.frame.origin.x + 5, 85, 20, 10);
            allPriceLabelAction.font = [UIFont fontWithName:FONTBOND size:16];
        }
        [allPriceLabelAction sizeToFit];
        [viewDelivery addSubview:allPriceLabelAction];
        
        //Оформить заказ--------------------------------------
        UIButton * buttonCheckout = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonCheckout.frame = CGRectMake(20, 140, self.frame.size.width - 40, 35);
        buttonCheckout.backgroundColor = [UIColor colorWithHexString:@"85af02"];
        [buttonCheckout setTitle:@"ПЕРЕЙТИ К ОФОРМЛЕНИЮ" forState:UIControlStateNormal];
        [buttonCheckout setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonCheckout.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:18];
        [buttonCheckout addTarget:self action:@selector(buttonCheckoutAction) forControlEvents:UIControlEventTouchUpInside];
        if (isiPhone5 || isiPhone4s) {
            buttonCheckout.frame = CGRectMake(20, 120, self.frame.size.width - 40, 35);
        }
        [viewDelivery addSubview:buttonCheckout];
    }
    return self;
}

#pragma mark - Action Buttons

- (void) upCountAction: (UIButton*) button
{
    for (int i = 0; i < self.mainArray.count; i++) {
        if ([button isEqual:[arrayButtonUp objectAtIndex:i]]) {
            UILabel * label = [arrayLabelOrders objectAtIndex:i];
            NSInteger countOrder = [[self.arrayBasketCount objectAtIndex:i] integerValue];
            countOrder += 1;
            [self.arrayBasketCount setObject:[NSNumber numberWithInteger:countOrder] atIndexedSubscript:i];
            label.text = [NSString stringWithFormat:@"%ld", (long)[[self.arrayBasketCount objectAtIndex:i] integerValue]];
            NSDictionary * dictArray = [self.mainArray objectAtIndex:i];
            NSArray * arrayVariants = [dictArray objectForKey:@"variants"];
            NSDictionary * dictVariants = [arrayVariants objectAtIndex:0];
            NSInteger intPrice = [[dictVariants objectForKey:@"price"] integerValue];
            allPrice += intPrice;
            allPriceLabelAction.text = [NSString stringWithFormat:@"%ld р", (long)allPrice];
            [allPriceLabelAction sizeToFit];
            
        }
    }
}

- (void) downCountAction: (UIButton*) button
{
    for (int i = 0; i < self.mainArray.count; i++) {
        if ([button isEqual:[arrayButtonDown objectAtIndex:i]]) {
            UILabel * label = [arrayLabelOrders objectAtIndex:i];
            NSInteger countOrder = [[self.arrayBasketCount objectAtIndex:i] integerValue];
            countOrder -= 1;
            [self.arrayBasketCount setObject:[NSNumber numberWithInteger:countOrder] atIndexedSubscript:i];
            label.text = [NSString stringWithFormat:@"%ld", (long)[[self.arrayBasketCount objectAtIndex:i] integerValue]];
            NSDictionary * dictArray = [self.mainArray objectAtIndex:i];
            NSArray * arrayVariants = [dictArray objectForKey:@"variants"];
            NSDictionary * dictVariants = [arrayVariants objectAtIndex:0];
            NSInteger intPrice = [[dictVariants objectForKey:@"price"] integerValue];
            allPrice -= intPrice;
            allPriceLabelAction.text = [NSString stringWithFormat:@"%ld р", (long)allPrice];
            [allPriceLabelAction sizeToFit];
                stap = i;
        }
    }
    [self animathionMethod];
}


- (void) animathionMethod {
    UILabel * label = [arrayLabelOrders objectAtIndex:stap];
    if ([label.text isEqualToString:@"0"]) {
        UIView * viewAnim = [arrayView objectAtIndex:stap];
        CGFloat heidth = viewAnim.frame.origin.y;
        [Animation animatioMoveXWithView:viewAnim move_X:self.frame.size.width andBlock:^{
            [self.mainArray removeObjectAtIndex:stap];
            [self.arrayBasketCount removeObjectAtIndex:stap];
            [arrayView removeObjectAtIndex:stap];
            [arrayButtonDown removeObjectAtIndex:stap];
            [arrayButtonUp removeObjectAtIndex:stap];
            [arrayLabelOrders removeObjectAtIndex:stap];
            
            NSInteger countOrder = [[[SingleTone sharedManager] labelCountBasket].text integerValue];
            countOrder -= 1;
            [[SingleTone sharedManager] labelCountBasket].text = [NSString stringWithFormat:@"%ld", (long)countOrder];
            for (int i = 0; i < self.mainArray.count; i++) {
                    UIView * view = [arrayView objectAtIndex:i];
                    if (view.frame.origin.y > heidth) {
                        [Animation animationTestView:view move_Y:view.frame.size.height andBlock:^{}];
                    }
                }
        }];
    }
}

- (void) buttonChangeDeliveryAction: (UIButton*) button
{
    for (int i = 0; i < 3; i++) {
        UIButton * otherButton = (UIButton*)[self viewWithTag:120 + i];
        if (button.tag == 120 + i) {
            
            button.backgroundColor = [UIColor colorWithHexString:COLORGREEN];
            button.userInteractionEnabled = NO;
            NSInteger intPrice = [[arrayPriceDelivery objectAtIndex:i] integerValue];
            countPrice = allPrice + intPrice;
            allPriceLabelAction.text = [NSString stringWithFormat:@"%ld р", (long)countPrice];
            [allPriceLabelAction sizeToFit];
            
        } else {
            otherButton.backgroundColor = [UIColor clearColor];
            otherButton.userInteractionEnabled = YES;
        }
    }
}

- (void) buttonCheckoutAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_BASKET_CONTROLLER_PUSH_CHEKOUT_CONTROLLER object:nil];

}


@end
