//
//  UIButton+ButtonImage.m
//  PsychologistIOS
//
//  Created by Viktor on 09.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "UIButton+ButtonImage.h"
#import "HexColors.h"
#import "Macros.h"

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

+ (UIButton*) createButtonCustomImageWithImage: (NSString*) imageName
                                       andRect: (CGRect) rect
{
    UIImage *imageBarButton = [UIImage imageNamed:imageName];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = rect;
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

+ (UIButton*) createButtonWriteWithImage: (NSString*) image
{
    UIImage *imageBarButton = [UIImage imageNamed:image];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 20, 20);
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



+ (UIButton*) customButtonSystemWithFrame: (CGRect) frame
                           andColor: (NSString*) colorName
                          andAlphaBGColor: (CGFloat) alphaColor
                           andBorderColor: (NSString*) borderColor
                    andCornerRadius: (CGFloat) cornerRadius
                        andTextName: (NSString*) textNameButton
                             andColorText: (NSString*) colorText
                              andSizeText: (CGFloat) sizeText
                           andBorderWidht: (CGFloat) borderWidht {
    
    UIButton * systemButton = [UIButton buttonWithType:UIButtonTypeSystem];
    systemButton.frame = frame;
    systemButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:colorName alpha:alphaColor];
    systemButton.layer.borderColor = [UIColor hx_colorWithHexRGBAString:borderColor].CGColor;
    systemButton.layer.borderWidth = borderWidht;
    systemButton.layer.cornerRadius = cornerRadius;
    [systemButton setTitle:textNameButton forState:UIControlStateNormal];
    [systemButton setTitleColor:[UIColor hx_colorWithHexRGBAString:colorText] forState:UIControlStateNormal];
    systemButton.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:sizeText];
    
    return systemButton;
}

@end
