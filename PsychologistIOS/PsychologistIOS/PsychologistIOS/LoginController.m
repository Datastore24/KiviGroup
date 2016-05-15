//
//  LoginController.m
//  PsychologistIOS
//
//  Created by Viktor on 31.03.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "LoginController.h"
#import "SWRevealViewController.h"
#import "LoginView.h"
#import "Macros.h"
#import "CategoryController.h"
#import "VKApi.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKCoreKit/FBSDKGraphRequestConnection.h>

#import "Auth.h"
#import "AuthDbClass.h"
#import "SingleTone.h"
#import <AFNetworking/AFNetworking.h>
#import "APIGetClass.h"

@interface LoginController () <UIWebViewDelegate>

@property (strong,nonatomic) NSString * loginString;

@end

@implementation LoginController
{
    UIWebView * authWebView;
    NSDictionary * dictResponse;
    
    BOOL isBool;
    NSDictionary * responsePassword;
    NSDictionary * responseInfo;
    AuthDbClass * authDbClass;
}

- (void) viewDidLoad
{
    
#pragma mark - Auth
    
    authDbClass = [[AuthDbClass alloc] init];
    isBool = NO;
    
    
    
    
    
#pragma mark - Header
    
    self.navigationController.navigationBarHidden = YES;
       
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    //Пареметры кнопки меню------------------------------------
    UIImage *imageBarButton = [UIImage imageNamed:@"menuIcon.png"];
    [_buttonMenu setImage:imageBarButton];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 32, 24);
    CGRect rect = button.frame;
    rect.origin.y += 16;
    button.frame = rect;
    [button setImage:imageBarButton forState:UIControlStateNormal];
    [button addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    _buttonMenu.customView=button;
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
    self.navigationController.navigationBar.hidden = NO; // спрятал navigation bar
    
#pragma mark - Initialization
    //Основной фон-------------------------------------
    LoginView * backgroundView = [[LoginView alloc] initWithBackgroundView:self.view];
    [self.view addSubview:backgroundView];
    
    //Основные графические элементы--------------------
    LoginView * mainContentView = [[LoginView alloc] initWithContentView:self.view];
    [self.view addSubview:mainContentView];
    
    LoginView * buttonLigin = [[LoginView alloc] initButtonLogin];
    [mainContentView addSubview:buttonLigin];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushWithMainView) name:NOTIFICATION_LOGIN_VIEW_PUSH_MAIN_VIEW object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getSmsCode:) name:NOTIFICATION_SEND_SMS_CODE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationVKAvto) name:@"VKN" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationFaceAvto) name:@"FaceBookN" object:nil];
    
#pragma mark - CheckAuth
    //Проверка при запуске приложеия
    if([authDbClass showAllUsers].count>0){
        Auth * userInfo = [[authDbClass showAllUsers] objectAtIndex:0];
        //        NSLog(@"userInfo.salt: %@",userInfo.salt);
        
        //Проверка CoreData на существование password, token FB, token VK
        if(userInfo.password.length != 0 || userInfo.token_fb.length != 0 || userInfo.token_vk.length != 0){
            [self performSelector:@selector(checkAuth) withObject:nil afterDelay:1.8f]; //Запуск проверки с паузой
        }else{
            [self showLoginWith:NO];
        }
    }else{
        [self showLoginWith:NO];
    }

}

//Показ проверки и анимация появления авторизации
-(void)showLoginWith:(BOOL) animation{
    if(animation){
        //Повяление с анимацией
        [UIView animateWithDuration:2.0 animations:^{
//            textFieldPhone.alpha=1;
//            buttonGetCode.alpha=1;
//            viewLoginPhone.alpha=1;
//            labelPlaceHolderPhone.alpha=1;
//            viewRegistration.alpha=1;
//            checkView.alpha=0;
        }];
        
    }else{
       // Без анимации
    }
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - action Methods

- (void) getSmsCode: (NSNotification*) notification
{
    NSLog(@"NOTIF %@",notification.object);
    
    self.loginString = notification.object;
    NSLog(@"%@",self.loginString);
    [self getPassword:notification.object];
    
    
}

- (void) pushWithMainView
{
    
    
    UITextField * textFildSMS = (UITextField*)[self.view viewWithTag:120];
    NSLog(@"PASSWORD %@",textFildSMS.text);
    
    if (textFildSMS.text.length < 5) {
        NSLog(@"%lu", textFildSMS.text.length);
    } else {
        
        [self getInfo:self.loginString andPassword:textFildSMS.text andDeviceToken:[[SingleTone sharedManager] token_ios] andBlock:^{
            NSLog(@"INFO: %@",responseInfo);
            
            if ([[responseInfo objectForKey:@"error"]integerValue]==0) {
                
                NSDictionary * respData = [responseInfo objectForKey:@"data"];
                [authDbClass updateUser:[respData objectForKey:@"login"] andPassword:[respData objectForKey:@"password"] andIdUser:[respData objectForKey:@"id"] andTokenVk:[respData objectForKey:@"vk_token"] andTokenFb:[respData objectForKey:@"fb_token"]  andTypeAuth:[respData objectForKey:@"pass"] ];
                CategoryController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"CategoryController"];
                
                
                
                [[SingleTone sharedManager]setLogin:[respData objectForKey:@"login"]];
                
                [self.navigationController pushViewController:detail animated:YES];
            } else if ([[responseInfo objectForKey:@"error"]integerValue]==1) {
                
                NSLog(@"ERROR:%@",[responseInfo objectForKey:@"error_msg"]);
                
            }
        }];
        
        

        
   
}
    
}

- (void) notificationFaceAvto
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else {
             NSLog(@"Logged in");
             
             NSString * string = result.token.appID;
             NSString * strng2 = result.token.tokenString;
             NSLog(@"%@", string);
             NSLog(@"%@", strng2);
           //-------------
             
             
             [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me"
                                                parameters:@{@"fields": @"name, first_name, last_name, email"}]
              startWithCompletionHandler:^(FBSDKGraphRequestConnection * connection, id result, NSError * error) {
                  if (!error) {
                      
                      NSLog(@"result %@", result);
                      
                      
                  }
                  else{
                      NSLog(@"%@", [error localizedDescription]);
                  }
              }];


             
          //-----------
             
         }
     }];
}

- (void) notificationVKAvto
{
    //создаем webView
    authWebView = [[UIWebView alloc] initWithFrame:self.view.frame];
    authWebView.tag = 1024;
    authWebView.delegate = self;
    UIButton* closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.view addSubview:authWebView];
    [authWebView loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://oauth.vk.com/authorize?client_id=5461383&scope=wall,offline&redirect_uri=oauth.vk.com/blank.html&display=touch&response_type=token"]]];
    //обеспечиваем появление клавиатуры для авторизации
    [self.view.window makeKeyAndVisible];
    //создаем кнопочку для закрытия окна авторизации
    closeButton.frame = CGRectMake(5, 15, 20, 20);
    closeButton.tag = 1025;
    [closeButton addTarget:self action:@selector(closeWebView) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setTitle:@"x" forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:closeButton];
}

-(void) closeWebView {
    [[self.view viewWithTag:1024] removeFromSuperview];
    [[self.view viewWithTag:1025] removeFromSuperview];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {
    //создадим хеш-таблицу для хранения данных
    NSMutableDictionary* user = [[NSMutableDictionary alloc] init];
    //смотрим на адрес открытой станицы
    NSString *currentURL = webView.request.URL.absoluteString;
    NSRange textRange =[[currentURL lowercaseString] rangeOfString:[@"access_token" lowercaseString]];
    //смотрим, содержится ли в адресе информация о токене
    if(textRange.location != NSNotFound){
        //Ура, содержится, вытягиваем ее
        NSArray* data = [currentURL componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"=&"]];
        [user setObject:[data objectAtIndex:1] forKey:@"access_token"];
        [user setObject:[data objectAtIndex:3] forKey:@"expires_in"];
        [user setObject:[data objectAtIndex:5] forKey:@"user_id"];
        
        //Получаем нужные строки
        NSString * access_token = [user objectForKey:@"access_token"];
        NSString * user_id = [user objectForKey:@"user_id"];
        //Передаем данные в АПИ
        [self getApiWithUserID:user_id andUserToken:access_token andBlock:^{
            NSLog(@"%@", dictResponse);
        }];
        
        
        [self postVKAPIWithMessage:@"Тест отправки картинки" andUserID:user_id andUserToken:access_token andURLString:@"https://pp.vk.me/c543100/v543100002/146be/LKVNy4LdX9k.jpg"];
        
        
        [self closeWebView];
        //передаем всю информацию специально обученному классу
        //[[VkontakteDelegate sharedInstance] loginWithParams:user];
//        [[VkontakteDelegate sharedInstance] postToWall];
    }
    else {
        //Ну иначе сообщаем об ошибке...
        textRange =[[currentURL lowercaseString] rangeOfString:[@"access_denied" lowercaseString]];
        if (textRange.location != NSNotFound) {
            NSLog(@"Check your internet connection and try again!");
            [self closeWebView];
        }
    }
}

#pragma mark - VK API
//Зпрос данных
- (void) getApiWithUserID: (NSString*) userIdD andUserToken: (NSString*) userToken andBlock: (void (^)(void))block
{
    NSDictionary * dictParams = [NSDictionary dictionaryWithObjectsAndKeys:userIdD, @"user_id",
                                 userToken, @"access_token", nil];
    VKApi * vkApi = [VKApi new];
    [vkApi getUserWithParams:dictParams complitionBlock:^(id response) {
        dictResponse = (NSDictionary*) response;
        
        if ([[dictResponse objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"%@", [dictResponse objectForKey:@"error_msg"]);
            //ТУТ UILabel когда нет фоток там API выдает
        } else if ([[dictResponse objectForKey:@"error"] integerValue] == 0) {
            block();
        }
    }];
}

//Вывод сообщения не стену------------
- (void) postVKAPIWithMessage: (NSString*) message
                    andUserID: (NSString*) userIdD
                 andUserToken: (NSString*) userToken
                 andURLString: (NSString*) urlString
{
    NSDictionary * dictParams = [NSDictionary dictionaryWithObjectsAndKeys:userIdD, @"user_id",
                                 userToken, @"access_token", urlString, @"attachments", nil];
    VKApi * vkAPI = [VKApi new];
    [vkAPI postWallWithParams:dictParams message:message andLinkAttach:nil complitionBlock:^(id response) {
        if ([[response objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"%@", [response objectForKey:@"error_msg"]);
            //ТУТ UILabel когда нет фоток там API выдает
        } else if ([[response objectForKey:@"error"] integerValue] == 0) {
            
            NSLog(@"Все хорошо");

        }
    }];
}

#pragma mark - API

-(void) getPassword:(NSString *) phone
{
    
    NSString * phoneResult = [phone stringByReplacingOccurrencesOfString: @"+" withString: @""];
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             phoneResult,@"phone",
                             nil];
    
    
    
    APIGetClass * getAPI = [[APIGetClass alloc] init];
    [getAPI getDataFromServerWithParams:params method:@"get_password" complitionBlock:^(id response) {
        //        NSLog(@"%@", response);
        
        responsePassword = (NSDictionary*)response;
        NSLog(@"resp: %@",responsePassword);
        NSLog(@"error_msg: %@",[responsePassword objectForKey:@"error_msg"]);
        
    }];
}

-(void) getInfo:(NSString *) login andPassword:(NSString*) password andDeviceToken: (NSString*) token_ios
       andBlock:(void (^)(void))block
{
    
    NSString * loginResult = [login stringByReplacingOccurrencesOfString: @"+" withString: @""];
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             loginResult,@"login",
                             password,@"password",
                             token_ios,@"token",
                             nil];
  
    APIGetClass * getAPI = [[APIGetClass alloc] init];
    [getAPI getDataFromServerWithParams:params method:@"show_user_token" complitionBlock:^(id response) {
               NSLog(@"%@", response);
        
        responseInfo = (NSDictionary*)response;
        block();
        
    }];
}


@end
