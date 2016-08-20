//
//  HumanDetailView.m
//  TravelTogether
//
//  Created by Виктор Мишустин on 20/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "HumanDetailView.h"
#import "HexColors.h"
#import "Macros.h"
#import "UIButton+ButtonImage.h"
#import "CustomLabels.h"


@interface HumanDetailView ()

@property (strong, nonatomic) NSArray * arrayData;
@property (assign, nonatomic) CGFloat heighter;

@end

@implementation HumanDetailView

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 64.f, view.frame.size.width, view.frame.size.height - 64.f);

        self.arrayData = data;
        NSDictionary * dictData = [self.arrayData objectAtIndex:0];
        self.heighter = 27.5f;
        
        //Массив заголовков
        NSArray * arrayTitls = [NSArray arrayWithObjects:@"О себе:", @"Возраст", @"Пол", @"Я хочу:", @"Отношения:", @"Ориентация:", @"Внешность:", nil];
        //Массив тектовых данных
        NSArray * arrayText = [dictData objectForKey:@"array"];
        
        UIImageView * imageAva = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, 182.5f)];
        imageAva.image = [UIImage imageNamed:[dictData objectForKey:@"image"]];
        [self addSubview:imageAva];
        
        UIView * viewGray = [[UIView alloc] initWithFrame:CGRectMake(0.f, 182.5f, self.frame.size.width, 24.f)];
        viewGray.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"e6e6e6"];
        [self addSubview:viewGray];
        
        for (int i = 0; i < arrayTitls.count; i++) {
            UILabel * labelTitl = [[UILabel alloc] initWithFrame:CGRectMake(21.5f, self.heighter + 206.5, 61.f, 20.f)];
            UILabel * labelText = [[UILabel alloc] initWithFrame:CGRectMake(85.f, self.heighter + 206.5, 227.f, 20.f)];
            if (i == 0) {
                labelText.numberOfLines = 3;
                labelText.frame = CGRectMake(85.f, self.heighter + 206.5, 227.f, 45.f);
                self.heighter += 47.5f;
            } else if (i == 3 || i == 6) {
                labelText.numberOfLines = 2;
                labelText.frame = CGRectMake(85.f, self.heighter + 206.5, 227.f, 32.f);
                self.heighter += 40.f;
            } else {
                labelText.numberOfLines = 1;
                self.heighter += 30.f;
            }
            labelTitl.text = [arrayTitls objectAtIndex:i];
            labelTitl.textColor = [UIColor hx_colorWithHexRGBAString:@"bdbcbc"];
            labelTitl.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:10];
            [self addSubview:labelTitl];
            
            labelText.text = [arrayText objectAtIndex:i];
            labelText.textColor = [UIColor hx_colorWithHexRGBAString:@"807e7e"];
            labelText.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:10];
            [self addSubview:labelText];
        }
        
        UIButton * buttonLike = [UIButton createButtonWithImage:@"likeButtonImage.png" anfFrame:CGRectMake(70.f, 140.f, 33.f, 33.f)];
        buttonLike.alpha = 0.7f;
        [self addSubview:buttonLike];
        
        UIButton * buttonMessege = [UIButton createButtonWithImage:@"messageButtonImage.png" anfFrame:CGRectMake(self.frame.size.width - 103.f, 140.f, 33.f, 33.f)];
        buttonMessege.alpha = 0.7f;
        [buttonMessege addTarget:self action:@selector(buttonMessegeAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonMessege];
        
        CustomLabels * labelName = [[CustomLabels alloc] initLabelTableWithWidht:103.f andHeight:148.f
                                                                    andSizeWidht:114.f andSizeHeight:20
                                                                        andColor:@"ffffff" andText:[dictData objectForKey:@"name"]];
        labelName.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:10];
        labelName.textColor = [UIColor whiteColor];
        [self addSubview:labelName];
        
        CustomLabels * labelCity = [[CustomLabels alloc] initLabelTableWithWidht:103.f andHeight:160.f
                                                                    andSizeWidht:114.f andSizeHeight:20
                                                                        andColor:@"ffffff" andText:[dictData objectForKey:@"city"]];
        labelCity.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:10];
        labelCity.textColor = [UIColor whiteColor];
        [self addSubview:labelCity];
        

    }
    return self;
}

#pragma mark - Actions

- (void) buttonMessegeAction {
    [self.delegate pushToMessegerController:self];
}

@end
