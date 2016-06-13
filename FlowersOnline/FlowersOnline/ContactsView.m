//
//  ContactsView.m
//  FlowersOnline
//
//  Created by Viktor on 13.06.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "ContactsView.h"
#import "CustomLabels.h"
#import "UIColor+HexColor.h"
#import "Macros.h"

@implementation ContactsView

- (instancetype)initWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 64, view.frame.size.width, view.frame.size.height - 64);
        
        //Адрес Заголовок-----------------------------
        CustomLabels * addressTitle = [[CustomLabels alloc] initLabelTableWithWidht:20 andHeight:20 andSizeWidht:self.frame.size.width - 40 andSizeHeight:20 andColor:COLORTEXTGRAY andText:@"Адрес:"];
        addressTitle.font = [UIFont fontWithName:FONTBOND size:14];
        addressTitle.textAlignment = NSTextAlignmentLeft;
        if (isiPhone5) {
            addressTitle.font = [UIFont fontWithName:FONTBOND size:12];
        } else if (isiPhone4s) {
            addressTitle.font = [UIFont fontWithName:FONTBOND size:12];
            addressTitle.frame = CGRectMake(20, 10, self.frame.size.width - 40, 20);
        }
        
        [self addSubview:addressTitle];
        
        //Адресс текст---------------------------------
        CustomLabels * addressText = [[CustomLabels alloc] initLabelTableWithWidht:20 andHeight:40 andSizeWidht:self.frame.size.width - 40 andSizeHeight:40 andColor:COLORTEXTGRAY andText:@"141421 г. Химки, мкр-н Сходня, (Станция Сходня), ул. Железнодорожная д.3 (напротив Сходня-Гранд"];
        addressText.numberOfLines = 0;
        addressText.font = [UIFont fontWithName:FONTREGULAR size:14];
        addressText.textAlignment = NSTextAlignmentLeft;
        if (isiPhone5) {
            addressText.font = [UIFont fontWithName:FONTREGULAR size:11.5];
        } else if (isiPhone4s) {
            addressText.font = [UIFont fontWithName:FONTREGULAR size:11.5];
            addressText.frame = CGRectMake(20, 25, self.frame.size.width - 40, 40);
        }
        [self addSubview:addressText];
        
        //Граница адреса-------------------------------
        UIView * viewBorderAddress = [[UIView alloc] initWithFrame:CGRectMake(20, 90, self.frame.size.width - 40, 0.5)];
        viewBorderAddress.backgroundColor = [UIColor colorWithHexString:COLORTEXTGRAY];
        if (isiPhone4s) {
            viewBorderAddress.frame = CGRectMake(20, 70, self.frame.size.width - 40, 0.5);
        }
        [self addSubview:viewBorderAddress];
        
        //Наши контакты------------------------------------
        CustomLabels * contactsTitle = [[CustomLabels alloc] initLabelTableWithWidht:20 andHeight:105 andSizeWidht:self.frame.size.width - 40 andSizeHeight:20 andColor:COLORTEXTGRAY andText:@"Контакты для заказа и консультации."];
        contactsTitle.font = [UIFont fontWithName:FONTBOND size:14];
        contactsTitle.textAlignment = NSTextAlignmentLeft;
        if (isiPhone5) {
            contactsTitle.font = [UIFont fontWithName:FONTBOND size:12];
        } else if (isiPhone4s) {
            contactsTitle.font = [UIFont fontWithName:FONTBOND size:12];
            contactsTitle.frame = CGRectMake(20, 80, self.frame.size.width - 40, 20);
        }
        [self addSubview:contactsTitle];
        
        //Не изменяемые заголовки---------------------------
        //Заголовк телефон-------------------
        CustomLabels * labelTintPhone = [[CustomLabels alloc] initLabelBondWithWidht:20
                                                                           andHeight:125
                                                                            andColor:COLORTEXTGRAY andText:@"Тел:"];
        if (isiPhone5) {
            labelTintPhone.font = [UIFont fontWithName:FONTBOND size:12];
            labelTintPhone.frame = CGRectMake(20, 120, 50, 20);
            [labelTintPhone sizeToFit];
        } else if (isiPhone4s) {
            labelTintPhone.font = [UIFont fontWithName:FONTBOND size:12];
            labelTintPhone.frame = CGRectMake(20, 95, 50, 20);
            [labelTintPhone sizeToFit];
        }
        [self addSubview:labelTintPhone];
        
        //Данные Телефон---------------------
        CustomLabels * labelTintPhoneAct = [[CustomLabels alloc] initLabelRegularWithWidht:25 + labelTintPhone.frame.size.width
                                                                                 andHeight:125
                                                                                  andColor:COLORTEXTGRAY andText:@"+7-963-718-88-61"];
        if (isiPhone6) {
            labelTintPhoneAct.font = [UIFont fontWithName:FONTREGULAR size:13.7];
        } else if (isiPhone5) {
            labelTintPhoneAct.font = [UIFont fontWithName:FONTREGULAR size:11.7];
            labelTintPhoneAct.frame = CGRectMake(25 + labelTintPhone.frame.size.width, 120, 50, 20);
            [labelTintPhoneAct sizeToFit];
        } else if (isiPhone4s) {
            labelTintPhoneAct.font = [UIFont fontWithName:FONTREGULAR size:11.7];
            labelTintPhoneAct.frame = CGRectMake(25 + labelTintPhone.frame.size.width, 95, 50, 20);
            [labelTintPhoneAct sizeToFit];
        }
        [self addSubview:labelTintPhoneAct];
        
        //Заголовк почта-------------------
        CustomLabels * labelTintEmail = [[CustomLabels alloc] initLabelBondWithWidht:20
                                                                           andHeight:145
                                                                            andColor:COLORTEXTGRAY andText:@"Email:"];
        if (isiPhone5) {
            labelTintEmail.font = [UIFont fontWithName:FONTBOND size:12];
            labelTintEmail.frame = CGRectMake(20, 135, 50, 20);
            [labelTintEmail sizeToFit];
        } else if (isiPhone4s) {
            labelTintEmail.font = [UIFont fontWithName:FONTBOND size:12];
            labelTintEmail.frame = CGRectMake(20, 110, 50, 20);
            [labelTintEmail sizeToFit];
        }
        [self addSubview:labelTintEmail];
        
        //Заголовк почта изменяемый-------------------
        CustomLabels * labelTintEmailAct = [[CustomLabels alloc] initLabelRegularWithWidht:25 + labelTintEmail.frame.size.width
                                                                                 andHeight:145
                                                                                  andColor:COLORTEXTGRAY andText:@"sales@floweronline.ru - консультации и заказы"];
        if (isiPhone6) {
            labelTintEmailAct.font = [UIFont fontWithName:FONTREGULAR size:13.7];
        } else if (isiPhone5) {
            labelTintEmailAct.font = [UIFont fontWithName:FONTREGULAR size:11.7];
            labelTintEmailAct.frame = CGRectMake(25 + labelTintEmail.frame.size.width, 135, 50, 20);
            [labelTintEmailAct sizeToFit];
        } else if (isiPhone4s) {
            labelTintEmailAct.font = [UIFont fontWithName:FONTREGULAR size:11.7];
            labelTintEmailAct.frame = CGRectMake(25 + labelTintEmail.frame.size.width, 110, 50, 20);
            [labelTintEmailAct sizeToFit];
        }
        [self addSubview:labelTintEmailAct];
        
        //Заголовк скайп-------------------
        CustomLabels * labelTintSkype = [[CustomLabels alloc] initLabelBondWithWidht:20
                                                                           andHeight:165
                                                                            andColor:COLORTEXTGRAY andText:@"Skype:"];
        if (isiPhone5) {
            labelTintSkype.font = [UIFont fontWithName:FONTBOND size:12];
            labelTintSkype.frame = CGRectMake(20, 150, 50, 20);
            [labelTintSkype sizeToFit];
        } else if (isiPhone4s) {
            labelTintSkype.font = [UIFont fontWithName:FONTBOND size:12];
            labelTintSkype.frame = CGRectMake(20, 125, 50, 20);
            [labelTintSkype sizeToFit];
        }
        [self addSubview:labelTintSkype];
        
        //Заголовк скайп изменяемый-------------------
        CustomLabels * labelTintSkypeAct = [[CustomLabels alloc] initLabelRegularWithWidht:25 + labelTintSkype.frame.size.width
                                                                                 andHeight:165
                                                                                  andColor:COLORTEXTGRAY andText:@"ecuatrade"];
        if (isiPhone6) {
            labelTintSkypeAct.font = [UIFont fontWithName:FONTREGULAR size:13.7];
        } else if (isiPhone5) {
            labelTintSkypeAct.font = [UIFont fontWithName:FONTREGULAR size:11.7];
            labelTintSkypeAct.frame = CGRectMake(25 + labelTintSkype.frame.size.width, 150, 50, 20);
            [labelTintSkypeAct sizeToFit];
        } else if (isiPhone4s) {
            labelTintSkypeAct.font = [UIFont fontWithName:FONTREGULAR size:11.7];
            labelTintSkypeAct.frame = CGRectMake(25 + labelTintSkype.frame.size.width, 125, 50, 20);
            [labelTintSkypeAct sizeToFit];
        }
        [self addSubview:labelTintSkypeAct];
        
        
        //Реквизиты-----------------------------------------------
        CustomLabels * requisitesTitle = [[CustomLabels alloc] initLabelBondWithWidht:20
                                                                            andHeight:240
                                                                             andColor:COLORTEXTGRAY
                                                                              andText:@"Реквизиты:"];
        if (isiPhone5) {
            requisitesTitle.font = [UIFont fontWithName:FONTBOND size:12];
            requisitesTitle.frame = CGRectMake(20, 200, 100, 20);
        } else if (isiPhone4s) {
            requisitesTitle.font = [UIFont fontWithName:FONTBOND size:12];
            requisitesTitle.frame = CGRectMake(20, 150, 100, 20);
        }
        [self addSubview:requisitesTitle];
        
        //Реквизиты список-----------------------------------------
        CustomLabels * requisitesText = [[CustomLabels alloc] initLabelTableWithWidht:20 andHeight:225 andSizeWidht:self.frame.size.width - 40 andSizeHeight:350 andColor:COLORTEXTGRAY
                                                                              andText:@"Полное наименование:\nИП Родригес-Качалов Александр\nФакт. адрес: 141707, МО, г. Химки, мкр-н Сходня, ул. Железнодорожная д.3A\nКонтактный телефон: +7(963) 718 - 88-61\nE-mail:  sales@floweronline.ru\nСайт: http://www.floweronline.ru\nДата регистрации: 29 августа 2014\n\n\nРегистрирующий орган: Межрайонная инспекция Федеральной Налоговой службы №46 по г. Москве\nСвидетельство о гос. регистрации:\nсерия 77 № 017405355\nОГРНИП: 314774624100140\nИНН/КПП: 774318221080 / \nОКВЭД: 52.48.32 ,64.12, 74.84"];
        requisitesText.numberOfLines = 0;
        requisitesText.font = [UIFont fontWithName:FONTREGULAR size:14];
        requisitesText.textAlignment = NSTextAlignmentLeft;
        if (isiPhone5) {
            requisitesText.font = [UIFont fontWithName:FONTREGULAR size:12];
            requisitesText.frame = CGRectMake(20, 200, self.frame.size.width - 40, 300);
        } else if (isiPhone4s) {
            requisitesText.font = [UIFont fontWithName:FONTREGULAR size:12];
            requisitesText.frame = CGRectMake(20, 140, self.frame.size.width - 40, 300);
            requisitesText.text = @"Полное наименование:\nИП Родригес-Качалов Александр\nФакт. адрес: 141707, МО, г. Химки, мкр-н Сходня, ул. Железнодорожная д.3A\nКонтактный телефон: +7(963) 718 - 88-61\nE-mail:  sales@floweronline.ru\nСайт: http://www.floweronline.ru\nДата регистрации: 29 августа 2014\n\nРегистрирующий орган: Межрайонная инспекция Федеральной Налоговой службы №46 по г. Москве\nСвидетельство о гос. регистрации:\nсерия 77 № 017405355\nОГРНИП: 314774624100140\nИНН/КПП: 774318221080 / \nОКВЭД: 52.48.32 ,64.12, 74.84";
        }
        [self addSubview:requisitesText];
        
        //Граница реквизитов------------------------
        UIView * viewBorderRequisites = [[UIView alloc] initWithFrame:CGRectMake(20, 410, self.frame.size.width - 40, 0.5)];
        viewBorderRequisites.backgroundColor = [UIColor colorWithHexString:COLORTEXTGRAY];
        if (isiPhone5) {
            viewBorderRequisites.frame = CGRectMake(20, 350, self.frame.size.width - 40, 0.5);
        } else if (isiPhone4s) {
            viewBorderRequisites.frame = CGRectMake(20, 291, self.frame.size.width - 40, 0.5);
        }
        [self addSubview:viewBorderRequisites];

    }
    return self;
}

@end
