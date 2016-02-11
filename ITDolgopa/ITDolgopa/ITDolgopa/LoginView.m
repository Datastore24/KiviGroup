//
//  LoginView.m
//  ITDolgopa
//
//  Created by Viktor on 05.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "LoginView.h"
#import "Macros.h"
#import "UIColor+HexColor.h"

@interface LoginView ()

@end

@implementation LoginView

- (id)initWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:MAINBACKGROUNDCOLOR];
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        
        //Создание Logo------------------------------------------------------------------
        //Создаем кастомную ширину лого--------------------------------------------------
        CGFloat widthLogin = (self.frame.size.width / 3) * 2;
        UIImageView * imageViewLogo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, widthLogin, widthLogin / 3.5)];
        imageViewLogo.image = [UIImage imageNamed:@"Logo.png"];
        imageViewLogo.center = self.center;
        //Создаем кастомный центр лого---------------------------------------------------
        CGPoint centerLogo = imageViewLogo.center;
        centerLogo.y = (centerLogo.y - imageViewLogo.frame.origin.y) + (imageViewLogo.frame.size.height * 2);
        imageViewLogo.center = centerLogo;
        [self addSubview:imageViewLogo];
        
        //Создание полоски вью телефона--------------------------------------------------
        UIView * viewLoginPhone = [[UIView alloc] initWithFrame:CGRectMake(0, 0, widthLogin, 0.5)];
        viewLoginPhone.center = self.center;
        viewLoginPhone.backgroundColor = [UIColor colorWithHexString:BACKGROUNDCOLORLIGINVIEW];
        [self addSubview:viewLoginPhone];
        
        
        
        

        
    }
    return self;
}


@end



