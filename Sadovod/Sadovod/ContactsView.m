//
//  ContactsView.m
//  Sadovod
//
//  Created by Виктор Мишустин on 09/09/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "ContactsView.h"
#import "InputTextView.h"
#import "CustomButton.h"
#import "CustomLabels.h"
#import "Macros.h"
#import "HexColors.h"
#import "UIView+BorderView.h"

@interface ContactsView ()

@property (strong, nonatomic) UIScrollView * mainScrollView;

@end

@implementation ContactsView

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 0.f, view.frame.size.width, view.frame.size.height);
        self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
        [self addSubview:self.mainScrollView];
        
        
        CustomLabels * labelTitl = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:15.f andSizeWidht:self.frame.size.width - 30 andSizeHeight:40 andColor:@"000000"
                                                                         andText:@"График работы магазина: ежедневно кроме субботы."];
        labelTitl.font = [UIFont fontWithName:VM_FONT_BOLD size:15];
        labelTitl.numberOfLines = 2;
        [self.mainScrollView addSubview:labelTitl];
        
        CustomLabels * labelTime = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:55.f andSizeWidht:self.frame.size.width - 30 andSizeHeight:60 andColor:@"000000"
                                                                         andText:@"Часы приема звонков:\n\nежедневно с 10:00 до 18:00"];
        labelTime.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
        labelTime.numberOfLines = 3;
        [self.mainScrollView addSubview:labelTime];
        
        CustomLabels * labelPhone = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:110.f andSizeWidht:self.frame.size.width - 30 andSizeHeight:40 andColor:@"000000"
                                                                         andText:@"Телефоны для справок и заказов:"];
        labelPhone.font = [UIFont fontWithName:VM_FONT_BOLD size:15];
        [self.mainScrollView addSubview:labelPhone];
        
        UIButton * buttonPhone = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonPhone.frame = CGRectMake(0.f, 220.f, self.frame.size.width, 20);
        [buttonPhone setTitle:@"+7(495) 768-78-38" forState:UIControlStateNormal];
        [buttonPhone setTitleColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_800] forState:UIControlStateNormal];
        buttonPhone.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
        [self addSubview:buttonPhone];
        
        CustomLabels * labelPhoneUs = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:180.f andSizeWidht:self.frame.size.width - 30 andSizeHeight:40 andColor:@"000000"
                                                                         andText:@"Звоните нам, мы всегда ответим и проконсультируем Вас!"];
        labelPhoneUs.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
        labelPhoneUs.numberOfLines = 2;
        [self.mainScrollView addSubview:labelPhoneUs];
        
        CustomLabels * labelMailTitl = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:225.f andSizeWidht:self.frame.size.width - 30 andSizeHeight:40 andColor:@"000000"
                                                                         andText:@"С нами также можно связаться по электронной почте:"];
        labelMailTitl.font = [UIFont fontWithName:VM_FONT_BOLD size:15];
        labelMailTitl.numberOfLines = 2;
        [self.mainScrollView addSubview:labelMailTitl];
        
        UIButton * buttonEmail = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonEmail.frame = CGRectMake(0.f, 340.f, self.frame.size.width, 20);
        [buttonEmail setTitle:@"info@tk-sad.ru" forState:UIControlStateNormal];
        [buttonEmail setTitleColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_800] forState:UIControlStateNormal];
        buttonEmail.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
        [self addSubview:buttonEmail];
        
        CustomLabels * labelRequisitesTitl = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:300.f andSizeWidht:self.frame.size.width - 30 andSizeHeight:40 andColor:@"000000"
                                                                          andText:@"Наши реквизиты:"];
        labelRequisitesTitl.font = [UIFont fontWithName:VM_FONT_BOLD size:15];
        [self.mainScrollView addSubview:labelRequisitesTitl];
        
        CustomLabels * labelRequisites = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:330.f andSizeWidht:self.frame.size.width - 30 andSizeHeight:140 andColor:@"000000"
                                                                         andText:@"ООО \"Одежда\"\n\nАдрес: Россия, Москва, Севастопольский проспект, д.6\n\nИНН: 7726087967\n\nОГРН: 1037739097296\n\nКПП: 772601001   ОКПО: 17715714"];
        labelRequisites.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
        labelRequisites.numberOfLines = 0;
        [self.mainScrollView addSubview:labelRequisites];
        
        
    }
    return self;
}

@end
