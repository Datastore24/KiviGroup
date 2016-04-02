//
//  MainView.m
//  mykamchatka
//
//  Created by Viktor on 14.03.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "MainView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"

@implementation MainView

- (instancetype)initWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        
        //Основной фон----
        UIImageView * mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        mainImageView.image = [UIImage imageNamed:@"fon1_croped.jpg"];
        mainImageView.contentMode=UIViewContentModeScaleToFill;
        [self addSubview:mainImageView];
        
        //Первый лейбл----
        UILabel * myLoveLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, mainImageView.frame.size.width - 20, 20)];
        myLoveLabel.text = @"«МОЯ ЛЮБИМАЯ КАМЧАТКА -";
        myLoveLabel.textColor = [UIColor colorWithHexString:@"023d6e"];
        myLoveLabel.font = [UIFont fontWithName:FONTBOND size:14];
        if (isiPhone5) {
        myLoveLabel.frame = CGRectMake(20, 10, mainImageView.frame.size.width - 40, 16);
        myLoveLabel.font = [UIFont fontWithName:FONTBOND size:16];
        myLoveLabel.textAlignment = NSTextAlignmentCenter;
        }
        [mainImageView addSubview:myLoveLabel];
        
        //Первый лейбл----
        UILabel * firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 220, mainImageView.frame.size.width - 20, 20)];
        firstLabel.text = @"ПРИГЛАШЕНИЕ К ПУТЕШЕСТВИЮ»";
        firstLabel.textColor = [UIColor colorWithHexString:@"023d6e"];
        firstLabel.font = [UIFont fontWithName:FONTBOND size:14];
        if (isiPhone5) {
            firstLabel.frame = CGRectMake(20, 10, mainImageView.frame.size.width - 40, 16);
            firstLabel.font = [UIFont fontWithName:FONTBOND size:16];
            firstLabel.textAlignment = NSTextAlignmentCenter;
        }
        [mainImageView addSubview:firstLabel];
        
        //Второй лейбл-----
        UILabel * secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100 + firstLabel.frame.size.height + 25, mainImageView.frame.size.width - 40, 240)];
        secondLabel.numberOfLines = 0;
        secondLabel.text = @"Автор проекта -\n          депутат Государственной Думы Ирина Яровая";
        secondLabel.textColor = [UIColor colorWithHexString:@"023d6e"];
        secondLabel.font = [UIFont fontWithName:FONTREGULAR size:14];
        if (isiPhone5) {
        secondLabel.font = [UIFont fontWithName:FONTREGULAR size:15];
        secondLabel.frame = CGRectMake(20, 10 + firstLabel.frame.size.height + 25, mainImageView.frame.size.width - 40, 170);
        }
        [mainImageView addSubview:secondLabel];
        
        //Фотография яровой----
        UIImageView * yarovayaImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 290, 150, 169)];
        yarovayaImageView.image = [UIImage imageNamed:@"yar.png"];
        yarovayaImageView.contentMode=UIViewContentModeScaleToFill;
        [mainImageView addSubview:yarovayaImageView];
        
        
        //Третий лейбл
        UILabel * thirdLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 280, mainImageView.frame.size.width - 40, 200)];
        thirdLabel.numberOfLines = 0;
        thirdLabel.text = @"УЧАСТВУЙ \nВ ФОТОКОНКУРСЕ\nс 31 марта по 18 мая";
        thirdLabel.textColor = [UIColor colorWithHexString:@"023d6e"];
        thirdLabel.font = [UIFont fontWithName:FONTREGULAR size:20];
        if (isiPhone5) {
        thirdLabel.font = [UIFont fontWithName:FONTREGULAR size:15];
        thirdLabel.frame = CGRectMake(20, secondLabel.frame.origin.y + 170,
                                      mainImageView.frame.size.width - 40, 150);
        }
        [mainImageView addSubview:thirdLabel];
        
        //Третий лейбл
        UILabel * seasonLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 400, mainImageView.frame.size.width - 40, 200)];
        seasonLabel.numberOfLines = 0;
        seasonLabel.text = @"Победители будут определны \nпо четырем номинациям:";
        seasonLabel.textColor = [UIColor colorWithHexString:@"366c7b"];
        seasonLabel.font = [UIFont fontWithName:FONTREGULAR size:20];
        if (isiPhone5) {
            seasonLabel.font = [UIFont fontWithName:FONTREGULAR size:15];
            seasonLabel.frame = CGRectMake(20, secondLabel.frame.origin.y + 170,
                                          mainImageView.frame.size.width - 40, 150);
        }
        [mainImageView addSubview:seasonLabel];
        
        //Фотография сезонов----
        UIImageView * seasonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 520, mainImageView.frame.size.width - 20, 61)];
        seasonImageView.image = [UIImage imageNamed:@"season.png"];
        seasonImageView.contentMode=UIViewContentModeScaleToFill;
        [mainImageView addSubview:seasonImageView];
        
//        //Автор проекта
//        UILabel * authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, mainImageView.frame.size.height - 130, mainImageView.frame.size.width - 40, 40)];
//        authorLabel.numberOfLines = 0;
//        authorLabel.text = @"Автор проекта -  \nдепутат государственной думмы Ирина Яровая";
//        authorLabel.textColor = [UIColor whiteColor];
//        authorLabel.font = [UIFont fontWithName:FONTBOND size:14];
//        if (isiPhone5) {
//        authorLabel.font = [UIFont fontWithName:FONTBOND size:11];
//        authorLabel.frame = CGRectMake(20, mainImageView.frame.size.height - 110, mainImageView.frame.size.width - 40, 40);
//        }
//        [mainImageView addSubview:authorLabel];
        
        
    }
    return self;
}

@end
