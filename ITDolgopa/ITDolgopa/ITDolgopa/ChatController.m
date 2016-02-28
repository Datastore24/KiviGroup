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
    NSArray * testArray;

    
}

- (void) viewDidLoad
{
#pragma mark - initialization
    
    isBool = YES;
    customHeight = 0.f;
    
    //Инициализация обновления чата----------------------------
    self.chatCount = 10;
    self.offset = 0;
    self.headerView.alpha=0;
    self.footerView.alpha=0;
    self.isRefresh = YES;
    
    
    //---------------------------------------------------------
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadChat) name:@"ReloadChat" object:nil];

   __block NSMutableArray * superArray = [[NSMutableArray alloc] init];
    
   __block  NSDictionary * testDict = [NSDictionary dictionaryWithObjectsAndKeys:@"332", @"messages_id",
                                                                         @"1", @"message_type",
                                                                         @"Проверка", @"message",
                                                                         @"0", @"is_read",
                                                                         @"1", @"from_who",
                               @"http://ceo.aqaholding.ru/files/avatar/1_1Z8SZlcT9R0_(1).jpg", @"avatar_url", nil];
    [superArray addObject:testDict];

    [self performSelector:@selector(loadViewWithArray:) withObject:superArray afterDelay:10];

    
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
    
    UITextField * textFildText = (UITextField*)[self.view viewWithTag:501];
    textFildText.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFildText:) name:UITextFieldTextDidChangeNotification object:textFildText];
    labelPlaceHolder = (UILabel*)[self.view viewWithTag:502];
    
    [self getAPIWithPhone:[[SingleTone sharedManager] phone]  andWithBlock:^{
        
        self.arrayDialog = [NSArray arrayWithArray:[self.dictResponse objectForKey:@"dialogs"]];
        
        [self loadViewWithArray:self.arrayDialog];
        
//        [NSTimer scheduledTimerWithTimeInterval:5.0f
//                                             target:self selector:@selector(reloadChat) userInfo:nil repeats:YES];
        
        NSLog(@"%@", self.arrayDialog);
    }];
    

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
//            NSLog(@"self.maxCount %lu", (unsigned long)self.maxCount);
//            
//            NSLog(@"%@", self.dictResponse);
            
            if (self.isRefresh) {
                
                [self.headerView stopRefreshing];
                self.mainScrollView.scrollEnabled = YES;
                
            }
            else {
                
                [self.footerView stopRefreshing];
                self.mainScrollView.scrollEnabled = YES;
                
                
            }
//            [self reloadTableViewWhenNewEvent];
            
            
            
        }
        
        block();
        
    }];
}


//Для рефрешера
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    
    
    /*
     Относительно предупреждений, это было связано с тем, что блок является объектом (сущностью в памяти) и такой объект должен быть высвобождени из памяти (потом). Объекты, которые инициализируются внутри блока имеют strong ссылку и эти объекты поставлены в зависимость от жизни объекта ViewController. Таким образом компилятор предупреждает о том, что возможно блок не сможет быть высвобожден из памяти.
     Чтоб это исправить, мы должны указать объектам, которые инициализируются внутри блока, что их жизнь, в данном конкретном случае зависит не от вью контроллера, а от блока.
     Для этого необходимо создать локальную переменную (как приведено ниже), которая будет иметь weak (слабую) ссылку на объект. Теперь блок может быть высвобожден из памяти
     Под эту тему нашел оч хороший класс, который реализует основные задачи с блоками в GCD, а так же прием описанный выше. Я этот класс дополнил возможностью выполнения задачи синхронно, в общем можно пользоваться
     
     */
    
    self.headerView = [[KYPullToCurveVeiw alloc]initWithAssociatedScrollView:self.mainScrollView withNavigationBar:YES];
    BBlockWeakSelf wself = self;
    [self.headerView  addRefreshingBlock:^{
        
        wself.isRefresh = YES;
        wself.mainScrollView.scrollEnabled = NO;
        wself.offset = 0;
        wself.chatCount=10;
        [wself getAPIWithPhone:[[SingleTone sharedManager] phone]  andWithBlock:^{
            
             wself.arrayDialog = [NSArray arrayWithArray:[wself.dictResponse objectForKey:@"dialogs"]];
            
            [wself loadViewWithArray:wself.arrayDialog];
        
        }];
        
    }];
   
    self.headerView = [[KYPullToCurveVeiw alloc]
                       initWithAssociatedScrollView:self.mainScrollView withNavigationBar:YES];
    
    
    
    [self.headerView addRefreshingBlock:^{
        
        if (wself.offset + wself.chatCount < wself.maxCount) {
            wself.isRefresh = NO;
            wself.mainScrollView.scrollEnabled = NO;
            wself.offset = self.offset + self.chatCount;
            [wself getAPIWithPhone:[[SingleTone sharedManager] phone]  andWithBlock:^{
                
                wself.arrayDialog = [NSArray arrayWithArray:[wself.dictResponse objectForKey:@"dialogs"]];
                
                [wself loadViewWithArray:wself.arrayDialog];
          
            }];

        }else{
            
            NSLog(@"end !!!!!!");
            wself.offset=wself.maxCount;
            wself.mainScrollView.scrollEnabled = YES;
            wself.chatCount=wself.maxCount;
            [wself.footerView stopRefreshing];
        }
    }];
   
}
- (void) loadViewWithArray: (NSArray*) array
{
    
    
    NSLog(@"Что то делаю");
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
        UILabel * labelData = [[UILabel alloc] initWithFrame:CGRectMake(customView.frame.origin.x + customView.frame.size.width + 20, customView.frame.origin.y, 50, customView.frame.size.height)];
        labelData.text = @"17.39";
        labelData.textColor = [UIColor whiteColor];
        labelData.font = [UIFont fontWithName:FONTLITE size:12];
        [cellView addSubview:labelData];
        //Фото отправителя-------------------------------------------
        if ([dictArrey objectForKey:@"avatar_url"] != [NSNull null]) {
            
            ViewSectionTable * viewSectionTable = [[ViewSectionTable alloc] initWithImageURL:[dictArrey objectForKey:@"avatar_url"] andView:customView];
            
            [cellView addSubview:viewSectionTable];
        }
        
    }
    self.mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 10 + customHeight);
    if (self.mainScrollView.contentSize.height > self.mainScrollView.frame.size.height) {
        self.mainScrollView.contentOffset =
        CGPointMake(0, self.mainScrollView.contentSize.height - self.mainScrollView.frame.size.height);
    }
}


@end
