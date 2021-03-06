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
#import "UserInfo.h"
#import "UserInfoDbClass.h"
#import "SingleTone.h"
#import "CheckRequiredField.h"

@interface FormalizationView() <UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, InputTextViewDelegate>

//Main
@property (strong, nonatomic) UIScrollView * mainScrollView;
@property (strong, nonatomic) NSMutableArray * arrayView; //массив всех вью
@property (strong, nonatomic) NSDictionary * dictData;
@property (strong, nonatomic) NSArray * arrayDataDelivery;
@property (strong, nonatomic) UserInfo * userInfo;

//TypeBuyer

@property (strong, nonatomic) UIView * viewBuyer;
@property (assign, nonatomic) BOOL chooseButton; //Какое физ лицо выбранно
@property (strong, nonatomic) UIButton * buttonFaceYur;

//PersonalData

@property (strong, nonatomic) UIView * viewPersonalData;
@property (strong, nonatomic) UIView * whiteViewPerson;
@property (strong, nonatomic) UIView * borderViewPerson;

//Address

@property (strong, nonatomic) UIView * viewaArddress;
@property (strong, nonatomic) CustomLabels * labelNumberWords; //Лейбл отображает колличество введенных символов

//DelivaryTypes

@property (strong, nonatomic) UIView * viewDeliveryTypes;
@property (strong, nonatomic) UIView * whiteViewDelivery;
@property (strong, nonatomic) UIPickerView * counterPicker;
@property (strong, nonatomic) UIView * borderDeliveryTypes;
@property (strong, nonatomic) CustomButton * buttonMoscow;
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
@property (strong, nonatomic) UIView * whiteViewCompany;
@property (strong, nonatomic) UIView * borderDeliveryCompany;
@property (assign, nonatomic) CGFloat heightCompany; //Ширина на которую надо сметь вь вверх
@property (strong, nonatomic) CustomButton * buttonCompany;

//DelivetyMain

@property (strong, nonatomic) UIView * whiteMainView;
@property (strong, nonatomic) UIView * viewDelivaryMail;
@property (strong, nonatomic) UIView * borderDeliveryMail;
@property (strong, nonatomic) CustomButton * buttonMail;

//PriceView

@property (strong, nonatomic) UIView * whitePriceView;
@property (strong, nonatomic) UIView * viewPrice;
@property (strong, nonatomic) UIView * viewText;
@property (strong, nonatomic) UIView * borderPriceView;

//Comments View

@property (strong, nonatomic) UILabel * labelNumberComments;
@property (strong, nonatomic) UIView * viewComments;

//OtherView

@property (strong, nonatomic) UIView * viewOther;
@property (strong, nonatomic) CustomLabels * labelDelivery;
@property (strong, nonatomic) CustomLabels * labelDeliveryAction;


//FotTextFilds
@property (strong, nonatomic) NSMutableArray * arrayTextFildFiz; //Массив текст филдов для физического лица
@property (strong, nonatomic) NSMutableArray * arrayTextFildYur; //Массив текст филдов для юридического лица

@end



@implementation FormalizationView

- (instancetype)initWithView: (UIView*) view
                     andData: (NSDictionary*) data
{
    self = [super init];
    if (self) {
        
        UserInfoDbClass * userInfoDbclass = [[UserInfoDbClass alloc] init];
        NSArray * userArray = [userInfoDbclass showAllUsersInfo];
        self.arrayTextFildFiz = [NSMutableArray array];
        self.arrayTextFildYur = [NSMutableArray array];
        
        NSLog(@"COUNT %lu",(unsigned long)userArray.count);
        if(userArray.count>0){
            self.userInfo = (UserInfo *)[userArray objectAtIndex:0];
            NSLog(@"TYPE %@",self.userInfo.us_type);
        }else{
            self.userInfo = nil;
             NSLog(@"USERINFO EMPTY");
        }
        
        
        self.isScrollPicker=NO;
        self.dictData = data;
        self.arrayDataDelivery= [self.dictData objectForKey:@"transport"];
        self.frame = CGRectMake(0.f, 0.f, view.frame.size.width, view.frame.size.height);
        self.arrayView = [[NSMutableArray alloc] init];
        self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 64.f, self.frame.size.width, self.frame.size.height-64.f)];
        self.mainScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.mainScrollView.contentSize = CGSizeMake(0, 1460);
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
        [self customHideViewWithHeight:70.f andView:self.whiteViewDelivery andNumberParams:3 andBool:YES andDuraction:0.f andBorderView:self.borderDeliveryTypes];
        
        //View Delivery Company
        self.viewDeliveryCompany = [self createDelivaryCompanyView];
        [self.mainScrollView addSubview:self.viewDeliveryCompany];
        [self.arrayView addObject:self.viewDeliveryCompany];
        [self customHideViewWithHeight:self.heightCompany andView:self.whiteViewCompany andNumberParams:4 andBool:YES andDuraction:0.f andBorderView:self.borderDeliveryCompany];
        
        //View Delivary Mail
        self.viewDelivaryMail = [self createDeliveryMailView];
        [self.mainScrollView addSubview:self.viewDelivaryMail];
        [self.arrayView addObject:self.viewDelivaryMail];
        [self customHideViewWithHeight:175.f andView:self.whiteMainView andNumberParams:5 andBool:YES andDuraction:0.f andBorderView:self.borderDeliveryMail];
        
        //View Price
        self.viewPrice = [self createPraceView];
        [self.mainScrollView addSubview:self.viewPrice];
        [self.arrayView addObject:self.viewPrice];
        
        //View Comments
        
        self.viewComments = [self createCommentsView];
        [self.mainScrollView addSubview:self.viewComments];
        [self.arrayView addObject:self.viewComments];
        
        //View Other
        
        self.viewOther = [self createOtherView];
        [self.mainScrollView addSubview:self.viewOther];
        [self.arrayView addObject:self.viewOther];
        
        
        //СКРЫТЫЕ ДОП ЭЛЕМЕНТЫ-----------
        self.viewFone = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.viewFone.backgroundColor = [UIColor blackColor];
        self.viewFone.alpha = 0.f;
        [self addSubview:self.viewFone];
        
        //Скрытие ненужных текст филдов
        [self hideTestFildsWithCustomer:YES];
        
        
        
        
        //Counter View
        self.viewCounter = [self createCounterView];
        self.viewCounter.alpha = 0.f;
        [self addSubview:self.viewCounter];
        
        if([self.userInfo.like_delivery integerValue] == 0 && self.userInfo.like_delivery.length !=0){
            [self buttonMoscow:self.buttonMoscow];
        }
        
        if([self.userInfo.like_delivery integerValue] == 1 && self.userInfo.like_delivery.length !=0){
            [self buttonMail:self.buttonMail];
        }
        
        if([self.userInfo.like_delivery integerValue] == 2 && self.userInfo.like_delivery.length !=0){
            [self buttonCompany:self.buttonCompany];
        }
        
        if([self.userInfo.us_type integerValue] == 1){
            [self buttonFaceAction:self.buttonFaceYur];
        }
        
        
        
        self.mainScrollView.contentOffset = CGPointZero;
        
        

        
    }
    return self;
}

#pragma mark TypeBuyer

- (UIView*) createBuyerView {
    
    UIView * whiteViewBuyer = [[UIView alloc] init];
    UIView * viewBorder = [[UIView alloc] init];
    self.chooseButton = YES;
    UIView * buyerView = [self customViewWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, 130) andTitlName:@"Тип плательщика" andView:whiteViewBuyer andBorderView:viewBorder andBlock:^{

        NSArray * arrayNameTitl = [NSArray arrayWithObjects:@"Физическое лицо", @"Юридическое лицо", nil];
        for (int i = 0; i < 2; i++) {
            UIButton * buttonFace = [UIButton buttonWithType:UIButtonTypeCustom];
            buttonFace.tag = 5 + i;
            buttonFace.frame = CGRectMake(0.f, 0.f + (whiteViewBuyer.frame.size.height / 2) * i, whiteViewBuyer.frame.size.width, whiteViewBuyer.frame.size.height / 2);
            [buttonFace addTarget:self action:@selector(buttonFaceAction:) forControlEvents:UIControlEventTouchUpInside];
   
                [buttonFace setImage:[UIImage imageNamed:@"buttonBuyerYes.png"] forState:UIControlStateSelected];
                
            
            
            
            
            [whiteViewBuyer addSubview:buttonFace];
            
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10.f, 10.f, 20.f, 20.f)];
            if(i == 0){
                if([self.userInfo.us_type integerValue]==0){
                   imageView.image = [UIImage imageNamed:@"buttonFaceYes.png"];
                    buttonFace.userInteractionEnabled = NO;
                }else{
                    imageView.image = [UIImage imageNamed:@"buttonFaceNo.png"];
                    buttonFace.userInteractionEnabled = YES;
                }
            }
            
            if (i == 1) {
                if([self.userInfo.us_type integerValue]==1){
                    imageView.image = [UIImage imageNamed:@"buttonFaceYes.png"];
                    
                    self.buttonFaceYur = buttonFace;
                    
                    buttonFace.userInteractionEnabled = NO;
                }else{
                    imageView.image = [UIImage imageNamed:@"buttonFaceNo.png"];
                    buttonFace.userInteractionEnabled = YES;
                }
                
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
    self.borderViewPerson = [[UIView alloc] init];
    self.whiteViewPerson.clipsToBounds = YES;
    UIView * personalDataView = [self customViewWithFrame:CGRectMake(0.f, self.viewBuyer.frame.size.height, self.frame.size.width, 210) andTitlName:@"Личные Данные" andView:self.whiteViewPerson andBorderView:self.borderViewPerson andBlock:^{
        
        NSArray * arrayPlaysHolders = [NSArray arrayWithObjects:@"Имя получателя, только имя *", @"Телефон", @"Email *", @"Название организации *", nil];
        for (int j = 0; j < 2; j++) {
            for (int i = 0; i < 4; i++) {
                InputTextView * inputText = [[InputTextView alloc] initInputTextWithView:self.whiteViewPerson
                                                                                 andRect:CGRectMake(0.f, 0.f + (40) * i, self.whiteViewPerson.frame.size.width, 40) andImage:nil
                                                                      andTextPlaceHolder:[arrayPlaysHolders objectAtIndex:i] colorBorder:nil];
                inputText.delegate = self;
                
                
                if(j==0){
                    switch (i) {
                        case 0:
                            inputText.textFieldInput.text = self.userInfo.ord_name;
                            break;
                        case 1:
                            inputText.textFieldInput.text = self.userInfo.phone;
                            break;
                        case 2:
                            inputText.textFieldInput.text = self.userInfo.email;
            

                        default:
                            break;
                    }
                }else if(j==1){
                    switch (i) {
                        case 0:
                            inputText.textFieldInput.text = self.userInfo.ord_name;
                            break;
                        case 1:
                            inputText.textFieldInput.text = self.userInfo.phone;
                            break;
                        case 2:
                            inputText.textFieldInput.text = self.userInfo.email;
                            break;
                        case 3:
                            inputText.textFieldInput.text = self.userInfo.org_name;
                            break;
                            
                        default:
                            break;
                    }
                    
                }
                
                if (inputText.textFieldInput.text.length != 0) {
                    [self animationPlaceHolderWithInputText:inputText];
                }
                

                

                   
                
                inputText.textFieldInput.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
                inputText.textFieldInput.textColor = [UIColor blackColor];
                inputText.textFieldInput.tag=5000 + i + 1000 * j;
                inputText.tag=5000 + i + 1000 * j; //Изменить тег напрмиер так 5000 * i + 1000 * j
                inputText.labelPlaceHoldInput.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
                inputText.labelPlaceHoldInput.textColor = [UIColor lightGrayColor];
                if (i == 1) {
                    inputText.textFieldInput.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                } else if (i == 2) {
                    inputText.textFieldInput.keyboardType = UIKeyboardTypeEmailAddress;
                }
                [self.whiteViewPerson addSubview:inputText];
                
                [UIView borderViewWithHeight:38.5f andWight:0 andView:inputText andColor:@"efeff4" andHieghtBorder:1.5f];
                if (j == 0) {
                    [self.arrayTextFildFiz addObject: inputText];
                } else {
                    [self.arrayTextFildYur addObject: inputText];
                }
                
                NSString * textString = inputText.textFieldInput.text;
                
                NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:textString, @"text", nil];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FORMALIZATION_CONTROLLER_CHECK object:nil userInfo:dict];
            }
            
            
            
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputTextStart) name:UITextFieldTextDidBeginEditingNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputTextEnd) name:UITextFieldTextDidEndEditingNotification object:nil];
        
        
        
    }];
    
    return personalDataView;
}

#pragma mark - Address

- (UIView*) createAddress {
    UIView * whiteViewAddress = [[UIView alloc] init];
    UIView * borderAdreeView = [[UIView alloc] init];
    UIView * addressDataView = [self customViewWithFrame:CGRectMake(0.f, self.viewPersonalData.frame.size.height + self.viewPersonalData.frame.origin.y - 40.f, self.frame.size.width, 170) andTitlName:@"Адрес доставки *" andView:whiteViewAddress andBorderView:borderAdreeView andBlock:^{
        
        UITextView * textView = [[UITextView alloc] initWithFrame:CGRectMake(10.f, 10.f, whiteViewAddress.frame.size.width - 20.f, whiteViewAddress.frame.size.height - 20.f)];
        textView.textColor = [UIColor blackColor];
        textView.text = self.userInfo.address;
        textView.delegate = self;
        textView.tag = 3000;
        textView.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
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
    self.borderDeliveryTypes = [[UIView alloc] init];
    self.whiteViewDelivery.clipsToBounds = YES;
    UIView * deliveryTypesView = [self customViewWithFrame:CGRectMake(0.f, self.viewaArddress.frame.size.height + self.viewaArddress.frame.origin.y, self.frame.size.width, 250)andTitlName:@"Способы доставки *" andView:self.whiteViewDelivery andBorderView:self.borderDeliveryTypes andBlock:^{
        
        [self animathionMethodUpAndDownWithView:self.whiteViewDelivery endHieght:20.f andUpAndDown:NO addOther:^{
        }];  //Смещение белого центра вниз
        [self animathionMethodUpAndDownWithView:self.borderDeliveryTypes endHieght:20.f andUpAndDown:NO addOther:^{
        }];  //Смещение белого центра вниз
        

        
        self.buttonMoscow = [self buttonCreatePush];
        self.buttonMoscow.tag = 20;
        [self.buttonMoscow addTarget:self action:@selector(buttonMoscow:) forControlEvents:UIControlEventTouchUpInside];
        self.buttonMoscow.isBool = NO;
        [self.whiteViewDelivery addSubview:self.buttonMoscow];
        
        
        
        CustomLabels * deliveryNameLabel = [[CustomLabels alloc] initLabelWithWidht:34.f andHeight:18.f andColor:@"000000" andText:@"Курьерская доставка" andTextSize:15 andLineSpacing:0.f fontName:VM_FONT_REGULAR];
        [self.whiteViewDelivery addSubview:deliveryNameLabel];
        
        CustomLabels * labelText = [[CustomLabels alloc] initLabelTableWithWidht:10.f andHeight:40.f
                                                                    andSizeWidht:self.whiteViewDelivery.frame.size.width - 20 andSizeHeight:60 andColor:@"787878"
                                                                         andText:@"Стоимость - 450 руб. в пределах МКАД \nЗа МКАД курьерская доставка не\nосуществляется."];
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
        
        NSString * startDelivery;
        NSString * endDelivery;
        
        
        if(self.userInfo.deli_start.length != 0){
            startDelivery = self.userInfo.deli_start;
        }else{
            startDelivery = @"9";
            
        }
        
        if(self.userInfo.deli_end.length != 0){
            endDelivery = self.userInfo.deli_end;
            
        }else{
            endDelivery = @"19";
            
        }
        
        NSArray * arrayNumberTime = [NSArray arrayWithObjects:startDelivery, endDelivery, nil];
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
    self.whiteViewCompany = [[UIView alloc] init];
    self.borderDeliveryCompany = [[UIView alloc] init];
    self.whiteViewCompany.clipsToBounds = YES;
    
    UIView * deliveryCompanyView = [self customViewWithFrame:CGRectMake(0.f, self.viewDeliveryTypes.frame.size.height + self.viewDeliveryTypes.frame.origin.y - 70, self.frame.size.width, 350 + (30 * self.arrayDataDelivery.count + 15)) andTitlName:@"" andView:self.whiteViewCompany andBorderView:self.borderDeliveryCompany andBlock:^{
    
        self.buttonCompany = [self buttonCreatePush];
        self.buttonCompany.tag = 20;
        [self.buttonCompany addTarget:self action:@selector(buttonCompany:) forControlEvents:UIControlEventTouchUpInside];
        self.buttonCompany.isBool = NO;
        [self.whiteViewCompany addSubview:self.buttonCompany];
        
        CustomLabels * labelTitleCompany = [[CustomLabels alloc] initLabelTableWithWidht:34.f andHeight:5.f
                                                                      andSizeWidht:self.whiteViewCompany.frame.size.width - 60 andSizeHeight:40 andColor:@"000000"
                                                                           andText:@"Бесплатная доставка до \nтранспортной компании"];
        labelTitleCompany.numberOfLines = 2;
        labelTitleCompany.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
        labelTitleCompany.textAlignment = NSTextAlignmentLeft;
        [self.whiteViewCompany addSubview:labelTitleCompany];
        
        CustomLabels * labelCutsivCompany = [[CustomLabels alloc] initLabelTableWithWidht:10.f andHeight:36.f
                                                                      andSizeWidht:self.whiteViewDelivery.frame.size.width - 20 andSizeHeight:70 andColor:@"787878"
                                                                           andText:@"Мы рекомендуем пользоваться \nуслугами транспортных компаний, \nэто надежнее и быстрее"];
        labelCutsivCompany.numberOfLines = 3;
        labelCutsivCompany.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
        labelCutsivCompany.textAlignment = NSTextAlignmentLeft;
        [self.whiteViewCompany addSubview:labelCutsivCompany];
        
        NSArray * arrayPlaysHolders = [NSArray arrayWithObjects:@"Фамилия *", @"Отчество *", @"Серия, номер паспорта *", nil];
        NSArray * arrauNameYUr = [NSArray arrayWithObjects:@"Название организации *", @"Контактное лицо *", @"ИНН *", nil];
        for (int j = 0; j < 2; j++) {
            for (int i = 0; i < 3; i++) {
                InputTextView * inputText = [[InputTextView alloc] initInputTextWithView:self.whiteViewPerson
                                                                                 andRect:CGRectMake(0.f, 100.f + (40) * i, self.whiteViewPerson.frame.size.width, 40) andImage:nil
                                                                      andTextPlaceHolder:nil colorBorder:nil];
                inputText.delegate = self;
                inputText.textFieldInput.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
                inputText.textFieldInput.textColor = [UIColor blackColor];
                inputText.textFieldInput.tag = 225 + i + 1000 * j;
                inputText.tag=225 + i + 1000 * j; //Изменить тег напрмиер так 5000 * i + 1000 * j
                
                
                
                if(j == 0){
                    switch (i) {
                        case 0:
                            inputText.textFieldInput.text = self.userInfo.us_fam;
                            break;
                        case 1:
                            inputText.textFieldInput.text = self.userInfo.us_otch;
                            break;
                        case 2:
                            inputText.textFieldInput.text = self.userInfo.doc_num;
                            
                        default:
                            break;
                    }
                }else if(j == 1 ){
                    switch (i) {
                        case 0:
                            inputText.textFieldInput.text = self.userInfo.org_name;
                            break;
                        case 1:
                            inputText.textFieldInput.text = self.userInfo.contact;
                            break;
                        case 2:
                            inputText.textFieldInput.text = self.userInfo.inn;
                            break;
                            
                        default:
                            break;
                    }
                    
                }
                
                if (inputText.textFieldInput.text.length != 0) {
                    [self animationPlaceHolderWithInputText:inputText];
                }
                
                
                
                inputText.labelPlaceHoldInput.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
                inputText.labelPlaceHoldInput.textColor = [UIColor lightGrayColor];
                inputText.labelPlaceHoldInput.tag = 900 + i; //Прописать новый тег с учетом параметра j
                if (i == 2) {
                    inputText.textFieldInput.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                }
                [self.whiteViewCompany addSubview:inputText];
                
                [UIView borderViewWithHeight:38.5f andWight:10 andView:inputText andColor:@"efeff4" andHieghtBorder:1.5f];
                
                if (j == 0) {
                    inputText.labelPlaceHoldInput.text = [arrayPlaysHolders objectAtIndex:i];
                    [self.arrayTextFildFiz addObject:inputText];
                } else {
                    inputText.labelPlaceHoldInput.text = [arrauNameYUr objectAtIndex:i];
                    [self.arrayTextFildYur addObject:inputText];
                }
            }
        }

        
        CustomLabels * deliveryDate = [[CustomLabels alloc] initLabelWithWidht:10.f andHeight:240.f andColor:@"000000" andText:@"Транспортные компании *" andTextSize:15 andLineSpacing:0.f fontName:VM_FONT_REGULAR];
        [self.whiteViewCompany addSubview:deliveryDate];
        
        
        for (int i = 0; i < self.arrayDataDelivery.count; i++) {
            
            NSDictionary * transport =[self.arrayDataDelivery objectAtIndex:i];
            NSString * nameTransport = [transport objectForKey:@"name"];
            NSString * idTransport = [NSString stringWithFormat:@"%@",[transport objectForKey:@"id"]];
            
            CustomButton * buttonTransport = [CustomButton buttonWithType:UIButtonTypeCustom];
            buttonTransport.tag = 700 + i;
            buttonTransport.customID = idTransport;
            buttonTransport.frame = CGRectMake(10.f, 260.f + 30 * i, self.whiteViewCompany.frame.size.width - 20, 30);
            [buttonTransport setImage:[UIImage imageNamed:@"buttonBuyerYes.png"] forState:UIControlStateSelected];
            
            [buttonTransport addTarget:self action:@selector(buttonTransportAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.whiteViewCompany addSubview:buttonTransport];
            
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10.f, 10.f, 20.f, 20.f)];
            
            if(self.userInfo.like_tk !=0){
                if([self.userInfo.like_tk integerValue] == [[transport objectForKey:@"id"] integerValue]){
                    imageView.image = [UIImage imageNamed:@"buttonFaceYes.png"];
                    buttonTransport.userInteractionEnabled = NO;
                }else{
                    imageView.image = [UIImage imageNamed:@"buttonFaceNo.png"];
                    buttonTransport.userInteractionEnabled = YES;
                    
                }
                
            }else{
                imageView.image = [UIImage imageNamed:@"buttonFaceNo.png"];
                if (i == 0) {
                    imageView.image = [UIImage imageNamed:@"buttonFaceYes.png"];
                    buttonTransport.userInteractionEnabled = NO;
                }
                
            }
            
            imageView.tag = 750 + i;
            [buttonTransport addSubview:imageView];
            
            
            CustomLabels * labelButtons = [[CustomLabels alloc] initLabelWithWidht:40.f andHeight:14 andColor:@"000000"
                                                                           andText:nameTransport
                                                                       andTextSize:15 andLineSpacing:0.f fontName:VM_FONT_REGULAR];
            
            [buttonTransport addSubview:labelButtons];
        }
        
        self.heightCompany = 200 + (30 * self.arrayDataDelivery.count + 15);
    
    
    }];
    
    CustomLabels * labelRegion = [[CustomLabels alloc] initLabelTableWithWidht:0.f andHeight:16 andSizeWidht:self.frame.size.width andSizeHeight:20 andColor:@"000000" andText:@"РЕГИОНЫ"];
    labelRegion.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
    labelRegion.textAlignment = NSTextAlignmentCenter;
    [deliveryCompanyView addSubview:labelRegion];
    
    
    
    return deliveryCompanyView;
    
}

#pragma mark - DeliveryMail

- (UIView*) createDeliveryMailView {
    self.whiteMainView = [[UIView alloc] init];
    self.borderDeliveryMail = [[UIView alloc] init];
    self.whiteMainView.clipsToBounds = YES;
    UIView * deliveryMailView = [self customViewWithFrame:CGRectMake(0.f, self.viewDeliveryCompany.frame.size.height + self.viewDeliveryCompany.frame.origin.y - 420, self.frame.size.width, 310) andTitlName:@"" andView:self.whiteMainView andBorderView:self.borderDeliveryMail andBlock:^{
        
        self.buttonMail = [self buttonCreatePush];
        self.buttonMail.tag = 400;
        [self.buttonMail addTarget:self action:@selector(buttonMail:) forControlEvents:UIControlEventTouchUpInside];
        self.buttonMail.isBool = NO;
        [self.whiteMainView addSubview:self.buttonMail];
        
        CustomLabels * labelTitleMail = [[CustomLabels alloc] initLabelTableWithWidht:34.f andHeight:5.f
                                                                            andSizeWidht:self.whiteViewCompany.frame.size.width - 60 andSizeHeight:40 andColor:@"000000"
                                                                                 andText:@"Бесплатная доставка до почты\nРоссии"];
        labelTitleMail.numberOfLines = 2;
        labelTitleMail.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
        labelTitleMail.textAlignment = NSTextAlignmentLeft;
        [self.whiteMainView addSubview:labelTitleMail];
        
        CustomLabels * labelCutsivMail = [[CustomLabels alloc] initLabelTableWithWidht:10.f andHeight:36.f
                                                                             andSizeWidht:self.whiteViewDelivery.frame.size.width - 20 andSizeHeight:60 andColor:@"787878"
                                                                                  andText:@"Доставка до почты осуществляется в\nтечении дня после сбора заказа"];
        labelCutsivMail.numberOfLines = 2;
        labelCutsivMail.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
        labelCutsivMail.textAlignment = NSTextAlignmentLeft;
        [self.whiteMainView addSubview:labelCutsivMail];
        
        
        NSArray * arrayPlaysHolders = [NSArray arrayWithObjects:@"Фамилия *", @"Отчество *", @"Индекс *", @"Скрытое окно", nil];
        NSArray * arrayPlaysHoldersYur = [NSArray arrayWithObjects:@"Название организации *", @"Контактное лицо *", @"ИНН *", @"КПП *", nil];
        for (int j = 0; j < 2; j++) {
            for (int i = 0; i < 4; i++) {
                InputTextView * inputText = [[InputTextView alloc] initInputTextWithView:self.whiteViewPerson
                                                                                 andRect:CGRectMake(0.f, 90.f + (40) * i, self.whiteViewPerson.frame.size.width, 40) andImage:nil
                                                                      andTextPlaceHolder:[arrayPlaysHolders objectAtIndex:i] colorBorder:nil];
                inputText.delegate = self;
                
                
                inputText.textFieldInput.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
                inputText.textFieldInput.textColor = [UIColor blackColor];
                inputText.textFieldInput.tag = 800 +i + 1000 * j; //Изменить параметры с учетом j
                inputText.tag = 800 +i + 1000 * j; //Изменить параметры с учетом j
                
                if(j== 0){
                    switch (i) {
                        case 0:
                            inputText.textFieldInput.text = self.userInfo.us_fam;
                            break;
                        case 1:
                            inputText.textFieldInput.text = self.userInfo.us_otch;
                            break;
                        case 2:
                            inputText.textFieldInput.text = self.userInfo.addr_index;
                            
                        default:
                            break;
                    }
                }else if(j == 1 ){
                    switch (i) {
                        case 0:
                            inputText.textFieldInput.text = self.userInfo.org_name;
                            break;
                        case 1:
                            inputText.textFieldInput.text = self.userInfo.contact;
                            break;
                        case 2:
                            inputText.textFieldInput.text = self.userInfo.inn;
                            break;
                        case 3:
                            inputText.textFieldInput.text = self.userInfo.kpp;
                            break;
                            
                        default:
                            break;
                    }
                    
                }
                
                if (inputText.textFieldInput.text.length != 0) {
                    [self animationPlaceHolderWithInputText:inputText];
                }
                
                
                
                
                inputText.labelPlaceHoldInput.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
                inputText.labelPlaceHoldInput.textColor = [UIColor lightGrayColor];
                inputText.labelPlaceHoldInput.tag = 1700 + i; //Изменить параметры с учетом j
                
                
                
                
                
                
                if (i == 2) {
                    inputText.textFieldInput.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                }
                if (j == 0) {
                    inputText.labelPlaceHoldInput.text = [arrayPlaysHolders objectAtIndex:i];
                    [self.arrayTextFildFiz addObject:inputText];
                } else {
                    inputText.labelPlaceHoldInput.text = [arrayPlaysHoldersYur objectAtIndex:i];
                    [self.arrayTextFildYur addObject:inputText];
                }
                [self.whiteMainView addSubview:inputText];
                
                [UIView borderViewWithHeight:38.5f andWight:10 andView:inputText andColor:@"efeff4" andHieghtBorder:1.5f];
            }
        }

        
    }];
    
    
    return deliveryMailView;
}


#pragma mark - PriceView

- (UIView*) createPraceView {
    self.whitePriceView = [[UIView alloc] init];
    self.borderPriceView = [[UIView alloc] init];
    self.whitePriceView.clipsToBounds = YES;
        UIView * priceView = [self customViewWithFrame:CGRectMake(0.f, self.viewDelivaryMail.frame.size.height + self.viewDelivaryMail.frame.origin.y - 175.f, self.frame.size.width, 255) andTitlName:@"Способы оплаты *" andView:self.whitePriceView andBorderView:self.borderPriceView andBlock:^{
            
            NSArray * arrayNames = [NSArray arrayWithObjects:@"Visa, MasterCard, Сбербанк", @"Яндекс деньги", @"WebMoney", @"Qiwi", @"Квитанция сбербанка", nil];
            
            for (int i = 0; i < arrayNames.count; i++) {
                
                UIButton * buttonPrice = [UIButton buttonWithType:UIButtonTypeCustom];
                buttonPrice.tag = 2000 + i;
                buttonPrice.frame = CGRectMake(0.f, 0.f + 30 * i, self.whiteViewCompany.frame.size.width - 20, 30);
                [buttonPrice setImage:[UIImage imageNamed:@"buttonBuyerYes.png"] forState:UIControlStateSelected];
                buttonPrice.userInteractionEnabled = YES;
                [buttonPrice addTarget:self action:@selector(buttonPriceAction:) forControlEvents:UIControlEventTouchUpInside];
                
                [self.whitePriceView addSubview:buttonPrice];
                
                UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10.f, 10.f, 20.f, 20.f)];
                
                if([self.userInfo.like_pay integerValue] == 1 && i==0){
                    imageView.image = [UIImage imageNamed:@"buttonFaceYes.png"];
                    buttonPrice.userInteractionEnabled = NO;
                    
                }else if([self.userInfo.like_pay integerValue] == 3 && i==1){
                    imageView.image = [UIImage imageNamed:@"buttonFaceYes.png"];
                    buttonPrice.userInteractionEnabled = NO;
                    
                }else if([self.userInfo.like_pay integerValue] == 2 && i==2){
                    imageView.image = [UIImage imageNamed:@"buttonFaceYes.png"];
                    buttonPrice.userInteractionEnabled = NO;
                    
                }else if([self.userInfo.like_pay integerValue] == 4 && i==3){
                    imageView.image = [UIImage imageNamed:@"buttonFaceYes.png"];
                    buttonPrice.userInteractionEnabled = NO;
                    
                }else if([self.userInfo.like_pay integerValue] == 6 && i==4){
                    imageView.image = [UIImage imageNamed:@"buttonFaceYes.png"];
                    buttonPrice.userInteractionEnabled = NO;
                    
                }else{
                    imageView.image = [UIImage imageNamed:@"buttonFaceNo.png"];
                    buttonPrice.userInteractionEnabled = YES;
                }
                
                
                
                
                
               
                imageView.tag = 2100 + i;
                [buttonPrice addSubview:imageView];
                
                CustomLabels * labelButtons = [[CustomLabels alloc] initLabelWithWidht:40.f andHeight:14 andColor:@"000000"
                                                                               andText:[arrayNames objectAtIndex:i] andTextSize:15 andLineSpacing:0.f fontName:VM_FONT_REGULAR];
                labelButtons.tag = 2500 + i;
                [buttonPrice addSubview:labelButtons];
            }
            
        }];
    
    CGRect rectBorder = self.borderPriceView.frame;
    rectBorder.size.height += 10;
    self.borderPriceView.frame = rectBorder;
    
    
    self.viewText = [[UIView alloc] initWithFrame:CGRectMake(15.f, 195.f, self.frame.size.width - 30.f, 60.f)];
    self.viewText.backgroundColor = [UIColor whiteColor];
    [priceView addSubview:self.viewText];
    CustomLabels * labelText = [[CustomLabels alloc] initLabelTableWithWidht:10.f andHeight:0.f
                                                                            andSizeWidht:self.whiteViewDelivery.frame.size.width - 20 andSizeHeight:60 andColor:@"787878"
                                                                                 andText:@"Счет и инструкции по оплате будут\nвысланы на Email после принятия\nзаказа оператором"];
                labelText.numberOfLines = 3;
                labelText.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
                labelText.textAlignment = NSTextAlignmentLeft;
                [self.viewText addSubview:labelText];
    
    
    return priceView;
    
}

#pragma mark - Comments

- (UIView*) createCommentsView {
    UIView * whiteCommentsView = [[UIView alloc] init];
    UIView * borderComment = [[UIView alloc] init];
    UIView * commentsView = [self customViewWithFrame:CGRectMake(0.f, self.viewPrice.frame.size.height + self.viewPrice.frame.origin.y, self.frame.size.width, 170) andTitlName:@"Комментарий к заказу" andView:whiteCommentsView andBorderView:borderComment andBlock:^{
        
        UITextView * textView = [[UITextView alloc] initWithFrame:CGRectMake(10.f, 10.f, whiteCommentsView.frame.size.width - 20.f, whiteCommentsView.frame.size.height - 20.f)];
        textView.textColor = [UIColor blackColor];
        textView.delegate = self;
        textView.text = self.userInfo.comment;
        textView.tag = 3001;
        textView.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
        //        textView.autocorrectionType = UITextAutocorrectionTypeNo;
        [whiteCommentsView addSubview:textView];
        
    }];
    
    self.labelNumberComments = [[CustomLabels alloc] initLabelTableWithWidht:self.frame.size.width - 80.f andHeight:13.f andSizeWidht:60.f andSizeHeight:20.f andColor:VM_COLOR_300 andText:@"200"];
    self.labelNumberComments.font = [UIFont fontWithName:VM_FONT_BEAU_SANS_LITE size:13];
    self.labelNumberComments.textAlignment = NSTextAlignmentRight;
    [commentsView addSubview:self.labelNumberComments];
    
    
    return commentsView;
}

#pragma mark - OtherView

- (UIView*) createOtherView {
    UIView * otherView = [[UIView alloc] initWithFrame:CGRectMake(0, self.viewComments.frame.size.height + self.viewComments.frame.origin.y, self.frame.size.width, 110)];
    
    CustomLabels * labelPrice = [[CustomLabels alloc] initLabelWithWidht:15.f andHeight:20 andColor:@"787878"
                                                                   andText:@"Итоговая стоимость:" andTextSize:16 andLineSpacing:0.f fontName:VM_FONT_REGULAR];
    [otherView addSubview:labelPrice];
    NSString * totalPrice= [NSString stringWithFormat:@"%d руб", [[[SingleTone sharedManager] priceType] integerValue]+450];
    CustomLabels * labelPriceAction = [[CustomLabels alloc] initLabelWithWidht:15.f + labelPrice.frame.size.width + 2 andHeight:20 andColor:VM_COLOR_800
                                                                 andText:totalPrice andTextSize:16 andLineSpacing:0.f fontName: VM_FONT_REGULAR];
    [otherView addSubview:labelPriceAction];
    
    self.labelDelivery = [[CustomLabels alloc] initLabelWithWidht:94.f andHeight:0 andColor:@"787878"
                                                                 andText:@"Доставка: " andTextSize:16 andLineSpacing:0.f fontName:VM_FONT_REGULAR];
    self.labelDelivery.alpha = 0.f;
    
    [otherView addSubview:self.labelDelivery];

    
    self.labelDeliveryAction = [[CustomLabels alloc] initLabelWithWidht:15.f + labelPrice.frame.size.width + 2 andHeight:0 andColor:VM_COLOR_800
                                                                       andText:@"450 руб" andTextSize:16 andLineSpacing:0.f fontName:VM_FONT_REGULAR];
    self.labelDeliveryAction.alpha = 0.f;
    [otherView addSubview:self.labelDeliveryAction];
    
    UIButton * buttonText = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonText.frame = CGRectMake(15.f, 45.f, self.frame.size.width - 30.f, 40);
    buttonText.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_800];
    [buttonText setTitle:@"Оформить заказ" forState:UIControlStateNormal];
    [buttonText addTarget:self action:@selector(buttonTextAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttonText setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonText.layer.cornerRadius = 3.f;
    buttonText.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:16];
    [otherView addSubview:buttonText];
    
    
    
    return otherView;
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
    
    
    self.arrayForPickerViewUpper = [NSMutableArray new];
    self.arrayForPickerViewLower = [NSMutableArray new];
    
    if(self.userInfo.deli_start.length !=0){
        NSInteger  counterUpper = [self.userInfo.deli_start integerValue]-9;
        NSInteger counterLower = [self.userInfo.deli_end integerValue]-9;
        
        self.rowUpper = counterUpper; //1
        [self.arrayForPickerViewUpper removeAllObjects];
        
        
        for(int i=0; i<counterLower+1; i++){
            
            [self.arrayForPickerViewUpper addObject:[NSString stringWithFormat:@"%d",9+i]];
        }
        
        
        
    }else{
        self.rowUpper = 0; //1
           self.arrayForPickerViewUpper = [NSMutableArray arrayWithObjects:@"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", nil];
    }
    
    //Значения из базы для второго пикера
    if(self.userInfo.deli_end.length !=0){
        NSInteger  counterUpper = [self.userInfo.deli_start integerValue]-9;
        NSInteger counterLower = [self.userInfo.deli_end integerValue]-[self.userInfo.deli_start integerValue];
        
        self.rowLower = counterLower;
        
        for(int i=counterUpper; i<14; i++){
            
            
            [self.arrayForPickerViewLower addObject:[NSString stringWithFormat:@"%d",9+i]];
        }

       
        
    }else{
        self.rowLower = 10;
        self.arrayForPickerViewLower = [NSMutableArray arrayWithObjects:@"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", nil];

        
    }
    
    
    
//    self.rowLower = 10; // 2
    
 
    
    
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
//    [self animathionMethodUpAndDownWithView:self.mainScrollView endHieght:50.f andUpAndDown:YES addOther:^{
//        self.mainScrollView.contentOffset = CGPointMake(0.f, 20.f);
//    }];
    
}
//Действие после воода данных в TextField
- (void) inputTextEnd {
//    [self animathionMethodUpAndDownWithView:self.mainScrollView endHieght:50.f andUpAndDown:NO addOther:^{
//        
//    }];
}


#pragma mark - Actions
//Выбор типа покупателя (юр лицо или физ лицо)
- (void) buttonFaceAction: (UIButton*) button {
    
    UserInfoDbClass * userInfoDbclass = [[UserInfoDbClass alloc] init];
    NSArray * userArray = [userInfoDbclass showAllUsersInfo];
    UserInfo * userInfo ;
    if(userArray.count>0){
        userInfo = (UserInfo *)[userArray objectAtIndex:0];
        NSLog(@"TYPE %@",userInfo.us_type);
    }else{
        userInfo = nil;
        NSLog(@"USER INFO - EMPTY");
    }
    
    [self hideTestFildsWithCustomer:YES];
    
    
    UIButton * buttonOne = [self viewWithTag:5];
    UIButton * buttonTwo = [self viewWithTag:6];
    UIImageView * imageViewOne = [self viewWithTag:10];
    UIImageView * imageViewTwo = [self viewWithTag:11];
    
    if (button.tag == 5) {
        buttonOne.userInteractionEnabled = NO;
        buttonTwo.userInteractionEnabled = YES;
        UILabel * labelButton = [self viewWithTag:2500];
        
        [userInfoDbclass checkUserInfo:@"" phone:@"" ord_name:@"" us_fam:@"" us_otch:@"" us_type:@"0" inn:@"" kpp:@"" like_delivery:@"" like_tk:@"" like_pay:@"" doc_date:@"" doc_vend:@"" doc_num:@"" org_name:@"" addr_index:@"" contact:@"" address:@"" deli_start:@"" deli_end:@"" transport:@"" comment:@""];
        
        labelButton.text = @"Visa, MasterCard, Сбербанк";
        self.chooseButton = YES;
        [UIView animateWithDuration:0.3 animations:^{
            imageViewOne.image = [UIImage imageNamed:@"buttonFaceYes.png"];
            imageViewTwo.image = [UIImage imageNamed:@"buttonFaceNo.png"];
            [self animationUpPersonalData];
        }];
        self.mainScrollView.contentSize = CGSizeMake(0, self.mainScrollView.contentSize.height + 80.f);
        [self customHideViewWithHeight:120 andView:self.whitePriceView andNumberParams:6 andBool:NO andDuraction:0.f andBorderView:self.borderPriceView];
        CGRect textRect = self.viewText.frame;
        textRect.origin.y += 120;
        self.viewText.frame = textRect;
        if (self.buttonMail.isBool) {
            [self customHideViewWithHeight:40 andView:self.whiteMainView andNumberParams:5 andBool:YES andDuraction:0.f andBorderView:self.borderDeliveryMail];
            self.mainScrollView.contentSize = CGSizeMake(0, self.mainScrollView.contentSize.height - 40.f);
        }
    } else if (button.tag == 6) {
        
        
        [self hideTestFildsWithCustomer:NO];
        
        buttonOne.userInteractionEnabled = YES;
        buttonTwo.userInteractionEnabled = NO;
        UILabel * labelButton = [self viewWithTag:2500];
        
        [userInfoDbclass checkUserInfo:@"" phone:@"" ord_name:@"" us_fam:@"" us_otch:@"" us_type:@"1" inn:@"" kpp:@"" like_delivery:@"" like_tk:@"" like_pay:@"" doc_date:@"" doc_vend:@"" doc_num:@"" org_name:@"" addr_index:@"" contact:@"" address:@"" deli_start:@"" deli_end:@"" transport:@"" comment:@""];
        
        labelButton.text = @"Счет на оплату";
        self.chooseButton = NO;
        [UIView animateWithDuration:0.3 animations:^{
            imageViewOne.image = [UIImage imageNamed:@"buttonFaceNo.png"];
            imageViewTwo.image = [UIImage imageNamed:@"buttonFaceYes.png"];
            [self animationDownPersonalData];
        }];
        self.mainScrollView.contentSize = CGSizeMake(0, self.mainScrollView.contentSize.height - 80.f);
        [self customHideViewWithHeight:120 andView:self.whitePriceView andNumberParams:6 andBool:YES andDuraction:0.f andBorderView:self.borderPriceView];
        CGRect textRect = self.viewText.frame;
        textRect.origin.y -= 120;
        self.viewText.frame = textRect;
        if (self.buttonMail.isBool) {
            [self customHideViewWithHeight:40 andView:self.whiteMainView andNumberParams:5 andBool:NO andDuraction:0.f andBorderView:self.borderDeliveryMail];
            self.mainScrollView.contentSize = CGSizeMake(0, self.mainScrollView.contentSize.height + 40.f);
        }
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
            UserInfoDbClass * userInfoDbClass = [[UserInfoDbClass alloc] init];
            
        if (self.pickerChenge) {
            self.rowUpper = self.pickerCountUpper; //Сохранение выбранного параметра пикера в пикере
            label.text = [self.arrayForPickerViewUpper objectAtIndex:self.pickerCountUpper]; //Изменение текста лейбла в зависимости от пикера
            [label sizeToFit];
            self.rowUppTag = self.rowUppTag - self.rowUpper; //Сохранение параметров выбраных в самом пикере
            self.rowLower += self.rowUppTag;
            //У нас есть всегда от 9 до ограничения второго пикера
            [self.arrayForPickerViewLower removeAllObjects]; //Перерисовываем массив
            
            NSString * pickerUpper = [self.arrayForPickerViewUpper objectAtIndex:self.pickerCountUpper];
            
            [userInfoDbClass checkUserInfo:@"" phone:@"" ord_name:@"" us_fam:@"" us_otch:@"" us_type:@"" inn:@"" kpp:@"" like_delivery:@"" like_tk:@"" like_pay:@"" doc_date:@"" doc_vend:@"" doc_num:@"" org_name:@"" addr_index:@"" contact:@"" address:@"" deli_start:pickerUpper deli_end:@"" transport:@"" comment:@""];
          
            
            for(int i= [[self.arrayForPickerViewUpper objectAtIndex:self.pickerCountUpper] integerValue]; i<23; i++){
                NSString * stringNumber = [NSString stringWithFormat:@"%d", i];
                [self.arrayForPickerViewLower addObject:stringNumber];
            }
        } else {
            self.rowLower = self.pickerCountLower; //Сохранение выбранного параметра пикера в пикере (2 параметра смотря какой пикер)
            label.text = [self.arrayForPickerViewLower objectAtIndex:self.pickerCountLower]; //Изменение текста лейбла в зависимости от пикера
            [label sizeToFit];
                [self.arrayForPickerViewUpper removeAllObjects]; //Перерисовываем массив
            
            NSString * pickerLower = [self.arrayForPickerViewLower objectAtIndex:self.pickerCountLower];
            
            [userInfoDbClass checkUserInfo:@"" phone:@"" ord_name:@"" us_fam:@"" us_otch:@"" us_type:@"" inn:@"" kpp:@"" like_delivery:@"" like_tk:@"" like_pay:@"" doc_date:@"" doc_vend:@"" doc_num:@"" org_name:@"" addr_index:@"" contact:@"" address:@"" deli_start:@"" deli_end:pickerLower transport:@"" comment:@""];
            
            
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
    
    self.labelDeliveryAction.alpha = 1.f;
    self.labelDelivery.alpha = 1.f;
    
    if (!button.isBool) {
        [UIView animateWithDuration:0.3 animations:^{
            button.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_400];
            button.layer.borderColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_400].CGColor;
            self.buttonCompany.backgroundColor = [UIColor whiteColor];
            self.buttonCompany.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
            self.buttonMail.backgroundColor = [UIColor whiteColor];
            self.buttonMail.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
            if (self.chooseButton) {
                self.mainScrollView.contentOffset = CGPointMake(0, 460);
            } else {
                self.mainScrollView.contentOffset = CGPointMake(0, 500);
            }
            if (self.buttonCompany.isBool) {
                [self customHideViewWithHeight:self.heightCompany - 45 andView:self.whiteViewCompany andNumberParams:4 andBool:YES andDuraction:0.f andBorderView:self.borderDeliveryCompany];
                self.mainScrollView.contentSize = CGSizeMake(0, self.mainScrollView.contentSize.height - (self.heightCompany - 45));
            }
            if (self.buttonMail.isBool) {
                if (self.chooseButton) {
                    [self customHideViewWithHeight:130 andView:self.whiteMainView andNumberParams:5 andBool:YES andDuraction:0.f andBorderView:self.borderDeliveryMail];
                    self.mainScrollView.contentSize = CGSizeMake(0, self.mainScrollView.contentSize.height - 130);
                } else {
                    [self customHideViewWithHeight:170 andView:self.whiteMainView andNumberParams:5 andBool:YES andDuraction:0.f andBorderView:self.borderDeliveryMail];
                    self.mainScrollView.contentSize = CGSizeMake(0, self.mainScrollView.contentSize.height - 170);
                }
            }
            [self customHideViewWithHeight:70.f andView:self.whiteViewDelivery andNumberParams:3 andBool:NO andDuraction:0.3 andBorderView:self.borderDeliveryTypes];
            self.mainScrollView.contentSize = CGSizeMake(0, self.mainScrollView.contentSize.height + 70);
            
        }];
        
        self.buttonCompany.isBool = NO;
        self.buttonMail.isBool = NO;
        button.isBool = YES;
        
        UserInfoDbClass * userInfoDbClass = [[UserInfoDbClass alloc] init];
        
        [userInfoDbClass checkUserInfo:@"" phone:@"" ord_name:@"" us_fam:@"" us_otch:@"" us_type:@"" inn:@"" kpp:@"" like_delivery:@"0" like_tk:@"" like_pay:@"" doc_date:@"" doc_vend:@"" doc_num:@"" org_name:@"" addr_index:@"" contact:@"" address:@"" deli_start:@"" deli_end:@"" transport:@"" comment:@""];
    }
}

//Выбор доставки транспортной компанией
- (void) buttonCompany: (CustomButton*) button {
    
    self.labelDeliveryAction.alpha = 0.f;
    self.labelDelivery.alpha = 0.f;
    
    if (!button.isBool) {
        [UIView animateWithDuration:0.3 animations:^{
            button.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_400];
            button.layer.borderColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_400].CGColor;
            self.buttonMoscow.backgroundColor = [UIColor whiteColor];
            self.buttonMoscow.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
            self.buttonMail.backgroundColor = [UIColor whiteColor];
            self.buttonMail.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
            if (self.buttonMoscow.isBool) {
                [self customHideViewWithHeight:70.f andView:self.whiteViewDelivery andNumberParams:3 andBool:YES andDuraction:0.3 andBorderView:self.borderDeliveryTypes];
                self.mainScrollView.contentSize = CGSizeMake(0, self.mainScrollView.contentSize.height - 70);
            }
            if (self.buttonMail.isBool) {
                if (self.chooseButton) {
                    [self customHideViewWithHeight:130 andView:self.whiteMainView andNumberParams:5 andBool:YES andDuraction:0.f andBorderView:self.borderDeliveryMail];
                    self.mainScrollView.contentSize = CGSizeMake(0, self.mainScrollView.contentSize.height - 130);
                } else {
                    [self customHideViewWithHeight:170 andView:self.whiteMainView andNumberParams:5 andBool:YES andDuraction:0.f andBorderView:self.borderDeliveryMail];
                    self.mainScrollView.contentSize = CGSizeMake(0, self.mainScrollView.contentSize.height - 170);
                }
            }
            [self customHideViewWithHeight:self.heightCompany - 45 andView:self.whiteViewCompany andNumberParams:4 andBool:NO andDuraction:0.f andBorderView:self.borderDeliveryCompany];
            self.mainScrollView.contentSize = CGSizeMake(0, self.mainScrollView.contentSize.height + (self.heightCompany - 45));
            if (self.chooseButton) {
                self.mainScrollView.contentOffset = CGPointMake(0, 620);
            } else {
                self.mainScrollView.contentOffset = CGPointMake(0, 660);
            }
            
        }];
        self.buttonMoscow.isBool = NO;
        self.buttonMail.isBool = NO;
        button.isBool = YES;
        UserInfoDbClass * userInfoDbClass = [[UserInfoDbClass alloc] init];
        
        [userInfoDbClass checkUserInfo:@"" phone:@"" ord_name:@"" us_fam:@"" us_otch:@"" us_type:@"" inn:@"" kpp:@"" like_delivery:@"2" like_tk:@"" like_pay:@"" doc_date:@"" doc_vend:@"" doc_num:@"" org_name:@"" addr_index:@"" contact:@"" address:@"" deli_start:@"" deli_end:@"" transport:@"" comment:@""];
        
    }
}

//Выбор доставки почтой
- (void) buttonMail: (CustomButton*) button {
    
    self.labelDeliveryAction.alpha = 0.f;
    self.labelDelivery.alpha = 0.f;
    
    if (!button.isBool) {
        [UIView animateWithDuration:0.3 animations:^{
            button.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_400];
            button.layer.borderColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_400].CGColor;
            self.buttonMoscow.backgroundColor = [UIColor whiteColor];
            self.buttonMoscow.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
            self.buttonCompany.backgroundColor = [UIColor whiteColor];
            self.buttonCompany.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
            if (self.buttonCompany.isBool) {
                [self customHideViewWithHeight:self.heightCompany - 45 andView:self.whiteViewCompany andNumberParams:4 andBool:YES andDuraction:0.f andBorderView:self.borderDeliveryCompany];
                self.mainScrollView.contentSize = CGSizeMake(0, self.mainScrollView.contentSize.height - (self.heightCompany - 45));
            }
            if (self.buttonMoscow.isBool) {
                [self customHideViewWithHeight:70.f andView:self.whiteViewDelivery andNumberParams:3 andBool:YES andDuraction:0.3 andBorderView:self.borderDeliveryTypes];
                self.mainScrollView.contentSize = CGSizeMake(0, self.mainScrollView.contentSize.height - 70);
            }
            if (self.chooseButton) {
                self.mainScrollView.contentOffset = CGPointMake(0, 745);
                [self customHideViewWithHeight:130 andView:self.whiteMainView andNumberParams:5 andBool:NO andDuraction:0.f andBorderView:self.borderDeliveryMail];
                self.mainScrollView.contentSize = CGSizeMake(0, self.mainScrollView.contentSize.height + 130);
            } else {
                self.mainScrollView.contentOffset = CGPointMake(0, 785);
                [self customHideViewWithHeight:170 andView:self.whiteMainView andNumberParams:5 andBool:NO andDuraction:0.f andBorderView:self.borderDeliveryMail];
                self.mainScrollView.contentSize = CGSizeMake(0, self.mainScrollView.contentSize.height + 170);
            }
        }];
    }
    self.buttonMoscow.isBool = NO;
    self.buttonCompany.isBool = NO;
    button.isBool = YES;
    UserInfoDbClass * userInfoDbClass = [[UserInfoDbClass alloc] init];
    
    [userInfoDbClass checkUserInfo:@"" phone:@"" ord_name:@"" us_fam:@"" us_otch:@"" us_type:@"" inn:@"" kpp:@"" like_delivery:@"1" like_tk:@"" like_pay:@"" doc_date:@"" doc_vend:@"" doc_num:@"" org_name:@"" addr_index:@"" contact:@"" address:@"" deli_start:@"" deli_end:@"" transport:@"" comment:@""];
}

//Выбор транспортной компании
- (void) buttonTransportAction: (CustomButton*) button {
    
    NSLog(@"BUTTON CUSTOMID %@",button.customID);
    for (int i = 0; i < self.arrayDataDelivery.count; i++) {
        UIButton * otherButton = (UIButton*)[self viewWithTag:700 + i];
        if (button.tag == 700 + i) {
            UserInfoDbClass * userInfoDbClass = [[UserInfoDbClass alloc] init];
            [userInfoDbClass checkUserInfo:@"" phone:@"" ord_name:@"" us_fam:@"" us_otch:@"" us_type:@"" inn:@"" kpp:@"" like_delivery:@"" like_tk:button.customID like_pay:@"" doc_date:@"" doc_vend:@"" doc_num:@"" org_name:@"" addr_index:@"" contact:@"" address:@"" deli_start:@"" deli_end:@"" transport:@"" comment:@""];
            UIImageView * imageView = (UIImageView*)[self viewWithTag:750 + i];
            [UIView animateWithDuration:0.3 animations:^{
                imageView.image = [UIImage imageNamed:@"buttonFaceYes.png"];
            } completion:^(BOOL finished) {
                button.userInteractionEnabled = NO;
            }];
        } else {
            otherButton.userInteractionEnabled = YES;
            UIImageView * imageView = (UIImageView*)[self viewWithTag:750 + i];
            imageView.image = [UIImage imageNamed:@"buttonFaceNo.png"];
        }
    }
}

//Выбор способа оплаты
- (void) buttonPriceAction: (UIButton*) button {
    for (int i = 0; i < 5; i++) {
        UIButton * otherButton = (UIButton*)[self viewWithTag:2000 + i];
        
        if (button.tag == 2000 + i) {
            
            NSString * payMethod;
            
            switch (button.tag) {
                case 2000:
                    payMethod = @"1";
                    break;
                case 2001:
                    payMethod = @"3";
                    break;
                case 2002:
                    payMethod = @"2";
                    break;
                case 2003:
                    payMethod = @"4";
                    break;
                case 2004:
                    payMethod = @"6";
                    break;
                    
                default:
                    break;
            }
            
            UserInfoDbClass * userInfoDbClass =[[UserInfoDbClass alloc] init];
             [userInfoDbClass checkUserInfo:@"" phone:@"" ord_name:@"" us_fam:@"" us_otch:@"" us_type:@"" inn:@"" kpp:@"" like_delivery:@"" like_tk:@"" like_pay:payMethod doc_date:@"" doc_vend:@"" doc_num:@"" org_name:@"" addr_index:@"" contact:@"" address:@"" deli_start:@"" deli_end:@"" transport:@"" comment:@""];
            
            UIImageView * imageView = (UIImageView*)[self viewWithTag:2100 + i];
            [UIView animateWithDuration:0.3 animations:^{
                imageView.image = [UIImage imageNamed:@"buttonFaceYes.png"];
            } completion:^(BOOL finished) {
                button.userInteractionEnabled = NO;
            }];
        } else {
            otherButton.userInteractionEnabled = YES;
            UIImageView * imageView = (UIImageView*)[self viewWithTag:2100 + i];
            imageView.image = [UIImage imageNamed:@"buttonFaceNo.png"];
        }
    }
    
}

- (void) buttonTextAction: (UIButton*) button {
    NSLog(@"Оформить заказ Перед блоком");
    
    //ПРОВЕРКИ
    
    int countErr = 0;
    
    //Типы доставки
    
//    if([self.userInfo.like_delivery integerValue] == 0 && self.userInfo.like_delivery.length !=0){
//        [self buttonMoscow:self.buttonMoscow];
//    }
//    
//    if([self.userInfo.like_delivery integerValue] == 1 && self.userInfo.like_delivery.length !=0){
//        [self buttonMail:self.buttonMail];
//    }
//    
//    if([self.userInfo.like_delivery integerValue] == 2 && self.userInfo.like_delivery.length !=0){
//        [self buttonCompany:self.buttonCompany];
//    }
//    
    
//    if([CheckRequiredField checkField:email andFieldTwo:nil countText:0
//                              andType:@"email" andErrorMessage:@"Введите верный Email"]){
//        countErr+=1;
//        
//    }
    
    
    if([self.userInfo.us_type integerValue] == 0){ //ФИЗ лицо
        
        if ([CheckRequiredField checkField:self.userInfo.ord_name andFieldTwo:nil countText:0 andType:@"text" andErrorMessage:@"Введите верное имя"]) {
            countErr+=1;
        } else if ([CheckRequiredField checkField:self.userInfo.phone andFieldTwo:nil countText:11 andType:@"phone" andErrorMessage:@"Введите верный номер телефона"]) {
            countErr+=1;
        } else if ([CheckRequiredField checkField:self.userInfo.email andFieldTwo:nil countText:0 andType:@"email" andErrorMessage:@"Введите верный Email"]) {
            countErr+=1;
        } else if ([CheckRequiredField checkField:self.userInfo.address andFieldTwo:nil countText:0 andType:@"text" andErrorMessage:@"Введите верный адрес"]) {
            countErr+=1;
        } else if ([CheckRequiredField checkField:self.userInfo.like_delivery andFieldTwo:nil countText:0 andType:@"text" andErrorMessage:@"Выберите тип доставки"]) {
            countErr+=1;
        } else if ([self.userInfo.like_delivery integerValue] == 0) {
            if ([CheckRequiredField checkField:self.userInfo.deli_start andFieldTwo:nil countText:0 andType:@"text" andErrorMessage:@"Введите время доставки"]) {
                countErr+=1;
            } else if ([CheckRequiredField checkField:self.userInfo.deli_end andFieldTwo:nil countText:0 andType:@"text" andErrorMessage:@"Введите время доставки"]) {
                countErr+=1;
            }
        } else if ([self.userInfo.like_delivery integerValue] == 1) { //доставка по почте
            if ([CheckRequiredField checkField:self.userInfo.us_fam andFieldTwo:nil countText:0 andType:@"text" andErrorMessage:@"Введите фамилию"]) {
                countErr+=1;
            } else if ([CheckRequiredField checkField:self.userInfo.us_otch andFieldTwo:nil countText:0 andType:@"text" andErrorMessage:@"Введите отчество"]) {
                countErr+=1;
            } else if ([CheckRequiredField checkField:self.userInfo.addr_index andFieldTwo:nil countText:6 andType:@"text" andErrorMessage:@"Введите индекс"]) {
                countErr+=1;
            }
        } else if ([self.userInfo.like_delivery integerValue] == 2) { //доставка транспортной компанией
            if ([CheckRequiredField checkField:self.userInfo.us_fam andFieldTwo:nil countText:0 andType:@"text" andErrorMessage:@"Введите фамилию"]) {
                countErr+=1;
            } else if ([CheckRequiredField checkField:self.userInfo.us_otch andFieldTwo:nil countText:0 andType:@"text" andErrorMessage:@"Введите отчество"]) {
                countErr+=1;
            } else if ([CheckRequiredField checkField:self.userInfo.doc_num andFieldTwo:nil countText:0 andType:@"text" andErrorMessage:@"Введите серию и номер паспорта"]) {
                countErr+=1;
            } else if ([CheckRequiredField checkField:self.userInfo.transport andFieldTwo:nil countText:0 andType:@"text" andErrorMessage:@"Выберите транспортную компанию"]) {
                countErr+=1;
            }
        } else if ([CheckRequiredField checkField:self.userInfo.like_pay andFieldTwo:nil countText:0 andType:@"text" andErrorMessage:@"Выберите тип оплаты"]) {
            countErr+=1;
        }
        
        
        
    }else if ([self.userInfo.us_type integerValue] == 1){//ЮР лицо
        if ([CheckRequiredField checkField:self.userInfo.ord_name andFieldTwo:nil countText:0 andType:@"text" andErrorMessage:@"Введите верное имя"]) {
            countErr+=1;
        } else if ([CheckRequiredField checkField:self.userInfo.phone andFieldTwo:nil countText:11 andType:@"phone" andErrorMessage:@"Введите верный номер телефона"]) {
            countErr+=1;
        } else if ([CheckRequiredField checkField:self.userInfo.email andFieldTwo:nil countText:0 andType:@"email" andErrorMessage:@"Введите верный Email"]) {
            countErr+=1;
        } else if ([CheckRequiredField checkField:self.userInfo.org_name andFieldTwo:nil countText:0 andType:@"text" andErrorMessage:@"Введите верное название организации"]) {
            countErr+=1;
        } else if ([CheckRequiredField checkField:self.userInfo.address andFieldTwo:nil countText:0 andType:@"text" andErrorMessage:@"Введите верный адрес"]) {
            countErr+=1;
        } else if ([CheckRequiredField checkField:self.userInfo.like_delivery andFieldTwo:nil countText:0 andType:@"text" andErrorMessage:@"Выберите тип доставки"]) {
            countErr+=1;
        } else if ([self.userInfo.like_delivery integerValue] == 0) {
            if ([CheckRequiredField checkField:self.userInfo.deli_start andFieldTwo:nil countText:0 andType:@"text" andErrorMessage:@"Введите время доставки"]) {
                countErr+=1;
            } else if ([CheckRequiredField checkField:self.userInfo.deli_end andFieldTwo:nil countText:0 andType:@"text" andErrorMessage:@"Введите время доставки"]) {
                countErr+=1;
            }
        } else if ([self.userInfo.like_delivery integerValue] == 1) { //доставка по почте
            if ([CheckRequiredField checkField:self.userInfo.org_name andFieldTwo:nil countText:0 andType:@"text" andErrorMessage:@"Введите верное название организации"]) {
                countErr+=1;
            } else if ([CheckRequiredField checkField:self.userInfo.contact andFieldTwo:nil countText:0 andType:@"text" andErrorMessage:@"Введите контактное лицо"]) {
                countErr+=1;
            } else if ([CheckRequiredField checkField:self.userInfo.inn andFieldTwo:nil countText:0 andType:@"text" andErrorMessage:@"Введите ИНН"]) {
                countErr+=1;
            } else if ([CheckRequiredField checkField:self.userInfo.kpp andFieldTwo:nil countText:0 andType:@"text" andErrorMessage:@"Введите КПП"]) {
                countErr+=1;
            }
        } else if ([self.userInfo.like_delivery integerValue] == 2) { //доставка транспортной компанией
            if ([CheckRequiredField checkField:self.userInfo.org_name andFieldTwo:nil countText:0 andType:@"text" andErrorMessage:@"Введите верное название организации"]) {
                countErr+=1;
            } else if ([CheckRequiredField checkField:self.userInfo.contact andFieldTwo:nil countText:0 andType:@"text" andErrorMessage:@"Введите контактное лицо"]) {
                countErr+=1;
            } else if ([CheckRequiredField checkField:self.userInfo.inn andFieldTwo:nil countText:0 andType:@"text" andErrorMessage:@"Введите ИНН"]) {
                countErr+=1;
            } else if ([CheckRequiredField checkField:self.userInfo.transport andFieldTwo:nil countText:0 andType:@"text" andErrorMessage:@"Выберите транспортную компанию"]) {
                countErr+=1;
            }
        } else if ([CheckRequiredField checkField:self.userInfo.like_pay andFieldTwo:nil countText:0 andType:@"text" andErrorMessage:@"Выберите тип оплаты"]) {
            countErr+=1;
        }

        
    }
    
    NSLog(@"%d", countErr);
    
    if(countErr == 0){
        [self.delegate getApiCreateOrder:self];
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
    if (textView.tag == 3000) {
        self.labelNumberWords.text = [NSString stringWithFormat:@"%d", labelCount];
    } else if (textView.tag == 3001) {
        self.labelNumberComments.text = [NSString stringWithFormat:@"%d", labelCount];
    }
    
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
    
    
    
    if (textView.tag == 3000) {
      
        [self animathionMethodUpAndDownWithView:self.mainScrollView endHieght:200.f andUpAndDown:YES addOther:^{
            self.mainScrollView.contentOffset = CGPointMake(0.f, 40.f);
            
        }];
    } else if (textView.tag == 3001) {
              [self animathionMethodUpAndDownWithView:self.mainScrollView endHieght:200.f andUpAndDown:YES addOther:^{
            self.mainScrollView.contentOffset = CGPointMake(0.f, 850.f);
            
        }];
    }

}


- (void)textViewDidChange:(UITextView *)textView {
    NSLog(@"LOG %@", textView.text);
    UserInfoDbClass * userInfoDbClass = [[UserInfoDbClass alloc] init];
    
    if(textView.tag == 3000){
     NSString * string = textView.text;
        if(string.length == 0){
            string = @"EMPTY";
        }else{
            string = textView.text;
        }
        
          [userInfoDbClass checkUserInfo:@"" phone:@"" ord_name:@"" us_fam:@"" us_otch:@"" us_type:@"" inn:@"" kpp:@"" like_delivery:@"" like_tk:@"" like_pay:@"" doc_date:@"" doc_vend:@"" doc_num:@"" org_name:@"" addr_index:@"" contact:@"" address:string deli_start:@"" deli_end:@"" transport:@"" comment:@""];
        
      
        
    }
    
    if(textView.tag == 3001){
        NSString * string = textView.text;
        if(string.length == 0){
            string = @"EMPTY";
        }else{
            string = textView.text;
        }
        
        [userInfoDbClass checkUserInfo:@"" phone:@"" ord_name:@"" us_fam:@"" us_otch:@"" us_type:@"" inn:@"" kpp:@"" like_delivery:@"" like_tk:@"" like_pay:@"" doc_date:@"" doc_vend:@"" doc_num:@"" org_name:@"" addr_index:@"" contact:@"" address:@"" deli_start:@"" deli_end:@"" transport:@"" comment:string];

       
        
    }
    
   

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
- (UIView*) customViewWithFrame: (CGRect) frame andTitlName: (NSString*) nameTitl andView: (UIView*) actionView andBorderView: (UIView*) borderView andBlock: (void(^)(void)) block {
    UIView * viewTypeBuyer = [[UIView alloc] initWithFrame:frame];
    
    CustomLabels * labelBuyer = [[CustomLabels alloc] initLabelWithWidht:15.f andHeight:15.f andColor:VM_COLOR_900
                                                                 andText:nameTitl andTextSize:15 andLineSpacing:0.f fontName:VM_FONT_REGULAR];
    [viewTypeBuyer addSubview:labelBuyer];
    
    borderView.frame = CGRectMake(14.f, 39.f, self.frame.size.width - 28.f, viewTypeBuyer.frame.size.height - 48.f);
    borderView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    borderView.layer.borderWidth = 1.f;
    [viewTypeBuyer addSubview:borderView];
    
    actionView.frame = CGRectMake(15.f, 40.f, self.frame.size.width - 30.f, viewTypeBuyer.frame.size.height - 50.f);
    actionView.backgroundColor = [UIColor whiteColor];
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
    
    CGRect rectBorder = self.borderViewPerson.frame;
    rectBorder.size.height -= 40.f;
    self.borderViewPerson.frame = rectBorder;
    
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
    
    CGRect rectBorder = self.borderViewPerson.frame;
    rectBorder.size.height += 40.f;
    self.borderViewPerson.frame = rectBorder;
    
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
- (void) customHideViewWithHeight: (CGFloat) costHeight andView: (UIView*) view andNumberParams: (NSInteger) numbarParams andBool: (BOOL) upAndDown andDuraction: (CGFloat) duraction andBorderView: (UIView*) borderView {
    [UIView animateWithDuration:duraction animations:^{
        CGRect rect = view.frame;
        if (upAndDown) {
            rect.size.height -= costHeight;
        } else {
            rect.size.height += costHeight;
        }
        
        CGRect borderRect = borderView.frame;
        if (upAndDown) {
            borderRect.size.height -= costHeight;
        } else {
            borderRect.size.height += costHeight;
        }
        
        view.frame = rect;
        borderView.frame = borderRect;
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


//Если принимает YES показывает физ текст филды, иначе показываает юр текст филды
- (void) hideTestFildsWithCustomer:(BOOL) customer {
    
    [UIView animateWithDuration:0.3 animations:^{
        if (customer) {
            for (UIView * view in self.arrayTextFildFiz) {
                view.alpha = 1;
            }
            for (UIView * view in self.arrayTextFildYur) {
                view.alpha = 0.f;
            }
        } else {
            for (UIView * view in self.arrayTextFildFiz) {
                view.alpha = 0;
            }
            for (UIView * view in self.arrayTextFildYur) {
                view.alpha = 1.f;
            }
        }
    }];

}

#pragma mark - InputTextViewDelegate

- (void) inputText: (InputTextView*) inputTextView {
    NSLog(@"%@ TAG %ld", inputTextView.textFieldInput.text,inputTextView.tag);
    
    InputTextView * nameTextView = (InputTextView *) [self viewWithTag:5000];
    NSString * name = nameTextView.textFieldInput.text;
    
    InputTextView * phoneTextView = (InputTextView *) [self viewWithTag:5001];
    NSString * phone = phoneTextView.textFieldInput.text;
    
    InputTextView * emailTextView = (InputTextView *) [self viewWithTag:5002];
     NSString * email = emailTextView.textFieldInput.text;
    
    InputTextView * famTextView = (InputTextView *) [self viewWithTag:225];
     NSString * fam =  famTextView.textFieldInput.text;
    
    InputTextView * othTextView = (InputTextView *) [self viewWithTag:226];
    NSString * oth =  othTextView.textFieldInput.text;
    
    InputTextView * passTextView = (InputTextView *) [self viewWithTag:227];
     NSString * passport =  passTextView.textFieldInput.text;
    
    InputTextView * indexTextView = (InputTextView *) [self viewWithTag:802];
    NSString * index = indexTextView.textFieldInput.text;
    
    
    InputTextView * pochFamTextView = (InputTextView *) [self viewWithTag:800];
    NSString * pochFam =  pochFamTextView.textFieldInput.text;
    
    InputTextView * pochOthTextView = (InputTextView *) [self viewWithTag:801];
    NSString * pochOth =  pochOthTextView.textFieldInput.text;
    
    /////
    
 
   
    
   
    
    InputTextView * nameOrgTextView = (InputTextView *) [self viewWithTag:6000];
    NSString * nameOrg =  nameOrgTextView.textFieldInput.text;
    
    InputTextView * phoneOrgTextView = (InputTextView *) [self viewWithTag:6001];
    NSString * phoneOrg =  phoneOrgTextView.textFieldInput.text;
    
    InputTextView * emailOrgTextView = (InputTextView *) [self viewWithTag:6002];
    NSString * emailOrg =  emailOrgTextView.textFieldInput.text;
    
    InputTextView * orgTextView = (InputTextView *) [self viewWithTag:6003];
    NSString * org =  orgTextView.textFieldInput.text;
    
    
    InputTextView * orgNameTextView = (InputTextView *) [self viewWithTag:1225];
    NSString * orgName = orgNameTextView.textFieldInput.text;
    
    InputTextView * contactTextView = (InputTextView *) [self viewWithTag:1226];
    NSString * contact = contactTextView.textFieldInput.text;
    
    InputTextView * innTextView = (InputTextView *) [self viewWithTag:1227];
    NSString * inn = innTextView.textFieldInput.text;
    
    NSLog(@"INN %@",inn);
    
    
    InputTextView * orgNamePochtTextView = (InputTextView *) [self viewWithTag:1800];
    NSString * orgNamePocht = orgNamePochtTextView.textFieldInput.text;
    
    InputTextView * pochContactTextView = (InputTextView *) [self viewWithTag:1801];
    NSString * pochContact = pochContactTextView.textFieldInput.text;
    
    InputTextView * pochInnTextView = (InputTextView *) [self viewWithTag:1802];
    NSString * pochInn = pochInnTextView.textFieldInput.text;
    
    
    InputTextView * kppTextView = (InputTextView *) [self viewWithTag:1803];
    NSString * pochKpp = kppTextView.textFieldInput.text;
    
    
    NSString * trueFam;
    NSString * trueOth;
   
    NSString * trueOrgName;
    NSString * trueName;
    NSString * truePhone;
    NSString * trueEmail;
    NSString * trueInn;
    NSString * trueContact;
    
   
    
    
    switch (inputTextView.tag) {
        case 5000:
            trueName = name;
            nameOrgTextView.textFieldInput.text=name;
            trueFam = fam;
            trueOth = oth;
            truePhone = phone;
            trueEmail = email;
            trueOrgName = org;
            trueInn = inn;
            trueContact = contact;
            break;
        case 6000:
            trueName = name;
            nameTextView.textFieldInput.text=nameOrg;
            trueFam = fam;
            trueOth = oth;
            truePhone = phone;
            trueEmail = email;
            trueOrgName = org;
            trueInn = inn;
            trueContact = contact;
            break;
            
        case 5001:
            truePhone = phone;
            phoneOrgTextView.textFieldInput.text=phone;
            
            trueName = name;
            trueFam = fam;
            trueOth = oth;
            trueEmail = email;
            trueOrgName = org;
            trueInn = inn;
            trueContact = contact;
            break;
        case 6001:
            truePhone = phone;
            phoneTextView.textFieldInput.text=phoneOrg;
            
            trueName = name;
            trueFam = fam;
            trueOth = oth;
            trueEmail = email;
            trueOrgName = org;
            trueInn = inn;
            trueContact = contact;
            break;
            
        case 5002:
            trueEmail = email;
            emailOrgTextView.textFieldInput.text=email;
            
            trueName = name;
            trueFam = fam;
            trueOth = oth;
            truePhone = phone;
            trueOrgName = org;
            //trueInn = inn;
            trueContact = contact;
            break;
            
        case 6002:
            trueEmail = email;
            emailTextView.textFieldInput.text=emailOrg;
            trueName = name;
            trueFam = fam;
            trueOth = oth;
            truePhone = phone;
            trueOrgName = org;
            trueInn = inn;
            trueContact = contact;
            break;
            
            //Зависимости
        case 6003:
            trueName = name;
            trueFam = fam;
            trueOth = oth;
            truePhone = phone;
            trueEmail = email;
            trueOrgName = org;
            trueInn = inn;
            trueContact = contact;
            
            orgNameTextView.textFieldInput.text=org;
            orgNamePochtTextView.textFieldInput.text=org;
            
            break;
        case 1225:
            trueName = name;
            trueFam = fam;
            trueOth = oth;
            truePhone = phone;
            trueEmail = email;
            trueInn = inn;
            trueContact = contact;
            
            trueOrgName = orgName;
            orgTextView.textFieldInput.text=orgName;
            orgNamePochtTextView.textFieldInput.text=orgName;
            
            break;
        case 1800:
            trueName = name;
            trueFam = fam;
            trueOth = oth;
            truePhone = phone;
            trueEmail = email;
            trueInn = inn;
            trueContact = contact;
            
            trueOrgName = orgNamePocht;
            orgTextView.textFieldInput.text=orgNamePocht;
            orgNameTextView.textFieldInput.text=orgNamePocht;
            
            break;
            
        case 1227:
            NSLog(@"1227");
            trueName = name;
            trueFam = fam;
            trueOth = oth;
            truePhone = phone;
            trueEmail = email;
            trueOrgName = org;
            trueContact = contact;
            
            trueInn = inn;
            pochInnTextView.textFieldInput.text = inn;
            break;
            
        case 1802:
            NSLog(@"1802");
            trueName = name;
            trueFam = fam;
            trueOth = oth;
            truePhone = phone;
            trueEmail = email;
            trueOrgName = org;
            trueContact = contact;
            
            trueInn = pochInn;
            innTextView.textFieldInput.text = pochInn;
            break;
            
        case 1226:
            
            trueName = name;
            trueFam = fam;
            trueOth = oth;
            truePhone = phone;
            trueEmail = email;
            trueOrgName = org;
            trueInn = inn;
            
            trueContact = contact;
            pochContactTextView.textFieldInput.text = contact;
            break;
            
        case 1801:
            
            trueName = name;
            trueFam = fam;
            trueOth = oth;
            truePhone = phone;
            trueEmail = email;
            trueOrgName = org;
            trueInn = inn;
            
            trueContact = pochContact;
            contactTextView.textFieldInput.text = pochContact;
            break;
            
        case 225:
            
            trueName = name;
            
            trueOth = oth;
            truePhone = phone;
            trueEmail = email;
            trueOrgName = org;
            trueInn = inn;
            
            trueFam = fam;
            pochFamTextView.textFieldInput.text = fam;
            break;
            
        case 800:
            
            trueName = name;
            
            trueOth = oth;
            truePhone = phone;
            trueEmail = email;
            trueOrgName = org;
            trueInn = inn;
            
            trueFam = pochFam;
            famTextView.textFieldInput.text = pochFam;
            break;
            
        case 226:
            
            trueName = name;
            trueFam = fam;
            truePhone = phone;
            trueEmail = email;
            trueOrgName = org;
            trueInn = inn;
            
            trueOth = oth;
            pochOthTextView.textFieldInput.text = oth;
            break;
        case 801:
            
            trueName = name;
            trueFam = fam;
            truePhone = phone;
            trueEmail = email;
            trueOrgName = org;
            trueInn = inn;
            
            trueOth = pochOth;
            othTextView.textFieldInput.text = pochOth;
            break;
            
        default:
            trueName = name;
            trueFam = fam;
            trueOth = oth;
            truePhone = phone;
            trueEmail = email;
            trueOrgName = org;
            trueInn = inn;
            trueContact = contact;
            
            break;
    }
    
     NSLog(@"TRUE NAME %@",trueName);
    
    
    //Частник
    if(trueName.length == 0){
        trueName = @"EMPTY";
    }
    if(trueFam.length == 0){
        trueFam = @"EMPTY";
    }
    if(trueOth.length == 0){
        trueOth = @"EMPTY";
    }
    if([truePhone isEqualToString:@"+7"] || [truePhone isEqualToString:@"+"]){
        truePhone = @"EMPTY";
    }
    if(truePhone.length == 0){
        truePhone = @"EMPTY";
    }
    
    if(trueEmail.length == 0){
        trueEmail = @"EMPTY";
    }
    
    //ЮР Лицо
    if(trueOrgName.length == 0 ){
        trueOrgName = @"EMPTY";
    }
    
    if(trueContact.length == 0 ){
        trueContact = @"EMPTY";
    }
    
    NSLog(@"TRUEINN: %@",trueInn);
    
    if(trueInn.length == 0 ){
        trueInn = @"EMPTY";
    }
    
    if(pochKpp.length == 0){
        pochKpp = @"EMPTY";
    }
    
    if(passport.length == 0 ){
        passport = @"EMPTY";
    }
    if(index.length == 0){
        index = @"EMPTY";
    }
    
    if(pochContact.length == 0){
        pochContact = @"EMPTY";
    }
    
    for(InputTextView * ourFiz in self.arrayTextFildFiz ){
        
         [self animationPlaceHolderWithInputText:ourFiz];
    }
    
    for(InputTextView * ourYour in self.arrayTextFildYur){
        
        [self animationPlaceHolderWithInputText:ourYour];
    }
   
    
       UserInfoDbClass * userInfoDbClass = [[UserInfoDbClass alloc] init];
    
    
        [userInfoDbClass checkUserInfo:trueEmail phone:truePhone ord_name:trueName us_fam:trueFam us_otch:trueOth us_type:@"" inn:trueInn kpp:pochKpp like_delivery:@"" like_tk:@"" like_pay:@"" doc_date:@"" doc_vend:@"" doc_num:passport org_name:trueOrgName addr_index:index contact:trueContact address:@"" deli_start:@"" deli_end:@"" transport:@"" comment:@""];
        
    


    //

}

//Метод скрывает все текст филды если булл YES скрываются юр лица, если BOOL NO скрываются физ лица

- (void) animationPlaceHolderWithInputText: (InputTextView*) inputTextView {
    if (inputTextView.textFieldInput.isBoll == YES && inputTextView.textFieldInput.text.length !=0) {
        CGRect rect;
        rect = inputTextView.labelPlaceHoldInput.frame;
        rect.origin.x = rect.origin.x + 100.f;
        inputTextView.labelPlaceHoldInput.frame = rect;
        inputTextView.labelPlaceHoldInput.alpha = 0.f;
        inputTextView.textFieldInput.isBoll = NO;
    }else if(inputTextView.textFieldInput.isBoll == NO && inputTextView.textFieldInput.text.length ==0){
        CGRect rect;
        rect = inputTextView.labelPlaceHoldInput.frame;
        rect.origin.x = rect.origin.x - 100.f;
        inputTextView.labelPlaceHoldInput.frame = rect;
        inputTextView.labelPlaceHoldInput.alpha = 1.f;
        inputTextView.textFieldInput.isBoll = YES;
    }
}


@end
