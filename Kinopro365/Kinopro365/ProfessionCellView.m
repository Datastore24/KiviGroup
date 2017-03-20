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
                                 andLikeNumber: (NSString*) likeNumber andProfileID: (NSString *) profileID
                                andIsFavourite: (NSString *) isFavourite endReward: (BOOL) isReward
                                       endLike: (BOOL) isLike {
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(orgnX, height, CGRectGetWidth(view.bounds), 125.f);
        
        UIView * upBorderView = [UIView createGrayBorderViewWithView:self andHeight:125.f endType:YES];
        [self addSubview:upBorderView];
        
        UIView * viewShadow = [[UIView alloc] initWithFrame:CGRectMake(13.f, 5.f, 75.f, 114.f)];
        viewShadow.backgroundColor = [UIColor groupTableViewBackgroundColor];
        viewShadow.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        [viewShadow.layer setShadowOffset:CGSizeMake(0, 3)];
        [viewShadow.layer setShadowOpacity:0.7];
        [viewShadow.layer setShadowRadius:2.0f];
        [viewShadow.layer setShouldRasterize:YES];
        
        [viewShadow.layer setCornerRadius:5.0f];
        
        [self addSubview:viewShadow];
        
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
        
        
        
        CustomButton * buttonCell = [CustomButton buttonWithType:UIButtonTypeCustom];
        buttonCell.frame = self.bounds;
        buttonCell.customFullName = name;
        buttonCell.customID = profileID;
        
        [buttonCell addTarget:self action:@selector(actionButtonCell:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonCell];
        
        CustomButton * buttonRewar = [CustomButton buttonWithType:UIButtonTypeCustom];
        buttonRewar.frame = CGRectMake(113.f, 97.f, 13.f, 20.f);
        NSString * imageReward;
        if (isReward) {
            imageReward = @"isRewarImageOn";
        } else {
            imageReward = @"professionImageStar";
        }
        [buttonRewar setImage:[UIImage imageNamed:imageReward] forState:UIControlStateNormal];
        [buttonRewar addTarget:self action:@selector(actionButtonReward:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonRewar];
        

        self.labelNumberStars = [self createLabelWithName:starsNumber andFrame:CGRectMake(134.f, 102.f, 20.f, 12.f)];
        [self addSubview:self.labelNumberStars];
        
        CustomButton * buttonLike = [CustomButton buttonWithType:UIButtonTypeCustom];
        buttonLike.frame = CGRectMake(179.f, 102.f, 15.f, 13.f);
        NSString * imageLike;
        if (isLike) {
            imageLike = @"isLikeImageOn";
        } else {
            imageLike = @"professionImageLike";
        }
        [buttonLike setImage:[UIImage imageNamed:imageLike] forState:UIControlStateNormal];
        [buttonLike addTarget:self action:@selector(actionButtonLike:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonLike];
        
        self.labelNumberLike = [self createLabelWithName:likeNumber andFrame:CGRectMake(202.f, 102.f, 20.f, 12.f)];
        [self addSubview:self.labelNumberLike];
        
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
        
        
        for (UILabel * label in self.subviews) {
            if (isiPhone6) {
                if ([label isKindOfClass:[UILabel class]] || ([label isKindOfClass:[CustomButton class]] && ![label isEqual:buttonCell])) {
                    CGRect rectLabel = label.frame;
                    rectLabel.origin.x += 20;
                    label.frame = rectLabel;
                }
            }
        }

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

- (void) actionButtonReward: (CustomButton*) sender {
    [self.deleagte actionReward:self withButton:sender];
    
}

- (void) actionButtonLike: (CustomButton*) sender {
    [self.deleagte actionLike:self withButton:sender];
    
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
