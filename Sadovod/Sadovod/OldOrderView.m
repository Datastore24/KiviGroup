//
//  OldOrderView.m
//  Sadovod
//
//  Created by Виктор Мишустин on 29.09.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "OldOrderView.h"
#import "Macros.h"
#import "HexColors.h"

@implementation OldOrderView

- (instancetype)initWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 64, CGRectGetWidth(view.frame), 30);
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        UILabel * labelOldOrder = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 400, 30)];
        labelOldOrder.text = @"Это устаревший товар.";
        labelOldOrder.textColor = [UIColor blackColor];
        labelOldOrder.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
        [self addSubview:labelOldOrder];
        
        UIButton * buttonWhatThis = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonWhatThis.frame = CGRectMake(180, 0, 120, 30);
        [buttonWhatThis setTitle:@"Что это значит ?" forState:UIControlStateNormal];
        [buttonWhatThis setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        buttonWhatThis.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
        buttonWhatThis.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [buttonWhatThis addTarget:self action:@selector(buttonWhatThis) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonWhatThis];
        
        UIView * borderView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 20, CGRectGetWidth(buttonWhatThis.frame) - 5, 1)];
        borderView.backgroundColor = [UIColor blackColor];
        [buttonWhatThis addSubview:borderView];
        
    }
    return self;
}

- (void) buttonWhatThis {
    [self.delegate puthToFAQ:self];
}

@end
