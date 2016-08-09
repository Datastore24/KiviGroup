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
#define isiPhone6Plus               ([[UIScreen mainScreen] bounds].size.height == 736)?TRUE:FALSE
#define isiPhone6                   ([[UIScreen mainScreen] bounds].size.height == 667)?TRUE:FALSE
#define isiPhone5                   ([[UIScreen mainScreen] bounds].size.height == 568)?TRUE:FALSE
#define isiPhone4s                  ([[UIScreen mainScreen] bounds].size.height == 480)?TRUE:FALSE

//Шрифты--------------------------------------------------------------------------
#define VM_FONT_BOLD                @"pfagoraslabpro-bold"
#define VM_FONT_REGULAR             @"pfagoraslabpro-regular"
#define VM_FONT_BEAU_SANS_BOLD      @"PFBeauSansPro-bold"
#define VM_FONT_BEAU_SANS_LITE      @"PFBeauSansPro-light"
#define VM_FONT_SF_DISPLAY_REGULAR  @"SFUIDisplay-Regular"


//Цвета интерфейса----------------------------------------------------------------------------
#define VM_COLOR_PINK               @"a91a58"
#define VM_COLOR_WHITE              @"ffffff"
#define VM_COLOR_BLACK              @"000000"
#define VM_COLOR_GREEN              @"598527"
#define VM_COLOR_RED                @"ed1c24"
#define VM_COLOR_LIGHT_GREY         @"a7a7a7"
#define VM_COLOR_DARK_GREY          @"6b6b6b"

//Цвета шрифтов-----------------------------------------
#define VM_COLOR_TEXT_GREEN         @"48592d"
#define VM_COLOR_TEXT_GREY          @"919091"


#define NOTIFICATION_SEARCH_DETAIL_VIEW_PUSH_TO_TRAVEL @"NOTIFICATION_SEARCH_DETAIL_VIEW_PUSH_TO_TRAVEL"


#endif /* Macros_h */
