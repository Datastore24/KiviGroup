//
//  BuyView.m
//  Sadovod
//
//  Created by Виктор Мишустин on 26/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "BuyView.h"
#import "CustomButton.h"
#import "CustomLabels.h"
#import "CheckDataServer.h"
#import "HexColors.h"
#import "Macros.h"
#import "UIImage+Resize.h"
#import "UIView+BorderView.h"
#import "SingleTone.h"

@interface BuyView () <UITableViewDelegate, UITableViewDataSource>

//Main

@property (strong, nonatomic) NSArray * arrayData;
@property (strong, nonatomic) NSArray * arrayCart;

//TableSize

@property (strong, nonatomic) UITableView * tableSize;

//ButtonCount

@property (strong, nonatomic) UIView * viewButtonMax;
@property (strong, nonatomic) CustomButton * buttonMax;

@end

@implementation BuyView

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data
                     andCart: (NSArray *) cart
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 64.f, view.frame.size.width, view.frame.size.height-64.f);
        self.arrayData = data;
        self.arrayCart = cart;
        
        //Table Size
        
        [self addSubview: [self createViewForTableSize]];
        
        //ButtonMax
        self.buttonMax = [CustomButton buttonWithType:UIButtonTypeCustom];
        self.buttonMax.frame = CGRectMake(self.frame.size.width - 80.f, self.frame.size.height - 140, 60.f, 60.f);
        self.buttonMax.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_300];
        self.buttonMax.layer.cornerRadius = 30.f;
        self.buttonMax.isBool = NO;
        [self.buttonMax setImage:[UIImage imageNamed:@"imageForButtonMax.png"] forState:UIControlStateNormal];
        [self.buttonMax setImageEdgeInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
        [self.buttonMax addTarget:self action:@selector(buttonMaxAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.buttonMax];
        
        self.viewButtonMax = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width - 190.f, self.frame.size.height - 270.f, 170.f, 120.f)];
        self.viewButtonMax.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.viewButtonMax.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        self.viewButtonMax.layer.borderWidth = 1.f;
        self.viewButtonMax.layer.cornerRadius = 2.f;
        self.viewButtonMax.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.viewButtonMax.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
        self.viewButtonMax.layer.shadowRadius = 3.0f;
        self.viewButtonMax.layer.shadowOpacity = 1.0f;
        self.viewButtonMax.alpha = 0.f;
        [self addSubview:self.viewButtonMax];
        
        NSArray * arrayNameButtons = [NSArray arrayWithObjects:@"Очистить", @"+1 всего", @"-1 всего", nil];
        for (int i = 0; i < 3; i++) {
            UIButton * buttonChangeAll = [UIButton buttonWithType:UIButtonTypeSystem];
            buttonChangeAll.frame = CGRectMake(0, 0 + 40 * i, 170.f, 40.f);
            [buttonChangeAll setTitle:[arrayNameButtons objectAtIndex:i] forState:UIControlStateNormal];
            [buttonChangeAll setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            buttonChangeAll.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
            buttonChangeAll.tag = 400 + i;
            [buttonChangeAll addTarget:self action:@selector(buttonChangeAllAction:) forControlEvents:UIControlEventTouchUpInside];
            buttonChangeAll.contentEdgeInsets = UIEdgeInsetsMake(0, -70, 0, 0);
            [self.viewButtonMax addSubview:buttonChangeAll];
        }
        
        
    }
    return self;
}

#pragma mark - TableSize

- (UIView*) createViewForTableSize {
    UIView * tableSizeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 200.f)];
    
    //Создание таблицы заказов----
    self.tableSize = [[UITableView alloc] initWithFrame:tableSizeView.frame];
    //Убираем полосы разделяющие ячейки------------------------------
    self.tableSize.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableSize.backgroundColor = nil;
    self.tableSize.dataSource = self;
    self.tableSize.delegate = self;
    self.tableSize.showsVerticalScrollIndicator = NO;
    self.tableSize.scrollEnabled = NO;
    
    //Очень полездное свойство, отключает дествие ячейки-------------
    self.tableSize.allowsSelection = NO;
    [tableSizeView addSubview:self.tableSize];
    
    
    return tableSizeView;
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    [CheckDataServer checkDataServer:self.arrayData andMessage:@"Нет размеров для отображения" view:tableView];
    
    
    return self.arrayData.count;
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
    cell.backgroundColor = nil;
    
    NSDictionary * dict = [self.arrayData objectAtIndex:indexPath.row];
    
    if([[dict objectForKey:@"aviable"] integerValue] == 1){
        NSString * count;
        for (int i=0; i<self.arrayCart.count; i++) {

            if([[dict objectForKey:@"id"] longLongValue] == [[[self.arrayCart objectAtIndex:i] objectForKey:@"id"] longLongValue]){
                
                count =[NSString stringWithFormat:@"%@",[[self.arrayCart objectAtIndex:i] objectForKey:@"count"]] ;
                
                break;
            }else{
                count =@"0";
             
            }
        }
        if(self.arrayCart.count ==0){
            count = @"0";
     
        }
     
        [cell.contentView addSubview:[self createCustomCellWithSize:[dict objectForKey:@"value"]
                                                           andCount:count
                                                       andProductID:[dict objectForKey:@"id"]
                                                      andCounterTag:indexPath.row]];
    }
    
    
   

    return cell;
}

#pragma mark - UITableViewDelegate
//Анимация нажатия ячейки--------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - CustomCell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.f;
}

- (UIView*) createCustomCellWithSize: (NSString*) size
                            andCount: (NSString*) count
                        andProductID: (NSString*) productID
                       andCounterTag: (NSInteger) counterTag {
    UIView * customCell = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, 46.f)];
    
    CustomButton * buttonSize = [CustomButton buttonWithType:UIButtonTypeCustom];
    buttonSize.frame = CGRectMake(15.f, 15.f, 15.f, 15);
    buttonSize.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"e8e8e8"].CGColor;
    buttonSize.layer.borderWidth = 2.f;
    buttonSize.layer.cornerRadius = 3.f;
    buttonSize.customID = productID;
    buttonSize.isBool = NO;
    buttonSize.tag = 10 + counterTag;
    if (![count isEqualToString:@"0"]) {
        buttonSize.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_300];
        buttonSize.layer.borderColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_300].CGColor;
        buttonSize.isBool = YES;
    }
//    if ([count integerValue] != 0) {
//        NSInteger countInt = [count integerValue];
//        NSInteger countAll = [[[SingleTone sharedManager] countType] integerValue] + countInt;
//        [[SingleTone sharedManager] setCountType:[NSString stringWithFormat:@"%d", countAll]];
//    }

    [buttonSize setImage:[UIImage imageNamed:@"confirmButtonCount.png"] forState:UIControlStateNormal];
    [self.buttonMax setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [buttonSize addTarget:self action:@selector(buttonSizeAction:) forControlEvents:UIControlEventTouchUpInside];
    [customCell addSubview:buttonSize];
    
    CustomLabels * labelSize = [[CustomLabels alloc] initLabelWithWidht:45.f andHeight:16.f andColor:@"000000" andText:[NSString stringWithFormat:@"размер: %@", size] andTextSize:13 andLineSpacing:0.f fontName:VM_FONT_REGULAR];
    [customCell addSubview:labelSize];
    
    CustomButton * buttonDown = [CustomButton buttonWithType:UIButtonTypeSystem];
    buttonDown.frame = CGRectMake(self.frame.size.width - 100.f, 17.f, 15.f, 15.f);
    buttonDown.customID = productID;
    [buttonDown setTitle:@"-" forState:UIControlStateNormal];
    [buttonDown setTitleColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_300] forState:UIControlStateNormal];
    buttonDown.titleLabel.font = [UIFont fontWithName:VM_FONT_BOLD size:30];
    buttonDown.tag = 100 + counterTag;
    [buttonDown addTarget:self action:@selector(buttonDownAction:) forControlEvents:UIControlEventTouchUpInside];
    [customCell addSubview:buttonDown];
    
    CustomButton * buttonUp = [CustomButton buttonWithType:UIButtonTypeSystem];
    buttonUp.frame = CGRectMake(self.frame.size.width - 40.f, 17.f, 15.f, 15.f);
    buttonUp.customID = productID;
    [buttonUp setTitle:@"+" forState:UIControlStateNormal];
    [buttonUp setTitleColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_300] forState:UIControlStateNormal];
    buttonUp.titleLabel.font = [UIFont fontWithName:VM_FONT_BOLD size:30];
    buttonUp.tag = 200 + counterTag;
    [buttonUp addTarget:self action:@selector(buttonUpAction:) forControlEvents:UIControlEventTouchUpInside];
    [customCell addSubview:buttonUp];
    
    CustomLabels * labelCount = [[CustomLabels alloc] initLabelTableWithWidht:self.frame.size.width - 85.f andHeight:2 andSizeWidht:45 andSizeHeight:45 andColor:@"000000" andText:count];
    labelCount.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
    labelCount.tag = 300 + counterTag;
    [customCell addSubview:labelCount];
    
    
    

    
    [UIView borderViewWithHeight:45.9f andWight:0.f andView:customCell andColor:VM_COLOR_200];
    
    return customCell;
}

#pragma mark - Actions

//Действие каждого элемента в скрытом окне
- (void) buttonChangeAllAction: (UIButton*) button {
    if (button.tag == 400) {
        [self.deleagte getApiClearAllSizeToBasket];
        for (int i = 0; i < self.arrayData.count; i++) {
            CustomLabels * label = (CustomLabels*)[self viewWithTag:300 + i];
            CustomButton * buttonSize = (CustomButton*)[self viewWithTag:10 + i];
            
            [UIView animateWithDuration:0.2 animations:^{
                label.text = @"0";
                buttonSize.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"e8e8e8"].CGColor;
                buttonSize.backgroundColor = [UIColor whiteColor];
            } completion:^(BOOL finished) {
                buttonSize.isBool = NO;
            }];
        }
    } else if (button.tag == 401) {
        [self.deleagte getApiAddAllSizeToBasket];
        for (int i = 0; i < self.arrayData.count; i++) {
            CustomLabels * label = (CustomLabels*)[self viewWithTag:300 + i];
            CustomButton * buttonSize = (CustomButton*)[self viewWithTag:10 + i];
            NSInteger countUp = [label.text integerValue];
            countUp += 1;
            [UIView animateWithDuration:0.2 animations:^{
                label.text = [NSString stringWithFormat:@"%d", countUp];
                if (!buttonSize.isBool) {
                    buttonSize.layer.borderColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_300].CGColor;
                    buttonSize.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_300];
                }
            } completion:^(BOOL finished) {
                buttonSize.isBool = YES;
            }];
        }
    } else if (button.tag == 402) {
        [self.deleagte getApiDelAllSizeToBasket];
        for (int i = 0; i < self.arrayData.count; i++) {
            CustomLabels * label = (CustomLabels*)[self viewWithTag:300 + i];
            CustomButton * buttonSize = (CustomButton*)[self viewWithTag:10 + i];
            NSInteger countUp = [label.text integerValue];
            if (countUp == 1) {
                [UIView animateWithDuration:0.2 animations:^{
                    buttonSize.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"e8e8e8"].CGColor;
                    buttonSize.backgroundColor = [UIColor whiteColor];
                }];
            }
            buttonSize.isBool = NO;
            if (countUp > 0) {
                countUp -= 1;
                [UIView animateWithDuration:0.3 animations:^{
                    label.text = [NSString stringWithFormat:@"%d", countUp];
                }];
            }
        }
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.viewButtonMax.alpha = 0.f;
    } completion:^(BOOL finished) {
        self.buttonMax.isBool = NO;
    }];

}

//действие кнопки увеличивающей колличестко конкретного товара
- (void) buttonUpAction: (CustomButton*) button {
    for (int i = 0; i < self.arrayData.count; i++) {
        if (button.tag == 200 + i) {
            CustomLabels * label = (CustomLabels*)[self viewWithTag:300 + i];
            CustomButton * buttonSize = (CustomButton*)[self viewWithTag:10 + i];
            [self.deleagte getApiAddToBasket:button.customID];
            NSInteger countUp = [label.text integerValue];
            countUp += 1;
            NSInteger countSinglOrder = [[[SingleTone sharedManager] countType] integerValue];
            countSinglOrder += 1;
            [[SingleTone sharedManager] setCountType:[NSString stringWithFormat:@"%d", countSinglOrder]];
            //Тестовый привер вспывающего вью
            [self.deleagte addCountOrder:self];            
            
            [UIView animateWithDuration:0.2 animations:^{
                label.text = [NSString stringWithFormat:@"%d", countUp];
                if (!buttonSize.isBool) {
                    buttonSize.layer.borderColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_300].CGColor;
                    buttonSize.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_300];
                }
            }];
            buttonSize.isBool = YES;
        }
    }
}

//действие кнопки уменьшения колличестко конкретного товара
- (void) buttonDownAction: (CustomButton*) button {
    for (int i = 0; i < self.arrayData.count; i++) {
        if (button.tag == 100 + i) {
            CustomLabels * label = (CustomLabels*)[self viewWithTag:300 + i];
            CustomButton * buttonSize = (CustomButton*)[self viewWithTag:10 + i];
             [self.deleagte getApiDelToBasket:button.customID];
            NSInteger countUp = [label.text integerValue];
            if (countUp == 1) {
                [UIView animateWithDuration:0.2 animations:^{
                        buttonSize.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"e8e8e8"].CGColor;
                        buttonSize.backgroundColor = [UIColor whiteColor];
                }];
            }
            buttonSize.isBool = NO;
            if (countUp > 0) {
                countUp -= 1;
                NSInteger countSinglOrder = [[[SingleTone sharedManager] countType] integerValue];
                countSinglOrder -= 1;
                [[SingleTone sharedManager] setCountType:[NSString stringWithFormat:@"%d", countSinglOrder]];
                [self.deleagte hideCountOrder:self];
                [UIView animateWithDuration:0.3 animations:^{
                    label.text = [NSString stringWithFormat:@"%d", countUp];
                }];
            }
            
        }
    }
}

//Действие кнопки выбора размера
- (void) buttonSizeAction: (CustomButton*) button {
    for (int i = 0; i < self.arrayData.count; i++) {
        if (button.tag == 10 + i) {
            CustomLabels * label = (CustomLabels*)[self viewWithTag:300 + i];
            
            if (!button.isBool) {
                [UIView animateWithDuration:0.2 animations:^{
                    button.layer.borderColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_300].CGColor;
                    button.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_300];
                    label.text = [NSString stringWithFormat:@"%d", 1];
                    [self.deleagte getApiAddToBasket:button.customID];
                } completion:^(BOOL finished) {
                    button.isBool = YES;
                
                }];
            } else {
                [UIView animateWithDuration:0.2 animations:^{
                    button.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"e8e8e8"].CGColor;
                    button.backgroundColor = [UIColor whiteColor];
                    label.text = [NSString stringWithFormat:@"%d", 0];
                    [self.deleagte getApiClearSizeToBasket:button.customID];
                } completion:^(BOOL finished) {
                    button.isBool = NO;
                }];
            }
        }

    }
}

//Действие
- (void) buttonMaxAction: (CustomButton*) button {
    if (!button.isBool) {
        [UIView animateWithDuration:0.3 animations:^{
            self.viewButtonMax.alpha = 1.f;
        } completion:^(BOOL finished) {
            button.isBool = YES;
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            self.viewButtonMax.alpha = 0.f;
        } completion:^(BOOL finished) {
            button.isBool = NO;
        }];
    }
}

@end
