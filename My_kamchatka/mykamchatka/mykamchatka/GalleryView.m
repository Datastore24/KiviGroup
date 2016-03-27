//
//  GalleryView.m
//  mykamchatka
//
//  Created by Viktor on 18.03.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "GalleryView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "CustomButton.h"
#import "ViewSectionTable.h"
#import "GalleryDetailsController.h"

@implementation GalleryView
{
    UIScrollView * mainScrollView;
    NSInteger numerator;
}

- (instancetype)initBackgroundWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        //Инициализируем кастомный нумератор для разделения списка на два столбца
        numerator = 0;
        
        //Создаем фон из двух частей фонофого затемнения и изображения--------------------
        UIView * secondView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
        secondView.backgroundColor = [UIColor colorWithHexString:@"eceff3"];
        [self addSubview:secondView];
        UIImageView * mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
        mainImageView.image = [UIImage imageNamed:@"JuriFon.jpeg"];
        mainImageView.alpha = 0.25f;
        [secondView addSubview:mainImageView];
        
        //Создаем кнопки под топ баром---------------------------------------------------
        //Осноное вью для кнопок---------------------
        UIView * viewTopBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 64)];
        viewTopBar.backgroundColor = [UIColor colorWithHexString:@"b3ddf4"];
        [self addSubview:viewTopBar];
        
        //Массив имен времен года--------------------
        NSArray * arraySeason = [NSArray arrayWithObjects:@"Зима", @"Весна", @"Лето", @"Осень", nil];
        
        //Создание кнопок----------------------------
        for (int i = 0; i < 4; i ++) {
            CustomButton * buttonSeason = [CustomButton buttonWithType:UIButtonTypeCustom];
            buttonSeason.frame = CGRectMake(((self.frame.size.width - 350)/2) + 90 * i, 20, 80, 25);
            buttonSeason.backgroundColor = [UIColor colorWithHexString:@"2d6186"];
            [buttonSeason setTitle:[arraySeason objectAtIndex:i] forState:UIControlStateNormal];
            [buttonSeason setTintColor:[UIColor whiteColor]];
            buttonSeason.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:14];
            buttonSeason.layer.cornerRadius = 5.f;
            buttonSeason.change = YES;
            buttonSeason.tag = i+1;
            [buttonSeason addTarget:self action:@selector(buttonSeasonAction:) forControlEvents:UIControlEventTouchUpInside];
            [viewTopBar addSubview:buttonSeason];
            
            if (buttonSeason.tag == 1) {
                buttonSeason.change = NO;
                buttonSeason.backgroundColor = [UIColor colorWithHexString:@"05a4f6"];
            }
        }

    }
    return self;
}

//Реалезация галереи-------------------------------

- (instancetype)initWithView: (UIView*) view ansArrayGallery: (NSArray*) array
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 64, view.frame.size.width, view.frame.size.height);
        
        //Инициализируем кастомный нумератор для разделения списка на два столбца
        numerator = 0;
        
        //Создаем рабочий скрол вью-------------------------------------------------------
        mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:mainScrollView];
        
        //Создание коллекции изображений------------
        for (int i = 0; i < array.count; i++) {
            
            NSDictionary * dictData = [array objectAtIndex:i];
            
            UIView * imageView = [[UIImageView alloc] init];
            if (i %2 == 0) {
                imageView.frame = CGRectMake((self.frame.size.width / 2) - 170, 10 + 180 * numerator, 160, 160);
            } else {
                imageView.frame = CGRectMake((self.frame.size.width / 2) + 10, 10 + 180 * numerator, 160, 160);
                numerator += 1;
            }
            imageView.layer.cornerRadius = 5.f;
            imageView.layer.masksToBounds = YES;
            [mainScrollView addSubview:imageView];
            
            ViewSectionTable * viewSectionTable = [[ViewSectionTable alloc] initWithImageURL:[dictData objectForKey:@"image_intro"] andView:nil];
            [imageView addSubview:viewSectionTable];
            
            //Создаем кнопку перехода в новое вью------
            CustomButton * buttonGallery = [CustomButton buttonWithType:UIButtonTypeCustom];
            buttonGallery.frame = imageView.frame;
            buttonGallery.backgroundColor = [UIColor colorWithHexString:@"eceff3"];
            buttonGallery.alpha = 0.5f;
            buttonGallery.dictImage = dictData;
            buttonGallery.tag = 10 + i;
            [buttonGallery addTarget:self action:@selector(buttonGalleryTuch:) forControlEvents:UIControlEventTouchDown];
            [mainScrollView addSubview:buttonGallery];
            
            //Картинка глаза--------------------------
            UIImageView * eyeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
            eyeView.image = [UIImage imageNamed:@"eye.png"];
            eyeView.tag = 100 + i;
            eyeView.center = imageView.center;
            [mainScrollView addSubview:eyeView];
        }
        mainScrollView.contentSize = CGSizeMake(0, 140 + 200 * 10);
    }
    return self;
}

#pragma mark - ButtonsMethos

//Кнопки действия времен года----------------------
- (void) buttonSeasonAction: (CustomButton*) button
{
    for (int i = 1; i < 5; i++) {
        CustomButton * otherButton  = (CustomButton *) [self viewWithTag:i];
        if (button.tag == i) {
            if (button.change) {
                button.backgroundColor = [UIColor colorWithHexString:@"05a4f6"];
                NSLog(@"Тест на проверку");
                button.change = NO;
                
                //Создаем переменную для передачи данных на сервер--------
                if (button.tag == i) {
                NSString * getString = [NSString stringWithFormat:@"%ld", 96+ button.tag];
                //Создаем нотификацию для отправки данных-----------------
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICARION_GALLERY_VVIEW_CHANGE_MONTH object:getString];
                }
            }
        }else{
             otherButton.backgroundColor = [UIColor colorWithHexString:@"2d6186"];
             otherButton.change = YES;
        }
    }
}


//Тач по картинке--------------------------------
- (void) buttonGalleryTuch: (CustomButton*) button
{
    for (int i = 0; i < 20; i++)
    {
        
        if (button.tag == 10 + i) {
            button.alpha = 0.f;
            UIImageView * customImageView = (UIImageView*)[self viewWithTag:100+i];
            customImageView.alpha = 0.f;
//--------------------------------
            
            [button addTarget:self action:@selector(buttonGalleryBack:) forControlEvents:UIControlEventTouchDragOutside];
            [button addTarget:self action:@selector(buttonGalleryBack:) forControlEvents:UIControlEventTouchDragEnter];
            
            [button addTarget:self action:@selector(buttonGalleryAction:) forControlEvents:UIControlEventTouchUpInside];
<<<<<<< HEAD
            [button addTarget:self action:@selector(buttonGalleryAction:) forControlEvents:UIControlEventTouchUpOutside];
            [button addTarget:self action:@selector(buttonGalleryAction:) forControlEvents:  UIControlEventTouchCancel];
=======
            [button addTarget:self action:@selector(buttonGalleryBack:) forControlEvents:  UIControlEventTouchCancel];
            
            
>>>>>>> origin/master

        }
    }
}

-(void) buttonGalleryBack: (UIButton*) button{
    for (int i = 0; i < 20; i++)
    {
        if (button.tag == 10 + i) {
            button.alpha = 0.5f;
            UIImageView * customImageView = (UIImageView*)[self viewWithTag:100+i];
            customImageView.alpha = 1.f;
        }
    }
    
}

//Действие нажатия на картинку--------------------
- (void) buttonGalleryAction: (CustomButton*) button
{
    
    for (int i = 0; i < 20; i++)
    {
        if (button.tag == 10 + i) {
            NSDictionary * dictImage = button.dictImage;
            button.alpha = 0.5f;
            UIImageView * customImageView = (UIImageView*)[self viewWithTag:100+i];
            customImageView.alpha = 1.f;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_GALLARY_PUSH_GALLARY_DETAIL object:nil userInfo:dictImage];
            
        }
    }
}

@end
