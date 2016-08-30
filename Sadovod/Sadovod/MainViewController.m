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


@interface MainViewController ()

@property (strong, nonatomic) UIView *backView;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStatusBarBackgroundColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_900]];
    

//    self.mainViewOrder = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50)];
//    self.mainViewOrder.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"000000" alpha:0.3];
//    self.mainViewOrder.alpha = 0.f;
//    UIWindow* mainWindow = [[UIApplication sharedApplication] keyWindow];
//    [mainWindow addSubview: self.mainViewOrder];
    
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
    
    //Параметры кнопки авторизации-------------------------------
    UIButton * buttonAvtorization = [UIButton createButtonWriteWithImage:@"avtorizationButton.png"];
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
    UIButton *buttonBasket = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonBasket setFrame:CGRectMake(185, 10, 20, 20)];
    [buttonBasket setBackgroundImage:[UIImage imageNamed:@"buttonImageBasket.png"] forState:UIControlStateNormal];
    if (barBasket) {
        buttonBasket.alpha = 0.f;
    }
    [self.backView addSubview:buttonBasket];
    
    
    //Кнопка бар кода------
    UIButton * buttonBarCode = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonBarCode setFrame:CGRectMake(145, 10, 20, 20)];
    [buttonBarCode setBackgroundImage:[UIImage imageNamed:@"barButtonImage.png"] forState:UIControlStateNormal];
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

@end
