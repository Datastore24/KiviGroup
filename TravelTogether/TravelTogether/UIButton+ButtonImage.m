//
//  UIButton+ButtonImage.m
//  PsychologistIOS
//
//  Created by Viktor on 09.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "UIButton+ButtonImage.h"

@implementation UIButton (ButtonImage)

@dynamic imageButton;
@dynamic isBool;


+ (UIButton*) createButtonMenu
{
    UIImage *imageBarButton = [UIImage imageNamed:@"IconButtonMenu.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 17, 14);
    CGRect rect = button.frame;
    rect.origin.y += 16;
    button.frame = rect;
    [button setImage:imageBarButton forState:UIControlStateNormal];
    
    return button;
}

+ (UIButton*) createButtonWithImage: (NSString*) image
                           anfFrame: (CGRect) frame {
    UIImage *imageBarButton = [UIImage imageNamed:image];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setImage:imageBarButton forState:UIControlStateNormal];
    return button;
}

+ (UIButton*) createButtonBasket
{
    UIImage *imageBarButton = [UIImage imageNamed:@"iconBasket.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 20, 16);
    CGRect rect = button.frame;
    rect.origin.y += 16;
    button.frame = rect;
    [button setImage:imageBarButton forState:UIControlStateNormal];
    
    return button;
}

+ (UIButton*) createButtonBack
{
    UIImage *imageBarButton = [UIImage imageNamed:@"buttonBackImage.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 15, 15);
    CGRect rect = button.frame;
    rect.origin.y += 10;
    button.frame = rect;
    [button setImage:imageBarButton forState:UIControlStateNormal];
    
    return button;
}

+ (UIButton*) createButtonTextWithName: (NSString*) name
                              andFrame: (CGRect) rect
                              fontName: (NSString*) font
{
    UIButton * textButton = [UIButton buttonWithType:UIButtonTypeSystem];
    textButton.frame = rect;
    [textButton setTitle:name forState:UIControlStateNormal];
    [textButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    textButton.titleLabel.font = [UIFont fontWithName:font size:13];
    
    return textButton;
}

@end
