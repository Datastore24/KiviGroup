//
//  GaleryView.m
//  Sadovod
//
//  Created by Виктор Мишустин on 23.09.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "GaleryView.h"
#import "StyledPageControl.h"
#import "HexColors.h"
#import "Macros.h"
#import "UIButton+ButtonImage.h"
#import "CustomLabels.h"
#import "UIView+BorderView.h"
#import <SDWebImage/UIImageView+WebCache.h> //Загрузка изображения
#import "CustomButton.h"
#import "SingleTone.h"

@interface GaleryView () <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView * scrollImage;
@property (strong, nonatomic) StyledPageControl * pageControl;

@end

@implementation GaleryView

- (instancetype)initWithView: (UIView*) view andData: (NSDictionary *) data
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 64.f, view.frame.size.width, view.frame.size.height - 64);
        NSArray * arrayImage = [data objectForKey:@"images"];
        UIView * mainView = [self createScrollImageWithArrayImage:arrayImage andMainView:self];
        [self addSubview:mainView];
        
        
        UIButton * buttonCancel = [UIButton createButtonCustomImageWithImage:@"imageCross.png" andRect:CGRectMake(15, 15, 20, 20)];
        [buttonCancel addTarget:self action:@selector(buttonCancelAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonCancel];
        
    }
    return self;
}


- (UIView*) createScrollImageWithArrayImage: (NSArray*) arrayImage
                                andMainView: (UIView*) mainView
{
    UIView * viewForScrollImage = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
    self.scrollImage = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, viewForScrollImage.frame.size.width, viewForScrollImage.frame.size.height)];
    self.scrollImage.pagingEnabled = YES;
    self.scrollImage.backgroundColor = [UIColor whiteColor];
    self.scrollImage.delegate = self;
    self.scrollImage.showsHorizontalScrollIndicator = NO;
    self.scrollImage.contentSize = CGSizeMake(viewForScrollImage.frame.size.width * arrayImage.count, 0.f);
    [viewForScrollImage addSubview:self.scrollImage];
    
    for (int i = 0; i < arrayImage.count; i++) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.scrollImage.frame.size.width * i, 0.f, self.scrollImage.frame.size.width, self.scrollImage.frame.size.height)];
        NSURL *imgURL = [NSURL URLWithString:[arrayImage objectAtIndex:i]];
        
        //SingleTone с ресайз изображения
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:imgURL
                              options:0
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 // progression tracking code
                             }
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                
                                if(image){
                                    
                                    
                                    [imageView setClipsToBounds:YES];
                                    
                                    imageView.contentMode = UIViewContentModeScaleAspectFit;
                                    imageView.clipsToBounds =YES;
                                    
                                    imageView.image = image;
                                    
                                    
                                    
                                }else{
                                    
                                }
                            }];
        
        
        
        
        [self.scrollImage addSubview:imageView];
    }
    
    //Инициализация pageControl-------------------------------------------
    self.pageControl = [[StyledPageControl alloc] init];
    self.pageControl.frame = CGRectMake(5.f, viewForScrollImage.frame.size.height - 20.f, 60.f, 20.f);
    [self.pageControl setPageControlStyle:PageControlStyleStrokedCircle];
    [self.pageControl setNumberOfPages:arrayImage.count];
    [self.pageControl setCurrentPage:0];
    [self.pageControl setDiameter:12];
    self.pageControl.strokeWidth = 1;
    [self.pageControl setCoreSelectedColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_800]];
    [self.pageControl setStrokeSelectedColor:[UIColor lightGrayColor ]];
    [self.pageControl setStrokeNormalColor:[UIColor lightGrayColor]];
    [viewForScrollImage addSubview:self.pageControl];
    
    return viewForScrollImage;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.scrollImage]) {
        CGFloat pageWidth = CGRectGetWidth(self.bounds);
        CGFloat pageFraction = self.scrollImage.contentOffset.x / pageWidth;
        self.pageControl.currentPage = roundf(pageFraction);
    }
}

- (void) buttonCancelAction {
    [self.delegate hideGaleryView:self];
}


@end
