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

@implementation GalleryView
{
    UIScrollView * mainScrollView;
    NSInteger numerator;
}

- (instancetype)initWithView: (UIView*) view ansArrayGallery: (NSMutableArray*) array
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
        
        //Создаем рабочий скрол вью-------------------------------------------------------
        mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, mainImageView.frame.size.width, mainImageView.frame.size.height)];
        [self addSubview:mainScrollView];
        
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
            buttonSeason.frame = CGRectMake(12.5 + 100 * i, 10, 90, 30);
            buttonSeason.backgroundColor = [UIColor colorWithHexString:@"2d6186"];
            [buttonSeason setTitle:[arraySeason objectAtIndex:i] forState:UIControlStateNormal];
            [buttonSeason setTintColor:[UIColor whiteColor]];
            buttonSeason.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:14];
            buttonSeason.layer.cornerRadius = 5.f;
            buttonSeason.change = YES;
            buttonSeason.tag = i;
            [buttonSeason addTarget:self action:@selector(buttonSeasonAction:) forControlEvents:UIControlEventTouchUpInside];
            [viewTopBar addSubview:buttonSeason];
        }
        
        //Создание коллекции изображений------------
        for (int i = 0; i < 20; i++) {
            UIImageView * imageView = [[UIImageView alloc] init];
            if (i %2 == 0) {
                imageView.frame = CGRectMake(17, 74 + 200 * numerator, 180, 180);
            } else {
                imageView.frame = CGRectMake(217, 74 + 200 * numerator, 180, 180);
                numerator += 1;
            }
            UIImage * imageGallery = [UIImage imageNamed:@"JuriFon.jpeg"];
            imageView.image = imageGallery;
            imageView.layer.cornerRadius = 5.f;
            imageView.layer.masksToBounds = YES;
            [mainScrollView addSubview:imageView];
            
            //Создаем кнопку перехода в новое вью------
            UIButton * buttonGallery = [UIButton buttonWithType:UIButtonTypeCustom];
            buttonGallery.frame = imageView.frame;
            buttonGallery.backgroundColor = [UIColor colorWithHexString:@"eceff3"];
            buttonGallery.alpha = 0.5f;
            buttonGallery.tag = 10 + i;
            [buttonGallery addTarget:self action:@selector(buttonGalleryAction:) forControlEvents:UIControlEventTouchUpInside];
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
    
    for (int i = 0; i < 4; i++) {
        if (button.tag == i) {
            button.backgroundColor = [UIColor colorWithHexString:@"2d6186"];
        }
    }
    
    
    for (int i = 0; i < 4; i++) {
        if (button.tag == i) {
                button.backgroundColor = [UIColor colorWithHexString:@"05a4f6"];
            }
        }
}


//Тач по картинке--------------------------------
- (void) buttonGalleryTuch: (UIButton*) button
{
    for (int i = 0; i < 20; i++)
    {
        if (button.tag == 10 + i) {
            button.alpha = 0.f;
            UIImageView * customImageView = (UIImageView*)[self viewWithTag:100+i];
            customImageView.alpha = 0.f;
        }
    }
}

//Действие нажатия на картинку--------------------
- (void) buttonGalleryAction: (UIButton*) button
{
    
    for (int i = 0; i < 20; i++)
    {
        if (button.tag == 10 + i) {
            NSLog(@"button.tag = %ld", (long)button.tag);
            button.alpha = 0.5f;
            UIImageView * customImageView = (UIImageView*)[self viewWithTag:100+i];
            customImageView.alpha = 1.f;
        }
    }
}








@end
