//
//  ViewCellMyCasting.m
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 08.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "ViewCellMyCasting.h"
#import "HexColors.h"
#import "Macros.h"
#import <SDWebImage/UIImageView+WebCache.h> //Загрузка изображения

@implementation ViewCellMyCasting

- (instancetype)initWithMainView: (UIView*) mainView endHeight: (CGFloat) height endImageName: (NSString*) imageUrl endName: (NSString*) name
                      endCountry: (NSString*) country endAge: (NSString*) age endIsReward: (BOOL) isReward endRewardNumber: (NSString*) rewardNumber
                       endIsLike: (BOOL) isLike endLikeNumber: (NSString*) likeNumber endIsBookmark: (BOOL) isBookmark
                    endProfileID: (NSString*) profileID enfGrowth: (NSString*) growth endApproved: (BOOL) approved
{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0.f, height, CGRectGetWidth(mainView.bounds), 130.f);
        
        
        
        CustomButton * buttonImage = [self createCustomButtonWithFrame:CGRectMake(13.f, 12.f, 84.f, 108.f) endImageName:imageUrl andProfileID:profileID];
        [buttonImage addTarget:self action:@selector(actionButtonImage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonImage];
        
        
        
        
        NSArray * arrayText = [NSArray arrayWithObjects:name, country, age, growth, nil];
        for (int i = 0; i < arrayText.count; i++) {
            UILabel * label = [self creationLabelWithFrame:CGRectMake(110.f, 12.f + 16.5f * i, 200, 16.5f) endText:[arrayText objectAtIndex:i]];
            [self addSubview:label];
        }
        
        //Награды
        CustomButton * buttonReward = [self creationCustonButtonForChangeParamsWithFrame:CGRectMake(111.5f, 97.f, 13.f, 20.f) endParams:isReward
                                                                              endOnImage:@"isRewarImageOn" endOffImage:@"professionImageStar"];
        buttonReward.customID = profileID;
        [buttonReward addTarget:self action:@selector(actionButtonReward:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonReward];
        
        self.numberRewar = [self creationLabelWithFrame:CGRectMake(135.f, 104.f, 20.f, 11.f) endText:rewardNumber];
        [self addSubview:self.numberRewar];
        //
        
        //Лайки
        CustomButton * buttonLike = [self creationCustonButtonForChangeParamsWithFrame:CGRectMake(179.f, 104.5f, 15.f, 13.f) endParams:isLike
                                                                            endOnImage:@"isLikeImageOn" endOffImage:@"likeImage"];
        buttonLike.customID = profileID;
        [buttonLike addTarget:self action:@selector(actionButtonLike:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonLike];
        
        self.numberLike = [self creationLabelWithFrame:CGRectMake(202.f, 104.f, 20.f, 11.f) endText:likeNumber];
        [self addSubview:self.numberLike];
        
        //Закладки
        CustomButton * buttonBookmark = [self creationCustonButtonForChangeParamsWithFrame:CGRectMake(289.f, 99.f, 19.f, 19.f) endParams:isBookmark
                                                                                endOnImage:@"professionImageBookmarkOn"
                                                                               endOffImage:@"professionImageBookmark"];
        buttonBookmark.customID = profileID;
        [buttonBookmark addTarget:self action:@selector(actionButtonBookmark:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonBookmark];
        
        
        UIView * borderView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 129.f, CGRectGetWidth(mainView.bounds), 1)];
        borderView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"AEAEAE"];
        [self addSubview:borderView];
        
        //Кнопки удаление и Отмены
        
        if (!approved) {
            CustomButton * buttonDelete = [self createCustomButtonWithFrame:CGRectMake(238.f, 47.f, 26.f, 26.f)
                                                             endImageString:@"buttonDeleteCellImage"];
            [buttonDelete addTarget:self action:@selector(actionButtonDelete:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:buttonDelete];
            
            CustomButton * buttonConfirm = [self createCustomButtonWithFrame:CGRectMake(284.f, 47.f, 26.f, 26.f)
                                                              endImageString:@"buttonConfermCellImage"];
            [buttonConfirm addTarget:self action:@selector(actionButtonConfirm:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:buttonConfirm];
        } else {
            CustomButton * buttonDelete = [self createCustomButtonWithFrame:CGRectMake(284.f, 47.f, 26.f, 26.f)
                                                             endImageString:@"buttonDeleteCellImage"];
            [buttonDelete addTarget:self action:@selector(actionButtonDelete:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:buttonDelete];
        }
        
    }
    return self;
}

#pragma mark - Methods for Creation

- (CustomButton*) createCustomButtonWithFrame: (CGRect) frame endImageName: (NSString*) imageName
                                 andProfileID: (NSString *) profileID {
    
    CustomButton * button = [CustomButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    NSURL *imgURL = [NSURL URLWithString:imageName];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:imgURL
                          options:0
                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                             // progression tracking code
                         }
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished,
                                    NSURL *imageURL) {
                            
                            if(image){
                                [button.imageView setContentMode:UIViewContentModeScaleAspectFill];
                                [button.imageView setClipsToBounds:YES];
                                [button.imageView.layer setCornerRadius:5];
                                [button setImage:image forState:UIControlStateNormal];
                                button.customID = profileID;
                                
                            }else{
                                //Тут обработка ошибки загрузки изображения
                            }
                        }];
    
    
    return button;
}

- (CustomButton*) creationCustonButtonForChangeParamsWithFrame: (CGRect) frame endParams: (BOOL) params
                                                    endOnImage: (NSString*) onImage endOffImage: (NSString*) offImage {
    
    CustomButton * button = [CustomButton buttonWithType:UIButtonTypeCustom];
    button.isBool = params;
    button.frame = frame;
    NSString * stringImage;
    if (params) {
        stringImage = onImage;
    } else {
        stringImage = offImage;
    }
    [button setImage:[UIImage imageNamed:stringImage] forState:UIControlStateNormal];
    
    return button;
}

- (CustomButton*) createCustomButtonWithFrame: (CGRect) frame endImageString: (NSString*) imageName {
   
    CustomButton * button = [CustomButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    return button;
}

- (CustomButton*) createBlueCustonmButtonWithFrame: (CGRect) frame endName: (NSString*) name enfImage: (NSString*) buttonImage {
    
    CustomButton * button = [CustomButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    button.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"5581A8"];
    button.layer.cornerRadius = 3.f;
    [button setTitle:name forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:FONT_ISTOK_BOLD size:14];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    
    UIImageView * imageButton = [[UIImageView alloc] initWithFrame:CGRectMake(5.f, 5.f, 20.f, 20.f)];
    imageButton.image = [UIImage imageNamed:buttonImage];
    [button addSubview:imageButton];
    
    return button;
    
}

- (UILabel*) creationLabelWithFrame: (CGRect) frame endText: (NSString*) text {
    
    UILabel * label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textColor = [UIColor hx_colorWithHexRGBAString:@"353535"];
    label.font = [UIFont fontWithName:FONT_ISTOK_REGULAR size:16];
    label.textAlignment = NSTextAlignmentLeft;
    
    return label;
}

#pragma mark - Actions

- (void) actionButtonImage: (CustomButton*) sender {
    
    [self.delegate actionWith:self endButtonImage:sender];
}

- (void) actionButtonReward: (CustomButton*) sender {
    
    [self.delegate actionWith:self endButtonReward:sender];
}

- (void) actionButtonLike: (CustomButton*) sender {
    
    [self.delegate actionWith:self endButtonLike:sender];
}

- (void) actionButtonBookmark: (CustomButton*) sender {
    
    [self.delegate actionWith:self endButtonBookmark:sender];
}

- (void) actionButtonDelete: (CustomButton*) sender {
    
    [self.delegate actionWith:self endButtonDelete:sender];
}

- (void) actionButtonConfirm: (CustomButton*) sender {
    [self.delegate actionWith:self endButtonConfirm:sender];
    
}

@end
