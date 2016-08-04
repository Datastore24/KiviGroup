//
//  SearchTravelView.m
//  TravelTogether
//
//  Created by Виктор Мишустин on 04/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "SearchTravelView.h"
#import "HexColors.h"
#import "Macros.h"
#import "CustomLabels.h"
#import "InputTextView.h"

@interface SearchTravelView ()

@property (strong, nonatomic) UIButton * buttonAircraft;
@property (strong, nonatomic) UIButton * buttonTrain;

@end

@implementation SearchTravelView

- (instancetype)initMainViewSearchTravelWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 64.f, view.frame.size.width, view.frame.size.height - 64.f);
        
        NSArray * arrayTintText = [NSArray arrayWithObjects:               //Массив имен мелких заголовков
                                   @"Номер рейса", @"Выберете направление", @"Откуда", @"Туда", @"Куда", @"Обратно", @"", nil];
        
        NSArray * arrayPlaysHolders = [NSArray arrayWithObjects:@"PTX 5467", @"Страна", @"Город",
                                       @"Домодедово                 DME", @"19 августа, вт",
                                       @"Рим                                 ROM", @"29 августа, пн", nil];
        
        
        //Air view
        UIView * viewAircraft = [[UIView alloc] initWithFrame:
                                 CGRectMake(12.5f, 39.f, self.frame.size.width / 2.f - 12.5f, 21.f)];
        viewAircraft.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK];
        [self customRadiusWithView:viewAircraft andRadius:10.5f];
        [self addSubview:viewAircraft];
        
        self.buttonAircraft = [UIButton buttonWithType:UIButtonTypeSystem];
        self.buttonAircraft.frame = CGRectMake(13.5f, 40.f, self.frame.size.width / 2.f - 14.5f, 19.f);
        self.buttonAircraft.backgroundColor = [UIColor whiteColor];
        [self customRadiusWithView:self.buttonAircraft andRadius:9.5f];
        self.buttonAircraft.userInteractionEnabled = NO;
        self.buttonAircraft.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_WHITE alpha:0.f];
        [self.buttonAircraft setTitle:@"Самолет" forState:UIControlStateNormal];
        [self.buttonAircraft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.buttonAircraft.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
        [self.buttonAircraft addTarget:self action:@selector(buttonAircraftAction)
                 forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.buttonAircraft];
        
        
        //Train view
        UIView * viewTrain = [[UIView alloc] initWithFrame:
                              CGRectMake(self.frame.size.width / 2, 39.f,
                                         self.frame.size.width / 2.f - 12.5f, 21.f)];
        viewTrain.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK];
        [self customRightRadiusWithView:viewTrain andRadius:10.5f];
        [self addSubview:viewTrain];
        
        self.buttonTrain = [UIButton buttonWithType:UIButtonTypeSystem];
        self.buttonTrain.frame = CGRectMake(viewTrain.frame.origin.x + 1.f, 40.f,
                                       self.frame.size.width / 2.f - 14.5f, 19.f);
        self.buttonTrain.backgroundColor = [UIColor whiteColor];
        [self customRightRadiusWithView:self.buttonTrain andRadius:9.5f];
        self.buttonTrain.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_WHITE alpha:1.f];
        [self.buttonTrain setTitle:@"Поезд" forState:UIControlStateNormal];
        [self.buttonTrain setTitleColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK] forState:UIControlStateNormal];
        self.buttonTrain.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
        [self.buttonTrain addTarget:self action:@selector(buttonTrainAction)
                      forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.buttonTrain];
        
        //Наносим мелкие загаловки-------------------
        
        for (int i = 0; i < 7; i++) {
            CustomLabels * tintLabels = [[CustomLabels alloc] initLabelWithWidht:12.5f andHeight:75.f + 46.25 * i
                                                                        andColor:VM_COLOR_DARK_GREY
                                                                         andText:[arrayTintText objectAtIndex:i] andTextSize:10
                                                                  andLineSpacing:0.f fontName:VM_FONT_REGULAR];
            
            UIView * groudView = [[UIView alloc] initWithFrame:CGRectMake(12.5f, 87.5f + 46.f * i, 142.5f, 20.f)];
            groudView.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK];
            
            
            InputTextView * inputText = [[InputTextView alloc] initInputTextWithView:self andRect:CGRectMake(13.5f, 88.5f + 46.f * i, 140.5f, 18.f) andImage:nil andTextPlaceHolder:[arrayPlaysHolders objectAtIndex:i] colorBorder:VM_COLOR_PINK];
            
            if (i > 1 && i < 4) {
                tintLabels.frame = CGRectMake(26.f, 75.f + 46.25f * (i + 1.f), 100.f, 20.f);
                [tintLabels sizeToFit];
            } else if (i > 3) {
                tintLabels.frame = CGRectMake(175.f, 75.f + 46.25f * (i - 1.f), 100.f, 20.f);
                [tintLabels sizeToFit];
            }
            
            if (i > 2 && i < 5) {
                [self customRadiusWithView:groudView andRadius:10.f];
                [self customRadiusWithView:inputText andRadius:9.f];
            } else if (i > 4) {
                groudView.frame = CGRectMake(self.frame.size.width - 12.5f - 142.5f, 87.5f + 46.f * (i - 2.f), 142.5f, 20.f);
                inputText.frame = CGRectMake(self.frame.size.width - 11.5f - 142.5f, 88.5f + 46.f * (i - 2.f), 140.5f, 18.f);
                [self customRightRadiusWithView:groudView andRadius:10.f];
                [self customRightRadiusWithView:inputText andRadius:9.f];
            }else {
                [self customAllRadiusWithView:groudView andRadius:10.f];
                [self customAllRadiusWithView:inputText andRadius:9.f];
            }
            
            
            [self addSubview: tintLabels];
            [self addSubview:groudView];
            [self addSubview:inputText];
        }
        
    }
    return self;
}


//Два метода для создания загругления------

- (void) customRadiusWithView: (UIView*) view
                    andRadius: (CGFloat) radius
{
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                     byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft)
                                           cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

- (void) customRightRadiusWithView: (UIView*) view
                         andRadius: (CGFloat) radius
{
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                     byRoundingCorners:(UIRectCornerTopRight | UIRectCornerBottomRight)
                                           cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

- (void) customAllRadiusWithView: (UIView*) view
                         andRadius: (CGFloat) radius
{
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                     byRoundingCorners:(UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerTopLeft | UIRectCornerBottomLeft)
                                           cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}


#pragma mark - Action Methods

- (void) buttonAircraftAction
{
    self.buttonAircraft.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.buttonAircraft.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_WHITE alpha:0.f];
        [self.buttonAircraft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.buttonTrain.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_WHITE alpha:1.f];
        [self.buttonTrain setTitleColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK] forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        self.buttonTrain.userInteractionEnabled = YES;
        
        //Остальной код действия кнопки
        
    }];
}

- (void) buttonTrainAction
{
    self.buttonTrain.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.buttonTrain.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_WHITE alpha:0.f];
        [self.buttonTrain setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.buttonAircraft.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_WHITE alpha:1.f];
        [self.buttonAircraft setTitleColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK] forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        self.buttonAircraft.userInteractionEnabled = YES;
        
        //Остальной код действия кнопки
        
    }];
}
@end
