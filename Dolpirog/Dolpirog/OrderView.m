//
//  OrderView.m
//  Dolpirog
//
//  Created by Виктор Мишустин on 18/07/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "OrderView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "StyledPageControl.h"
#import "CustomLabels.h"

@interface OrderView () <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView * mainScrollView;
@property (strong, nonatomic) UIScrollView * scrollImages;
@property (strong, nonatomic) StyledPageControl * pageControl;

@end

@implementation OrderView

- (instancetype)initWithView: (UIView*) view
                     andDate: (NSArray*) arrayDate
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, view.frame.size.width, view.frame.size.height - 64)];
        [self addSubview:_mainScrollView];
        
#pragma mark - ScrollImage
        //Скрол для пролистывания картинок--------------------------
        _scrollImages = [[UIScrollView alloc] initWithFrame:CGRectMake(30, 30, self.frame.size.width - 60, 263)];
        [_scrollImages setDelegate:self];
        [_scrollImages setPagingEnabled:YES];
        [_scrollImages setContentSize:CGSizeMake((self.frame.size.width- 60) * 3, 0)]; // задаем количество слайдов
        _scrollImages.showsHorizontalScrollIndicator = NO;
        _scrollImages.showsVerticalScrollIndicator = NO;
        [_scrollImages setBackgroundColor:[UIColor whiteColor]]; // цвет фона скролвью
        [_mainScrollView addSubview:_scrollImages];
        
        //Инициализация pageControl-------------------------------------------
        _pageControl = [[StyledPageControl alloc] init];
        _pageControl.frame = CGRectMake((self.frame.size.width / 2) - 60, _scrollImages.frame.size.height + 5, 120, 20);
        [_pageControl setPageControlStyle:PageControlStyleStrokedCircle];
        [_pageControl setNumberOfPages:3];
        [_pageControl setCurrentPage:0];
        [_pageControl setDiameter:15];
        [_pageControl setCoreSelectedColor:[UIColor colorWithHexString:@"fee682"]];
        [_pageControl setStrokeSelectedColor:[UIColor colorWithHexString:@"fee682"]];
        [_pageControl setStrokeNormalColor:[UIColor colorWithHexString:@"fee682"]];
        [_mainScrollView addSubview:_pageControl];
        
        UIImageView * view1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width - 60, 263)];
        view1.image = [UIImage imageNamed:@"imageOrder1.png"];
        [_scrollImages addSubview:view1];
        
        UIImageView * view2 = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 60, 0,
                                                                            self.frame.size.width - 60,
                                                                            263)];
        view2.image = [UIImage imageNamed:@"imageCakeTwo.png"];
        [_scrollImages addSubview:view2];
        
        UIImageView * view3 = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 60) * 2, 0,
                                                                            self.frame.size.width - 60,
                                                                            263)];
        view3.image = [UIImage imageNamed:@"imageCakeThree.jpg"];;
        [_scrollImages addSubview:view3];
        
#pragma mark - Other View
        //Заголовок--------------------------------------------------
        CustomLabels * labelTitle = [[CustomLabels alloc] initLabelBondWithWidht:30
                                                                       andHeight:_scrollImages.frame.origin.y + _scrollImages.frame.size.height + 10
                                                                        andColor:COLORBROWN
                                                                         andText:@"Пирог с “капустой тушеной”"
                                                                     andTextSize: 16];
        [_mainScrollView addSubview:labelTitle];
        
        //Описательный текст----------------------------------------
        CustomLabels * textLabel = [[CustomLabels alloc] initLabelTableWithWidht:30
                                                                       andHeight:labelTitle.frame.origin.y + labelTitle.frame.size.height + 10
                                                                    andSizeWidht:_mainScrollView.frame.size.width - 60
                                                                   andSizeHeight:40
                                                                        andColor:@"000000"
                                                                         andText:@"Полностью раскрыть свои вкусовые качества капуста может именно в осетинском пироге. Посыпанная ароматными специями начинка пирога поразит своими вкусовыми качествами и позволит утолить голод."];
        textLabel.numberOfLines = 0;
        textLabel.font = [UIFont fontWithName:FONTREGULAR size:16];
        textLabel.textAlignment = NSTextAlignmentLeft;
        [textLabel sizeToFit];
        [_mainScrollView addSubview:textLabel];
        
        //Вью разделения----------------------------------------------
        UIView * borderView = [[UIView alloc] initWithFrame:CGRectMake(30, textLabel.frame.origin.y + textLabel.frame.size.height + 10, _mainScrollView.frame.size.width - 60, 0.5)];
        borderView.backgroundColor = [UIColor colorWithHexString:@"c0c0c0"];
        [_mainScrollView addSubview:borderView];
        
        //Состав заголовок------------------------------------------
        CustomLabels * labelTitleComposition = [[CustomLabels alloc] initLabelRegularWithWidht:30
                                                                       andHeight:borderView.frame.origin.y + 10
                                                                        andColor:COLORBROWN
                                                                         andText:@"Состав пирога:"
                                                                     andTextSize: 16];
        [_mainScrollView addSubview:labelTitleComposition];
        
        //Состав основной текст-------------------------------------
        CustomLabels * textLabelComposition = [[CustomLabels alloc] initLabelTableWithWidht:30
                                                                       andHeight:labelTitleComposition.frame.origin.y + labelTitleComposition.frame.size.height + 10
                                                                    andSizeWidht:_mainScrollView.frame.size.width - 60
                                                                   andSizeHeight:40
                                                                        andColor:@"898988"
                                                                         andText:@"Лук жаренный, Сливочное масло, Капуста, Осетинский сыр."];
        textLabelComposition.numberOfLines = 0;
        textLabelComposition.font = [UIFont fontWithName:FONTREGULAR size:16];
        textLabelComposition.textAlignment = NSTextAlignmentLeft;
        [textLabelComposition sizeToFit];
        [_mainScrollView addSubview:textLabelComposition];
        
#pragma mark - Change objects
        
        //Базовый вью элемнт для управления колличеством товара----
        UIView * mainViewCountOrder = [[UIView alloc] initWithFrame:CGRectMake(30, textLabelComposition.frame.origin.y + textLabelComposition.frame.size.height + 10, 150, 35)];
        mainViewCountOrder.layer.borderColor = [UIColor colorWithHexString:COLORBROWN].CGColor;
        mainViewCountOrder.layer.borderWidth = 2.f;
        mainViewCountOrder.layer.cornerRadius = 6;
        [_mainScrollView addSubview:mainViewCountOrder];
        
        
        
    }
    return self;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
        if ([scrollView isEqual:_scrollImages]) {
            CGFloat pageWidth = CGRectGetWidth(self.bounds);
            CGFloat pageFraction = _scrollImages.contentOffset.x / pageWidth;
            _pageControl.currentPage = roundf(pageFraction);
        }
}

@end
