//
//  FormalizationController.m
//  Sadovod
//
//  Created by Виктор Мишустин on 05/09/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "FormalizationController.h"
#import "FormalizationView.h"
#import "PopAnimator.h"
#import "PushAnimator.h"
#import "APIGetClass.h"
#import "SingleTone.h"
#import "UserInfoDbClass.h"
#import "UserInfo.h"

@interface FormalizationController() <UINavigationControllerDelegate,FormalizationViewDelegate>
@property (strong, nonatomic) NSDictionary * dictInfo;
@property (strong, nonatomic) UserInfo * userInfo;
@end

@implementation FormalizationController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.delegate = self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    UserInfoDbClass * userInfoDbclass = [[UserInfoDbClass alloc] init];
    NSArray * userArray = [userInfoDbclass showAllUsersInfo];
    
    NSLog(@"COUNT %lu",(unsigned long)userArray.count);
    if(userArray.count>0){
        self.userInfo = (UserInfo *)[userArray objectAtIndex:0];
        NSLog(@"TYPE %@",self.userInfo.us_type);
    }else{
        self.userInfo = nil;
        NSLog(@"USERINFO EMPTY");
    }
    
    [self setCustomTitle:@"Оформление заказа" andBarButtonAlpha: YES andButtonBasket: YES]; //Ввод заголовка
    
    //Кнопка Назад---------------------------------------------
    UIButton * buttonBack = [UIButton createButtonBack];
    [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = mailbuttonBack;
    
#pragma mark - View
    [self getApiInfoOrder:^{
        FormalizationView * mainView = [[FormalizationView alloc] initWithView:self.view andData:self.dictInfo];
        [self.view addSubview:mainView];
        mainView.delegate = self;
    }];
    
    
}

#pragma mark - Actions

- (void) buttonBackAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSArray*) setCustonArray
{
    NSArray * arrayCompany = [NSArray arrayWithObjects:@"Байкал-Сервис", @"ПЭК", @"Деловые линии", @"ЖелДорЭкспедиция", @"КИТ", @"Энергия", nil];
    return arrayCompany;
}

#pragma mark - ANIMATION POP PUSH
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController*)fromVC
                                                 toViewController:(UIViewController*)toVC
{
    if (operation == UINavigationControllerOperationPush)
        return [[PushAnimator alloc] init];
    
    if (operation == UINavigationControllerOperationPop)
        return [[PopAnimator alloc] init];
    
    return nil;
}

#pragma mark - API
-(void) getApiInfoOrder: (void (^)(void))block
{
    APIGetClass * api =[APIGetClass new]; //создаем API
    
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             
                             [[SingleTone sharedManager] catalogKey], @"key",
                             @"ios_sadovod",@"appname",
                             nil];
    
    [api getDataFromServerWithParams:params method:@"get_info_order" complitionBlock:^(id response) {
        
        if([response isKindOfClass:[NSDictionary class]]){
            
            NSDictionary * respDict = (NSDictionary *) response;
            NSLog(@"RESP NEW %@",respDict);
            self.dictInfo = respDict;
            [self checkCoreDateAndServer:respDict andBlock:^{
                block();
            }];
            
            
            
            
        }
        
    }];
    
}

#pragma mark - DELEGATE



-(void) getApiCreateOrder:(FormalizationView*) catalogDetailView 
{
    APIGetClass * api =[APIGetClass new]; //создаем API
    
    self.userInfo.email.length == 0 ? self.userInfo.email = @"" : nil;
    self.userInfo.phone.length == 0 ? self.userInfo.phone=@"" : nil;
    self.userInfo.ord_name.length == 0 ? self.userInfo.ord_name=@"" : nil;
    self.userInfo.us_fam.length == 0 ? self.userInfo.us_fam=@"" : nil;
    self.userInfo.us_otch.length == 0 ? self.userInfo.us_otch=@"" : nil;
    self.userInfo.us_type.length == 0 ? self.userInfo.us_type=@"" : nil;
    self.userInfo.inn.length == 0 ? self.userInfo.inn=@"" : nil;
    self.userInfo.kpp.length == 0 ? self.userInfo.kpp=@"" : nil;
    self.userInfo.like_delivery.length == 0 ? self.userInfo.like_delivery=@"" : nil;
    self.userInfo.like_tk.length == 0 ? self.userInfo.like_tk=@"" : nil;
    self.userInfo.like_pay.length == 0 ? self.userInfo.like_pay=@"" : nil;
    self.userInfo.doc_date.length == 0 ? self.userInfo.doc_date=@"" : nil;
    self.userInfo.doc_vend.length == 0 ? self.userInfo.doc_vend=@"" : nil;
    self.userInfo.doc_num.length == 0 ? self.userInfo.doc_num=@"" : nil;
    self.userInfo.org_name.length == 0 ? self.userInfo.org_name=@"" : nil;
    self.userInfo.addr_index.length == 0 ? self.userInfo.addr_index=@"" : nil;
    self.userInfo.contact.length == 0 ? self.userInfo.contact=@"" : nil;
    self.userInfo.address.length == 0 ? self.userInfo.address=@"" : nil;
    self.userInfo.deli_start.length == 0 ? self.userInfo.deli_start=@"" : nil;
    self.userInfo.deli_end.length == 0 ? self.userInfo.deli_end=@"" : nil;
    self.userInfo.transport.length == 0 ? self.userInfo.transport=@"" : nil;
    self.userInfo.comment.length == 0 ? self.userInfo.comment=@"" : nil;

    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             self.userInfo.us_type,@"user_type",
                             self.userInfo.ord_name,@"name",
                             self.userInfo.phone,@"phone",
                             self.userInfo.email,@"email",
                             self.userInfo.address,@"address",
                             self.userInfo.like_delivery,@"delivery_type",
                             self.userInfo.deli_start,@"delivery_begin",
                             self.userInfo.deli_end,@"delivery_end",
                             self.userInfo.us_fam,@"user_family,",
                             self.userInfo.us_otch,@"user_otch",
                             self.userInfo.addr_index,@"index",
                             self.userInfo.doc_num,@"passport_serial",
                             self.userInfo.doc_date,@"passport_date",
                             self.userInfo.doc_vend,@"passport_why",
                             self.userInfo.transport,@"transport_id",
                             self.userInfo.org_name,@"org_name",
                             self.userInfo.inn,@"org_inn",
                             self.userInfo.kpp,@"org_kpp",
                             self.userInfo.contact,@"contact_name",
                             self.userInfo.like_pay,@"pay_type",
                             self.userInfo.comment, @"comment",
                             [[SingleTone sharedManager] catalogKey], @"key",
                             @"ios_sadovod",@"package",
                             nil];
    
    
       NSLog(@"ОТПРАВЛЯЕМ %@",params);
    [api getDataFromServerWithParams:params method:@"send_order" complitionBlock:^(id response) {
        
        if([response isKindOfClass:[NSDictionary class]]){
            
            NSDictionary * respDict = (NSDictionary *) response;
            NSLog(@"RESP NEW %@",respDict);
            
            
            
            
            
        }
        
    }];
    
}

#pragma mark - CheckCoreDate

-(void) checkCoreDateAndServer:(NSDictionary *) dict andBlock: (void (^)(void))block{
    NSDictionary * dictInfo = [dict objectForKey:@"info"];
    NSString * email = [dictInfo objectForKey:@"email"];
    NSString * phone = [dictInfo objectForKey:@"phone"];
    NSString * ord_name = [dictInfo objectForKey:@"ord_name"];
    NSString * us_fam = [dictInfo objectForKey:@"us_fam"];
    NSString * us_otch = [dictInfo objectForKey:@"us_otch"];
    NSString * us_type = [dictInfo objectForKey:@"us_type"];
    NSString * inn = [dictInfo objectForKey:@"inn"];
    NSString * kpp = [dictInfo objectForKey:@"kpp"];
    NSString * like_delivery = [dictInfo objectForKey:@"like_delivery"];
    NSString * like_tk = [dictInfo objectForKey:@"like_tk"];
    NSString * like_pay = [dictInfo objectForKey:@"like_pay"];
    NSString * doc_date = [dictInfo objectForKey:@"doc_date"];
    NSString * doc_vend = [dictInfo objectForKey:@"doc_vend"];
    NSString * doc_num = [dictInfo objectForKey:@"doc_num"];
    NSString * org_name = [dictInfo objectForKey:@"org_name"];
    NSString * addr_index = [dictInfo objectForKey:@"addr_index"];
    NSString * contact = [dictInfo objectForKey:@"contact"];
    NSString * address = [dictInfo objectForKey:@"address"];
    NSString * deli_start = [dictInfo objectForKey:@"deli_start"];
    NSString * deli_end = [dictInfo objectForKey:@"deli_end"];
    
    if(email.length ==0){
        email = self.userInfo.email;
    }
    if(phone.length ==0){
        phone = self.userInfo.phone;
    }
    if(ord_name.length ==0){
        ord_name = self.userInfo.ord_name;
    }
    if(us_fam.length ==0){
        us_fam = self.userInfo.us_fam;
    }
    if(us_otch.length ==0){
        us_otch = self.userInfo.us_otch;
    }
    if(us_type.length ==0){
        us_type = self.userInfo.us_type;
    }
    if(inn.length ==0){
        inn = self.userInfo.inn;
    }
    if(kpp.length ==0){
        kpp = self.userInfo.kpp;
    }
    if(like_delivery.length ==0){
        like_delivery = self.userInfo.like_delivery;
    }
    if(like_tk.length ==0){
        like_tk = self.userInfo.like_tk;
    }
    if(like_pay.length ==0){
        like_pay = self.userInfo.like_pay;
    }
    if(doc_date.length ==0){
        doc_date = self.userInfo.doc_date;
    }
    if(doc_vend.length ==0){
        doc_vend = self.userInfo.doc_vend;
    }
    if(doc_num.length ==0){
        doc_num = self.userInfo.doc_num;
    }
    if(org_name.length ==0){
        org_name = self.userInfo.ord_name;
    }
    if(addr_index.length ==0){
        addr_index = self.userInfo.addr_index;
    }
    if(contact.length ==0){
        contact = self.userInfo.contact;
    }
    if(address.length ==0){
        address = self.userInfo.address;
    }
    if(deli_start.length ==0){
        deli_start = self.userInfo.deli_start;
    }
    if(deli_end.length ==0){
        deli_end = self.userInfo.deli_end;
    }
    
    UserInfoDbClass * userInfoDbClass = [[UserInfoDbClass alloc] init];
    
    [userInfoDbClass checkUserInfo:email phone:phone ord_name:ord_name us_fam:us_fam us_otch:us_otch us_type:us_type inn:inn kpp:kpp like_delivery:like_delivery like_tk:like_tk like_pay:like_pay doc_date:doc_date doc_vend:doc_vend doc_num:doc_num org_name:org_name addr_index:addr_index contact:contact address:address deli_start:deli_start deli_end:deli_end transport:@"" comment:@""];
    
    block();
    
}

@end
