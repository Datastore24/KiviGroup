//
//  DevelopersView.m
//  ITDolgopa
//
//  Created by Viktor on 05.03.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "DevelopersView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"

@implementation DevelopersView

- (instancetype)initWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        self.backgroundColor =[UIColor colorWithHexString:MAINBACKGROUNDCOLOR];
        
        UIImageView * imageDevelop = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - (self.frame.size.width + 64), self.frame.size.width, self.frame.size.width)];
        imageDevelop.image = [UIImage imageNamed:@"developImage.png"];
        [self addSubview:imageDevelop];
        
        UIButton * buttonCall = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonCall.frame = CGRectMake(20, 0, self.frame.size.width - 40, 40);
        CGPoint mainPoint = self.center;
        mainPoint.y = mainPoint.y - 80;
        buttonCall.center = mainPoint;
        buttonCall.layer.cornerRadius = 20.f;
        buttonCall.backgroundColor = [UIColor colorWithHexString:@"00a552"];
        [buttonCall setTitle:@"Тел: +7 (988) 503 52 28" forState:UIControlStateNormal];
        [buttonCall setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonCall.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:16];
        [buttonCall addTarget:self action:@selector(buttonCallAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonCall];
        
        UILabel * labelDevelop = [[UILabel alloc] initWithFrame:CGRectMake(30, 20, self.frame.size.width - 60, 100)];
        labelDevelop.numberOfLines = 0;
        labelDevelop.text = @"С командой  крутых разработчиков вы можете связаться по указанным контактам";
        labelDevelop.textColor = [UIColor whiteColor];
        labelDevelop.textAlignment = NSTextAlignmentCenter;
        labelDevelop.font = [UIFont fontWithName:FONTREGULAR size:16];
        [self addSubview:labelDevelop];

        
    }
    return self;
}

- (void) buttonCallAction
{
    NSLog(@"Дзынь дзынь на +7 (988) 503 52 28");
}

@end
