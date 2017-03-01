//
//  ProfessionCellView.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 13.02.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "ProfessionCellView.h"
#import "UIView+BorderView.h"
#import "HexColors.h"
#import "Macros.h"
#import <SDWebImage/UIImageView+WebCache.h> //Загрузка изображения



@implementation ProfessionCellView

- (instancetype)initCellProfessionWithMainView: (UIView*) view andHeight: (CGFloat) height andOrignX: (CGFloat) orgnX
                                 andImageAvart: (NSString*) imageAvatar andNameText: (NSString*) name
                                andCountryText: (NSString*) country andAgeText: (NSString*) age
                                 andGrowthText: (NSString*) growth andStarsNumber: (NSString*) starsNumber
                                 andLikeNumber: (NSString*) likeNumber
                                  andProfileID: (NSString *) profileID
                                andIsFavourite: (NSString *) isFavourite{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(orgnX, height, CGRectGetWidth(view.bounds), 125.f);
        
        UIView * upBorderView = [UIView createGrayBorderViewWithView:self andHeight:0.f];
        [self addSubview:upBorderView];
        
        UIImageView * avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(13.f, 5.f, 76.f, 115.f)];
        //Тень
        
        //
        NSURL *imgURL = [NSURL URLWithString:imageAvatar];
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:imgURL
                              options:0
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 // progression tracking code
                             }
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished,
                                        NSURL *imageURL) {
                                
                                if(image){
                                    avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
                                    avatarImageView.clipsToBounds = YES;
                                    avatarImageView.layer.cornerRadius = 5;
                                   
                                    
                                    avatarImageView.image = image;
                                    
                                    
                                }else{
                                    //Тут обработка ошибки загрузки изображения
                                }
                            }];
        
        
        
        
        [self addSubview:avatarImageView];
        
        UILabel * labelName = [self createLabelWithName:name andFrame:CGRectMake(110.f, 11.f, 200, 17.75f)];
        [self addSubview:labelName];
        UILabel * labelCountry = [self createLabelWithName:country andFrame:CGRectMake(110.f, 11.f + 17.75f, 200, 17.75f)];
        [self addSubview:labelCountry];
        UILabel * labelAge = [self createLabelWithName:age andFrame:CGRectMake(110.f, 11.f + 17.75f * 2, 200, 17.75f)];
        [self addSubview:labelAge];
        UILabel * labelGrowth = [self createLabelWithName:growth andFrame:CGRectMake(110.f, 11.f + 17.75f * 3, 200, 17.75f)];
        [self addSubview:labelGrowth];
        
        UIImageView * imageViewStars = [[UIImageView alloc] initWithFrame:CGRectMake(113.f, 97.f, 13.f, 20.f)];
        imageViewStars.image = [UIImage imageNamed:@"professionImageStar"];
        [self addSubview:imageViewStars];
        UILabel * labelNumberStars = [self createLabelWithName:starsNumber andFrame:CGRectMake(134.f, 102.f, 20.f, 12.f)];
        [self addSubview:labelNumberStars];
        
        UIImageView * imageViewLike = [[UIImageView alloc] initWithFrame:CGRectMake(179.f, 102.f, 15.f, 13.f)];
        imageViewLike.image = [UIImage imageNamed:@"professionImageLike"];
        [self addSubview:imageViewLike];
        UILabel * labelNumberLike = [self createLabelWithName:likeNumber andFrame:CGRectMake(202.f, 102.f, 20.f, 12.f)];
        [self addSubview:labelNumberLike];
        
        CustomButton * buttonCell = [CustomButton buttonWithType:UIButtonTypeCustom];
        buttonCell.frame = self.bounds;
        buttonCell.customFullName = name;
        buttonCell.customID = profileID;
        
        [buttonCell addTarget:self action:@selector(actionButtonCell:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonCell];
        
        CustomButton * buttonBookmark = [CustomButton buttonWithType:UIButtonTypeCustom];
        buttonBookmark.frame =CGRectMake(288.f, 97.f, 19.f, 20.f);
         buttonBookmark.customID = profileID;
        
        if([isFavourite integerValue] == 0){
            buttonBookmark.isBool = NO;
            [buttonBookmark setImage:[UIImage imageNamed:@"professionImageBookmark"] forState:UIControlStateNormal];
        }else{
            buttonBookmark.isBool = YES;
            [buttonBookmark setImage:[UIImage imageNamed:@"professionImageBookmarkOn"] forState:UIControlStateNormal];
            
            
        }
        
        buttonCell.customButton = buttonBookmark;
        
        
        
        [buttonBookmark addTarget:self action:@selector(actionButtonBookMark:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonBookmark];

    }
    return self;
}

#pragma mark - Actoions

- (void) actionButtonBookMark: (CustomButton*) sender {
    
    [self.deleagte actionBookMark:self withButton:sender];
}

- (void) actionButtonCell: (CustomButton*) sender {
    
    [self.deleagte actionButtonCell:self withButton:sender];
}

#pragma mark - CreationViews

- (UILabel*) createLabelWithName: (NSString*) name andFrame: (CGRect) frame {
    
    UILabel * labelData = [[UILabel alloc] initWithFrame:frame];
    labelData.text = name;
    labelData.textColor = [UIColor hx_colorWithHexRGBAString:@"353535"];
    labelData.textAlignment = NSTextAlignmentLeft;
    labelData.font = [UIFont fontWithName:FONT_ISTOK_REGULAR size:16];
    return labelData;
}





@end
