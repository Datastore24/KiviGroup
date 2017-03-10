//
//  CastingDetailsController.m
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 07.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "CastingDetailsController.h"
#import "ViewForCastingParams.h"

@interface CastingDetailsController ()

@property (assign, nonatomic) CGFloat starHeightViewForParams;
@property (assign, nonatomic) CGFloat heightForAnimation;
@property (assign, nonatomic) CGFloat heightHide;

@end

@implementation CastingDetailsController

- (void) loadView {
    [super loadView];
    
    UILabel * CustomText = [[UILabel alloc]initWithTitle:@"Телесериал"];
    self.navigationItem.titleView = CustomText;
    
    self.viewForShare.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.viewForShare.layer.shadowOffset = CGSizeMake(0.0f, -1.0f);
    self.viewForShare.layer.shadowOpacity = 1.0f;
    self.viewForShare.layer.shadowRadius = 4.0f;
    
    self.starHeightViewForParams = CGRectGetHeight(self.viewForParams.bounds);

    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
//    //Скрытие скрытых парамтеров--------------------------
//    self.heightHide = self.viewForHide.frame.size.height;
//    CGRect rectForHide = self.viewForHide.frame;
//    rectForHide.size.height = 0;
//    self.viewForHide.frame = rectForHide;
//    [self animationWithHeigthAnimathion:self.heightHide endType:2];
    
    
    //Обновление окна параметров
    for (UIView * view in self.viewForParams.subviews) {
        [view removeFromSuperview];
    }
    CGRect rect = self.viewForParams.frame;
    rect.size.height = self.starHeightViewForParams;
    self.viewForParams.frame = rect;
    
    
    NSArray * arrayString = [NSArray arrayWithObjects:
                             @"Город: Москва", @"Требуется: Актер",
                             @"Пол: Жен", @"Возраст: от 25 до 30",
                             @"Рост: 145 - 160", nil];
    
    for (int i = 0; i < arrayString.count; i++) {
        ViewForCastingParams * view = [[ViewForCastingParams alloc] initWithMainView:self.viewForParams endHeight:0 + 16 * i endText:[arrayString objectAtIndex:i]];
        [self.viewForParams addSubview:view];
    }
    CGRect newRect = self.viewForParams.frame;
    newRect.size.height = 20 + 16 * arrayString.count;
    self.viewForParams.frame = newRect;
    
    self.heightForAnimation = self.viewForParams.frame.size.height - self.starHeightViewForParams;
    
    [self animationWithHeigthAnimathion:self.heightForAnimation endType:1];
    self.mainScrollView.contentSize = CGSizeMake(0, self.view.bounds.size.height + self.heightForAnimation - 64 - self.heightHide);

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)actionBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionButtonVK:(id)sender {
    
    NSLog(@"Поделиться в контакте");
    
}

- (IBAction)actionButtonFacebook:(id)sender {
    
    NSLog(@"Поделиться в фэйсбук");
}

- (IBAction)actionButtonAddBit:(id)sender {
    NSLog(@"Подать заявку");
}

#pragma mark - Other

- (CGFloat)getLabelHeight:(UILabel*)label
{
    CGSize constraint = CGSizeMake(label.frame.size.width, CGFLOAT_MAX);
    CGSize size;
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [label.text boundingRectWithSize:constraint
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:label.font}
                                                  context:context].size;
    
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    
    return size.height;
}

#pragma mark - Animathion

- (void) animationWithHeigthAnimathion: (CGFloat) heightAnimation endType: (NSInteger) type {
    
    for (int i = 0; i < self.arrayViews.count; i++) {
        UIView * view = [self.arrayViews objectAtIndex:i];
        
        if (type == 1) {
            if (i == 1 || i == 2) {
               CGRect rectView = view.frame;
                rectView.origin.y = rectView.origin.y + heightAnimation - self.heightHide;
               view.frame = rectView;
            }
        } if (type == 2) {
            if (i == 0 || i == 3) {
                CGRect rectView = view.frame;
                rectView.origin.y -= heightAnimation;
                view.frame = rectView;
            }
        }
    }
}




@end
