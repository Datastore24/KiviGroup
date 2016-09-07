//
//  FormalizationView.m
//  Sadovod
//
//  Created by Виктор Мишустин on 05/09/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "FormalizationView.h"
#import "CustomLabels.h"
#import "Macros.h"
#import "HexColors.h"
#import "InputTextView.h"
#import "UIView+BorderView.h"
#import "CustomButton.h"

@interface FormalizationView() <UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

//Main
@property (strong, nonatomic) UIScrollView * mainScrollView;
@property (strong, nonatomic) NSMutableArray * arrayView; //массив всех вью

//TypeBuyer

@property (strong, nonatomic) UIView * viewBuyer;
@property (assign, nonatomic) BOOL chooseButton; //Какое физ лицо выбранно

//PersonalData

@property (strong, nonatomic) UIView * viewPersonalData;
@property (strong, nonatomic) UIView * whiteViewPerson;

//Address

@property (strong, nonatomic) UIView * viewaArddress;
@property (strong, nonatomic) CustomLabels * labelNumberWords; //Лейбл отображает колличество введенных символов

//DelivaryTypes

@property (strong, nonatomic) UIView * viewDeliveryTypes;
@property (strong, nonatomic) UIView * whiteViewDelivery;
@property (strong, nonatomic) UIPickerView * counterPicker;
@property (strong, nonatomic) NSMutableArray * arrayForPickerViewUpper;
@property (strong, nonatomic) NSMutableArray * arrayForPickerViewLower;
@property (assign, nonatomic) NSInteger pickerCountUpper; //значение выдаваемое при скроле пикера
@property (assign, nonatomic) NSInteger pickerCountLower; //значение выдаваемое при скроле пикера
@property (assign, nonatomic) BOOL isScrollPicker; //Значение когда пикер скролиться

@property (strong, nonatomic) UIView * viewFone; //Фоновое вью для блокировки действий
@property (strong, nonatomic) UIView * viewCounter; //Счетчик
@property (assign, nonatomic) BOOL pickerChenge; //Выбор нужного пикера    YES -- с какого времени    NO -- по какое
@property (assign, nonatomic) NSInteger customTag; //Переменная сохраняет тег выбранной кнопки времени;

@property (assign, nonatomic) NSInteger rowUpper; //Параметр хранит выбранное значение пикера для времени ОТ
@property (assign, nonatomic) NSInteger rowLower; //Параметр хранит выбранное значение пикера для времени ДО

@property (assign, nonatomic) NSInteger rowUppTag;

//DelivaryCompany

@property (strong, nonatomic) UIView * viewDeliveryCompany;

@end



@implementation FormalizationView

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data
{
    self = [super init];
    if (self) {
        
        self.isScrollPicker=NO;
        self.frame = CGRectMake(0.f, 0.f, view.frame.size.width, view.frame.size.height);
        self.arrayView = [[NSMutableArray alloc] init];
        self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
        self.mainScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.mainScrollView.contentSize = CGSizeMake(0, 1300);
        [self addSubview:self.mainScrollView];
        
        
        //View Buyer
        self.viewBuyer = [self createBuyerView];
        [self.mainScrollView addSubview:self.viewBuyer];
        [self.arrayView addObject:self.viewBuyer];
        
        //View PersonalData
        self.viewPersonalData = [self createPesonalData];
        [self.mainScrollView addSubview:self.viewPersonalData];
        [self.arrayView addObject:self.viewPersonalData];
        
        [self animationUpPersonalData]; //Прячем существующее вью ввода названия организации
        
        //View Address
        self.viewaArddress = [self createAddress];
        [self.mainScrollView addSubview:self.viewaArddress];
        [self.arrayView addObject:self.viewaArddress];
        
        //View Delivery Types
        self.viewDeliveryTypes = [self createDeliveryTypesView];
        [self.mainScrollView addSubview:self.viewDeliveryTypes];
        [self.arrayView addObject:self.viewDeliveryTypes];
        [self customHideViewWithHeight:70.f andView:self.whiteViewDelivery andNumberParams:3 andBool:YES andDuraction:0.f];
        
        //View Delivery Company
        self.viewDeliveryCompany = [self createDelivaryCompanyView];
        [self.mainScrollView addSubview:self.viewDeliveryCompany];
        [self.arrayView addObject:self.viewDeliveryCompany];
        
        //СКРЫТЫЕ ДОП ЭЛЕМЕНТЫ-----------
        self.viewFone = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.viewFone.backgroundColor = [UIColor blackColor];
        self.viewFone.alpha = 0.f;
        [self addSubview:self.viewFone];
        
        //CounterView
        self.viewCounter = [self createCounterView];
        self.viewCounter.alpha = 0.f;
        [self addSubview:self.viewCounter];
        
    }
    return self;
}

#pragma mark TypeBuyer

- (UIView*) createBuyerView {
    
    UIView * whiteViewBuyer = [[UIView alloc] init];
    self.chooseButton = YES;
    UIView * buyerView = [self customViewWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, 130) andTitlName:@"Тип плательщика" andView:whiteViewBuyer andBlock:^{
        NSArray * arrayNameTitl = [NSArray arrayWithObjects:@"Физическое лицо", @"Юридическое лицо", nil];
        for (int i = 0; i < 2; i++) {
            UIButton * buttonFace = [UIButton buttonWithType:UIButtonTypeCustom];
            buttonFace.tag = 5 + i;
            buttonFace.frame = CGRectMake(0.f, 0.f + (whiteViewBuyer.frame.size.height / 2) * i, whiteViewBuyer.frame.size.width, whiteViewBuyer.frame.size.height / 2);
            [buttonFace addTarget:self action:@selector(buttonFaceAction:) forControlEvents:UIControlEventTouchUpInside];
            [buttonFace setImage:[UIImage imageNamed:@"buttonBuyerYes.png"] forState:UIControlStateSelected];
            buttonFace.userInteractionEnabled = NO;
            [whiteViewBuyer addSubview:buttonFace];
            
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10.f, 10.f, 20.f, 20.f)];
            imageView.image = [UIImage imageNamed:@"buttonFaceYes.png"];
            if (i == 1) {
                imageView.image = [UIImage imageNamed:@"buttonFaceNo.png"];
                buttonFace.userInteractionEnabled = YES;
            }
            imageView.tag = 10 + i;
            [buttonFace addSubview:imageView];
            
            CustomLabels * labelButtons = [[CustomLabels alloc] initLabelWithWidht:40.f andHeight:14 andColor:@"000000"
                                                                           andText:[arrayNameTitl objectAtIndex:i] andTextSize:15 andLineSpacing:0.f fontName:VM_FONT_REGULAR];
            [buttonFace addSubview:labelButtons];
        }
    }];
    return buyerView;
}

#pragma mark - PersonalData

- (UIView*) createPesonalData {
    self.whiteViewPerson = [[UIView alloc] init];
    self.whiteViewPerson.clipsToBounds = YES;
    UIView * personalDataView = [self customViewWithFrame:CGRectMake(0.f, self.viewBuyer.frame.size.height, self.frame.size.width, 210) andTitlName:@"Личные Данные" andView:self.whiteViewPerson andBlock:^{
        
        NSArray * arrayPlaysHolders = [NSArray arrayWithObjects:@"Имя получателя, только имя *", @"Телефон", @"Email *", @"Название организации *", nil];
        for (int i = 0; i < 4; i++) {
            InputTextView * inputText = [[InputTextView alloc] initInputTextWithView:self.whiteViewPerson
                                                                             andRect:CGRectMake(0.f, 0.f + (40) * i, self.whiteViewPerson.frame.size.width, 40) andImage:nil
                                                                  andTextPlaceHolder:[arrayPlaysHolders objectAtIndex:i] colorBorder:nil];
            inputText.textFieldInput.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
            inputText.textFieldInput.textColor = [UIColor blackColor];
            inputText.labelPlaceHoldInput.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
            inputText.labelPlaceHoldInput.textColor = [UIColor lightGrayColor];
            if (i == 1) {
                inputText.textFieldInput.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            } else if (i == 2) {
                inputText.textFieldInput.keyboardType = UIKeyboardTypeEmailAddress;
            }
            [self.whiteViewPerson addSubview:inputText];
            
            [UIView borderViewWithHeight:38.5f andWight:0 andView:inputText andColor:@"efeff4" andHieghtBorder:1.5f];
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputTextStart) name:UITextFieldTextDidBeginEditingNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputTextEnd) name:UITextFieldTextDidEndEditingNotification object:nil];
        
        
        
    }];
    return personalDataView;
}

#pragma mark - Address

- (UIView*) createAddress {
    UIView * whiteViewAddress = [[UIView alloc] init];
    UIView * addressDataView = [self customViewWithFrame:CGRectMake(0.f, self.viewPersonalData.frame.size.height + self.viewPersonalData.frame.origin.y - 40.f, self.frame.size.width, 170) andTitlName:@"Адрес доставки *" andView:whiteViewAddress andBlock:^{
        
        UITextView * textView = [[UITextView alloc] initWithFrame:CGRectMake(10.f, 10.f, whiteViewAddress.frame.size.width - 20.f, whiteViewAddress.frame.size.height - 20.f)];
        textView.textColor = [UIColor blackColor];
        textView.delegate = self;
        textView.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
//        textView.autocorrectionType = UITextAutocorrectionTypeNo;
        [whiteViewAddress addSubview:textView];
        
    }];
    
    self.labelNumberWords = [[CustomLabels alloc] initLabelTableWithWidht:self.frame.size.width - 80.f andHeight:13.f andSizeWidht:60.f andSizeHeight:20.f andColor:VM_COLOR_300 andText:@"200"];
    self.labelNumberWords.font = [UIFont fontWithName:VM_FONT_BEAU_SANS_LITE size:13];
    self.labelNumberWords.textAlignment = NSTextAlignmentRight;
    [addressDataView addSubview:self.labelNumberWords];
    
    return addressDataView;
}

#pragma mark - DeliveryTypes

- (UIView*) createDeliveryTypesView {
    self.whiteViewDelivery = [[UIView alloc] init];
    self.whiteViewDelivery.clipsToBounds = YES;
    UIView * deliveryTypesView = [self customViewWithFrame:CGRectMake(0.f, self.viewaArddress.frame.size.height + self.viewaArddress.frame.origin.y, self.frame.size.width, 250)andTitlName:@"Способы доставки *" andView:self.whiteViewDelivery andBlock:^{
        
        [self animathionMethodUpAndDownWithView:self.whiteViewDelivery endHieght:20.f andUpAndDown:NO addOther:^{
        }];  //Смещение белого центра вниз
        
        CustomButton * buttonMoscow = [self buttonCreatePush];
        buttonMoscow.tag = 20;
        [buttonMoscow addTarget:self action:@selector(buttonMoscow:) forControlEvents:UIControlEventTouchUpInside];
        buttonMoscow.isBool = NO;
        [self.whiteViewDelivery addSubview:buttonMoscow];
        
        CustomLabels * deliveryNameLabel = [[CustomLabels alloc] initLabelWithWidht:34.f andHeight:18.f andColor:@"000000" andText:@"Курьерская доставка" andTextSize:15 andLineSpacing:0.f fontName:VM_FONT_REGULAR];
        [self.whiteViewDelivery addSubview:deliveryNameLabel];
        
        CustomLabels * labelText = [[CustomLabels alloc] initLabelTableWithWidht:10.f andHeight:40.f
                                                                    andSizeWidht:self.whiteViewDelivery.frame.size.width - 20 andSizeHeight:60 andColor:@"787878"
                                                                         andText:@"Стоимость - 450 руб. в пределах МКАД \nЗа МКАД курьерская доставка не\nосуществляется"];
        labelText.numberOfLines = 3;
        labelText.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
        labelText.textAlignment = NSTextAlignmentLeft;
        [self.whiteViewDelivery addSubview:labelText];
        
        CustomLabels * labelCutsiv = [[CustomLabels alloc] initLabelTableWithWidht:10.f andHeight:80.f
                                                                    andSizeWidht:self.whiteViewDelivery.frame.size.width - 20 andSizeHeight:60 andColor:@"787878"
                                                                         andText:@"Доставка осуществляется в течении \nдня в удобное для вас время"];
        labelCutsiv.numberOfLines = 2;
        labelCutsiv.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
        labelCutsiv.textAlignment = NSTextAlignmentLeft;
        [self.whiteViewDelivery addSubview:labelCutsiv];
        
        CustomLabels * chooseLabel = [[CustomLabels alloc] initLabelWithWidht:10.f andHeight:132.f andColor:@"000000" andText:@"Выберите желаемое время" andTextSize:15 andLineSpacing:0.f fontName:VM_FONT_REGULAR];
        [self.whiteViewDelivery addSubview:chooseLabel];
        
        NSArray * arrayNumberTime = [NSArray arrayWithObjects:@"9", @"19", nil];
        for (int i = 0; i < 2; i++) {
            UIButton * buttonChooseTime = [UIButton buttonWithType:UIButtonTypeCustom];
            buttonChooseTime.frame = CGRectMake(25.f + 120.f * i, 160.f, 90.f, 30);
            buttonChooseTime.backgroundColor = [UIColor groupTableViewBackgroundColor];
            buttonChooseTime.layer.borderColor = [UIColor lightGrayColor].CGColor;
            buttonChooseTime.layer.borderWidth = 0.3f;
            buttonChooseTime.layer.cornerRadius = 5.f;
            buttonChooseTime.layer.shadowColor = [[UIColor blackColor] CGColor];
            buttonChooseTime.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
            buttonChooseTime.layer.shadowRadius = 1.0f;
            buttonChooseTime.layer.shadowOpacity = 0.5f;
            buttonChooseTime.tag = 100 + i;
            [buttonChooseTime addTarget:self action:@selector(buttonChooseTimeAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.whiteViewDelivery addSubview:buttonChooseTime];
            
            CustomLabels * chooseLabelTime = [[CustomLabels alloc] initLabelWithWidht:25.f andHeight:8.f andColor:@"000000" andText:[arrayNumberTime objectAtIndex:i] andTextSize:15 andLineSpacing:0.f fontName:VM_FONT_REGULAR];
            chooseLabelTime.tag = 110 + i;
            [buttonChooseTime addSubview:chooseLabelTime];
        }
        NSArray * arrayNameLabelTime = [NSArray arrayWithObjects:@"c", @"по", @"часов", nil];
        for (int i = 0; i < 3; i++) {
            CustomLabels * chooseLabelTime = [[CustomLabels alloc] initLabelWithWidht:10.f + 117 * i andHeight:168.f andColor:@"000000" andText:[arrayNameLabelTime objectAtIndex:i] andTextSize:15 andLineSpacing:0.f fontName:VM_FONT_REGULAR];
            if (i == 1) {
                [self animathionMethodLeftAndRightnWithView:chooseLabelTime endHieght:4.f andUpAndDown:YES addOther:^{}];
            }
            [self.whiteViewDelivery addSubview:chooseLabelTime];
        }
    }];
    
    CustomLabels * labelRegion = [[CustomLabels alloc] initLabelTableWithWidht:0.f andHeight:35 andSizeWidht:self.frame.size.width andSizeHeight:20 andColor:@"000000" andText:@"МОСКВА"];
    labelRegion.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
    labelRegion.textAlignment = NSTextAlignmentCenter;
    [deliveryTypesView addSubview:labelRegion];
    
    
    return deliveryTypesView;
}

#pragma mark - Delivery Company

- (UIView*) createDelivaryCompanyView {
    UIView * whiteViewCompany = [[UIView alloc] init];
    UIView * deliveryCompanyView = [self customViewWithFrame:CGRectMake(0.f, self.viewDeliveryTypes.frame.size.height + self.viewDeliveryTypes.frame.origin.y - 70, self.frame.size.width, 170) andTitlName:@"" andView:whiteViewCompany andBlock:^{
    
    
    
    
    
    
    }];
    
    
    return deliveryCompanyView;
    
}



#pragma mark - PickerViewTime

- (UIView*) createCounterView {
    UIView * counterView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 130.f, self.frame.size.height / 2 - 130.f, 260.f, 300.f)];
    counterView.backgroundColor = [UIColor whiteColor];
    counterView.layer.cornerRadius = 5.f;
    
    CustomLabels * labelTitl = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:20.f andSizeWidht:240.f andSizeHeight:80.f andColor:@"808080" andText:@"Выберите время доставки"];
    labelTitl.numberOfLines = 0.f;
    labelTitl.textAlignment = NSTextAlignmentLeft;
    labelTitl.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
    [labelTitl sizeToFit];
    [counterView addSubview:labelTitl];
    
    self.rowLower = 10;
    self.rowUpper = 0;
    self.arrayForPickerViewUpper = [NSMutableArray arrayWithObjects:@"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", nil];
    self.arrayForPickerViewLower = [NSMutableArray arrayWithObjects:@"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", nil];

    
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


#pragma mark - Notifications
//Действие переl вводом данных в TextField
- (void) inputTextStart {
    [self animathionMethodUpAndDownWithView:self.mainScrollView endHieght:50.f andUpAndDown:YES addOther:^{
        self.mainScrollView.contentOffset = CGPointMake(0.f, 20.f);
    }];
    
}
//Действие после воода данных в TextField
- (void) inputTextEnd {
    [self animathionMethodUpAndDownWithView:self.mainScrollView endHieght:50.f andUpAndDown:NO addOther:^{
        
    }];
}


#pragma mark - Actions
//Выбор типа покупателя (юр лицо или физ лицо)
- (void) buttonFaceAction: (UIButton*) button {
    UIButton * buttonOne = [self viewWithTag:5];
    UIButton * buttonTwo = [self viewWithTag:6];
    UIImageView * imageViewOne = [self viewWithTag:10];
    UIImageView * imageViewTwo = [self viewWithTag:11];
    
    if (button.tag == 5) {
        buttonOne.userInteractionEnabled = NO;
        buttonTwo.userInteractionEnabled = YES;
        self.chooseButton = YES;
        [UIView animateWithDuration:0.3 animations:^{
            imageViewOne.image = [UIImage imageNamed:@"buttonFaceYes.png"];
            imageViewTwo.image = [UIImage imageNamed:@"buttonFaceNo.png"];
            [self animationUpPersonalData];
        }];
    } else if (button.tag == 6) {
        buttonOne.userInteractionEnabled = YES;
        buttonTwo.userInteractionEnabled = NO;
        self.chooseButton = NO;
        [UIView animateWithDuration:0.3 animations:^{
            imageViewOne.image = [UIImage imageNamed:@"buttonFaceNo.png"];
            imageViewTwo.image = [UIImage imageNamed:@"buttonFaceYes.png"];
            [self animationDownPersonalData];

        }];
    }
}

//Выбор премени доставки товара
- (void) buttonChooseTimeAction: (UIButton*) button {
        self.isScrollPicker = NO;
    
        if (button.tag == 100) {
            self.customTag = 0;
            self.pickerChenge = YES;
            
            [self.counterPicker reloadAllComponents];
            [self.counterPicker selectRow:self.rowUpper inComponent:0 animated:NO]; //Выбор ячейки пикера по сохраненным значениям
            self.rowUppTag = self.rowUpper;

        } else if (button.tag == 101) {
            self.customTag = 1;
            self.pickerChenge = NO;
            [self.counterPicker reloadAllComponents];
            [self.counterPicker selectRow:self.rowLower inComponent:0 animated:NO]; //Выбор ячейки пикера по сохраненным значениям
        }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.viewFone.alpha = 0.4f;
        self.viewCounter.alpha = 1.f;
    }];

}

//Метод для отмены пикера
- (void) buttonCancel{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.viewFone.alpha = 0.f;
        self.viewCounter.alpha = 0.f;
    }];
}

//Подтверждение кол-ва товара или отмена выбранного колличества
- (void) buttonPickerAction: (UIButton*) button {

    if (button.tag == 1000) {
        [self buttonCancel];
    } else if (button.tag == 1001) {
        if(self.isScrollPicker){
        UILabel * label = (UILabel*)[self viewWithTag:110 + self.customTag];
        if (self.pickerChenge) {
            self.rowUpper = self.pickerCountUpper; //Сохранение выбранного параметра пикера в пикере
            label.text = [self.arrayForPickerViewUpper objectAtIndex:self.pickerCountUpper]; //Изменение текста лейбла в зависимости от пикера
            [label sizeToFit];
            
            self.rowUppTag = self.rowUppTag - self.rowUpper; //Сохранение параметров выбраных в самом пикере
            self.rowLower += self.rowUppTag;
            
            //У нас есть всегда от 9 до ограничения второго пикера
 
            [self.arrayForPickerViewLower removeAllObjects]; //Перерисовываем массив
            NSLog(@"PICK: %d",[[self.arrayForPickerViewUpper objectAtIndex:self.pickerCountUpper] integerValue]);
    
            for(int i= [[self.arrayForPickerViewUpper objectAtIndex:self.pickerCountUpper] integerValue]; i<23; i++){
                NSString * stringNumber = [NSString stringWithFormat:@"%d", i];
                
                [self.arrayForPickerViewLower addObject:stringNumber];
                
            }
            
            
        } else {
            self.rowLower = self.pickerCountLower; //Сохранение выбранного параметра пикера в пикере (2 параметра смотря какой пикер)
 
            
            label.text = [self.arrayForPickerViewLower objectAtIndex:self.pickerCountLower]; //Изменение текста лейбла в зависимости от пикера
            [label sizeToFit];

                [self.arrayForPickerViewUpper removeAllObjects]; //Перерисовываем массив
           
            for(int i=9; i<=[[self.arrayForPickerViewLower objectAtIndex:self.pickerCountLower] integerValue]; i++){
                NSString * stringNumber = [NSString stringWithFormat:@"%d", i];

                [self.arrayForPickerViewUpper addObject:stringNumber];
                
            }
         
           

        }
        [UIView animateWithDuration:0.3 animations:^{
            self.viewFone.alpha = 0.f;
            self.viewCounter.alpha = 0.f;
        }];
            
        }else{
            [self buttonCancel];
            
        }
    }
    

}

//Выбор доставки курьером
- (void) buttonMoscow: (CustomButton*) button {
    if (!button.isBool) {
        [UIView animateWithDuration:0.3 animations:^{
            button.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_400];
            button.layer.borderColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_400].CGColor;
            if (self.chooseButton) {
                self.mainScrollView.contentOffset = CGPointMake(0, 460);
            } else {
                self.mainScrollView.contentOffset = CGPointMake(0, 500);
            }
            
        }];
        [self customHideViewWithHeight:70.f andView:self.whiteViewDelivery andNumberParams:3 andBool:NO andDuraction:0.3];
        button.isBool = YES;
    }
}


#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]) {
        [self animathionMethodUpAndDownWithView:self.mainScrollView endHieght:200.f andUpAndDown:NO addOther:^{
            
        }];
        [textView resignFirstResponder];
        return NO;
    }
    NSUInteger newLength = (textView.text.length - range.length) + text.length;
    NSInteger labelCount = 200 - newLength;
    self.labelNumberWords.text = [NSString stringWithFormat:@"%d", labelCount];
    if(newLength <= 199)
    {
        return YES;
    } else {
        NSUInteger emptySpace = 199 - (textView.text.length - range.length);
        textView.text = [[[textView.text substringToIndex:range.location]
                          stringByAppendingString:[text substringToIndex:emptySpace]]
                         stringByAppendingString:[textView.text substringFromIndex:(range.location + range.length)]];
        return NO;
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self animathionMethodUpAndDownWithView:self.mainScrollView endHieght:200.f andUpAndDown:YES addOther:^{
        self.mainScrollView.contentOffset = CGPointMake(0.f, 40.f);
        
    }];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.pickerChenge) {
        return  self.arrayForPickerViewUpper.count;
    } else {
        return  self.arrayForPickerViewLower.count;
    }
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (self.pickerChenge) {
        return  self.arrayForPickerViewUpper[row];
    } else {
        return  self.arrayForPickerViewLower[row];
    }
}

#pragma mark - UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 60.f;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel * label = nil;
    view = [[UIView alloc] init];
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 260, 60)];
    if (self.pickerChenge) {
        label.text = self.arrayForPickerViewUpper[row];
    } else {
        label.text = self.arrayForPickerViewLower[row];
    }
    label.font = [UIFont fontWithName:VM_FONT_BOLD size:25];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    
    [[pickerView.subviews objectAtIndex:1] setHidden:TRUE];
    [[pickerView.subviews objectAtIndex:2] setHidden:TRUE];
    
    return view;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if(!self.isScrollPicker){
       self.isScrollPicker=YES;
        
    }
    if(self.pickerChenge){
        self.pickerCountUpper=row;
    }else{
        self.pickerCountLower=row;
    }
    
    
}


#pragma mark - Other
//Структура для создания оформления закказа
- (UIView*) customViewWithFrame: (CGRect) frame andTitlName: (NSString*) nameTitl andView: (UIView*) actionView andBlock: (void(^)(void)) block {
    UIView * viewTypeBuyer = [[UIView alloc] initWithFrame:frame];
    
    CustomLabels * labelBuyer = [[CustomLabels alloc] initLabelWithWidht:15.f andHeight:15.f andColor:VM_COLOR_900
                                                                 andText:nameTitl andTextSize:15 andLineSpacing:0.f fontName:VM_FONT_REGULAR];
    [viewTypeBuyer addSubview:labelBuyer];
    
    actionView.frame = CGRectMake(15.f, 40.f, self.frame.size.width - 30.f, viewTypeBuyer.frame.size.height - 50.f);
    actionView.backgroundColor = [UIColor whiteColor];
//    actionView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
//    actionView.layer.borderWidth = 0.3f;
//    actionView.layer.cornerRadius = 2.f;
//    actionView.layer.shadowColor = [[UIColor blackColor] CGColor];
//    actionView.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
//    actionView.layer.shadowRadius = 1.0f;
//    actionView.layer.shadowOpacity = 0.5f;
    [viewTypeBuyer addSubview:actionView];

    block();
    
    return viewTypeBuyer;
}

//Метод понимающий вью вверх
- (void) animathionMethodUpAndDownWithView: (UIView*) viewCust
                               endHieght: (CGFloat) upHieght
                              andUpAndDown: (BOOL) upAndDown
                                  addOther: (void(^)(void)) block {  //Yes - Поднимаем вверх No - Опускаем вниз
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = viewCust.frame;
        if (upAndDown) {
            rect.origin.y -= upHieght;
            block();
        } else {
            rect.origin.y += upHieght;
            block();
        }
        viewCust.frame = rect;
    }];
}

//Метод понимающий вью вверх
- (void) animathionMethodLeftAndRightnWithView: (UIView*) viewCust
                                 endHieght: (CGFloat) upHieght
                              andUpAndDown: (BOOL) upAndDown
                                  addOther: (void(^)(void)) block {  //Yes - в право No - влево
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = viewCust.frame;
        if (upAndDown) {
            rect.origin.x -= upHieght;
            block();
        } else {
            rect.origin.x += upHieght;
            block();
        }
        viewCust.frame = rect;
    }];
}

//Метод анимации для персональных данных
- (void) animationUpPersonalData {
    CGRect rectWhitePerson = self.whiteViewPerson.frame;
    rectWhitePerson.size.height -= 40.f;
    self.whiteViewPerson.frame = rectWhitePerson;
    for (int i = 0; i < self.arrayView.count; i++) {
        UIView * viewBlock = [self.arrayView objectAtIndex:i];
        if (i > 1) {
            CGRect rect = viewBlock.frame;
            rect.origin.y -= 40;
            viewBlock.frame = rect;
        }
    }
}
//Метод анимации для персональных данных
- (void) animationDownPersonalData {
    CGRect rectWhitePerson = self.whiteViewPerson.frame;
    rectWhitePerson.size.height += 40.f;
    self.whiteViewPerson.frame = rectWhitePerson;
    for (int i = 0; i < self.arrayView.count; i++) {
        UIView * viewBlock = [self.arrayView objectAtIndex:i];
        if (i > 1) {
            CGRect rect = viewBlock.frame;
            rect.origin.y += 40;
            viewBlock.frame = rect;
        }
    }
}


//Общий параметр поднятия анимации
- (void) customHideViewWithHeight: (CGFloat) costHeight andView: (UIView*) view andNumberParams: (NSInteger) numbarParams andBool: (BOOL) upAndDown andDuraction: (CGFloat) duraction {
    [UIView animateWithDuration:duraction animations:^{
        CGRect rect = view.frame;
        if (upAndDown) {
            rect.size.height -= costHeight;
        } else {
            rect.size.height += costHeight;
        }
        
        view.frame = rect;
        for (int i = 0; i < self.arrayView.count; i++) {
            UIView * viewBlock = [self.arrayView objectAtIndex:i];
            if (i > numbarParams) {
                CGRect rect = viewBlock.frame;
                if (upAndDown) {
                    rect.origin.y -= costHeight;
                } else {
                    rect.origin.y += costHeight;
                }
                viewBlock.frame = rect;
            }
        }
    } completion:^(BOOL finished){
        
    }];
}


//Метод создания кнопки выбора
- (CustomButton*) buttonCreatePush {
    CustomButton * buttonPush = [CustomButton buttonWithType:UIButtonTypeCustom];
    buttonPush.frame = CGRectMake(10.f, 15.f, 18.f, 18.f);
    buttonPush.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    buttonPush.layer.borderWidth = 2.f;
    buttonPush.layer.cornerRadius = 3.f;
    
    return buttonPush;
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
