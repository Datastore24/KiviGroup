//
//  PersonalAreaView.m
//  PsychologistIOS
//
//  Created by Viktor on 14.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "PersonalAreaView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"

@interface PersonalAreaView () <UITextFieldDelegate>

@end

@implementation PersonalAreaView
{
    UIScrollView * mainScrollView;
    //Телефон---------------------
    UITextField * textFieldPhone;
    UILabel * labelPlaceHolderPhone;
    BOOL isBoolPhone;
    //Емаил------------------------
    UITextField * textFieldEmail;
    UILabel * labelPlaceHolderEmail;
    BOOL isBoolEmail;
    //НикНейм----------------------
    UITextField * textFieldviewNickName;
    UILabel * labelPlaceHolderNickName;
    BOOL isBoolNickName;
    //Город-----------------------
    UIButton * buttonCity;
    UILabel * labelButtonCity;

}

- (instancetype)initWithView: (UIView*) view andArray: (NSArray*) array
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height - 64);
        
        isBoolPhone = YES;
        isBoolEmail = YES;
        isBoolNickName = YES;
        
        mainScrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        [self addSubview:mainScrollView];
        
        //Телефон-----------
        //Вью для телевона------------------------------------------------
        UIView * viewPhone = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 164, 96, 328, 48)];
        viewPhone.layer.cornerRadius = 24.f;
        viewPhone.backgroundColor = [UIColor whiteColor];
        viewPhone.layer.borderColor = [UIColor colorWithHexString:@"a6a6a6"].CGColor;
        viewPhone.layer.borderWidth = 0.4f;
        [mainScrollView addSubview:viewPhone];
        
        //Ввод телефона-----------------------------------------------------------------
        textFieldPhone = [[UITextField alloc] initWithFrame:CGRectMake(32, 0, viewPhone.frame.size.width - 64, viewPhone.frame.size.height)];
        textFieldPhone.delegate = self;
        textFieldPhone.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        textFieldPhone.autocorrectionType = UITextAutocorrectionTypeNo;
        textFieldPhone.font = [UIFont fontWithName:FONTREGULAR size:22];
        textFieldPhone.textColor = [UIColor colorWithHexString:@"515050"];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationLabelPhone:) name:UITextFieldTextDidChangeNotification object:textFieldPhone];
        [viewPhone addSubview:textFieldPhone];
        
        //Плэйс холдер телефона----------------------------------------------------------
        labelPlaceHolderPhone = [[UILabel alloc] initWithFrame:CGRectMake(32, 0, viewPhone.frame.size.width - 64, viewPhone.frame.size.height)];
        labelPlaceHolderPhone.text = @"Телефон";
        labelPlaceHolderPhone.textColor = [UIColor colorWithHexString:@"515050"];
        labelPlaceHolderPhone.font = [UIFont fontWithName:FONTREGULAR size:22];
        [viewPhone addSubview:labelPlaceHolderPhone];
        
        //Email-----------
        //Вью для Email------------------------------------------------
        UIView * viewEmail = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 164, viewPhone.frame.size.height + viewPhone.frame.origin.y + 48, 328, 48)];
        viewEmail.layer.cornerRadius = 24.f;
        viewEmail.backgroundColor = [UIColor whiteColor];
        viewEmail.layer.borderColor = [UIColor colorWithHexString:@"a6a6a6"].CGColor;
        viewEmail.layer.borderWidth = 0.4f;
        [mainScrollView addSubview:viewEmail];
        
        //Ввод Email-----------------------------------------------------------------
        textFieldEmail = [[UITextField alloc] initWithFrame:CGRectMake(32, 0, viewPhone.frame.size.width - 64, viewPhone.frame.size.height)];
        textFieldEmail.delegate = self;
        textFieldEmail.keyboardType = UIKeyboardTypeURL;
        textFieldEmail.autocorrectionType = UITextAutocorrectionTypeNo;
        textFieldEmail.font = [UIFont fontWithName:FONTREGULAR size:20];
        textFieldEmail.textColor = [UIColor colorWithHexString:@"515050"];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationLabelEmail:) name:UITextFieldTextDidChangeNotification object:textFieldEmail];
        [viewEmail addSubview:textFieldEmail];
        
        //Плэйс холдер Email----------------------------------------------------------
        labelPlaceHolderEmail = [[UILabel alloc] initWithFrame:CGRectMake(32, 0, viewPhone.frame.size.width - 64, viewPhone.frame.size.height)];
        labelPlaceHolderEmail.text = @"Введите Email";
        labelPlaceHolderEmail.textColor = [UIColor colorWithHexString:@"515050"];
        labelPlaceHolderEmail.font = [UIFont fontWithName:FONTREGULAR size:20];
        [viewEmail addSubview:labelPlaceHolderEmail];
        
        //NickName-----------
        //Вью для NickName------------------------------------------------
        UIView * viewNickName = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 164, viewEmail.frame.size.height + viewEmail.frame.origin.y + 16, 328, 48)];
        viewNickName.layer.cornerRadius = 24.f;
        viewNickName.backgroundColor = [UIColor whiteColor];
        viewNickName.layer.borderColor = [UIColor colorWithHexString:@"a6a6a6"].CGColor;
        viewNickName.layer.borderWidth = 0.4f;
        [mainScrollView addSubview:viewNickName];
        
        //Ввод NickName-----------------------------------------------------------------
        textFieldviewNickName = [[UITextField alloc] initWithFrame:CGRectMake(32, 0, viewPhone.frame.size.width - 64, viewPhone.frame.size.height)];
        textFieldviewNickName.delegate = self;
        textFieldviewNickName.autocorrectionType = UITextAutocorrectionTypeNo;
        textFieldviewNickName.font = [UIFont fontWithName:FONTREGULAR size:20];
        textFieldviewNickName.textColor = [UIColor colorWithHexString:@"515050"];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationLabelNickName:) name:UITextFieldTextDidChangeNotification object:textFieldviewNickName];
        [viewNickName addSubview:textFieldviewNickName];
        
        //Плэйс холдер NickName----------------------------------------------------------
        labelPlaceHolderNickName = [[UILabel alloc] initWithFrame:CGRectMake(32, 0, viewPhone.frame.size.width - 64, viewPhone.frame.size.height)];
        labelPlaceHolderNickName.text = @"Ник";
        labelPlaceHolderNickName.textColor = [UIColor colorWithHexString:@"515050"];
        labelPlaceHolderNickName.font = [UIFont fontWithName:FONTREGULAR size:20];
        [viewNickName addSubview:labelPlaceHolderNickName];
        
        //Город-----------
        //Вью для Город------------------------------------------------
        buttonCity = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonCity.frame = CGRectMake(self.frame.size.width / 2 - 164, viewNickName.frame.size.height + viewNickName.frame.origin.y + 16, 328, 48);
        buttonCity.layer.cornerRadius = 24.f;
        buttonCity.backgroundColor = [UIColor whiteColor];
        buttonCity.layer.borderColor = [UIColor colorWithHexString:@"a6a6a6"].CGColor;
        buttonCity.layer.borderWidth = 0.4f;
        [buttonCity addTarget:self action:@selector(buttonCityAction) forControlEvents:UIControlEventTouchUpInside];
        [buttonCity setTitle:@"Город" forState:UIControlStateNormal];
        [buttonCity setTitleColor:[UIColor colorWithHexString:@"515050"] forState:UIControlStateNormal];
        buttonCity.contentEdgeInsets = UIEdgeInsetsMake(0, -200, 0, 0);
        buttonCity.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:20];
        [mainScrollView addSubview:buttonCity];
        
        UIImageView * imageViewButton = [[UIImageView alloc] initWithFrame:CGRectMake(buttonCity.frame.size.width - 64, 24, 16, 8)];
        imageViewButton.image = [UIImage imageNamed:@"arrowDownImage.png"];
        [buttonCity addSubview:imageViewButton];
        
        
        //Дата рождения-----------
        //Вью для Даты рождения------------------------------------------------
        UIButton * buttonBirth = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonBirth.frame = CGRectMake(self.frame.size.width / 2 - 164, buttonCity.frame.size.height + buttonCity.frame.origin.y + 16, 328, 48);
        buttonBirth.layer.cornerRadius = 24.f;
        buttonBirth.backgroundColor = [UIColor whiteColor];
        buttonBirth.layer.borderColor = [UIColor colorWithHexString:@"a6a6a6"].CGColor;
        buttonBirth.layer.borderWidth = 0.4f;
        [buttonBirth addTarget:self action:@selector(buttonBirthAction) forControlEvents:UIControlEventTouchUpInside];
        [buttonBirth setTitle:@"Дата рождения" forState:UIControlStateNormal];
        [buttonBirth setTitleColor:[UIColor colorWithHexString:@"515050"] forState:UIControlStateNormal];
        buttonBirth.contentEdgeInsets = UIEdgeInsetsMake(0, -100, 0, 0);
        buttonBirth.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:20];
        [mainScrollView addSubview:buttonBirth];
        
        UIImageView * imageViewButtonBirth = [[UIImageView alloc] initWithFrame:CGRectMake(buttonBirth.frame.size.width - 64, 24, 16, 8)];
        imageViewButtonBirth.image = [UIImage imageNamed:@"arrowDownImage.png"];
        [buttonBirth addSubview:imageViewButtonBirth];
        
        //Семейное положение-----------
        //Вью для Семейное положение------------------------------------------------
        UIButton * buttonMaritalStatus = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonMaritalStatus.frame = CGRectMake(self.frame.size.width / 2 - 164, buttonBirth.frame.size.height + buttonBirth.frame.origin.y + 16, 328, 48);
        buttonMaritalStatus.layer.cornerRadius = 24.f;
        buttonMaritalStatus.backgroundColor = [UIColor whiteColor];
        buttonMaritalStatus.layer.borderColor = [UIColor colorWithHexString:@"a6a6a6"].CGColor;
        buttonMaritalStatus.layer.borderWidth = 0.4f;
        [buttonMaritalStatus addTarget:self action:@selector(buttonMaritalStatu) forControlEvents:UIControlEventTouchUpInside];
        [buttonMaritalStatus setTitle:@"Семейное положение" forState:UIControlStateNormal];
        [buttonMaritalStatus setTitleColor:[UIColor colorWithHexString:@"515050"] forState:UIControlStateNormal];
        buttonMaritalStatus.contentEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
        buttonMaritalStatus.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:20];
        [mainScrollView addSubview:buttonMaritalStatus];
        
        UIImageView * imageViewButtonbuttonMaritalStatus = [[UIImageView alloc] initWithFrame:CGRectMake(buttonMaritalStatus.frame.size.width - 64, 24, 16, 8)];
        imageViewButtonbuttonMaritalStatus.image = [UIImage imageNamed:@"arrowDownImage.png"];
        [buttonMaritalStatus addSubview:imageViewButtonbuttonMaritalStatus];
        
        //Есть 18ть ??--------------------------------------
        UIButton * buttonEighteen = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonEighteen.frame = CGRectMake(120, buttonMaritalStatus.frame.size.height + buttonMaritalStatus.frame.origin.y + 16, 16, 16);
        buttonEighteen.backgroundColor = [UIColor whiteColor];
        [buttonEighteen addTarget:self action:@selector(buttonEighteenAction) forControlEvents:UIControlEventTouchUpInside];
        [mainScrollView addSubview:buttonEighteen];
        
        //Лейбл есть 18ть ???-----------------------------------
        UILabel * labelButtonEighteen = [[UILabel alloc] initWithFrame:CGRectMake(152, buttonMaritalStatus.frame.size.height + buttonMaritalStatus.frame.origin.y + 18, 200, 16)];
        labelButtonEighteen.text = @"Отображать темы 18 +";
        labelButtonEighteen.textColor = [UIColor colorWithHexString:@"5b5b5b"];
        labelButtonEighteen.font = [UIFont fontWithName:FONTREGULAR size:15];
        [mainScrollView addSubview:labelButtonEighteen];
        
        //Кнопка сохранить----------------------------------------
        UIButton * buttonSave = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonSave.frame = CGRectMake(self.frame.size.width / 2 - 92, buttonEighteen.frame.size.height + buttonEighteen.frame.origin.y + 48, 184, 48);
        buttonSave.layer.cornerRadius = 24;
        [buttonSave setTitle:@"СОХРАНИТЬ" forState:UIControlStateNormal];
        [buttonSave setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonSave.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:19];
        buttonSave.backgroundColor = [UIColor colorWithHexString:@"ea504f"];
        [mainScrollView addSubview:buttonSave];
        

        


    }
    return self;
}

#pragma mark - UITextFieldDelegate

//Скрытие клавиатуры----------------------------------------
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//Метод ввода тоьлко чисел-----------------------------------
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    /* for backspace */
    if([string length]==0){
        return YES;
    }
    
    /*  limit to only numeric characters  */
    
    if ([textField isEqual:textFieldPhone]) {
        NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        for (int i = 0; i < [string length]; i++) {
            unichar c = [string characterAtIndex:i];
            if ([myCharSet characterIsMember:c]) {
                
                
                /*  limit the users input to only 9 characters  */
                NSUInteger newLength = [textField.text length] + [string length] - range.length;
                return (newLength > 12) ? NO : YES;
            }
        }
        return NO;
    } else {
        /*  limit the users input to only 9 characters  */
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 50) ? NO : YES;
    }
    
    return NO;
}

//Анимация Лейблов при вводе Телефона------------------------
- (void) animationLabelPhone: (NSNotification*) notification
{
    UITextField * testField = notification.object;
    
    if (testField.text.length < 3) {
        testField.text = @"+7";
    }
    
    
    if (testField.text.length != 0 && isBoolPhone) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderPhone.frame;
            rect.origin.x = rect.origin.x + 100.f;
            labelPlaceHolderPhone.frame = rect;
            labelPlaceHolderPhone.alpha = 0.f;
            isBoolPhone = NO;
        }];
    } else if (testField.text.length == 0 && !isBoolPhone) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderPhone.frame;
            rect.origin.x = rect.origin.x - 100.f;
            labelPlaceHolderPhone.frame = rect;
            labelPlaceHolderPhone.alpha = 1.f;
            isBoolPhone = YES;
        }];
    }
}

//Анимация Лейблов при вводе Email------------------------
- (void) animationLabelEmail: (NSNotification*) notification
{
    UITextField * testField = notification.object;
    
    if (testField.text.length != 0 && isBoolEmail) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderEmail.frame;
            rect.origin.x = rect.origin.x + 100.f;
            labelPlaceHolderEmail.frame = rect;
            labelPlaceHolderEmail.alpha = 0.f;
            isBoolEmail = NO;
        }];
    } else if (testField.text.length == 0 && !isBoolEmail) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderEmail.frame;
            rect.origin.x = rect.origin.x - 100.f;
            labelPlaceHolderEmail.frame = rect;
            labelPlaceHolderEmail.alpha = 1.f;
            isBoolEmail = YES;
        }];
    }
}

//Анимация Лейблов при вводе Email------------------------
- (void) animationLabelNickName: (NSNotification*) notification
{
    UITextField * testField = notification.object;
    
    if (testField.text.length != 0 && isBoolNickName) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderNickName.frame;
            rect.origin.x = rect.origin.x + 100.f;
            labelPlaceHolderNickName.frame = rect;
            labelPlaceHolderNickName.alpha = 0.f;
            isBoolNickName = NO;
        }];
    } else if (testField.text.length == 0 && !isBoolNickName) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderNickName.frame;
            rect.origin.x = rect.origin.x - 100.f;
            labelPlaceHolderNickName.frame = rect;
            labelPlaceHolderNickName.alpha = 1.f;
            isBoolNickName = YES;
        }];
    }
}

//Поднимаем текст вверх--------------------------------------
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:textFieldPhone]) {
        if ([textField.text isEqualToString:@""]) {
            textField.text = @"+7";
            if (textField.text.length != 0 && isBoolPhone) {
                [UIView animateWithDuration:0.3 animations:^{
                    CGRect rect;
                    rect = labelPlaceHolderPhone.frame;
                    rect.origin.x = rect.origin.x + 100.f;
                    labelPlaceHolderPhone.frame = rect;
                    labelPlaceHolderPhone.alpha = 0.f;
                    isBoolPhone = NO;
                }];
            }
            
        }
    }
    
    textField.textAlignment = NSTextAlignmentLeft;
}

//Восстанавливаем стандартный размер-----------------------
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField isEqual:textFieldPhone]) {
        if ([textField.text isEqualToString:@"+7"]) {
            textField.text = @"";
            if (textField.text.length == 0 && !isBoolPhone) {
                [UIView animateWithDuration:0.3 animations:^{
                    CGRect rect;
                    rect = labelPlaceHolderPhone.frame;
                    rect.origin.x = rect.origin.x - 100.f;
                    labelPlaceHolderPhone.frame = rect;
                    labelPlaceHolderPhone.alpha = 1.f;
                    isBoolPhone = YES;
                }];
            }
        }
    }
    
    textField.textAlignment = NSTextAlignmentCenter;
}

//Отвязка от всех нотификаций------------------------------
- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Action Methods
//Действие кнопки Выбора города-----------------------------
- (void) buttonCityAction
{
    NSLog(@"Выбрать город");
}

//Действие семейное положение--------------------------------
- (void) buttonMaritalStatu
{
    NSLog(@"Семейное положение");
}

//Действие дата рождения----------------------------------------
- (void) buttonBirthAction
{
    NSLog(@"Дата рождения");
}

//Действие кнопки есть 18ть------------------------------------
- (void) buttonEighteenAction
{
    NSLog(@"Есть 18ть");
}

@end
