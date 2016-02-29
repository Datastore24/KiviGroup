//
//  ChatController.m
//  ITDolgopa
//
//  Created by Viktor on 25.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "ChatController.h"
#import "TitleClass.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "SWRevealViewController.h"
#import "ChatViewPush.h"
#import "ChatCellView.h"
#import "APIGetClass.h"
#import "SingleTone.h"
#import "ViewSectionTable.h"
#import "BBlock.h"


static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 230;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 230;

@interface ChatController () <UIScrollViewDelegate, UITextFieldDelegate>

@end

@implementation ChatController
{
    
    UILabel * labelPlaceHolder;
    BOOL isBool;
    CGFloat animatedDistance;
    UILabel * testLabel;
    CGFloat customHeight;
    UITextField * textFildText;
    UIImageView * localImageView;

    
}

- (void) viewDidLoad
{
#pragma mark - initialization
    
    isBool = YES;
    customHeight = 0.f;
    
    //Инициализация обновления чата----------------------------
    self.chatCount = 10;
    self.offset = 0;
    
    
    //---------------------------------------------------------
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadMoreDialog) name:@"ReloadChat" object:nil];


    
    self.navigationController.navigationBar.layer.cornerRadius=5;
    self.navigationController.navigationBar.clipsToBounds=YES;
    
    //Заголовок-----------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"ЧАТ С МАСТЕРОМ"];
    self.navigationItem.titleView = title;
    
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:MAINCOLORBUTTONLOGIN];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    //Пареметры кнопки меню------------------------------------
    UIImage *imageBarButton = [UIImage imageNamed:@"menuIcon.png"];
    [_buttonMenu setImage:imageBarButton];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake( 0, 0, 30, 30);
    [button setImage:imageBarButton forState:UIControlStateNormal];
    [button addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    _buttonMenu.customView=button;
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    self.navigationController.navigationBar.hidden = NO; // спрятал navigation bar
    
    //Параметры mainScrollView-----------------------------------
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,
                                                                    self.view.frame.size.height - 164)];
    self.mainScrollView.backgroundColor = [UIColor colorWithHexString:MAINBACKGROUNDCOLOR];
    self.mainScrollView.delegate = self;
    [self.view addSubview:self.mainScrollView];
    
    //Инициализация вью отправки----------------------------------
    ChatViewPush * chatViewPush = [[ChatViewPush alloc] initWhithView:self.view andFrame:CGRectMake(0, self.view.frame.size.height - 164, self.view.frame.size.width, 100)];
    [self.view addSubview:chatViewPush];
    
    textFildText = (UITextField*)[self.view viewWithTag:501];
    textFildText.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFildText:) name:UITextFieldTextDidChangeNotification object:textFildText];
    labelPlaceHolder = (UILabel*)[self.view viewWithTag:502];
    
    [self getAPIWithPhone:[[SingleTone sharedManager] phone]  andWithBlock:^{
        
        self.arrayDialog = [NSArray arrayWithArray:[self.dictResponse objectForKey:@"dialogs"]];
        
        
        
        [self loadViewWithArray:self.arrayDialog];
        
        //Временнй метод для симулятор, котоорый эмулирует нотификацию он новом сообщении
        [NSTimer scheduledTimerWithTimeInterval:7.0f
                                             target:self selector:@selector(loadMoreDialog) userInfo:nil repeats:YES];
        //
        
//        NSLog(@"%@", self.arrayDialog);
    }];
    
    //Инициализаци кнопки отправить------------------------------------------------------------
    UIButton * sendButton = (UIButton*)[self.view viewWithTag:510];
    [sendButton addTarget:self action:@selector(sendButtonAction) forControlEvents:UIControlEventTouchUpInside];
    

}

#pragma mark - UITextFieldDelegate

//Анимация Лейблов при вводе Текста-------------------------
- (void) textFildText: (NSNotification*) notification
{
    UITextField * testField = notification.object;
    
    if (testField.text.length != 0 && isBool) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolder.frame;
            rect.origin.x = rect.origin.x + 100.f;
            labelPlaceHolder.frame = rect;
            labelPlaceHolder.alpha = 0.f;
            isBool = NO;
        }];
    } else if (testField.text.length == 0 && !isBool) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolder.frame;
            rect.origin.x = rect.origin.x - 100.f;
            labelPlaceHolder.frame = rect;
            labelPlaceHolder.alpha = 1.f;
            isBool = YES;
        }];
    }
}

//Скрытие клавиатуры----------------------------------------
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Методы поднимающие ViewController, при открытии клавиатуры

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect textFieldRect =
    [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect =
    [self.view.window convertRect:self.view.bounds fromView:self.view];
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =
    midline - viewRect.origin.y
    - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =
    (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
    * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textfield{
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

#pragma mark - API

//Метод отправки сообщения--------------------------------------------------
- (void) getAPIWithPone: (NSString*) phone andMessage: (NSString*) message
{
    NSDictionary * dictParams = [NSDictionary dictionaryWithObjectsAndKeys:
                                 phone, @"phone",
                                 message, @"message", nil];
    APIGetClass * messageAPI = [[APIGetClass alloc] init];
    [messageAPI getDataFromServerWithParams:dictParams method:@"dialog_send_message" complitionBlock:^(id response) {
        
        NSDictionary * responseMessage = (NSDictionary*) response;
        if ([[responseMessage objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"error_msg %@", [responseMessage objectForKey:@"error_msg"]);
        } else if ([[responseMessage objectForKey:@"error"] integerValue] == 0) {
            NSLog(@"Сообщение доставленно");
            NSLog(@"%@", responseMessage);
            
            self.dialogMaxID = [responseMessage objectForKey:@"max_id"];
        }

    }];
}

//Метод прогрузки всего списка сообщений----------------------------------------------
- (void) getAPIWithPhone: (NSString*) phone andWithBlock: (void (^)(void)) block
{
    
    NSDictionary * dictParams = [NSDictionary dictionaryWithObjectsAndKeys:phone, @"phone",
                                 [NSNumber numberWithInteger:self.chatCount],@"count",
                                 [NSNumber numberWithInteger:self.offset],@"offset", nil];
    APIGetClass * aPIGetClass = [APIGetClass new];
    [aPIGetClass getDataFromServerWithParams:dictParams method:@"dialog_show" complitionBlock:^(id response) {
        
        self.dictResponse = (NSDictionary*) response;
        if ([[self.dictResponse objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"Ошибка");
        } else if ([[self.dictResponse objectForKey:@"error"] integerValue] == 0) {
            NSLog(@"Все хорошо");
//
            self.maxCount = [[self.dictResponse objectForKey:@"dialogs_count"] integerValue];
            self.dialogMaxID = [self.dictResponse objectForKey:@"max_id"];
            
            
        }
        
        block();
        
    }];
}

//Магия Кирилла-----------------------------------------------
- (void) getAPIMoreWithPhone: (NSString*) phone andMaxID:(NSString *) maxid andWithBlock: (void (^)(void)) block
{
    
    NSDictionary * dictParams = [NSDictionary dictionaryWithObjectsAndKeys:phone, @"phone",
                                 maxid,@"maxid", nil];
    APIGetClass * aPIGetClass = [APIGetClass new];
    [aPIGetClass getDataFromServerWithParams:dictParams method:@"dialog_show" complitionBlock:^(id response) {
        
        self.dictResponse = (NSDictionary*) response;
        if ([[self.dictResponse objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"Ошибка");
        } else if ([[self.dictResponse objectForKey:@"error"] integerValue] == 0) {
//            NSLog(@"Все хорошо");
            //
            self.maxCount = [[self.dictResponse objectForKey:@"dialogs_count"] integerValue];
            self.dialogMaxID = [self.dictResponse objectForKey:@"max_id"];
        }
        block();
    }];
}

-(void) loadMoreDialog{
    [self getAPIMoreWithPhone:[[SingleTone sharedManager] phone] andMaxID:self.dialogMaxID andWithBlock:^{
        
        self.arrayDialog = [NSArray arrayWithArray:[self.dictResponse objectForKey:@"dialogs"]];
        
        [self loadViewWithArray:self.arrayDialog];
        
        NSLog(@"%lu", (unsigned long)self.maxCount);
        NSLog(@"%@", self.arrayDialog);
    }];
}

//Локальная загрузка сообщения-----------------------------------
- (void) loadViewWithArray: (NSArray*) array
{
    
    
//    NSLog(@"Что то делаю");
    //Инициализация ячеек чата------------------------------------
    for (int i = 0; i < array.count; i++) {
        
        NSDictionary * dictArrey = [array objectAtIndex:i];
        
        testLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.mainScrollView.frame.size.width - 200, 40)];
        testLabel.numberOfLines = 0;
        testLabel.backgroundColor = [UIColor clearColor];
        testLabel.text = [dictArrey objectForKey:@"message"];
        testLabel.textColor = [UIColor whiteColor];
        testLabel.font = [UIFont fontWithName:FONTLITE size:12];
        [testLabel sizeToFit];
        ChatCellView * cellView = [[ChatCellView alloc] initWhithFirstView:self.view andDate:nil andImagePhoto:nil andFrame:CGRectMake(0, customHeight, self.view.frame.size.width, testLabel.frame.size.height + 40)];
        [self.mainScrollView addSubview:cellView];
        customHeight = customHeight + (testLabel.frame.size.height + 40);
        //Вью лейбла-------------------------------------------------
        UIView * customView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 195 / 2, 10, 195, testLabel.frame.size.height + 20)];
        
        customView.backgroundColor = [UIColor colorWithHexString:@"818181"];
        customView.layer.cornerRadius = 10.f;
        [cellView addSubview:customView];
        [customView addSubview:testLabel];
        //Лейбл даты-------------------------------------------------
        
        NSString * stringDateAll = [dictArrey objectForKey:@"created"];
        NSLog(@"%@", stringDateAll);
        
        
        
        UILabel * labelData = [[UILabel alloc] initWithFrame:CGRectMake(customView.frame.origin.x + customView.frame.size.width + 20, customView.frame.origin.y, 50, customView.frame.size.height)];
        labelData.text = @"17.39";
        labelData.textColor = [UIColor whiteColor];
        labelData.font = [UIFont fontWithName:FONTLITE size:12];
        [cellView addSubview:labelData];
        //Фото отправителя-------------------------------------------
        if ([dictArrey objectForKey:@"avatar_url"]) {
            ViewSectionTable * viewSectionTable = [[ViewSectionTable alloc] initWithImageURL:[dictArrey objectForKey:@"avatar_url"] andView:customView];
            [cellView addSubview:viewSectionTable];
        }else{
            
            NSLog(@"Нет аватара");
            
            localImageView = [[UIImageView alloc] initWithFrame:CGRectMake (customView.frame.origin.x - 60, customView.frame.origin.y - 5, 40, 40)];
            localImageView.backgroundColor = [UIColor whiteColor];
            localImageView.layer.cornerRadius = 20.0;
            localImageView.clipsToBounds = NO;
            
            [cellView addSubview:localImageView];
            
            UIButton * buttonLoadImage = [UIButton buttonWithType:UIButtonTypeSystem];
            buttonLoadImage.frame = CGRectMake(0, 0, 40, 40);
            [buttonLoadImage setTitle:@"Загрузить" forState:UIControlStateNormal];
            [buttonLoadImage setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            buttonLoadImage.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:8];
            [localImageView addSubview:buttonLoadImage];
            
        }
    }
    self.mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 10 + customHeight);
//    if (self.mainScrollView.contentSize.height > self.mainScrollView.frame.size.height) {
        self.mainScrollView.contentOffset =
        CGPointMake(0, self.mainScrollView.contentSize.height - self.mainScrollView.frame.size.height);
//    }
}

#pragma mark - Buttons Methods

//Действия кнопки отправить------------------------------
- (void) sendButtonAction
{
    if (textFildText.text.length != 0) {
        NSString * stringMessage = textFildText.text;
        NSLog(@"%@", stringMessage);
        
        NSMutableArray * arrayAddTextChat = [[NSMutableArray alloc] init];
        NSDictionary * dictOneMessage = [NSDictionary dictionaryWithObjectsAndKeys:
                                         /* Тут тоже делаем синглтон с аватаркой пользователя, если синглтон не создан. то показываем предложение в кружке загрузить*/
                                         @"1", @"dialog_id",
                                         @"1", @"from_who",
                                         stringMessage, @"message",
                                         @"2", @"message_type",
                                         @"361", @"messages_id", nil];
        
        [arrayAddTextChat addObject:dictOneMessage];
        [self loadViewWithArray:arrayAddTextChat];
        
        [self getAPIWithPone:[[SingleTone sharedManager] phone] andMessage:stringMessage];
        
        textFildText.text = @"";
        if (textFildText.text.length != 0 && isBool) {
            [UIView animateWithDuration:0.3 animations:^{
                CGRect rect;
                rect = labelPlaceHolder.frame;
                rect.origin.x = rect.origin.x + 100.f;
                labelPlaceHolder.frame = rect;
                labelPlaceHolder.alpha = 0.f;
                isBool = NO;
            }];
        } else if (textFildText.text.length == 0 && !isBool) {
            [UIView animateWithDuration:0.3 animations:^{
                CGRect rect;
                rect = labelPlaceHolder.frame;
                rect.origin.x = rect.origin.x - 100.f;
                labelPlaceHolder.frame = rect;
                labelPlaceHolder.alpha = 1.f;
                isBool = YES;
            }];
        }
    } else {
        NSLog(@"Введите текст");
    }
}

@end
