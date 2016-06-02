//
//  Macros.h
//  ITDolgopa
//
//  Created by Viktor on 05.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

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

#endif /* Macros_h */
