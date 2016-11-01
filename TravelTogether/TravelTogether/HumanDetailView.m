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

@property (strong, nonatomic) UIImageView * imageViewPhoto;
@property (strong, nonatomic) UIView * mainPhotoView;
@property (strong, nonatomic) CustomLabels * labelbuttonLike;


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
        
        UIScrollView * scrollPhoto = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, - 64.f, self.frame.size.width, 182.5f + 64)];
        scrollPhoto.pagingEnabled = YES;
        scrollPhoto.showsHorizontalScrollIndicator = NO;
        scrollPhoto.contentSize = CGSizeMake(self.frame.size.width * 3, 0);
        [self addSubview:scrollPhoto];
        
        for (int i = 0; i < 3; i++) {
            UIButton * buttonAva = [UIButton createButtonWithImage:[dictData objectForKey:@"image"] anfFrame:CGRectMake(0.f + self.frame.size.width * i, 0.f, self.frame.size.width, 182.5f)];
            [buttonAva addTarget:self action:@selector(buttonAvaAction:) forControlEvents:UIControlEventTouchUpInside];
            [scrollPhoto addSubview:buttonAva];
        }
        

        
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
        [buttonLike addTarget:self action:@selector(buttonLikeAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonLike];
        
        self.labelbuttonLike = [[CustomLabels alloc] initLabelTableWithWidht:0.f andHeight:0.f andSizeWidht:33.f
                                                                         andSizeHeight:33.f andColor:VM_COLOR_PINK andText:@"10"];
        self.labelbuttonLike.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_LIGHT size:7];
        [buttonLike addSubview:self.labelbuttonLike];
        
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
        
        //PhotoView
        self.mainPhotoView = [self createImageView];
        self.mainPhotoView.alpha = 0.f;
        [self addSubview:self.mainPhotoView];
        

    }
    return self;
}

#pragma mark - ImageView
- (UIView*) createImageView {
    UIView * imageViewFone = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
    imageViewFone.backgroundColor = [UIColor whiteColor];
    
    UIScrollView * scrollPhotoBig = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
    scrollPhotoBig.pagingEnabled = YES;
    scrollPhotoBig.showsHorizontalScrollIndicator = NO;
    scrollPhotoBig.contentSize = CGSizeMake(self.frame.size.width * 3, 0);
    [imageViewFone addSubview:scrollPhotoBig];
    
    for (int i = 0; i < 3; i++) {
        UIView * viewPhotoScroll = [[UIView alloc] initWithFrame:CGRectMake(0.f + self.frame.size.width * i, 0.f, self.frame.size.width, self.frame.size.height)];
        [scrollPhotoBig addSubview:viewPhotoScroll];
        
        self.imageViewPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, imageViewFone.frame.size.width,
                                                                            imageViewFone.frame.size.height - 34.f)];
        UIImage * imagePhoto = [UIImage imageNamed:@"imageBigPhoto.png"];
        self.imageViewPhoto.image = imagePhoto;
        //Временное условие----------------
        self.imageViewPhoto.contentMode = UIViewContentModeScaleAspectFit;
        [viewPhotoScroll addSubview:self.imageViewPhoto];
        
        
        
        CustomLabels * labelName = [[CustomLabels alloc] initLabelWithWidht:12.5f andHeight:imageViewFone.frame.size.height - 27.5f andColor:VM_COLOR_PINK andText:@"Дженифер Энистон" andTextSize:10 andLineSpacing:0.f fontName:VM_FONT_SF_DISPLAY_REGULAR];
        [viewPhotoScroll addSubview:labelName];
        
        CustomLabels * labelComment = [[CustomLabels alloc] initLabelWithWidht:labelName.frame.size.width + 15.f andHeight:imageViewFone.frame.size.height - 27.5f andColor:@"707070" andText:@"Пляж на мальдивах" andTextSize:10 andLineSpacing:0.f fontName:VM_FONT_SF_DISPLAY_REGULAR];
        [viewPhotoScroll addSubview:labelComment];
        
        CustomLabels * labelDate = [[CustomLabels alloc] initLabelWithWidht:12.5 andHeight:imageViewFone.frame.size.height - 16.f andColor:@"b7b6b6" andText:@"2 дня назад" andTextSize:8 andLineSpacing:0.f fontName:VM_FONT_SF_DISPLAY_REGULAR];
        [viewPhotoScroll addSubview:labelDate];
    }
    
    
    
    UIButton * buttonPhotoCancel = [UIButton createButtonWithImage:@"buttonCancelNew.png"
                                                          anfFrame:CGRectMake(self.frame.size.width - 40.f, 5.f, 30.f, 30.f)];
    [buttonPhotoCancel addTarget:self action:@selector(buttonPhotoCancel) forControlEvents:UIControlEventTouchUpInside];
    [imageViewFone addSubview:buttonPhotoCancel];
    
    return imageViewFone;
}


#pragma mark - Actions

- (void) buttonAvaAction: (UIButton*) button {
    [UIView animateWithDuration:0.3 animations:^{
        self.mainPhotoView.alpha = 1.f;
    }];
}

- (void) buttonMessegeAction {
    [self.delegate pushToMessegerController:self];
}

- (void) buttonLikeAction {
    NSInteger countLike = [self.labelbuttonLike.text integerValue];
    countLike += 1;
    [UIView animateWithDuration:0.3 animations:^{
        self.labelbuttonLike.text = [NSString stringWithFormat:@"%d", countLike];
    }];
}

//Скрытие картинки во весь экран
- (void) buttonPhotoCancel {
    [UIView animateWithDuration:0.3 animations:^{
        self.mainPhotoView.alpha = 0.f;
    }];
}

@end
