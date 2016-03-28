//
//  GallaryDetailsView.m
//  mykamchatka
//
//  Created by Viktor on 24.03.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "GallaryDetailsView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "ViewSectionTable.h"

@implementation GallaryDetailsView

- (instancetype)initBackgroundWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        
        //Создаем фон из двух частей фонофого затемнения и изображения--------------------
        UIView * secondView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
        secondView.backgroundColor = [UIColor colorWithHexString:@"eceff3"];
        [self addSubview:secondView];
        UIImageView * mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
        mainImageView.image = [UIImage imageNamed:@"JuriFon.jpeg"];
        mainImageView.alpha = 0.25f;
        [secondView addSubview:mainImageView];

    }
    return self;
}

- (instancetype)initImageWithView: (UIView*) view andDict: (NSDictionary*) dict
{
    self = [super init];
    if (self) {
        //Создаем изображения-------------------------------------------------------------
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        
        //Полноэкранное изображение-------
        NSLog(@"%@",[dict objectForKey:@"image_fulltext"]);
        UIImageView * imageView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, view.frame.size.width, view.frame.size.height/2)];
         imageView.layer.masksToBounds = YES;
        
        ViewSectionTable * imageGallary = [[ViewSectionTable alloc] initSharesWithImageURL:[dict objectForKey:@"image_fulltext"] andView:imageView andContentMode:UIViewContentModeScaleAspectFill];
        
        [imageView addSubview:imageGallary];
        
        [self addSubview:imageView];
        
        //Вью для коменнтариев-------------
        UIView * viewComments = [[UIView alloc] initWithFrame:CGRectMake(20 + 5, 20 + 45 + imageGallary.frame.size.height, imageGallary.frame.size.width, 80)];
        viewComments.backgroundColor = [UIColor blackColor];
        viewComments.alpha = 0.9f;
        [self addSubview:viewComments];
        
        //Лейбл комментария--------------
        UILabel * labelComment = [[UILabel alloc] initWithFrame:CGRectMake(40, 15, viewComments.frame.size.width - 20, 20)];
        labelComment.text = [dict objectForKey:@"title"];
        labelComment.textColor = [UIColor whiteColor];
        labelComment.font = [UIFont fontWithName:FONTLITE size:14];
        [viewComments addSubview:labelComment];
        
        //Лейбл Имени и Возраста--------
        UILabel * labelNameAndAge = [[UILabel alloc] initWithFrame:CGRectMake(40, 45, viewComments.frame.size.width - 20, 20)];
        labelNameAndAge.text = [dict objectForKey:@"introtext"];
        labelNameAndAge.textColor = [UIColor whiteColor];
        labelNameAndAge.font = [UIFont fontWithName:FONTLITE size:16];
        [viewComments addSubview:labelNameAndAge];
        

    }
    return self;
}


@end
