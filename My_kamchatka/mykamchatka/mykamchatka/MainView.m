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
        UILabel * firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, mainImageView.frame.size.width - 20, 20)];
        firstLabel.text = @"Вашу фотографию заметят!";
        firstLabel.textColor = [UIColor whiteColor];
        firstLabel.font = [UIFont fontWithName:FONTBOND size:22];
        if (isiPhone5) {
        firstLabel.frame = CGRectMake(20, 10, mainImageView.frame.size.width - 40, 16);
        firstLabel.font = [UIFont fontWithName:FONTBOND size:16];
        firstLabel.textAlignment = NSTextAlignmentCenter;
        }
        [mainImageView addSubview:firstLabel];
        
        //Второй лейбл-----
        UILabel * secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 30 + firstLabel.frame.size.height + 25, mainImageView.frame.size.width - 40, 240)];
        secondLabel.numberOfLines = 0;
        secondLabel.text = @"По итогам фотоконкурса будут выявлены победители и призеры, работы которых будут размещены в бортовом журнале и на экранах в салонах воздушных судов авиакомпании \"Аэрофлот-Российские Авиалинии\", а также представлены на фотовыставках в Москве и Петропавловске-Камчатском.";
        secondLabel.textColor = [UIColor whiteColor];
        secondLabel.font = [UIFont fontWithName:FONTREGULAR size:20];
        if (isiPhone5) {
        secondLabel.font = [UIFont fontWithName:FONTREGULAR size:15];
        secondLabel.frame = CGRectMake(20, 10 + firstLabel.frame.size.height + 25, mainImageView.frame.size.width - 40, 170);
        }
        [mainImageView addSubview:secondLabel];
        
        
        //Третий лейбл
        UILabel * thirdLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, secondLabel.frame.size.height + 100, mainImageView.frame.size.width - 40, 200)];
        thirdLabel.numberOfLines = 0;
        thirdLabel.text = @"Для победителей и призеров подготовлены познавательные призы и памятные подарки, а профессиональные фотографы - члены жюри фотоконкурса проведут мастер-классы.";
        thirdLabel.textColor = [UIColor whiteColor];
        thirdLabel.font = [UIFont fontWithName:FONTREGULAR size:20];
        if (isiPhone5) {
        thirdLabel.font = [UIFont fontWithName:FONTREGULAR size:15];
        thirdLabel.frame = CGRectMake(20, secondLabel.frame.origin.y + 170,
                                      mainImageView.frame.size.width - 40, 150);
        }
        [mainImageView addSubview:thirdLabel];
        
        //Автор проекта
        UILabel * authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, mainImageView.frame.size.height - 130, mainImageView.frame.size.width - 40, 40)];
        authorLabel.numberOfLines = 0;
        authorLabel.text = @"Автор проекта -  \nдепутат государственной думмы Ирина Яровая";
        authorLabel.textColor = [UIColor whiteColor];
        authorLabel.font = [UIFont fontWithName:FONTBOND size:15];
        if (isiPhone5) {
        authorLabel.font = [UIFont fontWithName:FONTBOND size:11];
        authorLabel.frame = CGRectMake(20, mainImageView.frame.size.height - 110, mainImageView.frame.size.width - 40, 40);
        }
        [mainImageView addSubview:authorLabel];
        
        
    }
    return self;
}

@end
