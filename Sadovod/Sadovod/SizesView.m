//
//  SizesView.m
//  Sadovod
//
//  Created by Виктор Мишустин on 13.09.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "SizesView.h"
#import "InputTextView.h"
#import "CustomButton.h"
#import "CustomLabels.h"
#import "Macros.h"
#import "HexColors.h"
#import "UIView+BorderView.h"

@interface SizesView ()

@property (strong, nonatomic) UIScrollView * mainScrollView;

@end

@implementation SizesView

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 0.f, view.frame.size.width, view.frame.size.height);
        self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
        self.mainScrollView.contentSize = CGSizeMake(0, 1450);
        [self addSubview:self.mainScrollView];
        
        
        CustomLabels * labelTitl = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:15.f andSizeWidht:self.frame.size.width - 30 andSizeHeight:20 andColor:VM_COLOR_800
                                                                         andText:@"Уважаеммые клиенты!"];
        labelTitl.font = [UIFont fontWithName:VM_FONT_BOLD size:16];
        labelTitl.textAlignment = NSTextAlignmentLeft;
        labelTitl.numberOfLines = 1;
        [self.mainScrollView addSubview:labelTitl];
        
        CustomLabels * labelDecor = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:40.f andSizeWidht:self.frame.size.width - 30 andSizeHeight:40 andColor:@"000000"
                                                                         andText:@"Мы просим Вас обратить внимание на следующее при оформлении заказа."];
        labelDecor.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
        labelDecor.textAlignment = NSTextAlignmentLeft;
        labelDecor.numberOfLines = 2;
        [self.mainScrollView addSubview:labelDecor];
        
        NSArray * arrayDecor = [NSArray arrayWithObjects:
                                @"1. Необходимо учитывать эластичность ткани (вязанного, хлопкового, синтетического трикотажа). Товар может выглядеть на сантиметровой ленте меньше;",
                                
                                @"2. Толщина изделия – немаловажный параметр: утеплители, использующиеся в производстве, могут быть различными по составу и размеру;",
                                
                                @"3. При оформлении заказа на толстовки и спортивные костюмы нужно помнить о том, что изделие может как облегать фигуру, так и сидеть на ней свободно – всё зависит от разработанной производителем модели.", nil];
        CGFloat heightDecor = 0.f;
        for (int i = 0; i < 3; i ++) {
            CustomLabels * labelDecor = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:80.f + 50 * i andSizeWidht:self.frame.size.width - 30 andSizeHeight:60 andColor:@"000000"
                                                                              andText:[arrayDecor objectAtIndex:i]];
            if (i < 2) {
                labelDecor.frame = CGRectMake(15.f, 65 + heightDecor, self.frame.size.width - 30, 80);
                labelDecor.numberOfLines = 5.f;
                heightDecor += 50.f;
            } else {
                labelDecor.frame = CGRectMake(15.f, 65 + heightDecor, self.frame.size.width - 30, 95);
                labelDecor.numberOfLines = 6.f;
                heightDecor += 80.f;
            }
            labelDecor.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
            labelDecor.textAlignment = NSTextAlignmentLeft;
            [self.mainScrollView addSubview:labelDecor];

        }
        
        
        CustomLabels * labelWoman = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:260.f andSizeWidht:self.frame.size.width - 30 andSizeHeight:40 andColor:@"000000"
                                                                          andText:@"Как определить размер женской одежды?"];
        labelWoman.font = [UIFont fontWithName:VM_FONT_BOLD size:15];
        labelWoman.textAlignment = NSTextAlignmentLeft;
        labelWoman.numberOfLines = 2;
        [self.mainScrollView addSubview:labelWoman];
        
        CustomLabels * labelWomanText = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:300.f andSizeWidht:self.frame.size.width - 30 andSizeHeight:100 andColor:@"000000"
                                                                              andText:@"Существует три основных параметра фигуры: обхват груди, талии и бёдер. Для их определения нужно совершить ряд действий с сантиметровой лентой.\nПоследовательность действий такова:"];
        labelWomanText.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
        labelWomanText.textAlignment = NSTextAlignmentLeft;
        labelWomanText.numberOfLines = 5;
        [self.mainScrollView addSubview:labelWomanText];
        
        
        
        
        NSArray * arrayWoman = [NSArray arrayWithObjects:
                                @"1. При измерении обхвата груди необходима расположить сантиметровую ленту по выступающим точкам груди, а также под мышечными впадинами. Обращаем ваше внимание на то, что на спине необходимо расположить ленту повыше;",
                                
                                @"2. «Обхват талии» измеряется только по линии, без никаких отклонений. Определить талию легко: стоит только наклониться вбок;",
                                
                                @"3. «Обхват бёдер» измеряется по самым выступающим точкам ягодиц;",
                                
                                @"4. «Обхват груди» необходим для покупки платьев, блузок, кофточек, курток, пальто, пиджаков и прочих нарядов;",
                                
                                @"5. «Обхват талии и бёдер» нужен для выбора юбок и брюк.", nil];
        CGFloat heightWoman = 0.f;
        for (int i = 0; i < 5; i++) {
            CustomLabels * labelWoman = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:80.f + 50 * i andSizeWidht:self.frame.size.width - 30 andSizeHeight:60 andColor:@"000000"
                                                                              andText:[arrayWoman objectAtIndex:i]];
            if (i == 0) {
                labelWoman.frame = CGRectMake(15.f, 380 + heightWoman, self.frame.size.width - 30, 100);
                labelWoman.numberOfLines = 6.f;
                heightWoman += 86.f;
            } else if (i == 1 || i == 3) {
                labelWoman.frame = CGRectMake(15.f, 380 + heightWoman, self.frame.size.width - 30, 60);
                labelWoman.numberOfLines = 3.f;
                heightWoman += 50.f;
            } else {
                labelWoman.frame = CGRectMake(15.f, 380 + heightWoman, self.frame.size.width - 30, 40);
                labelWoman.numberOfLines = 2.f;
                heightWoman += 30.f;
            }
            labelWoman.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
            labelWoman.textAlignment = NSTextAlignmentLeft;
            [self.mainScrollView addSubview:labelWoman];
        }
        

        
        CustomLabels * labelChoose = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:640.f andSizeWidht:self.frame.size.width - 30 andSizeHeight:40 andColor:@"000000"
                                                                          andText:@"Выбирайте правильно!"];
        labelChoose.font = [UIFont fontWithName:VM_FONT_BOLD size:15];
        labelChoose.textAlignment = NSTextAlignmentLeft;
        labelChoose.numberOfLines = 1;
        [self.mainScrollView addSubview:labelChoose];
        
        
        
        CustomLabels * labelWomanButtons = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:680.f andSizeWidht:self.frame.size.width - 30 andSizeHeight:20 andColor:VM_COLOR_800
                                                                           andText:@"Женская одежда"];
        labelWomanButtons.font = [UIFont fontWithName:VM_FONT_BOLD size:15];
        labelWomanButtons.textAlignment = NSTextAlignmentLeft;
        labelWomanButtons.numberOfLines = 1;
        [self.mainScrollView addSubview:labelWomanButtons];
        
        NSArray * arrayButtonsWoman = [NSArray arrayWithObjects:@"Блузки, туники, куртки, платья", @"Брюки, юбки, шорты", @"Джинсы", @"Бюстгальтеры", @"Нижнее белье", @"Перчатки, варежки", nil];
        for (int i = 0; i < 6; i++) {
            UIButton * buttonWoman = [UIButton buttonWithType:UIButtonTypeSystem];
            buttonWoman.frame = CGRectMake(15.f, 710.f + 25 * i, self.frame.size.width - 30, 20);
            [buttonWoman setTitle:[arrayButtonsWoman objectAtIndex:i] forState:UIControlStateNormal];
            [buttonWoman setTitleColor:[UIColor hx_colorWithHexRGBAString:@"000000"] forState:UIControlStateNormal];
            buttonWoman.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
            buttonWoman.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [self.mainScrollView addSubview:buttonWoman];
        }
        
        CustomLabels * labelMan = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:865.f andSizeWidht:self.frame.size.width - 30 andSizeHeight:20 andColor:VM_COLOR_800
                                                                                 andText:@"Мужская одежда"];
        labelMan.font = [UIFont fontWithName:VM_FONT_BOLD size:15];
        labelMan.textAlignment = NSTextAlignmentLeft;
        labelMan.numberOfLines = 1;
        [self.mainScrollView addSubview:labelMan];
        
        NSArray * arrayMan = [NSArray arrayWithObjects:@"Пиджаки, джемпера, жилеты, халаты, свитера,\nкуртки, рубашки", @"Рубашки, сорочки", @"Шорты, брюки", @"Джинсы", @"Нижнее белье", nil];
        for (int i = 0; i < 5; i++) {
            UIButton * buttonMan = [UIButton buttonWithType:UIButtonTypeSystem];
            if (i == 0) {
                buttonMan.frame = CGRectMake(15.f, 890.f + 25 * i, self.frame.size.width - 30, 40);
                buttonMan.titleLabel.numberOfLines = 2;
            } else {
            buttonMan.frame = CGRectMake(15.f, 910.f + 25 * i, self.frame.size.width - 30, 20);
            }
            [buttonMan setTitle:[arrayMan objectAtIndex:i] forState:UIControlStateNormal];
            [buttonMan setTitleColor:[UIColor hx_colorWithHexRGBAString:@"000000"] forState:UIControlStateNormal];
            buttonMan.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
            buttonMan.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [self.mainScrollView addSubview:buttonMan];
        }
        
        
        CustomLabels * labelKid = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:1040.f andSizeWidht:self.frame.size.width - 30 andSizeHeight:20 andColor:VM_COLOR_800
                                                                        andText:@"Детская Одежда"];
        labelKid.font = [UIFont fontWithName:VM_FONT_BOLD size:15];
        labelKid.textAlignment = NSTextAlignmentLeft;
        labelKid.numberOfLines = 1;
        [self.mainScrollView addSubview:labelKid];
        
        NSArray * arrayKid = [NSArray arrayWithObjects:@"Малыши (до 3х лет)", @"Девочки", @"Мальчики", nil];
        for (int i = 0; i < 3; i++) {
            UIButton * buttonKid = [UIButton buttonWithType:UIButtonTypeSystem];
            buttonKid.frame = CGRectMake(15.f, 1070.f + 25 * i, self.frame.size.width - 30, 20);
            [buttonKid setTitle:[arrayKid objectAtIndex:i] forState:UIControlStateNormal];
            [buttonKid setTitleColor:[UIColor hx_colorWithHexRGBAString:@"000000"] forState:UIControlStateNormal];
            buttonKid.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
            buttonKid.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [self.mainScrollView addSubview:buttonKid];
        }
        
        
        CustomLabels * labelShoes = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:1150.f andSizeWidht:self.frame.size.width - 30 andSizeHeight:20 andColor:VM_COLOR_800
                                                                        andText:@"Обувь"];
        labelShoes.font = [UIFont fontWithName:VM_FONT_BOLD size:15];
        labelShoes.textAlignment = NSTextAlignmentLeft;
        labelShoes.numberOfLines = 1;
        [self.mainScrollView addSubview:labelShoes];
        
        NSArray * arrayShoes = [NSArray arrayWithObjects:@"Женская обув", @"Мужская обувь", @"Детская обувь", nil];
        for (int i = 0; i < 3; i++) {
            UIButton * buttonShoes = [UIButton buttonWithType:UIButtonTypeSystem];
            buttonShoes.frame = CGRectMake(15.f, 1180.f + 25 * i, self.frame.size.width - 30, 20);
            [buttonShoes setTitle:[arrayShoes objectAtIndex:i] forState:UIControlStateNormal];
            [buttonShoes setTitleColor:[UIColor hx_colorWithHexRGBAString:@"000000"] forState:UIControlStateNormal];
            buttonShoes.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
            buttonShoes.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [self.mainScrollView addSubview:buttonShoes];
        }
        
        NSArray * otherTitl = [NSArray arrayWithObjects:@"Головные уборы", @"Браслеты", @"Кольца", nil];
        NSArray * otherButtons = [NSArray arrayWithObjects:@"Головные уборы", @"Браслеты", @"Кольца", nil];
        for (int i = 0; i < 3; i++) {
            CustomLabels * labelShoes = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:1260.f + 60 * i andSizeWidht:self.frame.size.width - 30 andSizeHeight:20 andColor:VM_COLOR_800
                                                                              andText:[otherTitl objectAtIndex:i]];
            labelShoes.font = [UIFont fontWithName:VM_FONT_BOLD size:15];
            labelShoes.textAlignment = NSTextAlignmentLeft;
            labelShoes.numberOfLines = 1;
            [self.mainScrollView addSubview:labelShoes];
            
            UIButton * buttonOther = [UIButton buttonWithType:UIButtonTypeSystem];
            buttonOther.frame = CGRectMake(15.f, 1290.f + 60 * i, self.frame.size.width - 30, 20);
            [buttonOther setTitle:[otherButtons objectAtIndex:i] forState:UIControlStateNormal];
            [buttonOther setTitleColor:[UIColor hx_colorWithHexRGBAString:@"000000"] forState:UIControlStateNormal];
            buttonOther.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
            buttonOther.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [self.mainScrollView addSubview:buttonOther];
        }
        
        
        
    }
    return self;
}

@end
