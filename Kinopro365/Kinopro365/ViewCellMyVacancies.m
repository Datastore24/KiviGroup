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

@implementation ViewCellMyVacancies

- (instancetype)initWithMainView: (UIView*) mainView endHeight: (CGFloat) height endImageName: (NSString*) imageUrl endName: (NSString*) name
                      endCountry: (NSString*) country endAge: (NSString*) age endIsReward: (BOOL) isReward endRewardNumber: (NSString*) rewardNumber
                       endIsLike: (BOOL) isLike endLikeNumber: (NSString*) likeNumber endIsBookmark: (BOOL) isBookmark endPhoneOne: (NSString*) phoneOne
                     endPhoneTwo: (NSString*) phoneTwo endEmail: (NSString*) email
 {
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0.f, height, CGRectGetWidth(mainView.bounds), 235.f);
        
        CustomButton * buttonImage = [self createCustomButtonWithFrame:CGRectMake(13.f, 12.f, 84.f, 108.f) endImageName:imageUrl];
        [buttonImage addTarget:self action:@selector(actionButtonImage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonImage];
        
        NSArray * arrayText = [NSArray arrayWithObjects:name, country, age, nil];
        for (int i = 0; i < 3; i++) {
            UILabel * label = [self creationLabelWithFrame:CGRectMake(110.f, 12.f + 16.5f * i, 200, 16.5f) endText:[arrayText objectAtIndex:i]];
            [self addSubview:label];
        }
        
        CustomButton * buttonReward = [self creationCustonButtonForChangeParamsWithFrame:CGRectMake(111.5f, 97.f, 13.f, 20.f) endParams:isReward
                                                                              endOnImage:@"isRewarImageOn" endOffImage:@"professionImageStar"];
        if (buttonReward.isBool) {
            buttonReward.userInteractionEnabled = NO;
        }
        [buttonReward addTarget:self action:@selector(actionButtonReward:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonReward];
        
        self.numberRewar = [self creationLabelWithFrame:CGRectMake(135.f, 104.f, 20.f, 11.f) endText:rewardNumber];
        [self addSubview:self.numberRewar];

        
        CustomButton * buttonLike = [self creationCustonButtonForChangeParamsWithFrame:CGRectMake(179.f, 104.5f, 15.f, 13.f) endParams:isReward
                                                                            endOnImage:@"isLikeImageOn" endOffImage:@"likeImage"];
        if (buttonLike.isBool) {
            buttonLike.userInteractionEnabled = NO;
        }
        [buttonLike addTarget:self action:@selector(actionButtonLike:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonLike];
        
        self.numberLike = [self creationLabelWithFrame:CGRectMake(202.f, 104.f, 20.f, 11.f) endText:likeNumber];
        [self addSubview:self.numberLike];
        
        CustomButton * buttonBookmark = [self creationCustonButtonForChangeParamsWithFrame:CGRectMake(289.f, 99.f, 19.f, 19.f) endParams:isReward
                                                                                endOnImage:@"professionImageBookmarkOn" endOffImage:@"professionImageBookmark"];
        [buttonBookmark addTarget:self action:@selector(actionButtonBookmark:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonBookmark];
        
        NSArray * arrayNamePhone = [NSArray arrayWithObjects:@"Телефон 1", @"Телефон 2", nil];
        for (int i = 0; i < 2; i++) {
            UILabel * label = [self creationLabelWithFrame:CGRectMake(13.f, 137.f + 38.f * i, 78.f, 14.f) endText:[arrayNamePhone objectAtIndex:i]];
            [self addSubview: label];
        }
        
        UILabel * labelEmail = [self creationLabelWithFrame:CGRectMake(13.f, 206.f, 78.f, 14.f) endText:@"E-mail"];
        [self addSubview: labelEmail];
        
        CustomButton * buttonPhoneOne = [self createBlueCustonmButtonWithFrame:CGRectMake(158.f, 130.f, 154.5, 30) endName:phoneOne enfImage:@"phoneImageProf"];
        [buttonPhoneOne addTarget:self action:@selector(actionButtonPhoneOne:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonPhoneOne];
        
        CustomButton * buttonPhoneTwo = [self createBlueCustonmButtonWithFrame:CGRectMake(158.f, 167.f, 154.5, 30) endName:phoneTwo enfImage:@"phoneImageProf"];
        [buttonPhoneTwo addTarget:self action:@selector(actionButtonPhoneTwo:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonPhoneTwo];
        
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
        [self addSubview:buttonEmail];
        
        UIView * borderView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 234.f, CGRectGetWidth(mainView.bounds), 1)];
        borderView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"AEAEAE"];
        [self addSubview:borderView];
        
    }
    return self;
}

#pragma mark - Methods for Creation

- (CustomButton*) createCustomButtonWithFrame: (CGRect) frame endImageName: (NSString*) imageName {
    
    CustomButton * button = [CustomButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
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
