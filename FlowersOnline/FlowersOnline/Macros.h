//
//  Macros.h
//  ITDolgopa
//
//  Created by Viktor on 05.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

/*Наименование нотификайии состоит из 3ех частей
 1 часть - Идентификатор нотификиции
 2 часть - Название класса где созданна нотификаци
 3 часть - Действие которое выполняет нотификации
*/

#ifndef Macros_h
#define Macros_h




//Макросы для приложения ---------------------------------------------------

//Элементы под разные устройства----------------------------------------------
#define isiPhone6  ([[UIScreen mainScreen] bounds].size.height == 667)?TRUE:FALSE
#define isiPhone5  ([[UIScreen mainScreen] bounds].size.height == 568)?TRUE:FALSE
#define isiPhone4s  ([[UIScreen mainScreen] bounds].size.height == 480)?TRUE:FALSE

//Шрифты--------------------------------------------------------------------------
#define FONTREGULAR @"SFUIDisplay-Regular"
#define FONTLITE @"SFUIDisplay-Light"
#define FONTBOND @"SFUIDisplay-Bold"

//Цвета----------------------------------------------------------------------------
#define COLORGREEN @"85af02"
#define COLORBLACK @"2a2a2a"
#define COLORGRAY @"d9d9d9"
#define COLORTEXTGRAY @"4d4d4b"
#define COLORPINCK @"fe3a63"

//Нотификации класса LoginView and LoginController
#define NOTIFICATION_LOGIN_VIEW_PUSH_BOUQUETS_CONTROLLER @"NOTIFICATION_LOGIN_VIEW_PUSH_BOUQUETS_CONTROLLER"

#endif /* Macros_h */
