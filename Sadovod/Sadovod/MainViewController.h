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

@interface MainViewController : UIViewController


-(void) initializeCartBarButton; //Инициализация контроллера с кнопками навигации

- (void) setCustomTitle: (NSString*) title; //Установга загаловка в контроллер


@end

