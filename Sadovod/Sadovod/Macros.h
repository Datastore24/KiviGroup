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

#define API_URL @"http://tk-sad.ru/abpro" //Адрес сервера

//Элементы под разные устройства----------------------------------------------
#define isiPhone6Plus                           ([[UIScreen mainScreen] bounds].size.height == 736)?TRUE:FALSE
#define isiPhone6                               ([[UIScreen mainScreen] bounds].size.height == 667)?TRUE:FALSE
#define isiPhone5                               ([[UIScreen mainScreen] bounds].size.height == 568)?TRUE:FALSE
#define isiPhone4s                              ([[UIScreen mainScreen] bounds].size.height == 480)?TRUE:FALSE

//Шрифты--------------------------------------------------------------------------
#define VM_FONT_BOLD                            @"pfagoraslabpro-bold"
#define VM_FONT_REGULAR                         @"pfagoraslabpro-regular"
#define VM_FONT_BEAU_SANS_BOLD                  @"PFBeauSansPro-bold"
#define VM_FONT_BEAU_SANS_LITE                  @"PFBeauSansPro-light"
#define VM_FONT_SF_DISPLAY_REGULAR              @"SFUIDisplay-Regular"


//Цвета интерфейса----------------------------------------------------------------------------
#define VM_COLOR_50                         @"E8EAF6"
#define VM_COLOR_100                        @"C5CAE9"
#define VM_COLOR_200                        @"9FA8DA"
#define VM_COLOR_300                        @"7986CB"
#define VM_COLOR_400                        @"5C6BC0"
#define VM_COLOR_500                        @"3F51B5"
#define VM_COLOR_600                        @"3949AB"
#define VM_COLOR_700                        @"303F9F"
#define VM_COLOR_800                        @"283593"
#define VM_COLOR_900                        @"1A237E"

//Нотификации
#define NOTIFICATION_FILTER_APPLY = @"NOTIFICATIONFILTERAPLLY"
//Нотификация для размеров
#define NOTIFICATION_SIZE_APPLY = @"NOTIFICATIONSIZEAPPLY"
//Проверка заказанных товаров (влияет на корзину)
#define NOTIFICATION_CHECK_COUNT_ORDER @"NOTIFICATION_CHECK_COUNT_ORDER"
//Нотификация авторизации
#define NOTIFICATION_AUTORIZATION @"NOTIFICATION_AUTORIZATION"
//Нотификация определения колличества и цены заказов
#define NOTIFICATION_SHOW_BASKET_VIEW @"NOTIFICATION_SHOW_BASKET_VIEW"
//Нотификация отображения телефона
#define NOTIFICATION_SHOW_PHONE @"NOTIFICATION_SHOW_PHONE"

#endif /* Macros_h */
