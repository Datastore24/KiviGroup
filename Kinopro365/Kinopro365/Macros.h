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



//Шрифты--------------------------------------------------------------------------
#define FONT_ISTOK_BOLD @"Istok-Bold"
#define FONT_ISTOK_BOLD_ITALIC @"Istok-BoldItalic"
#define FONT_ISTOK_ITALIC @"Istok-Italic"
#define FONT_ISTOK_REGULAR @"Istok-Regular"


//Цвета----------------------------------------------------------------------------
#define COLOR_ACCENTUATION_BLUE @"4e7db0"
#define COLOR_ALERT_BUTTON_COLOR @"4682AC"
#define COLOR_PLACEHOLDER @"C7C7CD"
#define COLOR_BORDER_AVATAR @"e5ebf1"

//Элементы под разные устройства----------------------------------------------
#define isiPhone6  ([[UIScreen mainScreen] bounds].size.height == 667)?TRUE:FALSE
#define isiPhone5  ([[UIScreen mainScreen] bounds].size.height == 568)?TRUE:FALSE
#define isiPhone4s  ([[UIScreen mainScreen] bounds].size.height == 480)?TRUE:FALSE
#define isiPhone6Plus  ([[UIScreen mainScreen] bounds].size.height == 736)?TRUE:FALSE






#endif /* Macros_h */
