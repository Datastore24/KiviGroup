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
#import "ParseDate.h"
#import "AlertClass.h"
#import "TextMethodClass.h"
#import <SCLAlertView-Objective-C/SCLAlertView.h>
#import <AFNetworking/AFNetworking.h>
#import "NetworkRechabilityMonitor.h"


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
    NSString * messageType;
    NSString * dateStringText;
    ChatCellView * cellView;
    UIView * customView;
    UILabel * dateTopLabel;
    UIView * dateOfViewMain;
    NSString * dateTextNow;
    UIButton * pushButton;
    
    
    NSMutableArray * arrayButtonsPush; //Массив кнопок
    NSMutableArray * arrayMessagePush; //Массив отправленных сообщений
    NSInteger pushTag;
    
    
    CGFloat testFloat;

    

    
}

- (void) viewDidLoad
{
#pragma mark - initialization
    
    //проверка интернет соединения --------------------------
    self.isNoInternet = 0;
    [NetworkRechabilityMonitor startNetworkReachabilityMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %ld", (long)status);
        if(status == 0){
            [NetworkRechabilityMonitor showNoInternet:self.view andShow:YES];
            self.isNoInternet = 1;
            NSLog(@"НЕТ ИНТЕРНЕТА");
        }else{
            if(self.isNoInternet == 1){
                [self loadMoreDialog];
            }
            NSLog(@"ЕСТЬ ИНТЕРНЕТ");
            [NetworkRechabilityMonitor showNoInternet:self.view andShow:NO];
        }
    }];
    //
    
    isBool = YES;
    customHeight = 0.f;
    
    //Инициализация обновления чата----------------------------
    self.chatCount = 100;
    self.offset = 0;
    
    self.arrayDate = [NSMutableArray array];
    arrayButtonsPush = [[NSMutableArray alloc] init];
    arrayMessagePush = [[NSMutableArray alloc] init];
    pushTag = 0;

    
    
    //---------------------------------------------------------
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadMoreDialog) name:@"ReloadChat" object:nil];
    
    
    //Скрытие клавиатуры тапом----------------------------------
    UITapGestureRecognizer * tapOnBackground = [[UITapGestureRecognizer alloc]
                                                initWithTarget:self action:@selector(tapOnBackgroundAction)];
    [self.view addGestureRecognizer:tapOnBackground];


    
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
    self.view.backgroundColor = [UIColor colorWithHexString:MAINBACKGROUNDCOLOR];
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
        
        [self loadViewWithArray:self.arrayDialog andUpdate:YES andLoad:NO andPush:NO];
        
     //   Временнй метод для симулятор, котоорый эмулирует нотификацию он новом сообщении
        [NSTimer scheduledTimerWithTimeInterval:7.0f
                                             target:self selector:@selector(loadMoreDialog) userInfo:nil repeats:YES];
        

        
    }];
    
    //Инициализаци кнопки отправить------------------------------------------------------------
    UIButton * sendButton = (UIButton*)[self.view viewWithTag:510];
    [sendButton addTarget:self action:@selector(sendButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    NSLog(@"ARRDATE %@",self.arrayDate);

    
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


//Метод подтверждения прочтения сообщения----------------------------------
- (void) getAPIConfermMessageWithPhone: (NSString*) phone
{
    NSDictionary * dictParams = [NSDictionary dictionaryWithObjectsAndKeys:phone, @"phone", nil];
    
    APIGetClass * apiConfermMessage = [APIGetClass new];
    [apiConfermMessage getDataFromServerWithParams:dictParams method:@"dialog_is_read" complitionBlock:^(id response) {
        
        NSDictionary * responseConfermMessage = (NSDictionary*) response;
        if ([[responseConfermMessage objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"%@", [responseConfermMessage objectForKey:@"error_msg"]);
        } else if ([[responseConfermMessage objectForKey:@"error"] integerValue] == 0) {
            NSLog(@"%@", responseConfermMessage);
            
            NSString * stringBadge = [NSString stringWithFormat:@"%ld", [[responseConfermMessage objectForKey:@"badge"] integerValue]];
            
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICATIONPUSHBADGEONAPPDELEGATE" object:stringBadge];
            
            
        }
    }];
}

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
            
            [pushButton setTitle:@"Не отправленно" forState:UIControlStateNormal];
            [pushButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            
        } else if ([[responseMessage objectForKey:@"error"] integerValue] == 0) {
            NSLog(@"Сообщение доставленно");
            NSLog(@"%@", responseMessage);
            
            [pushButton setTitle:@"Отправленно" forState:UIControlStateNormal];
            [pushButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            
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
             NSLog(@"%@", response);
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
            
            self.maxCount = [[self.dictResponse objectForKey:@"dialogs_count"] integerValue];
            self.dialogMaxID = [self.dictResponse objectForKey:@"max_id"];
        }
        block();
    }];
}

-(void) loadMoreDialog{
    [self getAPIMoreWithPhone:[[SingleTone sharedManager] phone] andMaxID:self.dialogMaxID andWithBlock:^{
        
        self.arrayDialog = [NSArray arrayWithArray:[self.dictResponse objectForKey:@"dialogs"]];
        
        [self loadViewWithArray:self.arrayDialog andUpdate:YES andLoad:YES andPush:NO];
        
//        NSLog(@"%lu", (unsigned long)self.maxCount);
//        NSLog(@"%@", self.arrayDialog);
    }];
    
    [self getAPIConfermMessageWithPhone:[[SingleTone sharedManager] phone]];
}

//Локальная загрузка сообщения-----------------------------------
- (void) loadViewWithArray: (NSArray*) array andUpdate: (BOOL) update andLoad: (BOOL) load andPush: (BOOL) push
{
    //Инициализация ячеек чата------------------------------------
    for (int i = 0; i < array.count; i++) {
        
        NSDictionary * dictArrey = [array objectAtIndex:i];
        NSString * readyMessage = [TextMethodClass stringByStrippingHTML:[dictArrey objectForKey:@"message"]];
        
        //Лейбл даты-------------------------------------------------
        
        NSString * stringDateAll = [dictArrey objectForKey:@"created"];
        NSArray * stringDateAllArray = [stringDateAll componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSString * stringDate = [stringDateAllArray objectAtIndex:0];
        NSString * stringTime = [stringDateAllArray objectAtIndex:1];
        
        testLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.mainScrollView.frame.size.width - 200, 40)];
        testLabel.numberOfLines = 0;
        testLabel.backgroundColor = [UIColor clearColor];
        testLabel.text = readyMessage;
        testLabel.textColor = [UIColor whiteColor];
        testLabel.font = [UIFont fontWithName:FONTLITE size:12];
        [testLabel sizeToFit];

        //Проверка на повторение пользователя------------------------------------------
        if ([messageType isEqualToString: [dictArrey objectForKey:@"message_type"]]) {
            cellView = [[ChatCellView alloc] initWhithFirstView:self.view andDate:nil andImagePhoto:nil andFrame:CGRectMake(0, customHeight + 10, self.view.frame.size.width, testLabel.frame.size.height + 40)];

            [self.mainScrollView addSubview:cellView];
            customHeight = customHeight + (testLabel.frame.size.height + 40);
            
            if (![dateTextNow isEqualToString:stringDate]) {
                
                
                cellView.frame = CGRectMake(0, customHeight + 20, self.view.frame.size.width, testLabel.frame.size.height + 50);
                customHeight = customHeight + (testLabel.frame.size.height + 50);
                
                
                UILabel * labelDate = [[UILabel alloc] initWithFrame:CGRectMake(0, - 50, self.view.frame.size.width, 20)];
                
                
                ParseDate * parseDate =[[ParseDate alloc] init];
                if([stringDate isEqual:[parseDate dateFormatToDay]]){
                    labelDate.text = @"Cегодня";
                }else if([stringDate isEqual:[parseDate dateFormatToYesterDay]]){
                    labelDate.text = @"Вчера";
                }else if([stringDate isEqual:[parseDate dateFormatToDayBeforeYesterday]]){
                    labelDate.text = @"Позавчера";
                }else{
                    labelDate.text = stringDate;
                }
                
                
                labelDate.textColor = [UIColor whiteColor];
                labelDate.textAlignment = NSTextAlignmentCenter;
                [cellView addSubview:labelDate];
                
                
                
            }
            
            
            
        } else {
            cellView = [[ChatCellView alloc] initWhithFirstView:self.view andDate:nil andImagePhoto:nil andFrame:CGRectMake(0, customHeight + 40, self.view.frame.size.width, testLabel.frame.size.height + 70)];
            customHeight = customHeight + (testLabel.frame.size.height + 70);
            
            
            NSLog(@"dateTextNow %@", dateTextNow);
            NSLog(@"stringDate %@", stringDate);
            NSLog(@"* * * * * * * * * * * * * * * ");
            
            
            if (![dateTextNow isEqualToString:stringDate]) {
                
                
                cellView.frame = CGRectMake(0, customHeight + 20, self.view.frame.size.width, testLabel.frame.size.height + 50);
                customHeight = customHeight + (testLabel.frame.size.height + 50);
                
                
                UILabel * labelDate = [[UILabel alloc] initWithFrame:CGRectMake(0, - 70, self.view.frame.size.width, 20)];
                
              
                ParseDate * parseDate =[[ParseDate alloc] init];
                if([stringDate isEqual:[parseDate dateFormatToDay]]){
                    labelDate.text = @"Cегодня";
                }else if([stringDate isEqual:[parseDate dateFormatToYesterDay]]){
                    labelDate.text = @"Вчера";
                }else if([stringDate isEqual:[parseDate dateFormatToDayBeforeYesterday]]){
                    labelDate.text = @"Позавчера";
                }else{
                    labelDate.text = stringDate;
                }
            
                
                labelDate.textColor = [UIColor whiteColor];
                labelDate.textAlignment = NSTextAlignmentCenter;
                [cellView addSubview:labelDate];
                
                
                
            }

            [self.mainScrollView addSubview:cellView];
            UILabel * labelFIO = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 195 / 2, - 25, 220, 20)];
            labelFIO.text = [dictArrey objectForKey:@"fio"];
            labelFIO.textColor = [UIColor whiteColor];
            labelFIO.font = [UIFont fontWithName:FONTREGULAR size:14];
            [cellView addSubview:labelFIO];
            
        }
        
        //Вью лейбла-------------------------------------------------
        customView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 195 / 2, 0, 195, testLabel.frame.size.height + 20)];
        
        customView.backgroundColor = [UIColor colorWithHexString:@"818181"];
        customView.layer.cornerRadius = 10.f;
        [cellView addSubview:customView];
        [customView addSubview:testLabel];


        //Лейбл Времени----------------------------------------------
        UILabel * labelData = [[UILabel alloc] initWithFrame:CGRectMake(customView.frame.origin.x + customView.frame.size.width + 10, customView.frame.origin.y, 40, customView.frame.size.height)];
        labelData.text = stringTime;
        labelData.textColor = [UIColor whiteColor];
        labelData.font = [UIFont fontWithName:FONTLITE size:12];
        [cellView addSubview:labelData];
        
        //Проверка на повторение даты-------------------------------------------------
        
        ParseDate * parseDate =[[ParseDate alloc] init];
        if([stringDate isEqual:[parseDate dateFormatToDay]]){
            
        }
            UILabel * dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelData.frame.origin.x + labelData.frame.size.width + 5, customView.frame.origin.y, 30, customView.frame.size.height)];
            dateLabel.text = stringDate;
            dateLabel.textColor = [UIColor clearColor];
            dateLabel.font = [UIFont fontWithName:FONTREGULAR size:12];
            [cellView addSubview:dateLabel];
            
            UIWindow *window = [[UIApplication sharedApplication] keyWindow];
            CGPoint convertedPoint = [cellView convertPoint:dateLabel.frame.origin
                                                     toView:window];
            NSString * datePositionY = [NSString stringWithFormat:@"%f",convertedPoint.y];
            NSString * datePositionX = [NSString stringWithFormat:@"%f",convertedPoint.x];
            NSDictionary * dictDatePostion = [[NSDictionary alloc] initWithObjectsAndKeys:
                                                dateLabel.text,@"text",
                                              datePositionX,@"positionX",
                                              datePositionY,@"positionY",nil];
            
            [self.arrayDate addObject:dictDatePostion];

        dateStringText = stringDate;
        if(update){
        dateOfViewMain = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
        dateOfViewMain.backgroundColor = [UIColor colorWithHue:0.7 saturation:0.3 brightness:0.4 alpha:0.4];
        dateOfViewMain.alpha = 0.1;
        [self.view addSubview:dateOfViewMain];
        
        dateTopLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
        dateTopLabel.center = dateOfViewMain.center;
        dateTopLabel.text = @"";
        dateTopLabel.textColor = [UIColor whiteColor];
        dateTopLabel.textAlignment = NSTextAlignmentCenter;
        dateTopLabel.backgroundColor = [UIColor clearColor];
        dateTopLabel.alpha = 1;
        [self.view addSubview:dateTopLabel];
        }
        
        //Сообщение о доставке сообщения---------------------------

        if ([[[SingleTone sharedManager] stringFIO] isEqualToString:[dictArrey objectForKey:@"fio"]] && push) {
            
            pushButton = [UIButton buttonWithType:UIButtonTypeSystem];
            pushButton.tag = pushTag;
            pushButton.frame = CGRectMake(180, cellView.frame.size.height - 20, 100, 20);
            if (![messageType isEqualToString: [dictArrey objectForKey:@"message_type"]])
            {
                pushButton.frame = CGRectMake(180, cellView.frame.size.height - 50, 100, 20);
                if (![dateTextNow isEqualToString:stringDate]) {
                    pushButton.frame = CGRectMake(180, cellView.frame.size.height - 30, 100, 20);
                }
            }
            [pushButton setTitle:@"" forState:UIControlStateNormal];
            [pushButton setTintColor:[UIColor whiteColor]];
            pushButton.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:12];
            [pushButton addTarget:self action:@selector(pushButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [arrayButtonsPush addObject:pushButton];
            pushTag += 1;
            [cellView addSubview:pushButton];
            
            NSString * stringMessagePush = [dictArrey objectForKey:@"message"];
            [arrayMessagePush addObject:stringMessagePush];
        }

        //Фото отправителя-------------------------------------------
        if ([dictArrey objectForKey:@"avatar_url"]) {
            ViewSectionTable * viewSectionTable = [[ViewSectionTable alloc] initWithImageURL:[dictArrey objectForKey:@"avatar_url"] andView:customView];
            if ([messageType isEqualToString: [dictArrey objectForKey:@"message_type"]]) {
                viewSectionTable.alpha = 0;
            }
            [cellView addSubview:viewSectionTable];
        }else{
            
            localImageView = [[UIImageView alloc] initWithFrame:CGRectMake (customView.frame.origin.x - 45, customView.frame.origin.y - 5, 40, 40)];
            localImageView.backgroundColor = [UIColor whiteColor];
            localImageView.layer.cornerRadius = 20.0;
            localImageView.clipsToBounds = NO;
            if ([messageType isEqualToString: [dictArrey objectForKey:@"message_type"]]) {
                localImageView.alpha = 0;
            }
            [cellView addSubview:localImageView];
            
            UIButton * buttonLoadImage = [UIButton buttonWithType:UIButtonTypeSystem];
            buttonLoadImage.frame = CGRectMake(0, 0, 40, 40);
            [buttonLoadImage setTitle:@"Загрузить" forState:UIControlStateNormal];
            [buttonLoadImage setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            buttonLoadImage.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:8];
            
            [localImageView addSubview:buttonLoadImage];
  
        }
        dateTextNow = stringDate;
        messageType = [dictArrey objectForKey:@"message_type"];
    }

    
    self.mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 20 + customHeight);
//    if (self.mainScrollView.contentSize.height > self.mainScrollView.frame.size.height) {
    

    NSLog(@"testFloat %f", testFloat);
    NSLog(@"mainScrollView %f", self.mainScrollView.contentOffset.y);
    
    

    
    if (!load || testFloat == self.mainScrollView.contentOffset.y) {
        self.mainScrollView.contentOffset =
        CGPointMake(0, self.mainScrollView.contentSize.height - self.mainScrollView.frame.size.height);
        
        testFloat = self.mainScrollView.contentSize.height - self.mainScrollView.frame.size.height;
    }

    

//    }
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    for (NSInteger i=self.arrayDate.count-1; i>=0; i--) {
        NSDictionary * datePostionInfoFirst = [self.arrayDate objectAtIndex:i];
        
        
        
        CGRect thePosition =  CGRectMake([[datePostionInfoFirst objectForKey:@"positionX"] floatValue],[[datePostionInfoFirst objectForKey:@"positionY"] floatValue], 100, 40);
        
//        NSLog(@"%f",scrollView.contentOffset.y);
//        if(scrollView.contentOffset.y == 0.0f){
//            NSLog(@"НАЧАЛО");
//            scrollView.scrollEnabled = NO;
//        }
//        

        CGRect container = CGRectMake(scrollView.contentOffset.x, scrollView.contentOffset.y, scrollView.frame.size.width, scrollView.frame.size.height);
        if(CGRectIntersectsRect(thePosition, container))
        {
            // This view has been scrolled on screen
            //Изменения даты
            ParseDate * parseDate =[[ParseDate alloc] init];
            if([[datePostionInfoFirst objectForKey:@"text"] isEqual:[parseDate dateFormatToDay]]){
                dateTopLabel.text = @"Cегодня";
            }else if([[datePostionInfoFirst objectForKey:@"text"] isEqual:[parseDate dateFormatToYesterDay]]){
                dateTopLabel.text = @"Вчера";
            }else if([[datePostionInfoFirst objectForKey:@"text"] isEqual:[parseDate dateFormatToDayBeforeYesterday]]){
                dateTopLabel.text = @"Позавчера";
            }else{
                dateTopLabel.text = [datePostionInfoFirst objectForKey:@"text"];
            }
        }  
    }
    
//    NSLog(@"mainScrollView %f", self.mainScrollView.contentOffset.y);
    
}



#pragma mark - Buttons Methods

//Действия кнопки отправить------------------------------
- (void) sendButtonAction
{
    
    if (textFildText.text.length != 0) {
        NSString * stringMessage = textFildText.text;
        NSMutableArray * arrayAddTextChat = [[NSMutableArray alloc] init];
        
      

        
        //Создание даты-----------------------------------
        NSDate * date = [NSDate date];
        NSDateFormatter * inFormatDate = [[NSDateFormatter alloc] init];
        [inFormatDate setDateFormat:@"dd.MM.YYYY HH.mm"];
        NSString *strDate = [inFormatDate stringFromDate:date];

        NSDictionary * dictOneMessage = [NSDictionary dictionaryWithObjectsAndKeys:
                                         @"1", @"dialog_id",
                                         @"1", @"from_who",
                                         stringMessage, @"message",
                                         @"2", @"message_type",
                                         @"361", @"messages_id",
                                         strDate, @"created",
                                         [[SingleTone sharedManager] stringFIO], @"fio", nil];
        
        [arrayAddTextChat addObject:dictOneMessage];
        [self loadViewWithArray:arrayAddTextChat andUpdate:NO andLoad:NO andPush:YES];
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
        [AlertClass showAlertViewWithMessage:@"Введите сообщение" view:self];
    }
}

//Действие кнопки отправить заного--------------------------------------------
- (void) pushButtonAction: (UIButton*) button
{
    for (int i = 0; i < arrayButtonsPush.count; i++) {
        if (button.tag == i) {
          [self getAPIWithPone:[[SingleTone sharedManager] phone] andMessage:[arrayMessagePush objectAtIndex:i]];
        }
    }
 
}

//Действие тапа на скрытие клавиатуры------------------------------------------
- (void) tapOnBackgroundAction
{
        [textFildText resignFirstResponder];
}

@end
