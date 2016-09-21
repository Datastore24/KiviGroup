//
//  ViewController.m
//  Sadovod
//
//  Created by Виктор Мишустин on 12/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "MainViewController.h"
#import "UILabel+TitleCategory.h"
#import "HexColors.h"
#import "Macros.h"
#import "SingleTone.h"
#import "BasketController.h"
#import "AuthorizationController.h"
#import "BasketController.h"
#import "FormalizationController.h"
#import "AlertClassCustom.h"
#import "PopAnimator.h"
#import "PushAnimator.h"


@interface MainViewController () <UINavigationControllerDelegate>

@property (strong, nonatomic) UIView *backView;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    [self setStatusBarBackgroundColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_900]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void) initializeCartBarButton
{
    //Пареметры кнопки меню------------------------------------
    UIButton * buttonMenu = [UIButton createButtonMenu];
    [buttonMenu addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * menuButton =[[UIBarButtonItem alloc] initWithCustomView:buttonMenu];
    self.navigationItem.leftBarButtonItem = menuButton;
    UIButton * buttonAvtorization;
    //Параметры кнопки авторизации-------------------------------
    if ([[[SingleTone sharedManager] typeMenu] isEqualToString:@"0"]) {
    buttonAvtorization = [UIButton createButtonWriteWithImage:@"entrance.png"];
    } else {
    buttonAvtorization = [UIButton createButtonWriteWithImage:@"avtorizationButton.png"];
    }
    [buttonAvtorization addTarget:self action:@selector(buttonAvtorization) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * avtorizationButton =[[UIBarButtonItem alloc] initWithCustomView:buttonAvtorization];
    self.navigationItem.rightBarButtonItem = avtorizationButton;
}

- (void) setCustomTitle: (NSString*) title andBarButtonAlpha: (BOOL) isBool andButtonBasket: (BOOL) barBasket
{
    self.backView =[[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 200.f, 40.f)];
    UILabel * customText = [[UILabel alloc]initWithTitle:title];
    customText.frame = CGRectMake(20.f, 0.f, customText.frame.size.width , 44.5f);
    [self.backView addSubview:customText];
    

    //Кнопка корзины------
    self.buttonBasket = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.buttonBasket setFrame:CGRectMake(185, 10, 20, 20)];
    [self.buttonBasket setBackgroundImage:[UIImage imageNamed:@"buttonImageBasket.png"] forState:UIControlStateNormal];
    [self.buttonBasket addTarget:self action:@selector(buttonBasketAction) forControlEvents:UIControlEventTouchUpInside];
    if (barBasket) {
        self.buttonBasket.alpha = 0.f;
    }
    [self.backView addSubview:self.buttonBasket];
    
    
    //Кнопка бар кода------
    UIButton * buttonBarCode = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonBarCode setFrame:CGRectMake(145, 10, 20, 20)];
    buttonBarCode.userInteractionEnabled = NO;
//    [buttonBarCode setBackgroundImage:[UIImage imageNamed:@"barButtonImage.png"] forState:UIControlStateNormal];
    if (isBool) {
        buttonBarCode.alpha = 0.f;
    }
    [self.backView addSubview:buttonBarCode];
    
    
    self.navigationItem.titleView = self.backView;
}

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

- (void) buttonBasketAction {
    BasketController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"BasketController"];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void) buttonAvtorization {
    AuthorizationController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"AuthorizationController"];
    [self.navigationController pushViewController:detail animated:YES];
    
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
