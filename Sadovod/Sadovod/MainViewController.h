//
//  ViewController.h
//  Sadovod
//
//  Created by Виктор Мишустин on 12/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+ButtonImage.h"
#import "SWRevealViewController.h"
#import "BottomBasketView.h"

@interface MainViewController : UIViewController

@property (strong, nonatomic) UIButton * buttonBarCode;
@property (strong, nonatomic) UIButton *buttonBasket;

//Парметры корзины

@property (strong, nonatomic) NSString * countOrder;
@property (strong, nonatomic) NSString * priceOrder;
@property (strong, nonatomic) BottomBasketView * mainViewOrder;


-(void) initializeCartBarButton; //Инициализация контроллера с кнопками навигации

- (void) setCustomTitle: (NSString*) title andBarButtonAlpha: (BOOL) isBool andButtonBasket: (BOOL) barBasket; //Установга загаловка в контроллер

- (void) createMainBasketWithCount: (NSString*) count andPrice: (NSString*) price;

- (void) changeCountString;



@end

