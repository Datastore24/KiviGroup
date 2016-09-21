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

@interface FormalizationController() <UINavigationControllerDelegate>

@end

@implementation FormalizationController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.delegate = self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self setCustomTitle:@"Оформление заказа" andBarButtonAlpha: YES andButtonBasket: YES]; //Ввод заголовка
    
    //Кнопка Назад---------------------------------------------
    UIButton * buttonBack = [UIButton createButtonBack];
    [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = mailbuttonBack;
    
#pragma mark - View
    
    FormalizationView * mainView = [[FormalizationView alloc] initWithView:self.view andData:[self setCustonArray]];
    [self.view addSubview:mainView];
    
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

@end
