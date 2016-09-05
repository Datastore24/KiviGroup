//
//  BasketView.m
//  Sadovod
//
//  Created by Виктор Мишустин on 30/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "BasketView.h"
#import "CustomButton.h"
#import "UIButton+ButtonImage.h"
#import "CustomLabels.h"
#import "UIView+BorderView.h"
#import "HexColors.h"
#import "Macros.h"

@interface BasketView () <UIPickerViewDelegate, UIPickerViewDataSource>

//Main

@property (strong, nonatomic) UIScrollView * mainScrollView;
@property (strong, nonatomic) NSArray * arrayData;
@property (strong, nonatomic) UIView * viewFone; //Фоновое вью для блокировки действий
@property (assign, nonatomic) NSInteger tagButton; //Параметр сохраняет тег нажатой кнопки при выборе колличества товара

//Counter

@property (strong, nonatomic) UIView * viewCounter;
@property (strong, nonatomic) NSArray * arrayForPickerView;
@property (strong, nonatomic) UIPickerView * counterPicker;
@property (assign, nonatomic) NSInteger countOrder; //Переменная для подсчета колличества товаров
@property (assign, nonatomic) NSInteger pickerCount; //значение выдаваемое при скроле пикера

//AnimathionDel (все свойства вязанные с анимацией)
@property (strong, nonatomic) NSMutableArray * arrayView; //Массив отображения всю каждого заказа (для анимации)


@end

@implementation BasketView

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 0.f, view.frame.size.width, view.frame.size.height);
        self.arrayData = data;
        self.tagButton = 0;
        
        self.arrayView = [[NSMutableArray alloc] init];
        
        self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.mainScrollView.contentSize = CGSizeMake(0, 180 * self.arrayData.count + 40);
        [self addSubview:self.mainScrollView];
        
        for (int i = 0; i < self.arrayData.count; i++) {
            
            NSDictionary * dictData = [self.arrayData objectAtIndex:i];
            
            UIView * viewOrder = [[UIView alloc] initWithFrame:CGRectMake(0, 0 + 180 * i, self.frame.size.width, 180)];
            [self.mainScrollView addSubview:viewOrder];
            [self.arrayView addObject:viewOrder]; //Добавляем каждый обект корзины;
            
            [UIView borderViewWithHeight:179 andWight:0 andView:viewOrder andColor:@"B8B8B8"];
            
            UIImageView * imageOrder = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 160, 160)];
            imageOrder.image = [UIImage imageNamed:[dictData objectForKey:@"image"]];
            imageOrder.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
            imageOrder.layer.borderWidth = 0.3f;
            imageOrder.layer.cornerRadius = 2.f;
            imageOrder.layer.shadowColor = [[UIColor blackColor] CGColor];
            imageOrder.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
            imageOrder.layer.shadowRadius = 1.0f;
            imageOrder.layer.shadowOpacity = 0.5f;
            [viewOrder addSubview:imageOrder];
            
            
            
            CustomLabels * labelName = [[CustomLabels alloc] initLabelWithWidht:220 andHeight:15 andColor:@"000000"
                                                                        andText:[dictData objectForKey:@"name"] andTextSize:16 andLineSpacing:0.f fontName:VM_FONT_BOLD];
            [viewOrder addSubview:labelName];
            
            CustomLabels * labelPrice = [[CustomLabels alloc] initLabelWithWidht:220 andHeight:35 andColor: VM_COLOR_800
                                                                        andText:[NSString stringWithFormat:@"%@ руб", [dictData objectForKey:@"price"]] andTextSize:16 andLineSpacing:0.f fontName:VM_FONT_BOLD];
            [viewOrder addSubview:labelPrice];
            
            CustomLabels * labelSize = [[CustomLabels alloc] initLabelWithWidht:220 andHeight:60 andColor: @"808080"
                                                                         andText:[NSString stringWithFormat:@"размер %@", [dictData objectForKey:@"size"]] andTextSize:16 andLineSpacing:0.f fontName:VM_FONT_REGULAR];
            [viewOrder addSubview:labelSize];
            
            CustomLabels * labelCount = [[CustomLabels alloc] initLabelWithWidht:220 andHeight:100 andColor: @"666666"
                                                                        andText:@"Кол-во:" andTextSize:13 andLineSpacing:0.f fontName:VM_FONT_BOLD];
            [viewOrder addSubview:labelCount];
            
            UIButton * buttonCount = [UIButton buttonWithType:UIButtonTypeSystem];
            buttonCount.frame = CGRectMake(220.f, 120.f, 40, 40);
            [buttonCount setTitle:[dictData objectForKey:@"count"] forState:UIControlStateNormal];
            [buttonCount setTitleColor:[UIColor hx_colorWithHexRGBAString:@"666666"] forState:UIControlStateNormal];
            buttonCount.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
            buttonCount.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
            buttonCount.backgroundColor = [UIColor groupTableViewBackgroundColor];
            buttonCount.layer.borderWidth = 0.5f;
            buttonCount.layer.cornerRadius = 0.f;
            buttonCount.tag = 10 + i;
            [buttonCount addTarget:self action:@selector(buttonCountAction:) forControlEvents:UIControlEventTouchUpInside];
            [viewOrder addSubview:buttonCount];
            
            UIButton * buttonBasket = [UIButton createButtonCustomImageWithImage:@"trash.png" andRect:CGRectMake(270, 120, 40, 40)];
            [buttonBasket setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
            buttonBasket.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
            buttonBasket.backgroundColor = [UIColor groupTableViewBackgroundColor];
            buttonBasket.tag = 500 + i;
            [buttonBasket addTarget:self action:@selector(buttonBasketAction:) forControlEvents:UIControlEventTouchUpInside];
            buttonBasket.layer.borderWidth = 0.5f;
            buttonBasket.layer.cornerRadius = 2.f;
            [viewOrder addSubview:buttonBasket];
            
            self.viewFone = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            self.viewFone.backgroundColor = [UIColor blackColor];
            self.viewFone.alpha = 0.f;
            [self addSubview:self.viewFone];
            
            //CounterView
            self.viewCounter = [self createCounterView];
            self.viewCounter.alpha = 0.f;
            [self addSubview:self.viewCounter];
        }
    }
    return self;
}


#pragma mark - CounterView

- (UIView*) createCounterView {
    UIView * counterView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 130.f, self.frame.size.height / 2 - 130.f, 260.f, 300.f)];
    counterView.backgroundColor = [UIColor whiteColor];
    counterView.layer.cornerRadius = 5.f;
    
    CustomLabels * labelTitl = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:20.f andSizeWidht:240.f andSizeHeight:80.f andColor:@"808080" andText:@"Установите нужное количество товаров"];
    labelTitl.numberOfLines = 0.f;
    labelTitl.textAlignment = NSTextAlignmentLeft;
    labelTitl.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
    [labelTitl sizeToFit];
    [counterView addSubview:labelTitl];
    
    self.arrayForPickerView = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", nil];
    
    self.counterPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0.f, 30.f, 260.f, 200.f)];
    self.counterPicker.delegate = self;
    self.counterPicker.dataSource = self;
    self.counterPicker.showsSelectionIndicator = NO;
    [self.counterPicker reloadAllComponents];
    
    [counterView addSubview: self.counterPicker];
    
    //Create Two borderView for picker
    
    for (int i = 0; i < 2; i++) {
        UIView * borderView = [[UIView alloc] initWithFrame:CGRectMake(130.f - 40.f, 100.f + 54 * i, 80.f, 3.f)];
        borderView.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_400];
        [counterView addSubview:borderView];
    }
    
    //Create buttons for confirm and exit
    
    NSArray * arrayNameButtons = [NSArray arrayWithObjects:@"Отмена", @"Изменить", nil];
    
    for (int i = 0; i < 2; i++) {
        UIButton * buttonPicker = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonPicker.frame = CGRectMake(20 + 120 * i, 240.f, 100.f, 40.f);
        [buttonPicker setTitle:[arrayNameButtons objectAtIndex:i] forState:UIControlStateNormal];
        if (i == 0) {
            [buttonPicker setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        } else {
            buttonPicker.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_300];
            buttonPicker.layer.borderColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_800].CGColor;
            buttonPicker.layer.borderWidth = 1.f;
            [buttonPicker setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            buttonPicker.layer.cornerRadius = 3.f;
        }
        
        buttonPicker.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
        buttonPicker.tag = 1000 + i;
        [buttonPicker addTarget:self action:@selector(buttonPickerAction:) forControlEvents:UIControlEventTouchUpInside];
        [counterView addSubview:buttonPicker];
    }
    
   
    return counterView;
}

#pragma mark - Action

//Выбор колличества товара в корзине
- (void) buttonCountAction: (UIButton*) button {
    for (int i = 0; i < self.arrayData.count; i ++) {
        if (button.tag == 10 + i) {
            
            self.tagButton = button.tag;
            NSLog(@"%d", self.tagButton);
            
            self.countOrder = [button.titleLabel.text integerValue];
            if (self.countOrder < 10) {
                [self.counterPicker selectRow:self.countOrder - 1 inComponent:0 animated:NO];
            } else {
                [self.counterPicker selectRow:9 inComponent:0 animated:NO];
            }
            
            [UIView animateWithDuration:0.3 animations:^{
                self.viewFone.alpha = 0.5;
                self.viewCounter.alpha = 1.f;
            } completion:^(BOOL finished) {
                
            }];
        }
    }
    
}

//Подтверждение кол-ва товара или отмена выбранного колличества
- (void) buttonPickerAction: (UIButton*) button {
    if (button.tag == 1000) {
        [UIView animateWithDuration:0.3 animations:^{
            self.viewFone.alpha = 0.f;
            self.viewCounter.alpha = 0.f;
        }];
    } else if (button.tag == 1001) {
        UIButton * button = (UIButton*)[self viewWithTag:self.tagButton];
        [button setTitle:[NSString stringWithFormat:@"%d", self.pickerCount] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.3 animations:^{
            self.viewFone.alpha = 0.f;
            self.viewCounter.alpha = 0.f;
        }];
    }
}

//Удаление товара из корзины
- (void) buttonBasketAction: (UIButton*) button {
    if (self.arrayView.count == 1) {
        [self.delegate backTuCatalog:self];
    } else {
    for (int i = 0; i < self.arrayView.count; i++) {
        if (button.tag == 500 + i) {
            UIView * viewTakeOrder = [self.arrayView objectAtIndex:i];
            for (int j = 0; j < self.arrayView.count; j++) {
                UIButton * butonTrash = (UIButton*)[self viewWithTag:500 + j];
                UIButton * buttonCount = (UIButton*)[self viewWithTag:10 + j];
                UIView * viewOther = [self.arrayView objectAtIndex:j];
                if (buttonCount.tag == 10 + i) {
                    buttonCount.tag = 0;
                    buttonCount = nil;
                }
                if (butonTrash.tag > 500 + i) {
                    butonTrash.tag -= 1;
                    buttonCount.tag -= 1;
                    [UIView animateWithDuration:0.3 delay:0.2 options:0 animations:^{
                        CGRect rectButtontrash = viewOther.frame;
                        rectButtontrash.origin.y -= 180.f;
                        viewOther.frame = rectButtontrash;
                    } completion:^(BOOL finished) {}];
                }
            }
            
            [self.arrayView removeObjectAtIndex:i];
            [UIView animateWithDuration:0.3 animations:^{
                CGRect rectView = viewTakeOrder.frame;
                rectView.origin.x -= self.frame.size.width;
                viewTakeOrder.frame = rectView;
            }];
            
        }
    }
    }
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return  self.arrayForPickerView.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.arrayForPickerView[row];
}

#pragma mark - UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 60.f;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel * label = nil;
    view = [[UIView alloc] init];
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 260, 60)];
    label.text = self.arrayForPickerView[row];
    label.font = [UIFont fontWithName:VM_FONT_BOLD size:25];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    
    [[pickerView.subviews objectAtIndex:1] setHidden:TRUE];
    [[pickerView.subviews objectAtIndex:2] setHidden:TRUE];

    return view;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.pickerCount = row + 1;
}


@end
