//
//  CallMasterView.m
//  ITDolgopa
//
//  Created by Viktor on 22.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "CallMasterView.h"

#import "OrderTimeView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "FontSizeChanger.h"

@interface CallMasterView () <UITextFieldDelegate>

@end

@implementation CallMasterView
{
    UIDatePicker * datePicker;
    UIDatePicker * timePicker;
    UILabel * labelDataAction;
    UILabel * labelTimeAction;
    UIView * firstViewAction;
    BOOL isBool;
    BOOL isBool2;
    BOOL isBoolProblem;
    UIView * secondView;
    UIView * secontViewAction;
    UIView * endView;
    UITextField * textFieldProblem;
    UILabel * labelPlaceHolderProblem;
    UIScrollView * mainScrollView;
}

- (instancetype)initWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        
        //Изменение размеров
        NSDictionary * fontSize = [FontSizeChanger changeFontSize];
        
        isBool = YES;
        isBool2 = YES;
        isBoolProblem = YES;
        
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.width);
        mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
        mainScrollView.backgroundColor = [UIColor colorWithHexString:MAINBACKGROUNDCOLOR];
        [self addSubview:mainScrollView];
        
        //Первая часть вью-----------------------------------------------------------
        UIView * firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 150)];
        firstView.backgroundColor = nil;
        [mainScrollView addSubview:firstView];
        
        //Первая активная вью----------------------------------------------------------
        firstViewAction = [[UIView alloc] initWithFrame:CGRectMake(0, firstView.frame.size.height, view.frame.size.width, 0)];
        firstViewAction.backgroundColor = [UIColor colorWithHexString:COLORLITELITEGRAY];
        [mainScrollView addSubview:firstViewAction];
        //Дата пикер даты------------------------------------------------------------
        datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 15, view.frame.size.width, 200)];
        datePicker.datePickerMode = UIDatePickerModeDate;
        [datePicker addTarget:self action:@selector(dataPickerValueChanged)
             forControlEvents:UIControlEventValueChanged];
        datePicker.minimumDate = [NSDate date];
        [firstViewAction addSubview:datePicker];
        
        //Кнопка скрытия датапикера----------------------------------------------------
        UIButton * buttonDate = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonDate.frame = CGRectMake(100, 110, 150, 40);
        //CustomCentr
        CGPoint point = firstView.center;
        point.y = point.y + 50;
        buttonDate.center = point;
        [buttonDate addTarget:self action:@selector(buttonDateAction) forControlEvents:UIControlEventTouchUpInside];
        [firstView addSubview:buttonDate];
        
        //Лейбл Дата-------------------------------------------------------------------
        UILabel * labelDate = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 47, 40)];
        labelDate.text = @"Дата:";
        labelDate.textColor = [UIColor colorWithHexString:COLORLITEGRAY];
        labelDate.font = [UIFont fontWithName:FONTREGULAR size:18.5f];
        [buttonDate addSubview:labelDate];
        
        //Лейбл дата активный-----------------------------------------------------------
        labelDataAction = [[UILabel alloc] initWithFrame:CGRectMake(labelDate.frame.origin.x + labelDate.frame.size.width + 3, 0, 80, 40)];
        NSDateFormatter *inFormat = [[NSDateFormatter alloc] init];
        [inFormat setDateFormat:@"dd.MM.yy"];
        NSString *strDate = [inFormat stringFromDate:datePicker.date];
        labelDataAction.text = strDate;
        labelDataAction.textColor = [UIColor whiteColor];
        labelDataAction.font = [UIFont fontWithName:FONTLITE size:18.5f];
        labelDataAction.tag = 401;
        [buttonDate addSubview:labelDataAction];
        
        //Конец первого блока------------------------------------------------------------
        
        secondView = [[UIView alloc] initWithFrame:CGRectMake(0, firstView.frame.origin.y + firstView.frame.size.height, self.frame.size.width, 40)];
        secondView.backgroundColor = [UIColor colorWithHexString:MAINBACKGROUNDCOLOR];
        [mainScrollView addSubview:secondView];
        
        //Вторая активная вью----------------------------------------------------------
        secontViewAction = [[UIView alloc] initWithFrame:CGRectMake(0, secondView.frame.origin.y + secondView.frame.size.height, view.frame.size.width, 0)];
        secontViewAction.backgroundColor = [UIColor colorWithHexString:COLORLITELITEGRAY];
        [mainScrollView addSubview:secontViewAction];
        //Дата пикер времени------------------------------------------------------------
        timePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 15, view.frame.size.width, 200)];
        timePicker.datePickerMode = UIDatePickerModeTime;
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"NL"];
        [timePicker setLocale:locale];
        [timePicker addTarget:self action:@selector(timePickerValueChanged)
             forControlEvents:UIControlEventValueChanged];
        [secontViewAction addSubview:timePicker];
        
        //Кнопка скрытия датапикера----------------------------------------------------
        UIButton * buttonTime = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonTime.frame = CGRectMake(50, 0, 150, 40);
        //CustomCentr
        CGPoint point1 = secondView.center;
        point1.y = point1.y - 150;
        buttonTime.center = point1;
        [buttonTime addTarget:self action:@selector(buttonTimeAction) forControlEvents:UIControlEventTouchUpInside];
        [secondView addSubview:buttonTime];
        
        //Лейбл Время-------------------------------------------------------------------
        UILabel * labelTime = [[UILabel alloc] initWithFrame:CGRectMake(18, 0, 60, 40)];
        labelTime.text = @"Время:";
        labelTime.textColor = [UIColor colorWithHexString:COLORLITEGRAY];
        labelTime.font = [UIFont fontWithName:FONTREGULAR size:18.5f];
        [buttonTime addSubview:labelTime];
        
        //Лейбл дата активный-----------------------------------------------------------
        labelTimeAction = [[UILabel alloc] initWithFrame:CGRectMake(labelTime.frame.origin.x + labelTime.frame.size.width + 3, 0, 70, 40)];
        NSDateFormatter *inFormat1 = [[NSDateFormatter alloc] init];
        [inFormat1 setDateFormat:@"HH.mm"];
        NSString *strDate1 = [inFormat1 stringFromDate:timePicker.date];
        labelTimeAction.text = strDate1;
        labelTimeAction.textColor = [UIColor whiteColor];
        labelTimeAction.font = [UIFont fontWithName:FONTLITE size:18.5f];
        labelTimeAction.tag = 410;
        [buttonTime addSubview:labelTimeAction];
        
        //Финальное Вью------------------------------------------------------------------
        endView = [[UIView alloc] initWithFrame:CGRectMake(0, secontViewAction.frame.origin.y + secontViewAction.frame.size.height, self.frame.size.width, view.frame.size.height - (secontViewAction.frame.origin.y + secontViewAction.frame.size.height))];
        endView.backgroundColor = [UIColor colorWithHexString:MAINBACKGROUNDCOLOR];
        [mainScrollView addSubview:endView];
        
        //Лейбл Проблема-------------------------------------------------------------------
        UILabel * labelProblem = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 80, 40)];
        labelProblem.text = @"Адрес:";
        labelProblem.textColor = [UIColor colorWithHexString:COLORLITEGRAY];
        labelProblem.font = [UIFont fontWithName:FONTREGULAR size:18.5f];
        [endView addSubview:labelProblem];
        
        //Плэйс холдер Проблемы-------------------------------------------------------------------
        labelPlaceHolderProblem = [[UILabel alloc] initWithFrame:CGRectMake(labelProblem.frame.origin.x + labelProblem.frame.size.width + 3, labelProblem.frame.origin.y, 200, 40)];
        labelPlaceHolderProblem.text = @"      Введите ваш адрес";
        labelPlaceHolderProblem.textColor = [UIColor whiteColor];
        labelPlaceHolderProblem.font = [UIFont fontWithName:FONTLITE size:15];
        if (isiPhone5) {
            labelPlaceHolderProblem.text = @"Введите ваш адрес";
            labelPlaceHolderProblem.font = [UIFont fontWithName:FONTLITE size:12];
        }
        [endView addSubview:labelPlaceHolderProblem];
        
        //Ввод проблемы---------------------------------------------------------
        textFieldProblem = [[UITextField alloc] initWithFrame:CGRectMake(labelProblem.frame.origin.x + labelProblem.frame.size.width + 3, labelProblem.frame.origin.y, 230, 40)];
        textFieldProblem.delegate = self;
        textFieldProblem.tag = 413;
        textFieldProblem.keyboardAppearance = UIKeyboardAppearanceDark;
        textFieldProblem.autocorrectionType = UITextAutocorrectionTypeNo;
        textFieldProblem.font = [UIFont fontWithName:FONTLITE size:15];
        if (isiPhone5) {
            textFieldProblem.font = [UIFont fontWithName:FONTLITE size:12];
            textFieldProblem.frame = CGRectMake(labelProblem.frame.origin.x + labelProblem.frame.size.width + 3, labelProblem.frame.origin.y, 180, 40);
        }
        textFieldProblem.textColor = [UIColor whiteColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationLabelProblem:) name:UITextFieldTextDidChangeNotification object:textFieldProblem];
        [endView addSubview:textFieldProblem];
        
        //Кнопка отправить------------------------------------------------------------------
        UIButton * buttonConferm = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonConferm.frame = CGRectMake(50, labelProblem.frame.origin.y + labelProblem.frame.size.height + 20, view.frame.size.width - 100, 35);
        buttonConferm.backgroundColor = [UIColor colorWithHexString:@"00a552"];
        buttonConferm.layer.borderColor = [UIColor whiteColor].CGColor;
        buttonConferm.layer.borderWidth = 0.5f;
        buttonConferm.layer.cornerRadius = 18.f;
        buttonConferm.tag = 415;
        [buttonConferm setTitle:@"ВЫЗВАТЬ МАСТЕРА" forState:UIControlStateNormal];
        [buttonConferm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonConferm.titleLabel.font = [UIFont fontWithName:FONTLITE size:[[fontSize objectForKey:@"textSize"] intValue]];
        [endView addSubview:buttonConferm];
        
        
        
        
        
    }
    return self;
}

//Отвязка от всех нотификаций------------------------------
- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) dataPickerValueChanged
{
    NSDateFormatter *inFormat = [[NSDateFormatter alloc] init];
    [inFormat setDateFormat:@"dd.MM.yy"];
    NSString *strDate = [inFormat stringFromDate:datePicker.date];
    labelDataAction.text = strDate;
}

- (void) timePickerValueChanged
{
    NSDateFormatter *inFormat = [[NSDateFormatter alloc] init];
    [inFormat setDateFormat:@"HH.mm"];
    NSString *strDate = [inFormat stringFromDate:timePicker.date];
    labelTimeAction.text = strDate;
}

#pragma mark - Buttons Methods

- (void) buttonDateAction
{
    if (isBool) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = firstViewAction.frame;
            rect.size.height = rect.size.height + 250;
            firstViewAction.frame = rect;
            //---------------------------------------
            CGRect rect1 = secondView.frame;
            rect1.origin.y = rect1.origin.y + 250;
            secondView.frame = rect1;
            //---------------------------------------
            CGRect rect2 = secontViewAction.frame;
            rect2.origin.y = rect2.origin.y + 250;
            secontViewAction.frame = rect2;
            //---------------------------------------
            CGRect rect3 = endView.frame;
            rect3.origin.y = rect3.origin.y + 250;
            endView.frame = rect3;
            isBool = NO;
        }];
        
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = firstViewAction.frame;
            rect.size.height = rect.size.height - 250;
            firstViewAction.frame = rect;
            //---------------------------------------
            CGRect rect1 = secondView.frame;
            rect1.origin.y = rect1.origin.y - 250;
            secondView.frame = rect1;
            //---------------------------------------
            CGRect rect2 = secontViewAction.frame;
            rect2.origin.y = rect2.origin.y - 250;
            secontViewAction.frame = rect2;
            //---------------------------------------
            CGRect rect3 = endView.frame;
            rect3.origin.y = rect3.origin.y - 250;
            endView.frame = rect3;
            isBool = YES;
        }];
        
    }
}

- (void) buttonTimeAction
{
    if (isBool2) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect2 = secontViewAction.frame;
            rect2.size.height = rect2.size.height + 250;
            secontViewAction.frame = rect2;
            //---------------------------------------
            CGRect rect3 = endView.frame;
            rect3.origin.y = rect3.origin.y + 250;
            endView.frame = rect3;
            isBool2 = NO;
        }];
        
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect2 = secontViewAction.frame;
            rect2.size.height = rect2.size.height - 250;
            secontViewAction.frame = rect2;
            //---------------------------------------
            CGRect rect3 = endView.frame;
            rect3.origin.y = rect3.origin.y - 250;
            endView.frame = rect3;
            isBool2 = YES;
        }];
        
    }
    
}

#pragma mark - UITextFieldDelegate
//Анимация Лейблов при вводе SMS-------------------------
- (void) animationLabelProblem: (NSNotification*) notification
{
    UITextField * testField = notification.object;
    if (testField.text.length != 0 && isBoolProblem) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderProblem.frame;
            rect.origin.x = rect.origin.x + 100.f;
            labelPlaceHolderProblem.frame = rect;
            labelPlaceHolderProblem.alpha = 0.f;
            isBoolProblem = NO;
        }];
    } else if (testField.text.length == 0 && !isBoolProblem) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderProblem.frame;
            rect.origin.x = rect.origin.x - 100.f;
            labelPlaceHolderProblem.frame = rect;
            labelPlaceHolderProblem.alpha = 1.f;
            isBoolProblem = YES;
        }];
    }
}

//Скрытие клавиатуры----------------------------------------
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


//Поднимаем текст вверх--------------------------------------
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (isiPhone5) {
        mainScrollView.contentOffset = (CGPoint){
            0, // ось x нас не интересует
            80 // Скроллим скролл к верхней границе текстового поля - Вы можете настроить эту величину по своему усмотрению
        };
        
    }
    textField.textAlignment = NSTextAlignmentLeft;
}

//Восстанавливаем стандартный размер-----------------------
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (isiPhone5) {
        mainScrollView.contentOffset = (CGPoint){0, 0}; // Возвращаем скролл в начало, так как редактирование текстового поля закончено
        
    }
    
    textField.textAlignment = NSTextAlignmentCenter;
}



@end
