//
//  RegistrationView.m
//  Sadovod
//
//  Created by Виктор Мишустин on 08/09/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "RegistrationView.h"
#import "InputTextView.h"
#import "CustomButton.h"
#import "CustomLabels.h"
#import "Macros.h"
#import "HexColors.h"
#import "UIView+BorderView.h"
#import "SingleTone.h"

@interface RegistrationView () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray * arrayData;
@property (strong, nonatomic) UITableView * mainTable;

@end

@implementation RegistrationView

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 64.f, view.frame.size.width, view.frame.size.height - 64);
        self.arrayData = data;
        
        if ([[[SingleTone sharedManager] typeMenu] isEqualToString:@"0"]) {
        
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        
        UIView * viewCentre = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 130.f, self.frame.size.height / 2 - 180.f, 260.f, 285.f)];
        viewCentre.backgroundColor = [UIColor whiteColor];
        [viewCentre.layer setBorderColor:[UIColor colorWithWhite:0.8f alpha:0.6f].CGColor];
        viewCentre.layer.borderWidth = 1.5f;
        viewCentre.layer.cornerRadius = 5.f;
        [self addSubview:viewCentre];
        
        
        NSArray * arrayName = [NSArray arrayWithObjects:@"Email", @"Имя", @"Телефон (не обязательно)", @"Пароль", @"Повторите пароль", nil];
        for (int i = 0; i < 5; i++) {
            InputTextView * inputText = [[InputTextView alloc] initInputTextWithView:viewCentre
                                                                             andRect:CGRectMake(15.f, 10.f + 40 * i, viewCentre.frame.size.width - 30.f, 40) andImage:nil
                                                                  andTextPlaceHolder:[arrayName objectAtIndex:i] colorBorder:nil];
            if (i == 0) {
                inputText.textFieldInput.keyboardType = UIKeyboardTypeEmailAddress;
            } else if (i == 2) {
                inputText.textFieldInput.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            } else if (i > 2) {
                inputText.textFieldInput.secureTextEntry = YES;
            }
            inputText.textFieldInput.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
            inputText.textFieldInput.textColor = [UIColor blackColor];
            inputText.labelPlaceHoldInput.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
            inputText.labelPlaceHoldInput.textColor = [UIColor lightGrayColor];
            [viewCentre addSubview:inputText];
            [UIView borderViewWithHeight:39.f andWight:10.f andView:inputText andColor:@"efeff4" andHieghtBorder:1.f];
        }
        
        
        UIButton * buttonEntrance = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonEntrance.frame = CGRectMake(15.f, 230.f, viewCentre.frame.size.width - 30.f, 40);
        buttonEntrance.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_800];
        [buttonEntrance setTitle:@"Зарегистрироваться" forState:UIControlStateNormal];
        [buttonEntrance setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonEntrance.layer.cornerRadius = 3.f;
        buttonEntrance.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:16];
        [viewCentre addSubview:buttonEntrance];
        } else {
            if (self.arrayData.count == 0) {
                
                UIImageView * imageGift = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 50, self.frame.size.height / 2 - 140, 100, 100)];
                imageGift.image = [UIImage imageNamed:@"gift.png"];
                [self addSubview:imageGift];
                
                CustomLabels * labelGift = [[CustomLabels alloc] initLabelTableWithWidht:0.f andHeight:self.frame.size.height / 2 - 20 andSizeWidht:self.frame.size.width andSizeHeight:50
                                                     andColor:@"d2d2d2" andText:@"Здесь будут отображаться \nВаши заказы"];
                labelGift.font = [UIFont fontWithName:VM_FONT_REGULAR size:24];
                labelGift.textAlignment = NSTextAlignmentCenter;
                labelGift.numberOfLines = 2.f;
                [self addSubview:labelGift];
                
                UIButton * buttonBack = [UIButton buttonWithType:UIButtonTypeSystem];
                buttonBack.frame = CGRectMake(self.frame.size.width / 2 - 80, self.frame.size.height / 2 + 40, 160, 35);
                buttonBack.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_800];
                buttonBack.layer.cornerRadius = 3.f;
                [buttonBack setTitle:@"Вернуться на главную" forState:UIControlStateNormal];
                [buttonBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                buttonBack.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:14];
                [self addSubview:buttonBack];
                
                
                
            } else {
                //Создание таблицы заказов----
                self.mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0.f, - 64.f, self.frame.size.width, self.frame.size.height + 64.f)];
                //Убираем полосы разделяющие ячейки------------------------------
                self.mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
                self.mainTable.backgroundColor = nil;
                self.mainTable.dataSource = self;
                self.mainTable.delegate = self;
                self.mainTable.showsVerticalScrollIndicator = NO;
                //Очень полездное свойство, отключает дествие ячейки-------------
                self.mainTable.allowsSelection = NO;
                [self addSubview:self.mainTable];
            } 
        }
        
    }
    
    return self;
}


#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

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
    
    
    [cell.contentView addSubview:[self createCustomCellWithNumber:[dict objectForKey:@"number"]
                                                          andDate:[dict objectForKey:@"date"]
                                                         andPrice:[dict objectForKey:@"price"]
                                                        andStatus:[dict objectForKey:@"status"]]];
    
    
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
//Анимация нажатия ячейки--------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}

#pragma mark - CustomCell

- (UIView*) createCustomCellWithNumber: (NSString*) number andDate: (NSString*) date
                              andPrice: (NSString*) price andStatus: (NSString*) status {
    UIView * mainViewCell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 60)];
    
    
    [UIView borderViewWithHeight:59.5f andWight:0.f andView:mainViewCell andColor:@"5C5C5C"];
    
    CustomLabels * labelNumber = [[CustomLabels alloc] initLabelWithWidht:15.f andHeight:15 andColor:@"000000" andText:[NSString stringWithFormat:@"№%@", number] andTextSize:15 andLineSpacing:0.f fontName:VM_FONT_BOLD];
    [mainViewCell addSubview:labelNumber];
    
    CustomLabels * labelDate = [[CustomLabels alloc] initLabelWithWidht:15.f andHeight:40 andColor:@"5C5C5C" andText:date andTextSize:13 andLineSpacing:0.f fontName:VM_FONT_REGULAR];
    [mainViewCell addSubview:labelDate];
    
    CustomLabels * labelPrice = [[CustomLabels alloc] initLabelTableWithWidht:self.frame.size.width - 115.f andHeight:15 andSizeWidht:100.f andSizeHeight:15
                                                                     andColor:VM_COLOR_800 andText:[NSString stringWithFormat:@"%@ руб", price]];
    labelPrice.font = [UIFont fontWithName:VM_FONT_BOLD size:15];
    labelPrice.textAlignment = NSTextAlignmentRight;
    [mainViewCell addSubview:labelPrice];
    
    CustomLabels * labelStatus = [[CustomLabels alloc] initLabelTableWithWidht:self.frame.size.width - 115.f andHeight:40 andSizeWidht:100.f andSizeHeight:13
                                                                     andColor:@"5C5C5C" andText:status];
    labelStatus.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
    labelStatus.textAlignment = NSTextAlignmentRight;
    [mainViewCell addSubview:labelStatus];
    
    if ([status isEqualToString:@"Ожидает оплаты"]) {
        mainViewCell.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"FEFADE" alpha:0.7f];
    } else if ([status isEqualToString:@"Готов в отправке"]) {
        mainViewCell.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"E6FEE5" alpha:0.7f];
    } else if ([status isEqualToString:@"Отправлен"]) {
        mainViewCell.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"83FC7F" alpha:0.7f];
    } else if ([status isEqualToString:@"Отменен"]) {
        mainViewCell.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"FD5A5A" alpha:0.3f];
    }
    

    
    
    return mainViewCell;
}










@end
