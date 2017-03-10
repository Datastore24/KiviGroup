//
//  ViewForScroll.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 13.02.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "ViewForScroll.h"
#import "UIView+BorderView.h"
#import "HexColors.h"
#import "Macros.h"

@implementation ViewForScroll

- (instancetype)initWithCustonView: (UIView*) view andRect: (CGRect) frame andCountScrolls: (NSInteger) countScrolls
{
    self = [super init];
    if (self) {
        self.frame = frame;
        
        self.arayButtons = [NSMutableArray array];

        
        NSInteger sizeButton = (CGRectGetWidth(self.bounds) - (46.f + 46.f)) / 3;
        
        for (int i = 0; i < countScrolls; i++) {
            
            NSString * stringForButton = [NSString stringWithFormat:@"%d - %d", 50 * i, 50 * (i + 1)];
            
            UIButton * buttonLeblCount = [UIButton buttonWithType:UIButtonTypeSystem];
            buttonLeblCount.frame = CGRectMake(46.f + sizeButton + sizeButton * i, 0.f, sizeButton, self.bounds.size.height);
            [buttonLeblCount setTitle:stringForButton forState:UIControlStateNormal];
            [buttonLeblCount setTitleColor:[UIColor hx_colorWithHexRGBAString:@"5683AA"] forState:UIControlStateNormal];
            if (i == 0) {
                buttonLeblCount.titleLabel.font = [UIFont fontWithName:FONT_ISTOK_BOLD size:18];
                buttonLeblCount.userInteractionEnabled = NO;
            } else {
                buttonLeblCount.titleLabel.font = [UIFont fontWithName:FONT_ISTOK_REGULAR size:16];
            }
            buttonLeblCount.tag = 10 + i;
            [buttonLeblCount addTarget:self action:@selector(actionButtonLeblCount:)
                                            forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:buttonLeblCount];
            [self.arayButtons addObject:buttonLeblCount];
        }
        
        UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 46.f, CGRectGetHeight(self.bounds))];
        leftView.backgroundColor = [UIColor whiteColor];
        [self addSubview:leftView];
        
        UIButton * buttonLeft = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonLeft.frame = CGRectMake(12.f, 12.f, 22.f, 22.f);
        [buttonLeft setImage:[UIImage imageNamed:@"buttonProfLeft"] forState:UIControlStateNormal];
        [buttonLeft addTarget:self action:@selector(actionButtonLeft:) forControlEvents:UIControlEventTouchUpInside];
        [leftView addSubview:buttonLeft];
        
        UIView * rightView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bounds) - 46, 0.f, 46.f,
                                                                      CGRectGetHeight(self.bounds))];
        rightView.backgroundColor = [UIColor whiteColor];
        [self addSubview:rightView];
        
        UIButton * buttonRight = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonRight.frame = CGRectMake(12.f, 12.f, 22.f, 22.f);
        [buttonRight setImage:[UIImage imageNamed:@"buttonProfRight"] forState:UIControlStateNormal];
        [buttonRight addTarget:self action:@selector(actionbuttonRight:) forControlEvents:UIControlEventTouchUpInside];
        [rightView addSubview:buttonRight];
        
        UIView * borderView = [UIView createGrayBorderViewWithView:self andHeight:0];
        [self addSubview:borderView];
        
    }
    return self;
}

#pragma mark - Actions

- (void) actionButtonLeft: (UIButton*) sender {
    
    [self.delegate actionMoveLeftWithView:self andButton:sender andArrayButtons:self.arayButtons];
}

- (void) actionbuttonRight: (UIButton*) sender {
    
    [self.delegate actionMoveRightWithView:self andButton:sender andArrayButtons:self.arayButtons];
}

- (void) actionButtonLeblCount: (UIButton*) sender {
   
    [self.delegate actionButtonLablCount:self andButton:sender];
}

@end
