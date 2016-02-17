//
//  Macros.h
//  ITDolgopa
//
//  Created by Viktor on 05.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

//Список кастомных тегов объектов приложени--------------------------------

//Класс Login View---------------------------------------------------------

//Кнопка ПОЛУЧИТЬ КОД tag = 301
//Кнопка Войти tag = 304
//Текст филд ввод телефона tag = 302
//Полоска tag = 3021;
//Placeholder телефона tag = 3022;
//Текст филд ввод смс tag = 303
//Вью дл анимации СМС mainViewSMS.tag = 305;
//View для анимации ПРОВЕРКИ tag = 306
//Индикатор загрузки tag=307
//Кнопка регистрации buttonRegistration.tag = 309;
//View регистрации tag = 308
//Кнопка ЗАРЕГЕСТРИРОВАТЬСЯ buttonRegistration.tag = 310;

//Класс Registration View---------------------------------------------------

//Текст Филд ввода телефона textFieldInputPhone.tag = 312;
//Текст Филд ввод ФИО textFieldInputSMS.tag = 313;




//Макросы для приложения ---------------------------------------------------
//Тут записанны общие данные о хар-ках приложения---------------------------

//1. Основной фон приложения------------------------------------------------
#define MAINBACKGROUNDCOLOR @"050505"
//2. Полоски для ввода телефона и СМС---------------------------------------
#define BACKGROUNDCOLORLIGINVIEW @"828282"

//Основной шрифт------------------------------------------------------------
#define MAINFONTLOGINVIEW @"SFUIDisplay-Light"

//Зеленая кнопка------------------------------------------------------------
//Основной цвет зеленой кнопки----------------------------------------------
#define MAINCOLORGREENBUTTON @"0f2813"
//Цвет границы зеленой кнопки-----------------------------------------------
#define BORDERCOLORGREENBUTTON @"01663b"

//Цвет кнопки войти---------------------------------------------------------
#define MAINCOLORBUTTONLOGIN @"ed1d24"

//Нотификация запускается после нажатия кнопки buttonGetCode----------------
#define LoginViewControllerButtonGetCodeAction @"LoginViewControllerButtonGetCodeAction"

//Шрифты и размеры в зависимости от устройства------------------------------

#define isiPhone5  ([[UIScreen mainScreen] bounds].size.height <= 568)?TRUE:FALSE

//Шрифты--------------------------------------------------------------------------
#define FONTREGULAR @"SFUIDisplay-Regular"
#define FONTLITE @"SFUIDisplay-Light"

//Цвета---------------------------------------------------------------------------
#define COLORLITEGRAY @"929597"
#define COLORLITELITEGRAY @"f9fafa"



#endif /* Macros_h */
