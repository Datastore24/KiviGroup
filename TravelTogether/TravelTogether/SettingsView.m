//
//  SettingsView.m
//  TravelTogether
//
//  Created by Виктор Мишустин on 29/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "SettingsView.h"
#import "HexColors.h"
#import "CustomLabels.h"
#import "UIButton+ButtonImage.h"
#include "UIView+BorderView.h"
#import "Macros.h"
#import "MBSwitch.h"

@interface SettingsView ()

//Main

@property (strong, nonatomic) NSArray * arrayData;
@property (strong, nonatomic) NSArray * arrayImages;

//Logo

@property (strong, nonatomic) UIView * viewLogo;

//SwichElements

@property (strong, nonatomic) UIView * viewSwichElements;

//PushCommunacation

@property (strong, nonatomic) UIView * viewForCommunacation;

//RegulationsView

@property (strong, nonatomic) UIView * viewRegulations;

@end

@implementation SettingsView

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 64.f, view.frame.size.width, view.frame.size.height - 64.f);
        self.arrayData = data;
        
        //Logo
        self.viewLogo = [self createLogoView];
        [self addSubview: self.viewLogo];
        
        //SwivhElements
        self.viewSwichElements = [self createSwichElements];
        [self addSubview:self.viewSwichElements];
        
        //PushCommunication
        self.viewForCommunacation = [self createButtonsForCommunacation];
        [self addSubview:self.viewForCommunacation];
        
        //RegulationsView
        self.viewRegulations = [self createRegulationsView];
        [self addSubview:self.viewRegulations];
        
        //Social NetWork
        [self addSubview:[self createViewSocialNetWork]];

    }
    return self;
}

#pragma mark - Logo

- (UIView*) createLogoView {
    
    UIView * viewAva = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, 182.5f)];
    NSDictionary * dictData = [self.arrayData objectAtIndex:0];
    self.arrayImages = [dictData objectForKey:@"arrayImage"];
    
    UIImageView * imageAva = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, 182.5f)];
    imageAva.image = [UIImage imageNamed:[dictData objectForKey:@"image"]];
    [viewAva addSubview:imageAva];
    
    UIButton * buttonLike = [UIButton createButtonWithImage:@"likeButtonImage.png" anfFrame:CGRectMake(70.f, 140.f, 33.f, 33.f)];
    buttonLike.alpha = 0.7f;
    [buttonLike addTarget:self action:@selector(buttonLikeAction) forControlEvents:UIControlEventTouchUpInside];
    [viewAva addSubview:buttonLike];
    
    CustomLabels * labelbuttonLike = [[CustomLabels alloc] initLabelTableWithWidht:0.f andHeight:0.f andSizeWidht:33.f
                                                                     andSizeHeight:33.f andColor:VM_COLOR_PINK andText:[dictData objectForKey:@"countLike"]];
    labelbuttonLike.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_LIGHT size:7];
    [buttonLike addSubview:labelbuttonLike];
    
    UIButton * buttonMessege = [UIButton createButtonWithImage:@"messageButtonImage.png" anfFrame:CGRectMake(self.frame.size.width - 103.f, 140.f, 33.f, 33.f)];
    buttonMessege.alpha = 0.7f;
    [buttonMessege addTarget:self action:@selector(buttonMessegeAction) forControlEvents:UIControlEventTouchUpInside];
    [viewAva addSubview:buttonMessege];
    
    CustomLabels * labelbuttonMessege = [[CustomLabels alloc] initLabelTableWithWidht:0.f andHeight:0.f andSizeWidht:33.f
                                                                        andSizeHeight:33.f andColor:@"ffffff" andText:[dictData objectForKey:@"countMessage"]];
    labelbuttonMessege.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_LIGHT size:7];
    [buttonMessege addSubview:labelbuttonMessege];
    
    CustomLabels * labelName = [[CustomLabels alloc] initLabelTableWithWidht:103.f andHeight:148.f
                                                                andSizeWidht:114.f andSizeHeight:20
                                                                    andColor:@"ffffff" andText:[dictData objectForKey:@"name"]];
    labelName.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:10];
    labelName.textColor = [UIColor whiteColor];
    [viewAva addSubview:labelName];
    
    CustomLabels * labelCity = [[CustomLabels alloc] initLabelTableWithWidht:103.f andHeight:160.f
                                                                andSizeWidht:114.f andSizeHeight:20
                                                                    andColor:@"ffffff" andText:[dictData objectForKey:@"city"]];
    labelCity.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:10];
    labelCity.textColor = [UIColor whiteColor];
    [viewAva addSubview:labelCity];
    
    return viewAva;
}

#pragma mark - SwichElements

- (UIView*) createSwichElements {
    UIView * viewForElements = [[UIView alloc] initWithFrame:CGRectMake(0.f, 182.5f, self.frame.size.width, 106.f)];
    
    NSArray * arrayNamesLables = [NSArray arrayWithObjects:@"Отправлять Push уведомления",
                                  @"Вкл звук уведомлений", @"Включить вибрацию", nil];
    for (int i = 0; i < 3; i++) {
        CustomLabels * labelForElement = [[CustomLabels alloc] initLabelWithWidht:20.f andHeight:39.f + 21.f * i andColor:@"706f6f" andText:[arrayNamesLables objectAtIndex:i] andTextSize:10 andLineSpacing:0.f fontName:VM_FONT_SF_DISPLAY_REGULAR];
        [viewForElements addSubview:labelForElement];
        
        MBSwitch * swithElements = [[MBSwitch alloc] initWithFrame:CGRectMake(self.frame.size.width - 56.f, 33.75f + 22.5 * i, 35.f, 16.5)];
        swithElements.onTintColor = [UIColor hx_colorWithHexRGBAString:@"e9e5e5"];
        swithElements.offTintColor = [UIColor hx_colorWithHexRGBAString:@"e9e5e5"];
        swithElements.thumbTintColor = [UIColor hx_colorWithHexRGBAString:@"b7b7b7"];
        swithElements.tag = 10 + i;
        [swithElements addTarget:self action:@selector(swithElementsAction:) forControlEvents:UIControlEventValueChanged];
        [viewForElements addSubview:swithElements];
    }
    
    [UIView borderViewWithHeight:105.f andWight:21.25f andView:viewForElements andColor:VM_COLOR_PINK andHeight:1.f];
    
    
    return viewForElements;
}

#pragma mark - ButtonsForСommunication

- (UIView*) createButtonsForCommunacation {
    UIView * viewCommunication = [[UIView alloc] initWithFrame:CGRectMake(0.f, self.viewSwichElements.frame.size.height + self.viewSwichElements.frame.origin.y, self.frame.size.width, 58.5f)];
    
    NSArray * nameCommunacation = [NSArray arrayWithObjects:@"Связаться с нами", @"Оставить отзыв", nil];
    for (int i = 0; i < 2; i++) {
        UIButton * buttonCommunication = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonCommunication.frame = CGRectMake(20.f, 11.f + 20.f * i, self.frame.size.width - 40, 15.f);
        [buttonCommunication setTitle:[nameCommunacation objectAtIndex:i] forState:UIControlStateNormal];
        [buttonCommunication setTitleColor:[UIColor hx_colorWithHexRGBAString:@"706f6f"] forState:UIControlStateNormal];
        buttonCommunication.titleLabel.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:10];
        buttonCommunication.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        buttonCommunication.tag = 20 + i;
        [buttonCommunication addTarget:self action:@selector(buttonCommunicationAction:) forControlEvents:UIControlEventTouchUpInside];
        [viewCommunication addSubview:buttonCommunication];
        
        UIImageView * imageArrow = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 27.5f, 12.f + 22.f * i, 6.f, 12.f)];
        imageArrow.image = [UIImage imageNamed:@"arrowPinck.png"];
        [viewCommunication addSubview:imageArrow];
    }
    
    [UIView borderViewWithHeight:57.5f andWight:21.25f andView:viewCommunication andColor:VM_COLOR_PINK andHeight:1.f];
    return viewCommunication;
}


#pragma mark - Regulations

- (UIView*) createRegulationsView {
    UIView * regulationsView = [[UIView alloc] initWithFrame:CGRectMake(0.f, self.viewForCommunacation.frame.size.height + self.viewForCommunacation.frame.origin.y, self.frame.size.width, 56.f)];
    
    NSArray * nameCommunacation = [NSArray arrayWithObjects:@"Соглашение пользователя", @"Политика конфиденциальности", nil];
    for (int i = 0; i < 2; i++) {
        UIButton * buttonRegulation = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonRegulation.frame = CGRectMake(20.f, 11.f + 20.f * i, self.frame.size.width - 40, 15.f);
        [buttonRegulation setTitle:[nameCommunacation objectAtIndex:i] forState:UIControlStateNormal];
        [buttonRegulation setTitleColor:[UIColor hx_colorWithHexRGBAString:@"706f6f"] forState:UIControlStateNormal];
        buttonRegulation.titleLabel.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:10];
        buttonRegulation.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        buttonRegulation.tag = 30 + i;
        [regulationsView addSubview:buttonRegulation];
        
    }
    
    return regulationsView;
}

#pragma mark - Social Network

- (UIView*) createViewSocialNetWork {
    UIView * netWorkView = [[UIView alloc] initWithFrame:CGRectMake(0.f, self.viewRegulations.frame.size.height + self.viewRegulations.frame.origin.y, self.frame.size.width, self.frame.size.height - (self.viewRegulations.frame.size.height + self.viewRegulations.frame.origin.y))];
    
    UIView * borderView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, 25.f)];
    borderView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"e6e6e6"];
    [netWorkView addSubview:borderView];
    
    CustomLabels * labelTitl = [[CustomLabels alloc] initLabelWithWidht:20.f andHeight:7.5f andColor:VM_COLOR_PINK andText:@"Поделиться в сетях" andTextSize:10 andLineSpacing:0.f fontName:VM_FONT_SF_DISPLAY_REGULAR];
    [borderView addSubview:labelTitl];
    
    NSArray * imagesNetWork = [NSArray arrayWithObjects:@"icon_odnok.png", @"icon_vk.png", @"icon_facebook.png", @"icon_instagram.png", nil];
    NSArray * arrayNameLabels = [NSArray arrayWithObjects:@"Одноклассники", @"В контакте", @"Фейсбук", @"Инстаграм", nil];
    for (int i = 0; i < 4; i++) {
        UIButton * buttonNetwork = [UIButton createButtonWithImage:[imagesNetWork objectAtIndex:i] anfFrame:CGRectMake(29.f + 74.f * i, 37.5f, 38.5f, 38.5f)];
        [netWorkView addSubview:buttonNetwork];
        
        
        CustomLabels * labelNetWork = [[CustomLabels alloc] initLabelWithWidht:20.f andHeight:86.5f andColor:@"706f6f" andText:[arrayNameLabels objectAtIndex:i] andTextSize:7 andLineSpacing:0.f fontName:VM_FONT_SF_DISPLAY_REGULAR];
        CGPoint centr = buttonNetwork.center;
        centr.y += 28.f;
        labelNetWork.center = centr;
        [netWorkView addSubview:labelNetWork];
    }
    return netWorkView;
}

#pragma mark - Actions

- (void) buttonCommunicationAction: (UIButton*) button {
        if (button.tag == 20) {
            [self.delegate pushTuConnectWithUs:self];
        }
}


//Дейсвия свичей в настройках
- (void) swithElementsAction: (MBSwitch*) mbSwitch {
    for (int i = 0; i < 3; i++) {
        if (mbSwitch.tag == 10 + i) {
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


//Действие кнопки мои сообщения
- (void) buttonMessegeAction {
    [self.delegate pushToMessegerController:self];
}
//Действие кнопки мои симпатии
- (void) buttonLikeAction {
    [self.delegate pushToLikedController:self];
}

@end
