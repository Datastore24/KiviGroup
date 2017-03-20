//
//  ViewCellMyVacancies.m
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 06.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "ViewCellMyVacancies.h"
#import "HexColors.h"
#import "Macros.h"
#import <SDWebImage/UIImageView+WebCache.h> //Загрузка изображения

@interface ViewCellMyVacancies ()

@property (strong, nonatomic) NSMutableArray * arraySize;

@end


@implementation ViewCellMyVacancies

- (instancetype)initWithMainView: (UIView*) mainView endHeight: (CGFloat) height endImageName: (NSString*) imageUrl endName: (NSString*) name
                      endCountry: (NSString*) country endAge: (NSString*) age endIsReward: (BOOL) isReward endRewardNumber: (NSString*) rewardNumber
                       endIsLike: (BOOL) isLike endLikeNumber: (NSString*) likeNumber endIsBookmark: (BOOL) isBookmark endPhoneOne: (NSString*) phoneOne
                     endPhoneTwo: (NSString*) phoneTwo endEmail: (NSString*) email endProfileID: (NSString*) profileID
 {
    self = [super init];
    if (self) {
        
        self.arraySize = [NSMutableArray array];
        
        self.frame = CGRectMake(0.f, height, CGRectGetWidth(mainView.bounds), 235.f);
        
        UIView * shadowView = [[UIView alloc] initWithFrame:CGRectMake(13.f, 12.f, 84.f, 108.f)];
        shadowView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        shadowView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        [shadowView.layer setShadowOffset:CGSizeMake(0, 3)];
        [shadowView.layer setShadowOpacity:0.7];
        [shadowView.layer setShadowRadius:2.0f];
        [shadowView.layer setShouldRasterize:YES];
        [shadowView.layer setCornerRadius:5.0f];
        [self addSubview:shadowView];
        
        CustomButton * buttonImage = [self createCustomButtonWithFrame:CGRectMake(13.f, 12.f, 84.f, 108.f) endImageName:imageUrl andProfileID:profileID];
        [buttonImage addTarget:self action:@selector(actionButtonImage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonImage];
        
        
        
        
        NSArray * arrayText = [NSArray arrayWithObjects:name, country, age, nil];
        for (int i = 0; i < 3; i++) {
            UILabel * label = [self creationLabelWithFrame:CGRectMake(110.f, 12.f + 16.5f * i, 200, 16.5f) endText:[arrayText objectAtIndex:i]];
            [self.arraySize addObject:label];
            [self addSubview:label];
        }
        
        //Награды
        CustomButton * buttonReward = [self creationCustonButtonForChangeParamsWithFrame:CGRectMake(111.5f, 97.f, 13.f, 20.f) endParams:isReward
                                                                              endOnImage:@"isRewarImageOn" endOffImage:@"professionImageStar"];
        buttonReward.customID = profileID;
        [buttonReward addTarget:self action:@selector(actionButtonReward:) forControlEvents:UIControlEventTouchUpInside];
        [self.arraySize addObject:buttonReward];
        [self addSubview:buttonReward];
        
        self.numberRewar = [self creationLabelWithFrame:CGRectMake(135.f, 104.f, 20.f, 11.f) endText:rewardNumber];
        [self.arraySize addObject:self.numberRewar];
        [self addSubview:self.numberRewar];
        //
        
        //Лайки
        CustomButton * buttonLike = [self creationCustonButtonForChangeParamsWithFrame:CGRectMake(179.f, 104.5f, 15.f, 13.f) endParams:isLike
                                                                            endOnImage:@"isLikeImageOn" endOffImage:@"likeImage"];
        buttonLike.customID = profileID;
        [buttonLike addTarget:self action:@selector(actionButtonLike:) forControlEvents:UIControlEventTouchUpInside];
        [self.arraySize addObject:buttonLike];
        [self addSubview:buttonLike];
        
        self.numberLike = [self creationLabelWithFrame:CGRectMake(202.f, 104.f, 20.f, 11.f) endText:likeNumber];
        [self.arraySize addObject:self.numberLike];
        [self addSubview:self.numberLike];
        
        //Закладки
        CustomButton * buttonBookmark = [self creationCustonButtonForChangeParamsWithFrame:CGRectMake(289.f, 99.f, 19.f, 19.f) endParams:isBookmark
                                                    endOnImage:@"professionImageBookmarkOn"
                                                                    endOffImage:@"professionImageBookmark"];
        buttonBookmark.customID = profileID;
        [buttonBookmark addTarget:self action:@selector(actionButtonBookmark:) forControlEvents:UIControlEventTouchUpInside];
        [self.arraySize addObject:buttonBookmark];
        [self addSubview:buttonBookmark];
        
        //
        
        if(phoneOne.length != 0){
            UILabel * labelPhoneOne = [self creationLabelWithFrame:CGRectMake(13.f, 137.f, 78.f, 14.f) endText:@"Телефон 1"];
            [self addSubview: labelPhoneOne];
            
            CustomButton * buttonPhoneOne = [self createBlueCustonmButtonWithFrame:CGRectMake(158.f, 130.f, 154.5, 30) endName:phoneOne enfImage:@"phoneImageProf"];
            [buttonPhoneOne addTarget:self action:@selector(actionButtonPhoneOne:) forControlEvents:UIControlEventTouchUpInside];
            [self.arraySize addObject:buttonPhoneOne];
            [self addSubview:buttonPhoneOne];
        }
        NSLog(@"PHONE %ld",phoneTwo.length);
        if(phoneTwo.length != 0){
            UILabel * labelPhoneTwo = [self creationLabelWithFrame:CGRectMake(13.f, 137.f + 38.f, 78.f, 14.f) endText:@"Телефон 2"];
            [self addSubview: labelPhoneTwo];
            
            CustomButton * buttonPhoneTwo = [self createBlueCustonmButtonWithFrame:CGRectMake(158.f, 167.f, 154.5, 30) endName:phoneTwo enfImage:@"phoneImageProf"];
            [buttonPhoneTwo addTarget:self action:@selector(actionButtonPhoneTwo:) forControlEvents:UIControlEventTouchUpInside];
            [self.arraySize addObject:buttonPhoneTwo];
            [self addSubview:buttonPhoneTwo];
        }
       
        
        if(email.length !=0){
            UILabel * labelEmail = [self creationLabelWithFrame:CGRectMake(13.f, 206.f, 78.f, 14.f) endText:@"E-mail"];
            [self addSubview: labelEmail];
            
            CustomButton * buttonEmail = [CustomButton buttonWithType:UIButtonTypeSystem];
            buttonEmail.frame = CGRectMake(153, 208.f, 160, 13.f);
            [buttonEmail setTitle:email forState:UIControlStateNormal];
            [buttonEmail setTitleColor:[UIColor hx_colorWithHexRGBAString:@"353535"] forState:UIControlStateNormal];
            buttonEmail.titleLabel.font = [UIFont fontWithName:FONT_ISTOK_BOLD size:14];
            [buttonEmail setTitleEdgeInsets:UIEdgeInsetsMake(0, 25, 0, 0)];
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5.f, 0, 18.f, 13.f)];
            imageView.image = [UIImage imageNamed:@"mainImageProf"];
            [buttonEmail addSubview:imageView];
            [buttonEmail addTarget:self action:@selector(actionButtonEmail:) forControlEvents:UIControlEventTouchUpInside];
            [self.arraySize addObject:buttonEmail];
            [self addSubview:buttonEmail];
        }
        
        
        
        UIView * borderView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 234.f, CGRectGetWidth(mainView.bounds), 1)];
        borderView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"AEAEAE"];
        [self addSubview:borderView];
        
        if (isiPhone6) {
            for (UIView * view in self.arraySize) {
                CGRect rectView = view.frame;
                rectView.origin.x += 40;
                view.frame = rectView;
            }
        } else if (isiPhone6Plus) {
            for (UIView * view in self.arraySize) {
                CGRect rectView = view.frame;
                rectView.origin.x += 60;
                view.frame = rectView;
            }
        }
    }
    return self;
}

#pragma mark - Methods for Creation

- (CustomButton*) createCustomButtonWithFrame: (CGRect) frame endImageName: (NSString*) imageName
                                 andProfileID: (NSString *) profileID {
    
    CustomButton * button = [CustomButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    
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

- (void) actionButtonPhoneOne: (CustomButton*) sender {
    
    [self.delegate actionWith:self endButtonPhoneOne:sender];
}

- (void) actionButtonPhoneTwo: (CustomButton*) sender {
    
    [self.delegate actionWith:self endButtonPhoneTwo:sender];
}

- (void) actionButtonEmail: (CustomButton*) sender {
    
    [self.delegate actionWith:self endButtonEmail:sender];
}

@end
