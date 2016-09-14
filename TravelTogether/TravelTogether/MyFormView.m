//
//  MyFormView.m
//  TravelTogether
//
//  Created by Виктор Мишустин on 24/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "MyFormView.h"
#import "HexColors.h"
#import "Macros.h"
#import "CustomLabels.h"
#import "UIButton+ButtonImage.h"
#import "UIView+BorderView.h"
#import "InputTextView.h"
#import <NSDate+TimeAgo.h>
#import "InputTextToView.h"
#import "MBSwitch.h"

@interface MyFormView () <UITableViewDelegate, UITableViewDataSource>

//Main----------

@property (strong, nonatomic) NSArray * arrayData;
@property (strong, nonatomic) UIView * foneView;
@property (strong, nonatomic) NSArray * arrayCountry;
@property (strong, nonatomic) NSArray * timeArray;
@property (assign, nonatomic) NSInteger takeButton;
@property (strong, nonatomic) UIView * searchView;
@property (strong, nonatomic) NSArray * arrayImages;


//LogoView

@property (strong, nonatomic) UIView * logoView;

//ScrollSetting

@property (strong, nonatomic) UIScrollView * scrollSetting;
@property (strong, nonatomic) UIView * datePickerView;
@property (strong, nonatomic) NSString * timeAgo; //Год рождения
@property (strong, nonatomic) UIButton * buttonAge; //кнопка возраста
@property (strong, nonatomic) UIButton * buttonCity; //Кнопка города
@property (strong, nonatomic) UIButton * buttonPushDate; //Кнопка выбора возраста
@property (strong, nonatomic) InputTextView * inputText;
@property (strong, nonatomic) UITableView * tableSearch;
@property (strong, nonatomic) UIImageView * imageViewPhoto;
@property (strong, nonatomic) UIView * mainPhotoView;
@property (strong, nonatomic) UIScrollView * aboutMeScrollView;



@end

@implementation MyFormView

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 64.f, view.frame.size.width, view.frame.size.height - 64.f);
        self.arrayData = data;
        self.arrayCountry = [NSArray arrayWithObjects:
                             @"Австралия", @"Австрия",@"Азербайджан",@"Белоруссия",@"Бенин",
                             @"Вануату",@"Венесуэла",@"Гамбия",@"Германия",@"Иран",@"Казахстан",@"Лаос", nil];
        self.timeArray = self.arrayCountry;
        
        //Logo-------
        self.logoView = [self createLogoView];
        [self addSubview:self.logoView];
        
        //ScrollSetting
        [self addSubview:[self createScrollSetting]];
        
        //Фоновое вью необходимо для блокировки действий
        self.foneView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
        self.foneView.backgroundColor = [UIColor blackColor];
        self.foneView.alpha = 0.f;
        [self addSubview:self.foneView];
        //Джестер для фона--
        UITapGestureRecognizer *singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handleSingleTap:)];
        [self.foneView addGestureRecognizer:singleFingerTap];
        
        //Скрытые доп элементы;
        self.datePickerView = [self setDatePicker];
        [self addSubview:self.datePickerView];
        
        //ViewSerach
        self.searchView = [self searchViewWith:self];
        [self addSubview:self.searchView];
        
        //PhotoView
        self.mainPhotoView = [self createImageView];
        self.mainPhotoView.alpha = 0.f;
        [self addSubview:self.mainPhotoView];

        
    }
    return self;
}

#pragma mark - Logo

- (UIView*) createLogoView {
    
    UIView * viewAva = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, 182.5f)];
    if (isiPhone6) {
        viewAva.frame = CGRectMake(0.f, 0.f, self.frame.size.width, 215.5f);
    }
    NSDictionary * dictData = [self.arrayData objectAtIndex:0];
    self.arrayImages = [dictData objectForKey:@"arrayImage"];
    
    UIImageView * imageAva = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, 182.5f)];
    if (isiPhone6) {
        imageAva.frame = CGRectMake(0.f, 0.f, self.frame.size.width, 215.5f);
    }
    imageAva.image = [UIImage imageNamed:[dictData objectForKey:@"image"]];
    [viewAva addSubview:imageAva];
    
    UIButton * buttonLike = [UIButton createButtonWithImage:@"likeButtonImage.png" anfFrame:CGRectMake(70.f, 140.f, 33.f, 33.f)];
    if (isiPhone6) {
        buttonLike.frame = CGRectMake(82.5f, 162.5f, 40.f, 40.f);
    }
    buttonLike.alpha = 0.7f;
    [buttonLike addTarget:self action:@selector(buttonLikeAction) forControlEvents:UIControlEventTouchUpInside];
    [viewAva addSubview:buttonLike];
    
    CustomLabels * labelbuttonLike = [[CustomLabels alloc] initLabelTableWithWidht:0.f andHeight:0.f andSizeWidht:33.f
                                                                     andSizeHeight:33.f andColor:VM_COLOR_PINK andText:[dictData objectForKey:@"countLike"]];
    labelbuttonLike.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_LIGHT size:7];
    if (isiPhone6) {
        labelbuttonLike.frame = CGRectMake(0.f, 0.f, 40.f, 40.f);
        labelbuttonLike.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_LIGHT size:8];
    }
    [buttonLike addSubview:labelbuttonLike];
    
    UIButton * buttonMessege = [UIButton createButtonWithImage:@"messageButtonImage.png" anfFrame:CGRectMake(self.frame.size.width - 103.f, 140.f, 33.f, 33.f)];
    if (isiPhone6) {
        buttonMessege.frame = CGRectMake(self.frame.size.width - 122.5f, 162.5f, 40.f, 40.f);
    }
    buttonMessege.alpha = 0.7f;
    [buttonMessege addTarget:self action:@selector(buttonMessegeAction) forControlEvents:UIControlEventTouchUpInside];
    [viewAva addSubview:buttonMessege];
    
    CustomLabels * labelbuttonMessege = [[CustomLabels alloc] initLabelTableWithWidht:0.f andHeight:0.f andSizeWidht:33.f
                                                                     andSizeHeight:33.f andColor:@"ffffff" andText:[dictData objectForKey:@"countMessage"]];
    labelbuttonMessege.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_LIGHT size:7];
    if (isiPhone6) {
        labelbuttonMessege.frame = CGRectMake(0.f, 0.f, 40.f, 40.f);
        labelbuttonMessege.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_LIGHT size:8];
    }
    [buttonMessege addSubview:labelbuttonMessege];
    
    CustomLabels * labelName = [[CustomLabels alloc] initLabelTableWithWidht:103.f andHeight:148.f
                                                                andSizeWidht:114.f andSizeHeight:20
                                                                    andColor:@"ffffff" andText:[dictData objectForKey:@"name"]];
    labelName.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:10];
    if (isiPhone6) {
        labelName.frame = CGRectMake(122.5f, 161.25f, 136.25f, 40.f);
        labelName.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_LIGHT size:12];
    }
    labelName.textColor = [UIColor whiteColor];
    [viewAva addSubview:labelName];
    
    CustomLabels * labelCity = [[CustomLabels alloc] initLabelTableWithWidht:103.f andHeight:160.f
                                                                andSizeWidht:114.f andSizeHeight:20
                                                                    andColor:@"ffffff" andText:[dictData objectForKey:@"city"]];
    labelCity.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:10];
    if (isiPhone6) {
        labelCity.frame = CGRectMake(122.5f, 175.f, 136.25f, 40.f);
        labelCity.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_LIGHT size:12];
    }
    labelCity.textColor = [UIColor whiteColor];
    [viewAva addSubview:labelCity];
    
    return viewAva;
}

#pragma mark - ScrollSetting

- (UIView*) createScrollSetting {
    UIView * scrollSettingView = [[UIView alloc] initWithFrame:CGRectMake(0.f, self.logoView.frame.size.height, self.frame.size.width,
                                                                          self.frame.size.height - self.logoView.frame.size.height)];
    
    self.scrollSetting = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, scrollSettingView.frame.size.width, scrollSettingView.frame.size.height)];
    self.scrollSetting.contentSize = CGSizeMake(scrollSettingView.frame.size.width * 3, 0.f);
    self.scrollSetting.pagingEnabled = YES;
    self.scrollSetting.scrollEnabled = NO;
    self.scrollSetting.showsHorizontalScrollIndicator = NO;
    [scrollSettingView addSubview:self.scrollSetting];
    
    [self.scrollSetting addSubview:[self createViewOboutMeWithView:self.scrollSetting]];
    [self.scrollSetting addSubview:[self createViewIWantWithView:self.scrollSetting]];
    [self.scrollSetting addSubview:[self createViewPhotoWithView:self.scrollSetting]];
    
    //button navigation for ScrollView
    NSArray * arrayNameButtonsScroll = [NSArray arrayWithObjects:@"О себе", @"Я хочу", @"Фото", nil];
    for (int i = 0; i < 3; i ++) {
        UIButton * buttonScroll = [UIButton buttonWithType:UIButtonTypeSystem];
        if (i == 0) {
            buttonScroll.frame = CGRectMake(44.f, 13.f, 81.f, 21.f);
            if (isiPhone6) {
                buttonScroll.frame = CGRectMake(51.f, 16.5f, 95.f, 25.f);
            }
            buttonScroll.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK];
            [buttonScroll setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            buttonScroll.userInteractionEnabled = NO;
        } else {
            buttonScroll.frame = CGRectMake(145.f + 72.5 * (i - 1), 13.f, 51.f, 21.f);
            if (isiPhone6) {
                buttonScroll.frame = CGRectMake(170.f + 85.f * (i - 1), 16.5f, 60.f, 25.f);
            }
            buttonScroll.backgroundColor = [UIColor whiteColor];
            [buttonScroll setTitleColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK] forState:UIControlStateNormal];
        }
        buttonScroll.tag = 10 + i;
        [buttonScroll setTitle:[arrayNameButtonsScroll objectAtIndex:i] forState:UIControlStateNormal];
        buttonScroll.layer.borderWidth = 0.7f;
        buttonScroll.layer.borderColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK].CGColor;
        buttonScroll.layer.cornerRadius = 10.5f;
        if (isiPhone6) {
            buttonScroll.layer.cornerRadius = 12.5f;
        }
        buttonScroll.titleLabel.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:10];
        [buttonScroll addTarget:self action:@selector(buttonScrollAction:) forControlEvents:UIControlEventTouchUpInside];
        [scrollSettingView addSubview:buttonScroll];
    }
    
    
    return scrollSettingView;
}

//Первое окно вью "О СЕБЕ"
- (UIView*) createViewOboutMeWithView: (UIView*) view {
    UIView * aboutMeView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, view.frame.size.width, view.frame.size.height)];
    self.aboutMeScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 48.f, view.frame.size.width, view.frame.size.height - 48)];
    
    
    
    UITapGestureRecognizer * singleFingerTapReturn = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                             action:@selector(singleFingerTapReturn:)];
    [self.aboutMeScrollView addGestureRecognizer:singleFingerTapReturn];
    
    
    
    if (isiPhone5) {
        self.aboutMeScrollView.frame = CGRectMake(0.f, 48.f, view.frame.size.width, view.frame.size.height - 48.f);
    }
    if (isiPhone6) {
        self.aboutMeScrollView.contentSize = CGSizeMake(0, self.aboutMeScrollView.frame.size.height + 172.5f);
    } else {
        self.aboutMeScrollView.contentSize = CGSizeMake(0, 420.f);
    }
    [aboutMeView addSubview:self.aboutMeScrollView];
    
    InputTextView * inputName = [[InputTextView alloc] initInputTextWithView:aboutMeView andRect:CGRectMake(12.f, 0.f, 150.f, 21.f) andImage:nil andTextPlaceHolder:@"Имя" colorBorder:nil];
    inputName.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"bdbcbc"].CGColor;
    inputName.layer.borderWidth = 1.f;
    inputName.layer.cornerRadius = 10.f;
    if (isiPhone6) {
        inputName.frame = CGRectMake(15.f, 11.5f, 166.f, 25.f);
        inputName.layer.borderWidth = 1.f;
        inputName.layer.cornerRadius = 12.5f;
        inputName.textFieldInput.frame = CGRectMake(10.f, 0.f, 166.f - 10.f, 25.f);
        inputName.textFieldInput.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:12];
        inputName.labelPlaceHoldInput.frame = CGRectMake(10.f, 0.f, 166.f - 10.f, 25.f);
        inputName.labelPlaceHoldInput.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:12];
    }
    [self.aboutMeScrollView addSubview:inputName];
    
    self.buttonAge = [UIButton createButtonTextWithName:@"Возраст" andFrame:CGRectMake(12.f, 34.f, 60.f, 21.f) fontName:VM_FONT_SF_DISPLAY_REGULAR];
    self.buttonAge.layer.borderWidth = 1.f;
    self.buttonAge.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"bdbcbc"].CGColor;
    self.buttonAge.layer.cornerRadius = 10.f;
    [self.buttonAge setTitleColor:[UIColor hx_colorWithHexRGBAString:@"bdbcbc"] forState:UIControlStateNormal];
    self.buttonAge.titleLabel.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:9];
    if (isiPhone6) {
        self.buttonAge.frame = CGRectMake(15.f, 51.5f, 70.f, 25.f);
        self.buttonAge.layer.cornerRadius = 12.5f;
        self.buttonAge.titleLabel.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:12];
    }
    [self.buttonAge addTarget:self action:@selector(buttonAgeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.aboutMeScrollView addSubview:self.buttonAge];
    
    CustomLabels * labelSex = [[CustomLabels alloc] initLabelWithWidht:12.5f andHeight:74.5 andColor:@"bdbcbc" andText:@"Пол" andTextSize:9 andLineSpacing:0.f fontName:VM_FONT_SF_DISPLAY_REGULAR];
    if (isiPhone6) {
        labelSex.frame = CGRectMake(15.f, 99.f, 20, 10);
        labelSex.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:12];
        [labelSex sizeToFit];
    }
    [self.aboutMeScrollView addSubview:labelSex];
    
    for (int i = 0; i < 2; i++) {
        UIButton * buttonSex = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonSex.frame = CGRectMake(46.f + 65.f * i, 68.f, 51.f, 21.f);
        if (isiPhone6) {
            buttonSex.frame = CGRectMake(55.f + 75.f * i, 91.f, 60.f, 25.f);
        }
        if (i == 0) {
            [buttonSex setTitle:@"Жен" forState:UIControlStateNormal];
            buttonSex.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK];
            [buttonSex setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            buttonSex.userInteractionEnabled = NO;
        } else {
            [buttonSex setTitle:@"Муж" forState:UIControlStateNormal];
            buttonSex.backgroundColor = [UIColor whiteColor];
            [buttonSex setTitleColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK] forState:UIControlStateNormal];
        }
        buttonSex.tag = 20 + i;
        buttonSex.layer.borderWidth = 0.7f;
        buttonSex.layer.borderColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK].CGColor;
        buttonSex.layer.cornerRadius = 10.5f;
        buttonSex.titleLabel.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:10];
        if (isiPhone6) {
            buttonSex.layer.cornerRadius = 12.5f;
            buttonSex.titleLabel.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:12];
        }
        [buttonSex addTarget:self action:@selector(buttonSexAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.aboutMeScrollView addSubview:buttonSex];
    }
    
    UIView * cityView = [[UIView alloc] initWithFrame:CGRectMake(12.5f, 102.f, 150.f, 21.f)];
    cityView.layer.borderWidth = 1.f;
    cityView.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"bdbcbc"].CGColor;
    cityView.layer.cornerRadius = 10.f;
    if (isiPhone6) {
        cityView.frame = CGRectMake(15.f, 131.5f, 175.f, 25.f);
        cityView.layer.cornerRadius = 12.5f;
    }
    [self.aboutMeScrollView addSubview:cityView];
    self.buttonCity = [UIButton createButtonTextWithName:@"Местоположение" andFrame:CGRectMake(21.f, 102.f, 150.f, 21.f) fontName:VM_FONT_SF_DISPLAY_REGULAR];
    self.buttonCity.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.buttonCity setTitleColor:[UIColor hx_colorWithHexRGBAString:@"bdbcbc"] forState:UIControlStateNormal];
    self.buttonCity.titleLabel.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:9];
    if (isiPhone6) {
        self.buttonCity.frame = CGRectMake(25.f, 131.5f, 175.f, 25.f);
        self.buttonCity.titleLabel.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:12];
    }
    [self.buttonCity addTarget:self action:@selector(buttonCityAction) forControlEvents:UIControlEventTouchUpInside];
    [self.aboutMeScrollView addSubview:self.buttonCity];
    
    InputTextToView * appearanceText = [[InputTextToView alloc] initWithTextViewFrame:CGRectMake(12.5f, 136.f, self.frame.size.width - 25.f, 37.5f)];
    appearanceText.mainTextView.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:9];
    appearanceText.mainTextView.textColor = [UIColor blackColor];
    appearanceText.layer.borderWidth = 1.f;
    appearanceText.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"bdbcbc"].CGColor;
    appearanceText.placeholder = @"Внешность";
    appearanceText.layer.cornerRadius = 10.f;
    appearanceText.placeHolderLabel.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:9];
    if (isiPhone6) {
        appearanceText.frame = CGRectMake(15.f, 171.f, self.frame.size.width - 30.f, 45.f);
        appearanceText.mainTextView.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:12];
        appearanceText.placeHolderLabel.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:12];
    }
    [self.aboutMeScrollView addSubview:appearanceText];
    
    InputTextToView * aboutMeText = [[InputTextToView alloc] initWithTextViewFrame:CGRectMake(12.5f, 187.5f, self.frame.size.width - 25.f, 71.5f)];
    aboutMeText.mainTextView.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:9];
    aboutMeText.mainTextView.textColor = [UIColor blackColor];
    aboutMeText.layer.borderWidth = 1.f;
    aboutMeText.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"bdbcbc"].CGColor;
    aboutMeText.placeholder = @"О себе";
    aboutMeText.layer.cornerRadius = 10.f;
    aboutMeText.placeHolderLabel.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:9];
    if (isiPhone6) {
        aboutMeText.frame = CGRectMake(15.f, 231.f, self.frame.size.width - 30.f, 85.f);
        aboutMeText.mainTextView.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:12];
        aboutMeText.placeHolderLabel.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:12];
    }
    [self.aboutMeScrollView addSubview:aboutMeText];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startInputTextView:) name:UITextViewTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endInputTextView:) name:UITextViewTextDidEndEditingNotification object:nil];
    
    //ДопЭлементы
    
    UIView * viewVerification = [[UIView alloc] initWithFrame:CGRectMake(0.f, 344.f, self.frame.size.width, 30.f)];
    if (isiPhone5) {
        viewVerification.frame = CGRectMake(0.f, 274.f, self.frame.size.width, 20.f);
    }
    viewVerification.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"e6e6e6"];
    [self.aboutMeScrollView addSubview:viewVerification];
    
    CustomLabels * labelTitlVerification = [[CustomLabels alloc] initLabelWithWidht:15.f andHeight:7.55f  andColor:VM_COLOR_PINK andText:@"Верификация" andTextSize:14 andLineSpacing:0.f fontName:VM_FONT_SF_DISPLAY_REGULAR];
    if (isiPhone5) {
        labelTitlVerification.frame = CGRectMake(12.5f, 0.f, 100.f, 20.f);
        labelTitlVerification.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:9];
//        [labelTitlVerification sizeToFit];
    }
    [viewVerification addSubview:labelTitlVerification];
    
    CustomLabels * labelTextVerification = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:349.f + 25.f andSizeWidht:self.frame.size.width - 30.f andSizeHeight:50.f andColor:@"9c9b9b"
                                                                                 andText:@"Пожалуйста подтвердите ваши данные, что бы мы могли понимать что вы реальный пользователь.\nВаши данные не будут показаны другим пользователям."];
    labelTextVerification.numberOfLines = 0;
    labelTextVerification.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:12];
    if (isiPhone5) {
        labelTextVerification.frame = CGRectMake(15.f, 302.f, self.frame.size.width - 30.f, 40.f);
        labelTextVerification.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:10];
    }
    labelTextVerification.textAlignment = NSTextAlignmentLeft;
    [self.aboutMeScrollView addSubview:labelTextVerification];
    
    NSArray * arrayNameVerification = [NSArray arrayWithObjects:@"Телефон", @"Email", nil];
    
    for (int i = 0; i < 2; i++) {
        InputTextView * inputTextVerification;
        if (isiPhone5) {
            inputTextVerification = [[InputTextView alloc] initInputTextWithView:self.aboutMeScrollView andRect:CGRectMake(72.5f, (52.5f + 300.f) + 34.f * i, 180.f, 21.f) andImage:nil andTextPlaceHolder:[arrayNameVerification objectAtIndex:i] colorBorder:@"bdbcbc"];
        } else {
            inputTextVerification = [[InputTextView alloc] initInputTextWithView:self.aboutMeScrollView andRect:CGRectMake(85.f, (284.f + 30.f + 125.f) + 35 * i, 210.f, 25.f) andImage:nil andTextPlaceHolder:[arrayNameVerification objectAtIndex:i] colorBorder:@"bdbcbc"];
        }
        inputTextVerification.layer.borderWidth = 1.f;
        inputTextVerification.layer.cornerRadius = 12.5f;
        inputTextVerification.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"bdbcbc"].CGColor;
        if (isiPhone5) {
            inputTextVerification.layer.cornerRadius = 10.5f;
        }
        if (i == 0) {
            inputTextVerification.textFieldInput.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        } else {
            inputTextVerification.textFieldInput.keyboardType = UIKeyboardTypeEmailAddress;
        }
        
        inputTextVerification.tag = 500 + i;
        [self.aboutMeScrollView addSubview:inputTextVerification];
        
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputTextVerificationStart) name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endInputTextVerificationStart) name:UITextFieldTextDidEndEditingNotification object:nil];
    
    
    return aboutMeView;
}

//Второе окно вью "Я ХОЧУ"
- (UIView*) createViewIWantWithView: (UIView*) view {
    UIView * iWontView = [[UIView alloc] initWithFrame:CGRectMake(view.frame.size.width, 0.f, view.frame.size.width, view.frame.size.height)];
    
    NSArray * arrayTextTitls = [NSArray arrayWithObjects:@"Общаться", @"Найти попутчика", @"Найти пару", @"Найти новых другей", nil];
    
    for (int i = 0; i < 4; i++) {
        CustomLabels * labelTitls = [[CustomLabels alloc] initLabelWithWidht:12.5f andHeight:53.f + 29.f * i andColor:@"706f6f" andText:[arrayTextTitls objectAtIndex:i] andTextSize:9 andLineSpacing:0.f fontName:VM_FONT_SF_DISPLAY_REGULAR];
        if (isiPhone6) {
            labelTitls.frame = CGRectMake(15.f, 62.5f + 35.f * i, 20, 10);
            labelTitls.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:12];
            [labelTitls sizeToFit];
        }
        [iWontView addSubview:labelTitls];
        
        MBSwitch * swithMale;
        if (isiPhone6) {
            swithMale = [[MBSwitch alloc] initWithFrame:CGRectMake(self.frame.size.width - 55.f, 53.5f + 35 * i, 40.f, 20.f)];;
        } else {
            swithMale = [[MBSwitch alloc] initWithFrame:CGRectMake(self.frame.size.width - 50.f, 46.f + 29.5 * i, 34.f, 16.5f)];
        }
        swithMale.onTintColor = [UIColor hx_colorWithHexRGBAString:@"e9e5e5"];
        swithMale.offTintColor = [UIColor hx_colorWithHexRGBAString:@"e9e5e5"];
        swithMale.thumbTintColor = [UIColor hx_colorWithHexRGBAString:@"b7b7b7"];
        swithMale.tag = 30 + i;
        [swithMale addTarget:self action:@selector(swichMaleAction:) forControlEvents:UIControlEventValueChanged];
        [iWontView addSubview:swithMale];

    }
    NSArray * arrayTextBorder = [NSArray arrayWithObjects:@"Отношения", @"Ориентация", nil];
    for (int i = 0; i < 2; i++) {
        UIView * viewBorder = [[UIView alloc] initWithFrame:CGRectMake(0.f, 164.f + 66.f * i, self.frame.size.width, 20.f)];
        if (isiPhone6) {
            viewBorder.frame = CGRectMake(0.f, 192.5f + 85.f * i, self.frame.size.width, 30.f);
        }
        viewBorder.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"e6e6e6"];
        [iWontView addSubview:viewBorder];

        CustomLabels * labelForBorder = [[CustomLabels alloc] initLabelTableWithWidht:12.5f andHeight:0.f andSizeWidht:200.f andSizeHeight:20.f andColor:VM_COLOR_PINK andText:[arrayTextBorder objectAtIndex:i]];
        labelForBorder.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:9];
        if (isiPhone6) {
            labelForBorder.frame = CGRectMake(15.f, 10.5f, 0, 0);
            labelForBorder.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:12];
            [labelForBorder sizeToFit];
        }
        labelForBorder.textAlignment = NSTextAlignmentLeft;
        [viewBorder addSubview:labelForBorder];
    }
    
    NSArray * relationText = [NSArray arrayWithObjects:@"Свободен", @"В свободных отношениях", @"Занят", nil];
    for (int i = 0; i < 3; i ++) {
        UIButton * buttonRelations = [UIButton buttonWithType:UIButtonTypeSystem];
        if (i == 0) {
            buttonRelations.frame = CGRectMake(12.5f, 197.f, 59.5f, 20.f);
            if (isiPhone6) {
                buttonRelations.frame = CGRectMake(15.f, 237.5f, 70.f, 25.f);
            }
            buttonRelations.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK];
            [buttonRelations setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            buttonRelations.userInteractionEnabled = NO;
        } else {
            buttonRelations.frame = CGRectMake(12.5f + 76.25f * i, 197.f, 141.25f, 20.f);
            if (isiPhone6) {
                buttonRelations.frame = CGRectMake(15.f + 90. * i, 237.5f, 165.f, 25.f);
            }
            if (i == 2) {
                buttonRelations.frame = CGRectMake(12.5f + 237.5 * (i - 1), 197.f, 59.5f, 20.f);
                if (isiPhone6) {
                    buttonRelations.frame = CGRectMake(15.f + 278.75 * (i - 1), 237.5f, 70.f, 25.f);
                }
            }
            buttonRelations.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"e2dfdf"];
            [buttonRelations setTitleColor:[UIColor hx_colorWithHexRGBAString:@"706f6f"] forState:UIControlStateNormal];
        }
        buttonRelations.layer.cornerRadius = 10.f;
        buttonRelations.tag = 40 + i;
        [buttonRelations setTitle:[relationText objectAtIndex:i] forState:UIControlStateNormal];
        buttonRelations.titleLabel.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:10];
        [buttonRelations addTarget:self action:@selector(buttonRelationsAction:) forControlEvents:UIControlEventTouchUpInside];
        if (isiPhone6) {
            buttonRelations.layer.cornerRadius = 12.5f;
            buttonRelations.titleLabel.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:12];
        }
        [iWontView addSubview:buttonRelations];
    }
    
    NSArray * orientationArray = [NSArray arrayWithObjects:@"Гетеро", @"Би", @"Без предубеждений", nil];
    for (int i = 0; i < 3; i++) {
        UILabel * labelOrientation = [[UILabel alloc] initWithFrame:CGRectMake(12.5f, 262.5f + 30 * i, 95.f, 16.5f)];
        if (isiPhone6) {
            labelOrientation.frame = CGRectMake(15.f, 317.75f + 30 * i, 95.f, 22.f);
        }
        MBSwitch * swichOrientation;
        if (isiPhone6) {
            swichOrientation = [[MBSwitch alloc] initWithFrame: CGRectMake(140.f, 317.75f + 30.f * i, 40.f, 20.f)];
        } else {
            swichOrientation = [[MBSwitch alloc] initWithFrame: CGRectMake(120.f, 262.5f + 30.f * i, 34.f, 16.5f)];
        }
        
        if (i == 2) {
            labelOrientation.frame = CGRectMake(170.f, 262.5f, 95.f, 16.5f);
            swichOrientation.frame = CGRectMake(272.5f, 262.5f, 34.f, 16.5f);
            if (isiPhone6) {
                labelOrientation.frame = CGRectMake(200.f, 317.75f, 95.f, 22.f);
                swichOrientation.frame = CGRectMake(320.f, 317.75f, 40.f, 20.f);
            }
        }
        labelOrientation.text = [orientationArray objectAtIndex:i];
        labelOrientation.textColor = [UIColor hx_colorWithHexRGBAString:@"706f6f"];
        labelOrientation.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:9];
        [iWontView addSubview: labelOrientation];
        
        if (i == 0) {
            swichOrientation.thumbTintColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK];
            swichOrientation.on = YES;
            swichOrientation.userInteractionEnabled = NO;
        } else {
            swichOrientation.thumbTintColor = [UIColor hx_colorWithHexRGBAString:@"b7b7b7"];
        }
        swichOrientation.onTintColor = [UIColor hx_colorWithHexRGBAString:@"e9e5e5"];
        swichOrientation.offTintColor = [UIColor hx_colorWithHexRGBAString:@"e9e5e5"];
        swichOrientation.tag = 50 + i;
        [swichOrientation addTarget:self action:@selector(swichOrientationAction:) forControlEvents:UIControlEventValueChanged];
        [iWontView addSubview:swichOrientation];
    }
    return iWontView;
}

//Третье окно вью "ФОТО"
- (UIView*) createViewPhotoWithView: (UIView*) view {
    UIView * photoView = [[UIView alloc] initWithFrame:CGRectMake(view.frame.size.width * 2, 0.f, view.frame.size.width, view.frame.size.height)];
    
    UIScrollView * scrollViewPhoto = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 47.f, self.frame.size.width, photoView.frame.size.height - 46.f)];
    if (isiPhone6) {
        scrollViewPhoto.frame = CGRectMake(0.f, 55.f, self.frame.size.width, photoView.frame.size.height - 55.f);
    }
    scrollViewPhoto.showsVerticalScrollIndicator = NO;
    [photoView addSubview:scrollViewPhoto];
    
    //Элементы создания таблицы
    NSInteger line = 0; //Строки
    NSInteger column = 0; //Столбци
    
    for (int i = 0; i < self.arrayImages.count; i++) {
        UIButton * buttonPhoto = [UIButton createButtonWithImage:[self.arrayImages objectAtIndex:i]
                                                        anfFrame:CGRectMake(0.f + (self.frame.size.width / 3 + 0.5) * column,
                                                                            0.f + (self.frame.size.width / 3 + 0.5) * line,
                                                                            self.frame.size.width / 3 - 0.5f,
                                                                            self.frame.size.width / 3 - 0.5f)];
        buttonPhoto.tag = 60 + i;
        if (i == 0) {
            [buttonPhoto addTarget:self action:@selector(buttonPhotoAdd) forControlEvents:UIControlEventTouchUpInside];
        } else {
        [buttonPhoto addTarget:self action:@selector(buttonPhotoAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        [scrollViewPhoto addSubview:buttonPhoto];
        if (i != self.arrayImages.count - 1) {
            column += 1;
            if (column > 2) {
                column = 0;
                line += 1;
            }
        }
    }
    
    scrollViewPhoto.contentSize = CGSizeMake(0.f, (self.frame.size.width / 3) * (line + 1));

    return photoView;
}

//AgeDatePicker
- (UIView*) setDatePicker {
    UIView * viewDatePicker = [[UIView alloc] initWithFrame:CGRectMake(0.f, self.frame.size.height + 182.5f, self.frame.size.width, 230.f)];
    viewDatePicker.backgroundColor = [UIColor whiteColor];
    
    UIDatePicker * datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, 190.f)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    NSDate * oldDate = [self logicalYearAgo:[NSDate date]];
    datePicker.maximumDate = oldDate;
    [datePicker addTarget:self action:@selector(datePickerAction:) forControlEvents:UIControlEventValueChanged];
    [viewDatePicker addSubview:datePicker];
    
    self.buttonPushDate = [UIButton buttonWithType:UIButtonTypeSystem];
    self.buttonPushDate.frame = CGRectMake(viewDatePicker.frame.size.width / 2.f + 50, 190.f, 80.f, 20.f);
    [self.buttonPushDate setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.buttonPushDate setTitle:@"Готово" forState:UIControlStateNormal];
    [self.buttonPushDate setTitleColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK] forState:UIControlStateNormal];
    self.buttonPushDate.enabled = NO;
//    self.buttonPushDate.layer.borderWidth = 0.7f;
//    self.buttonPushDate.layer.borderColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK].CGColor;
    self.buttonPushDate.layer.cornerRadius = 10.f;
    self.buttonPushDate.titleLabel.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:15];
    [self.buttonPushDate addTarget:self action:@selector(buttonPushDateAction) forControlEvents:UIControlEventTouchUpInside];
    [viewDatePicker addSubview:self.buttonPushDate];
    
    return viewDatePicker;
}

#pragma mark - Actions

- (void) singleFingerTapReturn:(UITapGestureRecognizer *)recognizer {
    
    [self endEditing:YES];

}

- (void) inputTextVerificationStart {
    
    self.aboutMeScrollView.scrollEnabled = NO;
    
    if (self.aboutMeScrollView.contentOffset.y > 50) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = self.frame;
            if (isiPhone5) {
                rect.origin.y -= 335;
                self.aboutMeScrollView.contentOffset = CGPointMake(0, 168.f);
            } else {
                rect.origin.y -= 410;
                self.aboutMeScrollView.contentOffset = CGPointMake(0, 180.f);
            }
            self.frame = rect;
        }];
        
        
    }
}

- (void) endInputTextVerificationStart {
    
    self.aboutMeScrollView.scrollEnabled = YES;
    
    if (self.aboutMeScrollView.contentOffset.y > 50) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = self.frame;
            if (isiPhone5) {
                rect.origin.y += 335;
                self.aboutMeScrollView.contentOffset = CGPointMake(0, 150.f);
            } else {
                rect.origin.y += 410;
                self.aboutMeScrollView.contentOffset = CGPointMake(0, 180.f);
            }
            self.frame = rect;
        }];
        
        
    }
}


//Действие кнопки мои сообщения
- (void) buttonMessegeAction {
    [self.delegate pushToMessegerController:self];
}
//Действие кнопки мои симпатии
- (void) buttonLikeAction {
    [self.delegate pushToLikedController:self];
}

//Выбор категории основного скрола
- (void) buttonScrollAction: (UIButton*) button {
    for (int i = 0; i < 3; i++) {
        UIButton * otherButton = (UIButton*)[self viewWithTag:10 + i];
        if (button.tag == 10 + i) {
            [UIView animateWithDuration:0.3f animations:^{
                button.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            } completion:^(BOOL finished) {
                button.userInteractionEnabled = NO;
            }];
            self.scrollSetting.contentOffset = CGPointMake(self.frame.size.width * i, 0);
        } else {
            [UIView animateWithDuration:0.3f animations:^{
                otherButton.backgroundColor = [UIColor whiteColor];
                [otherButton setTitleColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK] forState:UIControlStateNormal];
            } completion:^(BOOL finished) {
                otherButton.userInteractionEnabled = YES;
            }];
        }
    }
}

//Выбор отношений
- (void) buttonRelationsAction: (UIButton*) button {
    for (int i = 0; i < 3; i++) {
        UIButton * otherButton = (UIButton*)[self viewWithTag:40 + i];
        if (button.tag == 40 + i) {
            [UIView animateWithDuration:0.3f animations:^{
                button.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            } completion:^(BOOL finished) {
                button.userInteractionEnabled = NO;
            }];
        } else {
            [UIView animateWithDuration:0.3f animations:^{
                otherButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"e2dfdf"];
                [otherButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"706f6f"] forState:UIControlStateNormal];
            } completion:^(BOOL finished) {
                otherButton.userInteractionEnabled = YES;
            }];
        }
    }
}

//Действие кнопки выбор возраста
- (void) buttonAgeAction {
    [UIView animateWithDuration:0.3f animations:^{
        CGRect pickerRect = self.datePickerView.frame;
        pickerRect.origin.y -= (230.f + 182.5f);
        self.datePickerView.frame = pickerRect;
        
        self.foneView.alpha = 0.4f;
    }];
}

//Действие скрола дата пикера
- (void) datePickerAction: (UIDatePicker*) datePicker {
    self.buttonPushDate.enabled = YES;
    self.timeAgo = [datePicker.date timeAgo];;
}

//Скрытие дата пикера тапом по вью
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    [self backAnimationDatePicker];
}

//Выбор дня рождения
- (void) buttonPushDateAction {
    [self.buttonAge setTitle:self.timeAgo forState:UIControlStateNormal];
    [self.buttonAge setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self backAnimationDatePicker];
}

//Выбор пола
- (void) buttonSexAction: (UIButton*) button {
    for (int i = 0; i < 2; i++) {
        UIButton * otherButton = [self viewWithTag:20 + i];
        if (button.tag == 20 + i) {
            [UIView animateWithDuration:0.3f animations:^{
                button.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            } completion:^(BOOL finished) {
                button.userInteractionEnabled = NO;
            }];
        } else {
            [UIView animateWithDuration:0.3f animations:^{
                otherButton.backgroundColor = [UIColor whiteColor];
                [otherButton setTitleColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK] forState:UIControlStateNormal];
            } completion:^(BOOL finished) {
                otherButton.userInteractionEnabled = YES;
            }];
        }
    }
    
}

//Действие кнопки выбора города
- (void) buttonCityAction {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rectSeaarchView = self.searchView.frame;
        rectSeaarchView.origin.x -= self.frame.size.width;
        self.searchView.frame = rectSeaarchView;
    }];
}

//Дейсвия свичей кого ищу
- (void) swichMaleAction: (MBSwitch*) mbSwitch {
    for (int i = 0; i < 4; i++) {
        if (mbSwitch.tag == 30 + i) {
            if (mbSwitch.on) {
                [mbSwitch setOn:YES animated:YES];
                mbSwitch.thumbTintColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK];
            } else {
                [mbSwitch setOn:NO animated:YES];
                mbSwitch.thumbTintColor = [UIColor hx_colorWithHexRGBAString:@"b7b7b7"];
            }
        }
    }
}

//Действие свичей выбора ориентации
- (void) swichOrientationAction: (MBSwitch*) mbSwich {
    for (int i = 0; i < 3; i++) {
        MBSwitch * otherSwich = [self viewWithTag:50 + i];
        if (mbSwich.tag == 50 + i) {
            if (mbSwich.on) {
                [mbSwich setOn:YES animated:YES];
                mbSwich.thumbTintColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK];
                mbSwich.userInteractionEnabled = NO;
            }
        } else {
            if (mbSwich.on) {
                [otherSwich setOn:NO animated:YES];
                otherSwich.thumbTintColor = [UIColor hx_colorWithHexRGBAString:@"b7b7b7"];
                otherSwich.userInteractionEnabled = YES;
            }
        }
    }
}

//Действие выбора фото---
- (void) buttonPhotoAction: (UIButton*) button {
    for (int i = 0; i < self.arrayImages.count; i++) {
        if (button.tag == 60 + i) {
//            UIImage * imagePhoto = button.imageView.image;
//            Загружаем тестовую картинку
            UIImage * imagePhoto = [UIImage imageNamed:@"imageBigPhoto.png"];
            self.imageViewPhoto.image = imagePhoto;
            [UIView animateWithDuration:0.3f animations:^{
                self.mainPhotoView.alpha = 1.f;
            }];
        }
    }
}

//Скрытие картинки во весь экран
- (void) buttonPhotoCancel {
    [UIView animateWithDuration:0.3 animations:^{
        self.mainPhotoView.alpha = 0.f;
    }];
}

//Добавление нового фото
- (void) buttonPhotoAdd {
    NSLog(@"Добавление фото");
}

#pragma mark - SearchView

- (UIView*) searchViewWith: (UIView*) view {
    UIView * viewSearch = [[UIView alloc] initWithFrame:CGRectMake(view.frame.size.width, 0.f, view.frame.size.width, view.frame.size.height)];
    viewSearch.backgroundColor = [UIColor whiteColor];
    
    self.inputText = [[InputTextView alloc] initInputTextSearchWithView:viewSearch andRect:CGRectMake(0.f, 10.f, viewSearch.frame.size.width, 15.f) andImage:nil andTextPlaceHolder:@"Страна" colorBorder:nil];
    if (isiPhone6) {
        self.inputText.frame = CGRectMake(0.f, 12.f, viewSearch.frame.size.width, 20.f);
    }
    [viewSearch addSubview:self.inputText];
    if (isiPhone6) {
        [UIView borderViewWithHeight:40.f andWight:0.f andView:viewSearch andColor:VM_COLOR_PINK];
    } else {
        [UIView borderViewWithHeight:35.f andWight:0.f andView:viewSearch andColor:VM_COLOR_PINK];
    }
    
    
    UIButton * buttonCancel = [UIButton createButtonWithImage:@"buttonCityCancel.png" anfFrame:CGRectMake(self.frame.size.width - 50.f, 3.f, 30.f, 30.f)];
    if (isiPhone6) {
        buttonCancel.frame = CGRectMake(self.frame.size.width - 50.f, 5.f, 30.f, 30.f);
    }
    [buttonCancel addTarget:self action:@selector(buttonCancelAction) forControlEvents:UIControlEventTouchUpInside];
    [viewSearch addSubview:buttonCancel];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishInputSearchText) name:UITextFieldTextDidChangeNotification object:nil];
    
    self.tableSearch = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 40.f, viewSearch.frame.size.width, viewSearch.frame.size.height - 40.f)];
    if (isiPhone6) {
        self.tableSearch.frame = CGRectMake(0.f, 45.f, viewSearch.frame.size.width, viewSearch.frame.size.height - 45.f);
    }
    //Убираем полосы разделяющие ячейки------------------------------
    self.tableSearch.backgroundColor = nil;
    self.tableSearch.dataSource = self;
    self.tableSearch.delegate = self;
    self.tableSearch.showsVerticalScrollIndicator = NO;
    [viewSearch addSubview:self.tableSearch];
    
    return viewSearch;
}

#pragma mark - UITableViewDelegate

//Анимация нажатия ячейки--------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.buttonCity setTitle:[self.arrayCountry objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    [self.buttonCity setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.inputText.textFieldInput resignFirstResponder];
    [self.inputText.textFieldInput resignFirstResponder];
    [UIView animateWithDuration:0.3f animations:^{
        CGRect rect = self.searchView.frame;
        rect.origin.x += self.searchView.frame.size.width;
        self.searchView.frame = rect;
    }];
    
    self.inputText.textFieldInput.text = @"";
    self.arrayCountry = self.timeArray;
    [self reloadData:YES];
    if (!self.inputText.textFieldInput.isBoll) {
        [UIView animateWithDuration:0.25f animations:^{
            CGRect rect;
            rect = self.inputText.labelPlaceHoldInput.frame;
            rect.origin.x = rect.origin.x - 100.f;
            self.inputText.labelPlaceHoldInput.frame = rect;
            self.inputText.labelPlaceHoldInput.alpha = 1.f;
            self.inputText.textFieldInput.isBoll = YES;
        }];
    }
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayCountry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * identifier = @"identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [self.arrayCountry objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:13];
    cell.textLabel.textColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_DARK_GREY];
    
    
    return cell;
}

- (void) startInputTextView: (NSNotification*) notification {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.frame;
        if (isiPhone6) {
            rect.origin.y -= 420.f;
            self.aboutMeScrollView.contentOffset = CGPointMake(0.f, 0.f);
        } else {
            rect.origin.y -= 360.f;
            self.aboutMeScrollView.contentOffset = CGPointMake(0.f, 0.f);
        }
        
        self.frame = rect;
    }];
    
    self.aboutMeScrollView.scrollEnabled = NO;
}

- (void) endInputTextView: (NSNotification*) notification {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.frame;
        if (isiPhone6) {
            rect.origin.y += 420.f;
        } else {
            rect.origin.y += 360.f;
        }
        self.frame = rect;
    }];
    
    self.aboutMeScrollView.scrollEnabled = YES;
}

- (void) buttonCancelAction {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.searchView.frame;
        rect.origin.x += self.searchView.frame.size.width;
        self.searchView.frame = rect;
        [self.inputText.textFieldInput resignFirstResponder];
    } completion:^(BOOL finished) {
        self.inputText.textFieldInput.text = @"";
        self.arrayCountry = self.timeArray;
        [self reloadData:YES];
        if (!self.inputText.textFieldInput.isBoll) {
            [UIView animateWithDuration:0.25f animations:^{
                CGRect rect;
                rect = self.inputText.labelPlaceHoldInput.frame;
                rect.origin.x = rect.origin.x - 100.f;
                self.inputText.labelPlaceHoldInput.frame = rect;
                self.inputText.labelPlaceHoldInput.alpha = 1.f;
                self.inputText.textFieldInput.isBoll = YES;
            }];
        }
    }];
}


#pragma mark - ImageView
- (UIView*) createImageView {
    UIView * imageViewFone = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
    imageViewFone.backgroundColor = [UIColor whiteColor];
    
    UIScrollView * scrollPhotoBig = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
    scrollPhotoBig.pagingEnabled = YES;
    scrollPhotoBig.showsHorizontalScrollIndicator = NO;
    scrollPhotoBig.contentSize = CGSizeMake(self.frame.size.width * 3, 0);
    [imageViewFone addSubview:scrollPhotoBig];
    
    for (int i = 0; i < 3; i++) {
        UIView * viewPhotoScroll = [[UIView alloc] initWithFrame:CGRectMake(0.f + self.frame.size.width * i, 0.f, self.frame.size.width, self.frame.size.height)];
        [scrollPhotoBig addSubview:viewPhotoScroll];
        
        self.imageViewPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, imageViewFone.frame.size.width,
                                                                            imageViewFone.frame.size.height - 34.f)];
        if (isiPhone6) {
            self.imageViewPhoto.frame = CGRectMake(0.f, 0.f, imageViewFone.frame.size.width,
                                                   imageViewFone.frame.size.height - 40.f);
        }
        UIImage * imagePhoto = [UIImage imageNamed:@"imageBigPhoto.png"];
        self.imageViewPhoto.image = imagePhoto;
        //Временное условие----------------
        self.imageViewPhoto.contentMode = UIViewContentModeScaleAspectFit;
        if (isiPhone6) {
            self.imageViewPhoto.contentMode = UIViewContentModeScaleToFill;
        }
        [viewPhotoScroll addSubview:self.imageViewPhoto];
        
        
        
        CustomLabels * labelName = [[CustomLabels alloc] initLabelWithWidht:12.5f andHeight:imageViewFone.frame.size.height - 27.5f andColor:VM_COLOR_PINK andText:@"Дженифер Энистон" andTextSize:10 andLineSpacing:0.f fontName:VM_FONT_SF_DISPLAY_REGULAR];
        if (isiPhone6) {
            labelName.frame = CGRectMake(15.f, imageViewFone.frame.size.height - 32.5f, 20, 40);
            labelName.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:12];
            [labelName sizeToFit];
        }
        [viewPhotoScroll addSubview:labelName];
        
        CustomLabels * labelComment = [[CustomLabels alloc] initLabelWithWidht:labelName.frame.size.width + 15.f andHeight:imageViewFone.frame.size.height - 27.5f andColor:@"707070" andText:@"Пляж на мальдивах" andTextSize:10 andLineSpacing:0.f fontName:VM_FONT_SF_DISPLAY_REGULAR];
        if (isiPhone6) {
            labelComment.frame = CGRectMake(labelName.frame.size.width + 18.f, imageViewFone.frame.size.height - 32.5f, 20, 30);
            labelComment.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:12];
            [labelComment sizeToFit];
        }
        [viewPhotoScroll addSubview:labelComment];
        
        CustomLabels * labelDate = [[CustomLabels alloc] initLabelWithWidht:12.5 andHeight:imageViewFone.frame.size.height - 16.f andColor:@"b7b6b6" andText:@"2 дня назад" andTextSize:8 andLineSpacing:0.f fontName:VM_FONT_SF_DISPLAY_REGULAR];
        if (isiPhone6) {
            labelDate.frame = CGRectMake(15.f, imageViewFone.frame.size.height - 18.5f, 20, 40);
            labelDate.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:10];
            [labelDate sizeToFit];
        }
        [viewPhotoScroll addSubview:labelDate];
    }
    
    
    
    UIButton * buttonPhotoCancel = [UIButton createButtonWithImage:@"buttonCancelNew.png"
                                                          anfFrame:CGRectMake(self.frame.size.width - 40.f, 5.f, 30.f, 30.f)];
    [buttonPhotoCancel addTarget:self action:@selector(buttonPhotoCancel) forControlEvents:UIControlEventTouchUpInside];
    [imageViewFone addSubview:buttonPhotoCancel];
    
    return imageViewFone;
}



#pragma mark - Other

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//Анимация возвращающая дата пикер на место
- (void) backAnimationDatePicker {
    [UIView animateWithDuration:0.3f animations:^{
        CGRect pickerRect = self.datePickerView.frame;
        pickerRect.origin.y += 230.f + 182.5f;
        self.datePickerView.frame = pickerRect;
        self.foneView.alpha = 0.f;
    }];
}

//Вычитает определенное колличество лет из веденной даты
- (NSDate *)logicalYearAgo:(NSDate *)from {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:-18];
    return [gregorian dateByAddingComponents:offsetComponents toDate:from options:0];
}

- (void) finishInputSearchText {
    
    NSMutableArray * arrayRefrash = [NSMutableArray array];
    
    if (self.inputText.textFieldInput.text.length != 0) {
        for (int i = 0; i < self.timeArray.count; i++) {
            
            if ([[self.timeArray objectAtIndex:i] rangeOfString:self.inputText.textFieldInput.text].location != NSNotFound) {
                [arrayRefrash addObject:[self.timeArray objectAtIndex:i]];
            }
        }
        self.arrayCountry = arrayRefrash;
        [self reloadData:YES];
    } else {
        self.arrayCountry = self.timeArray;
        [self reloadData:YES];
    }
    
}

- (void)reloadData:(BOOL)animated
{
    [UIView transitionWithView:self.tableSearch
                      duration:0.3f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^(void) {
                        [self.tableSearch reloadData];
                    } completion:NULL];
}
                          

@end
