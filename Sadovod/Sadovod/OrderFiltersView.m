//
//  OrderFiltersView.m
//  Sadovod
//
//  Created by Виктор Мишустин on 25/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "OrderFiltersView.h"
#import "HexColors.h"
#import "Macros.h"
#import "UIView+BorderView.h"
#import "CustomButton.h"
#import "CustomLabels.h"
#import "UIButton+ButtonImage.h"
#import "NMRangeSlider.h"
#import "ColorButton.h"

@interface OrderFiltersView ()

//Main

@property (strong, nonatomic) NSDictionary * dictData; //Основной дикшенери приходит с сервера
@property (strong, nonatomic) UIScrollView * mainScrollView;
@property (strong, nonatomic) NSMutableArray * arrayAllButtons; //Массив всех активных снопок
@property (strong, nonatomic) NSMutableArray * arrayAllButtonsCancel; //Массив всех кнопок отмены;
@property (assign, nonatomic) NSInteger counter; //Общий параметр всех включенных кнопок

//Price

@property (strong, nonatomic) NMRangeSlider * slider;
@property (strong, nonatomic) CustomLabels * labelFrom;
@property (strong, nonatomic) CustomLabels * labelTo;
@property (assign, nonatomic) float minPrice;
@property (assign, nonatomic) float maxPrice;
@property (strong, nonatomic) UIButton * buttonCanselPrice;
@property (assign, nonatomic) BOOL sliderBool; //Переменная для правильного вывода счетчика в слайдере;


//Size

@property (strong, nonatomic) UIView * viewSize;
@property (assign, nonatomic) NSInteger countColumn;
@property (strong, nonatomic) NSArray * arraySize;
@property (assign, nonatomic) NSInteger countSize;
@property (strong, nonatomic) UIButton * buttonCanselSize;
@property (assign, nonatomic) BOOL sizeBool; //Переменная для подсчета активных окнон

//Color

@property (strong, nonatomic) UIView * viewColor;
@property (assign, nonatomic) NSInteger countColor;
@property (strong, nonatomic) NSArray * arrayColor;
@property (strong, nonatomic) UIButton * buttonCanselColor;
@property (assign, nonatomic) BOOL colorBool; //Переменная для подсчета активных окнон

//Detail

@property (strong, nonatomic) NSMutableArray * arrayDetailButtons;
@property (strong, nonatomic) UIView * viewDetail;
@property (strong, nonatomic) NSArray * arrayDetail;
@property (strong, nonatomic) NSMutableArray * mArrayDetail;

//Сonfirm

@property (strong, nonatomic) UIButton * bigButtonConfirm;
@property (strong, nonatomic) UIButton * buttonConfirm;
@property (strong, nonatomic) UIButton * buttonCancel;



@end


@implementation OrderFiltersView

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 64.f, view.frame.size.width, view.frame.size.height-64.f);
       
        self.arrayDetailButtons = [[NSMutableArray alloc] init];
        self.arrayAllButtons = [[NSMutableArray alloc] init];
        self.arrayAllButtonsCancel = [[NSMutableArray alloc] init];
        self.counter = 0;
        self.mArrayDetail = [[ NSMutableArray alloc] init];
        
        
        self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0, self.frame.size.width, self.frame.size.height)];
        self.mainScrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:self.mainScrollView];
        
        
        for (int i=0;i<data.count;i++){
            
            if([[self.dictData objectForKey:@"id"] integerValue]==81){
                NSArray * sizeArray =[self.dictData objectForKey:@"options"];
                self.countColumn = sizeArray.count-1;
                
            }
            
           
            if(i+1==data.count){
                 for (int j=0;j<data.count;j++){
                     self.dictData = [data objectAtIndex:j];
                     
                     if([[self.dictData objectForKey:@"id"] integerValue]==-1){
                         //PriceView----------------
                         [self.mainScrollView addSubview:[self createPriceView]];
                         
                     }else if([[self.dictData objectForKey:@"id"] integerValue]==81){
                         
                         //SizeView------------------
                         self.viewSize = [self createSizeView];
                         [self.mainScrollView addSubview:self.viewSize];
                         
                         
                         
                     }else if([[self.dictData objectForKey:@"id"] integerValue]==2){
                         //ColorView-----------------
                         self.viewColor = [self createColorView];
                         [self.mainScrollView addSubview:self.viewColor];
                         
                     }else if([[self.dictData objectForKey:@"id"] integerValue]==-2){
                         NSLog(@"ID %@ NAME %@",[self.dictData objectForKey:@"id"],[self.dictData objectForKey:@"name"]);
                         
                     }else{
                         NSLog(@"ID %@ NAME %@",[self.dictData objectForKey:@"id"],[self.dictData objectForKey:@"name"]);
                         //Detail
                         [self.mArrayDetail addObject:self.dictData];
                         
                         
                     }
                     if(j+1==data.count){
                         self.viewDetail = [self createDetailView];
                         [self.mainScrollView addSubview:self.viewDetail];
                     }

                 }
                
                
            }
            
           
        }
        
       
        
       
        
        
        
        //Confirm
        [self addSubview:[self createConfirmView]];
        
        self.mainScrollView.contentSize = CGSizeMake(0, self.viewDetail.frame.size.height + self.viewDetail.frame.origin.y + 60);

    }
    return self;
}


#pragma mark - PriceView
- (UIView*) createPriceView {
    self.sliderBool = NO;
    UIView * priceView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, 160.f)];
    
    CustomLabels * priceTitl = [[CustomLabels alloc] initLabelWithWidht:20.f andHeight:20.f andColor:VM_COLOR_800 andText:@"Цена" andTextSize:16 andLineSpacing:0.f fontName:VM_FONT_REGULAR];
    [priceView addSubview:priceTitl];
    
    UIView * backgroundSlider = [[UIView alloc] initWithFrame:CGRectMake(35.f, 160 / 2 - 8, self.frame.size.width - 70.f, 5)];
    backgroundSlider.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_300];
    [priceView addSubview:backgroundSlider];
    self.slider = [[NMRangeSlider alloc] initWithFrame:CGRectMake(30.f, 65, self.frame.size.width - 60, 20)];
   [self configureSlider];
    [self.slider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
    [priceView addSubview:self.slider];
    
    self.labelFrom = [[CustomLabels alloc] initLabelWithWidht:15.f andHeight:120.f andColor:VM_COLOR_800 andText:[NSString stringWithFormat:@"ОТ %@", [self.dictData objectForKey:@"cost_min_orig"] ] andTextSize:16 andLineSpacing:0.f fontName:VM_FONT_REGULAR];
    
    [priceView addSubview:self.labelFrom];
    
    self.labelTo = [[CustomLabels alloc] initLabelWithWidht:self.frame.size.width - 15.f andHeight:120.f andColor:VM_COLOR_800 andText:[NSString stringWithFormat:@"ДО %@",[self.dictData objectForKey:@"cost_max_orig"]] andTextSize:16 andLineSpacing:0.f fontName:VM_FONT_REGULAR];
    self.labelTo.frame = CGRectMake(self.frame.size.width - 115.f, 120.f, 100.f, self.labelFrom.frame.size.height);
    self.labelTo.textAlignment = NSTextAlignmentRight;
    [priceView addSubview:self.labelTo];
    
    self.buttonCanselPrice = [UIButton createButtonCustomImageWithImage:@"imageCross.png" andRect:CGRectMake(self.frame.size.width - 35.f, 20.f, 15.f, 15.f)];
    [self.buttonCanselPrice addTarget:self action:@selector(buttonCanselPriceAction:) forControlEvents:UIControlEventTouchUpInside];
    self.buttonCanselPrice.alpha = 0.f;
    [priceView addSubview:self.buttonCanselPrice];
    
    
    //Коллекция хранения всех кнопок отмены и числовых значений
    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.buttonCanselColor, @"button", nil];
    [self.arrayAllButtonsCancel addObject:dict];
    
    
    [UIView borderViewWithHeight:159.f andWight:0.f andView:priceView andColor:@"94969a"];
    
    return priceView;
}

#pragma mark - SizeView
- (UIView*) createSizeView {
    UIView * sizeView = [[UIView alloc] init];
    self.countSize = 0;
    self.sizeBool = NO;
    
    self.arraySize = [self.dictData objectForKey:@"options"];
    
    //Расчет таблицы-------
    NSInteger line = 0; //Строки
    NSInteger column = 0; //Столбци
    for (int i = 0; i < self.arraySize.count; i++) {
        CustomButton * buttonSize = [CustomButton buttonWithType:UIButtonTypeSystem];
        buttonSize.frame = CGRectMake(20.f + (self.frame.size.width / 7.f - 5) * column,
                                      50.f + (self.frame.size.width / 7 - 15) * line,
                                      self.frame.size.width / 7 - 10, self.frame.size.width / 7 - 20);
        buttonSize.layer.borderWidth = 1.5f;
        buttonSize.layer.borderColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_800].CGColor;
        buttonSize.layer.cornerRadius = 6.f;
        [buttonSize setTitle:[[self.arraySize objectAtIndex:i] objectForKey:@"name"]  forState:UIControlStateNormal];
        [buttonSize setTitleColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_800] forState:UIControlStateNormal];
        buttonSize.titleLabel.font = [UIFont fontWithName:VM_FONT_BOLD size:15];
        buttonSize.tag = 10 + i;
        buttonSize.isBool = NO;
        [buttonSize addTarget:self action:@selector(buttonSizeAction:) forControlEvents:UIControlEventTouchUpInside];
        [sizeView addSubview: buttonSize];
        [self.arrayAllButtons addObject:buttonSize];
        if (i != self.arraySize.count - 1) {
            column += 1;
            if (column > 6) {
                column = 0;
                line += 1;
            }
        }
        
    }
    sizeView.frame = CGRectMake(0.f, 160.f, self.frame.size.width,
                                (50.f + ((self.frame.size.width / 7 - 15) * (line + 1)) + 10));
    CustomLabels * sizeTitl = [[CustomLabels alloc] initLabelWithWidht:20.f andHeight:20.f andColor:VM_COLOR_800 andText:@"Размеры" andTextSize:16 andLineSpacing:0.f fontName:VM_FONT_REGULAR];
    [sizeView addSubview:sizeTitl];
    
    self.buttonCanselSize = [UIButton createButtonCustomImageWithImage:@"imageCross.png" andRect:CGRectMake(self.frame.size.width - 35.f, 20.f, 15.f, 15.f)];
    [self.buttonCanselSize addTarget:self action:@selector(buttonCanselSizeAction:) forControlEvents:UIControlEventTouchUpInside];
    self.buttonCanselSize.alpha = 0.f;
    [sizeView addSubview:self.buttonCanselSize];
    
    //Коллекция хранения всех кнопок отмены и числовых значений
    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.buttonCanselSize, @"button", nil];
    [self.arrayAllButtonsCancel addObject:dict];
    
    [UIView borderViewWithHeight:sizeView.frame.size.height - 1.f andWight:0.f andView:sizeView andColor:@"94969a"];
    
    return sizeView;
}

#pragma mark - ColorView

- (UIView*) createColorView {
    UIView * colorView = [[UIView alloc] init];
    self.countColor = 0;
    self.colorBool = NO;
    
    self.arrayColor = [self.dictData objectForKey:@"options"];
    
    
    //Расчет таблицы-------
    NSInteger line = 0; //Строки
    NSInteger column = 0; //Столбци
    for (int i = 0; i < self.arrayColor.count; i++) {
        int value =[[[self.arrayColor objectAtIndex:i] objectForKey:@"name"] intValue];
        NSString * color;
        switch (value) {
            case 13:
                color=@"000000";
                break;
            case 12:
                color=@"9801cc";
                break;
            case 11:
                color=@"3233ff";
                break;
            case 10:
                color=@"666666";
                break;
            case 9:
                color=@"fe00ba";
                break;
            case 8:
                color=@"ffffff";
                break;
            case 7:
                color=@"fe6700";
                break;
            case 6:
                color=@"fe0000";
                break;
            case 5:
                color=@"653300";
                break;
            case 4:
                color=@"009800";
                break;
            case 3:
                color=@"feff00";
                break;
            case 2:
                color=@"84d6fe";
                break;
            case 1:
                color=@"feeede";
                break;
            case 0:
                color=@"000000";
                break;
                
            default:
                break;
        }
        
        ColorButton * buttonColor = [ColorButton buttonWithType:UIButtonTypeSystem];
        buttonColor.frame = CGRectMake(20.f + (self.frame.size.width / 7.f - 5) * column,
                                      50.f + (self.frame.size.width / 7 - 15) * line,
                                      self.frame.size.width / 7 - 10, self.frame.size.width / 7 - 20);
        buttonColor.layer.borderWidth = 1.5f;
        buttonColor.layer.borderColor = [UIColor blackColor].CGColor;
        buttonColor.layer.cornerRadius = 6.f;
        buttonColor.backgroundColor = [UIColor hx_colorWithHexRGBAString:color];
        buttonColor.tag = 100 + i;
        buttonColor.isBool = NO;
        [buttonColor addTarget:self action:@selector(buttonColorAction:) forControlEvents:UIControlEventTouchUpInside];
        [colorView addSubview: buttonColor];
        [self.arrayAllButtons addObject:buttonColor];
        if (i != self.arrayColor.count - 1) {
            column += 1;
            if (column > 6) {
                column = 0;
                line += 1;
            }
        }
        
    }
    CGFloat colorCustomHeight = 50.f + (self.frame.size.width / 7 - 15) * (int)(self.countColumn/7 + 1) ;
    colorView.frame = CGRectMake(0.f, colorCustomHeight+220, self.frame.size.width,
                                (50.f + ((self.frame.size.width / 7 - 15) * (line + 1)) + 10));
    CustomLabels * colorTitl = [[CustomLabels alloc] initLabelWithWidht:20.f andHeight:20.f andColor:VM_COLOR_800 andText:@"Цвет" andTextSize:16 andLineSpacing:0.f fontName:VM_FONT_REGULAR];
    [colorView addSubview:colorTitl];
    
    self.buttonCanselColor = [UIButton createButtonCustomImageWithImage:@"imageCross.png" andRect:CGRectMake(self.frame.size.width - 35.f, 20.f, 15.f, 15.f)];
    [self.buttonCanselColor addTarget:self action:@selector(buttonCanselColorAction:) forControlEvents:UIControlEventTouchUpInside];
    self.buttonCanselColor.alpha = 0.f;
    [colorView addSubview:self.buttonCanselColor];
    
    //Коллекция хранения всех кнопок отмены и числовых значений
    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.buttonCanselColor, @"button", nil];
    [self.arrayAllButtonsCancel addObject:dict];
    
    [UIView borderViewWithHeight:colorView.frame.size.height - 1.f andWight:0.f andView:colorView andColor:@"94969a"];
    
    return colorView;
}

#pragma mark - DetailView

- (UIView*) createDetailView {
    UIView * detailView = [[UIView alloc] init];
    
    
    
    NSArray * arrayDetail = self.mArrayDetail;
    
    //Общий параметр высоты вью каждой детали
    CGFloat viewHeight = 0; //Старторвая высота
    for (int i = 0; i < arrayDetail.count; i++) {
        NSDictionary * dictDetail = [arrayDetail objectAtIndex:i];
        NSArray * arrayDictDetail = [dictDetail objectForKey:@"options"]; //Массив каждой детали
        UIView * detailPartView = [[UIView alloc] init]; // Вью каждой детали
        NSMutableArray * detailArray = [[NSMutableArray alloc] init]; //Массив кнопок в каждой детали
        NSInteger countDetail = 0; //счетчик деталей
        BOOL booldetail = NO; //Для подсчета активных окон
        //Расчет таблицы-------
        NSInteger line = 0; //Строки
        CGFloat allHeight = 0; //общая ширина
        for (int j = 0; j < arrayDictDetail.count; j++) {
            CustomButton * buttonDetail = [CustomButton buttonWithType:UIButtonTypeSystem];
            buttonDetail.layer.borderWidth = 1.5f;
            buttonDetail.layer.borderColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_800].CGColor;
            buttonDetail.layer.cornerRadius = 6.f;
            [buttonDetail setTitle:[[arrayDictDetail objectAtIndex:j] objectForKey:@"name"] forState:UIControlStateNormal];
            [buttonDetail setTitleColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_800] forState:UIControlStateNormal];
            buttonDetail.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:14];
            [buttonDetail addTarget:self action:@selector(buttonDetailAction:) forControlEvents:UIControlEventTouchUpInside];
            NSInteger letterCount = buttonDetail.titleLabel.text.length;
            if (allHeight + (8 * letterCount + 20) > self.frame.size.width - 40) {
                allHeight = 0.f;
                line += 1;
            }
            buttonDetail.frame = CGRectMake(20.f + allHeight,
                                              50.f + (self.frame.size.width / 7 - 15) * line,
                                              8 * letterCount + 20,
                                              self.frame.size.width / 7 - 20);
            buttonDetail.isBool = NO;
            [detailPartView addSubview: buttonDetail];
            allHeight += buttonDetail.frame.size.width + 5;
            [detailArray addObject:buttonDetail];
            [self.arrayAllButtons addObject:buttonDetail];
        }
        detailPartView.frame = CGRectMake(0.f, viewHeight, self.frame.size.width,
                                     (50.f + ((self.frame.size.width / 7 - 15) * (line + 1)) + 10));
        [detailView addSubview:detailPartView];
        CustomLabels * colorTitl = [[CustomLabels alloc] initLabelWithWidht:20.f andHeight:20.f andColor:VM_COLOR_800 andText:[dictDetail objectForKey:@"name"] andTextSize:16 andLineSpacing:0.f fontName:VM_FONT_REGULAR];
        [detailPartView addSubview:colorTitl];
        
        
        UIButton * buttonCancelDetail = [UIButton createButtonCustomImageWithImage:@"imageCross.png" andRect:CGRectMake(self.frame.size.width - 35.f, 20.f, 15.f, 15.f)];
        [buttonCancelDetail addTarget:self action:@selector(buttonCanselDetailAction:) forControlEvents:UIControlEventTouchUpInside];
        buttonCancelDetail.alpha = 0.f;
        buttonCancelDetail.tag = 1000 + i;
        [detailPartView addSubview:buttonCancelDetail];
        
        //Коллекция хранения всех кнопок отмены и числовых значений
        NSMutableDictionary * dictCancel = [NSMutableDictionary dictionaryWithObjectsAndKeys:buttonCancelDetail, @"button", nil];
        [self.arrayAllButtonsCancel addObject:dictCancel];
        
        if (i != arrayDetail.count - 1) {
            [UIView borderViewWithHeight:detailPartView.frame.size.height - 1.f andWight:0.f andView:detailPartView andColor:@"94969a"];
        }
        
        viewHeight += detailPartView.frame.size.height;
        
        NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:detailArray, @"buttonArray",
                                      [NSNumber numberWithInteger:countDetail], @"count", buttonCancelDetail, @"cancel", [NSNumber numberWithBool:booldetail], @"bool", nil]; //Дикшенери для хранения данных
        [self.arrayDetailButtons addObject:dict];
        

    }
    detailView.frame = CGRectMake(0, self.viewColor.frame.size.height + self.viewColor.frame.origin.y, self.frame.size.width, viewHeight);
    return detailView;
}

#pragma mark - ConfirmView

- (UIView*) createConfirmView {
    UIView * confirmView = [[UIView alloc] initWithFrame:CGRectMake(0.f, self.frame.size.height - 60.f, self.frame.size.width, 60.f)];
    confirmView.backgroundColor = [UIColor whiteColor];
    
    //Большая кнопка подтвердить
    self.bigButtonConfirm = [UIButton buttonWithType:UIButtonTypeCustom];
    self.bigButtonConfirm.frame = CGRectMake(20.f, 10.f, confirmView.frame.size.width - 40.f, 40.f);
    self.bigButtonConfirm.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_800];
    [self.bigButtonConfirm setTitle:@"Готово" forState:UIControlStateNormal];
    [self.bigButtonConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.bigButtonConfirm.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
    [self.bigButtonConfirm addTarget:self action:@selector(buttonConfirmAction) forControlEvents:UIControlEventTouchUpInside];
    [confirmView addSubview:self.bigButtonConfirm];
    UIImageView * imageBigButton = [[UIImageView alloc] initWithFrame:CGRectMake(90.f, 8.f, 20.f, 20.f)];
    imageBigButton.image = [UIImage imageNamed:@"imageConfirm.png"];
    self.bigButtonConfirm.alpha = 1.f;
    [self.bigButtonConfirm addSubview:imageBigButton];
    
    //Маленькая кнпока подтвердить
    self.buttonConfirm = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buttonConfirm.frame = CGRectMake(self.frame.size.width / 2 + 5.f, 10.f, confirmView.frame.size.width / 2 - 25.f, 40.f);
    self.buttonConfirm.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_800];
    [self.buttonConfirm setTitle:@"Готово" forState:UIControlStateNormal];
    [self.buttonConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.buttonConfirm.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
    [self.buttonConfirm addTarget:self action:@selector(buttonConfirmAction) forControlEvents:UIControlEventTouchUpInside];
    self.buttonConfirm.contentEdgeInsets = UIEdgeInsetsMake(0.f, 20.f, 0.f, 0.f);
    self.buttonConfirm.alpha = 0.f;
    [confirmView addSubview:self.buttonConfirm];
    UIImageView * imageButton = [[UIImageView alloc] initWithFrame:CGRectMake(20.f, 8.f, 20.f, 20.f)];
    imageButton.image = [UIImage imageNamed:@"imageConfirm.png"];
    [self.buttonConfirm addSubview:imageButton];
    
    //Маленькая кнпока отмена
    self.buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buttonCancel.frame = CGRectMake(20.f, 10.f, confirmView.frame.size.width / 2 - 25.f, 40.f);
    self.buttonCancel.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_800];
    [self.buttonCancel setTitle:@"Отмена" forState:UIControlStateNormal];
    [self.buttonCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.buttonCancel.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
    [self.buttonCancel addTarget:self action:@selector(buttonCancelAction) forControlEvents:UIControlEventTouchUpInside];
    self.buttonCancel.contentEdgeInsets = UIEdgeInsetsMake(0.f, 20.f, 0.f, 0.f);
    self.buttonCancel.alpha = 0.f;
    [confirmView addSubview:self.buttonCancel];
    UIImageView * imageButtonCancel = [[UIImageView alloc] initWithFrame:CGRectMake(20.f, 10.f, 20.f, 20.f)];
    imageButtonCancel.image = [UIImage imageNamed:@"imageCancel.png"];
    [self.buttonCancel addSubview:imageButtonCancel];
    

    
    
    return confirmView;
}



#pragma mark - Actions

//Сброс фильта цены
- (void) buttonCanselPriceAction: (UIButton*) button {

    self.slider.lowerValue = self.minPrice;
    self.slider.upperValue = self.maxPrice;
    
    self.labelFrom.text=[NSString stringWithFormat:@"ОТ %i", (int)self.minPrice];
    self.labelTo.text=[NSString stringWithFormat:@"ДО %i", (int)self.maxPrice];

    [UIView animateWithDuration:0.3 animations:^{
        button.alpha = 0.f;
    }];
    
    self.counter -= 1;
    self.sliderBool = NO;
    
    
    [self buttonActionCheck];
    
}

//Кнопки выбора размера
- (void) buttonSizeAction: (CustomButton*) button {
    for (int i = 0; i < self.arraySize.count; i++) {
        if (button.tag == 10 + i) {
            if (!button.isBool) {
                self.countSize += 1;
                if (!self.sizeBool) {
                    self.counter += 1;
                    self.sizeBool = YES;
                }
                [UIView animateWithDuration:0.3f animations:^{
                    button.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_800];
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                } completion:^(BOOL finished) {
                    button.isBool = YES;
                    if (self.buttonCanselSize.alpha == 0.f) {
                        [UIView animateWithDuration:0.3 animations:^{
                            self.buttonCanselSize.alpha = 1.f;
                        }];
                    }
                }];
            } else {
                self.countSize -= 1;
                [UIView animateWithDuration:0.3f animations:^{
                    button.backgroundColor = [UIColor whiteColor];
                    [button setTitleColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_800] forState:UIControlStateNormal];
                } completion:^(BOOL finished) {
                    button.isBool = NO;
                }];
            }
        }
    }
    if(self.countSize==0){
        [UIView animateWithDuration:0.3 animations:^{
            self.buttonCanselSize.alpha = 0.f;
        }];
        if (self.sizeBool) {
            self.counter -= 1;
            self.sizeBool = NO;
        }
    }
    
    
    [self buttonActionCheck];
}

//Отмена всех размеров
- (void) buttonCanselSizeAction: (UIButton*) button {
    self.countSize = 0;
    for (int i = 0; i < self.arraySize.count; i++) {
        CustomButton * allButtons = (CustomButton*)[self viewWithTag:10 + i];
        allButtons.isBool = NO;
        [UIView animateWithDuration:0.3 animations:^{
            allButtons.backgroundColor = [UIColor whiteColor];
            [allButtons setTitleColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_800] forState:UIControlStateNormal];
            self.buttonCanselSize.alpha = 0.f;
        }];
    }
    
    self.counter -= 1;
    self.sizeBool = NO;
    
    [self buttonActionCheck];
}

//Кнопка выбора цвета
- (void) buttonColorAction: (ColorButton*) button {
    for (int i = 0; i < self.arrayColor.count; i++) {
        if (button.tag == 100 + i) {
            if (!button.isBool) {
                self.countColor += 1;
                if (!self.colorBool) {
                    self.counter += 1;
                    self.colorBool = YES;
                }
                [UIView animateWithDuration:0.3f animations:^{
                    button.alpha = 0.3;
                } completion:^(BOOL finished) {
                    button.isBool = YES;
                    if (self.buttonCanselColor.alpha == 0.f) {
                        [UIView animateWithDuration:0.3 animations:^{
                            self.buttonCanselColor.alpha = 1.f;
                        }];
                    }
                }];
            } else {
                self.countColor -= 1;
                [UIView animateWithDuration:0.3f animations:^{
                    button.alpha = 1.f;
                } completion:^(BOOL finished) {
                    button.isBool = NO;
                }];
            }
        }
    }
    if(self.countColor == 0){
        [UIView animateWithDuration:0.3 animations:^{
            self.buttonCanselColor.alpha = 0.f;
        }];
        if (self.colorBool) {
            self.counter -= 1;
            self.colorBool = NO;
        }
    }
    
    [self buttonActionCheck];
}

//Отмена всех цветоа
- (void) buttonCanselColorAction: (UIButton*) button {
    self.countColor = 0;
    for (int i = 0; i < self.arrayColor.count; i++) {
        ColorButton * allButtons = (ColorButton*)[self viewWithTag:100 + i];
        allButtons.isBool = NO;
        [UIView animateWithDuration:0.3 animations:^{
            allButtons.alpha = 1.f;
            self.buttonCanselColor.alpha = 0.f;
        }];
    }
    
    self.counter -= 1;
    self.colorBool = NO;
    
    [self buttonActionCheck];
}

//Кнопки выбора деталей------
- (void) buttonDetailAction: (CustomButton*) button {
    for (int i = 0; i < self.arrayDetailButtons.count; i++) {
        NSMutableDictionary * dict = [self.arrayDetailButtons objectAtIndex:i]; //Дикшенери для хранения всех элементов
        NSMutableArray * arrayDetail = [dict objectForKey:@"buttonArray"]; //Массив кнопок каждой детали
        NSInteger countDetail = [[dict objectForKey:@"count"] integerValue]; //Счетчик нажатых кнопок
        UIButton * buttonCancel = [dict objectForKey:@"cancel"];
        BOOL boolDetail = [[dict objectForKey:@"bool"] boolValue];
        for (int j = 0; j < arrayDetail.count; j++) {
            if ([button isEqual:[arrayDetail objectAtIndex:j]]) {
                if (!button.isBool) {
                    countDetail += 1;
                    if (!boolDetail) {
                        self.counter += 1;
                        [dict setObject:[NSNumber numberWithBool:YES] forKey:@"bool"];
                    }
                    [dict setObject:[NSNumber numberWithInteger:countDetail] forKey:@"count"];
                    [UIView animateWithDuration:0.3f animations:^{
                        button.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_800];
                        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    } completion:^(BOOL finished) {
                        button.isBool = YES;
                        if (buttonCancel.alpha == 0.f) {
                            [UIView animateWithDuration:0.3 animations:^{
                                buttonCancel.alpha = 1.f;
                            }];
                        }
                    }];
                } else {
                    countDetail -= 1;
                    [dict setObject:[NSNumber numberWithInteger:countDetail] forKey:@"count"];
                    [UIView animateWithDuration:0.3f animations:^{
                        button.backgroundColor = [UIColor whiteColor];
                        [button setTitleColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_800] forState:UIControlStateNormal];
                    } completion:^(BOOL finished) {
                        button.isBool = NO;
                    }];
                }
            }
            NSInteger count = [[dict objectForKey:@"count"] integerValue];
            if(count == 0){
                [UIView animateWithDuration:0.3 animations:^{
                    buttonCancel.alpha = 0.f;
                }];
                if ([[dict objectForKey:@"bool"] boolValue]) {
                    self.counter -= 1;
                    [dict setObject:[NSNumber numberWithBool:NO] forKey:@"bool"];
                }
            }
        }
    }
    
    [self buttonActionCheck];
}

//Сброс активнеости в каждой детали
- (void) buttonCanselDetailAction: (UIButton*) button {
    for (int i = 0; i < self.arrayDetailButtons.count; i++) {
        if (button.tag == 1000 + i) {
            NSMutableDictionary * dict = [self.arrayDetailButtons objectAtIndex:i];
            [dict setObject:[NSNumber numberWithInteger:0] forKey:@"count"];
            [dict setObject:[NSNumber numberWithBool:NO] forKey:@"bool"];
            self.counter -= 1;
            NSMutableArray * arrayButtons = [dict objectForKey:@"buttonArray"];
            for (CustomButton * ctButton in arrayButtons) {
                ctButton.isBool = NO;
                [UIView animateWithDuration:0.3 animations:^{
                    ctButton.backgroundColor = [UIColor whiteColor];
                    [ctButton setTitleColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_800] forState:UIControlStateNormal];
                    button.alpha = 0.f;
                }];
            }
        }
    }
    
    [self buttonActionCheck];
}



//Подтверждение всех фильтров и возврат назад
- (void) buttonConfirmAction {
    [self.delegate backTuCatalog:self];
}

//Отмена всех фильтров
- (void) buttonCancelAction {
    self.countColor = 0;
    self.countSize = 0;
    self.slider.lowerValue = self.minPrice;
    self.slider.upperValue = self.maxPrice;
    self.labelFrom.text=[NSString stringWithFormat:@"ОТ %i", (int)self.minPrice];
    self.labelTo.text=[NSString stringWithFormat:@"ДО %i", (int)self.maxPrice];
    self.counter = 0;
    self.sizeBool = NO;
    self.sliderBool = NO;
    self.colorBool = NO;
    
    for (int i = 0; i < self.arrayDetailButtons.count; i++) {
        NSMutableDictionary * dict = [self.arrayDetailButtons objectAtIndex:i];
        [dict setObject:[NSNumber numberWithInteger:0] forKey:@"count"];
        [dict setObject:[NSNumber numberWithBool:NO] forKey:@"bool"];
    }
    for (int i = 0; i < self.arrayAllButtons.count; i++) {
        if ([[self.arrayAllButtons objectAtIndex:i] isKindOfClass:[CustomButton class]]) {
            CustomButton * buttonText = [self.arrayAllButtons objectAtIndex:i];
            [UIView animateWithDuration:0.3 animations:^{
                buttonText.backgroundColor = [UIColor whiteColor];
                [buttonText setTitleColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_800] forState:UIControlStateNormal];
            } completion:^(BOOL finished) {
                buttonText.isBool = NO;
            }];
        } else if ([[self.arrayAllButtons objectAtIndex:i] isKindOfClass:[ColorButton class]]) {
            ColorButton * buttonColor = [self.arrayAllButtons objectAtIndex:i];
            [UIView animateWithDuration:0.3 animations:^{
                buttonColor.alpha = 1.f;
            } completion:^(BOOL finished) {
                buttonColor.isBool = NO;
            }];
        }
    }
    for (NSMutableDictionary * dict in self.arrayAllButtonsCancel) {
        if ([dict objectForKey:@"button"]) {
            UIButton * button = [dict objectForKey:@"button"];
            [UIView animateWithDuration:0.3 animations:^{
                button.alpha = 0.f;
            }];
        }
    }
    
    
    [self buttonActionCheck];
    
}

#pragma mark - Slider

- (void) configureMetalThemeForSlider:(NMRangeSlider*) slider
{
    UIImage* image = nil;
    image = [UIImage imageNamed:@"slideTrack.png"];
    image = [self imageWithImage:image scaledToSize:CGSizeMake(image.size.width / 2, image.size.height / 2)];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 7.0, 0.0, 7.0)];
    slider.trackImage = image;
    
    image = [UIImage imageNamed:@"slideTuch.png"];
    image = [self imageWithImage:image scaledToSize:CGSizeMake(image.size.width / 2, image.size.height / 2)];
    image = [image imageWithAlignmentRectInsets:UIEdgeInsetsMake(-1, 2, 1, 2)];
    slider.lowerHandleImageNormal = image;
    slider.upperHandleImageNormal = image;
    
    image = [UIImage imageNamed:@"sliderTuchUp.png"];
    image = [self imageWithImage:image scaledToSize:CGSizeMake(image.size.width / 2, image.size.height / 2)];
    image = [image imageWithAlignmentRectInsets:UIEdgeInsetsMake(-1, 2, 1, 2)];
    slider.lowerHandleImageHighlighted = image;
    slider.upperHandleImageHighlighted = image;
}

- (void) configureSlider
{
    
    [self configureMetalThemeForSlider:self.slider];
    self.slider.minimumValue = [[self.dictData objectForKey:@"cost_min_orig"] floatValue];
    self.slider.maximumValue = [[self.dictData objectForKey:@"cost_max_orig"] floatValue];
    self.minPrice=[[self.dictData objectForKey:@"cost_min_orig"] floatValue];
    self.maxPrice=[[self.dictData objectForKey:@"cost_max_orig"] floatValue];

    self.slider.lowerValue = [[self.dictData objectForKey:@"cost_min_orig"] floatValue];
    self.slider.upperValue = [[self.dictData objectForKey:@"cost_max_orig"] floatValue];

    
    float range =self.slider.maximumValue * 0.1;
    
    self.slider.minimumRange = range;
}

- (void) sliderChange: (NMRangeSlider*) slider {

    
    if (self.slider.lowerValue > [[self.dictData objectForKey:@"cost_min_orig"] floatValue]
        || self.slider.upperValue < [[self.dictData objectForKey:@"cost_max_orig"] floatValue]) {
        [UIView animateWithDuration:0.3 animations:^{
            self.buttonCanselPrice.alpha = 1.f;
            
            if (!self.sliderBool) {
                self.counter += 1;
                self.sliderBool = YES;
            }
            
        }];
    } else {
        if (self.buttonCanselPrice.alpha == 1.f) {
            [UIView animateWithDuration:0.3 animations:^{
                self.buttonCanselPrice.alpha = 0.f;
            }];
        }
        if (self.sliderBool) {
            self.counter -= 1;
            self.sliderBool = NO;
        }
    }
    self.labelFrom.text = [NSString stringWithFormat:@"ОТ %d", (NSInteger)self.slider.lowerValue];
    [self.labelFrom sizeToFit];
    self.labelTo.text = [NSString stringWithFormat:@"ДО %d", (NSInteger)self.slider.upperValue];
    
    
    [self buttonActionCheck];
}

#pragma mark - Other

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void) buttonActionCheck {
    if (self.counter > 1) {
        [UIView animateWithDuration:0.3 animations:^{
            self.bigButtonConfirm.alpha = 0.f;
            self.buttonConfirm.alpha = 1.f;
            self.buttonCancel.alpha = 1.f;
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            self.bigButtonConfirm.alpha = 1.f;
            self.buttonConfirm.alpha = 0.f;
            self.buttonCancel.alpha = 0.f;
        }];
    }
}


@end
