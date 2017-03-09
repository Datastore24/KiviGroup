//
//  MyCustingDetailsController.m
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 08.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "MyCustingDetailsController.h"
#import "ViewCellMyCasting.h"


@interface MyCustingDetailsController () <ViewCellMyCastingDelegate>

@property (strong, nonatomic) UIScrollView * firstScrollView;
@property (strong, nonatomic) UIScrollView * secondScrollView;
@property (assign, nonatomic) CGFloat heightTextView;

@end

@implementation MyCustingDetailsController

- (void) loadView {
    [super loadView];
    
    UILabel * CustomText = [[UILabel alloc]initWithTitle:@"Кастинги"];
    self.navigationItem.titleView = CustomText;
    
    self.mainScrollView.scrollEnabled = NO;
    self.mainScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.mainScrollView.bounds) * 2, 0);
    self.firstScrollView = [[UIScrollView alloc] initWithFrame:self.mainScrollView.bounds];
    [self.mainScrollView addSubview:self.firstScrollView];
    self.secondScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.mainScrollView.bounds), 0, CGRectGetWidth(self.mainScrollView.bounds), CGRectGetHeight(self.mainScrollView.bounds))];
    [self.mainScrollView addSubview:self.secondScrollView];
    
    self.heightTextView = self.mainTextView.frame.origin.y;
    self.viewForLabel.layer.cornerRadius = CGRectGetHeight(self.viewForLabel.bounds) / 2;
    self.buttonTextAdd.isBool = YES;
    
    self.buttonConsideration.userInteractionEnabled = NO;
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    //На рассмотрение
    for (int i = 0; i < 5; i++) {
        ViewCellMyCasting * cell = [[ViewCellMyCasting alloc] initWithMainView:self.firstScrollView endHeight:130.f * i endImageName:@"testImageVacancies.png" endName:@"Анастасия Филатова" endCountry:@"Москва (Рoссия)" endAge:@"25 лет" endIsReward:NO endRewardNumber:@"5" endIsLike:NO endLikeNumber:@"15" endIsBookmark:NO endProfileID:nil enfGrowth:@"рост: 168 см" endApproved: NO];
        cell.delegate = self;
        [self.firstScrollView addSubview:cell];
    }
    self.firstScrollView.contentSize = CGSizeMake(0, 130.f * 5);
    
    //Одобренные
    for (int i = 0; i < 3; i++) {
        ViewCellMyCasting * cell = [[ViewCellMyCasting alloc] initWithMainView:self.firstScrollView endHeight:130.f * i endImageName:@"testImageVacancies.png" endName:@"Анастасия Филатова" endCountry:@"Москва (Рoссия)" endAge:@"25 лет" endIsReward:NO endRewardNumber:@"5" endIsLike:NO endLikeNumber:@"15" endIsBookmark:NO endProfileID:nil enfGrowth:@"рост: 168 см" endApproved: YES];
        cell.delegate = self;
        [self.secondScrollView addSubview:cell];
    }
    self.secondScrollView.contentSize = CGSizeMake(0, 130.f * 3);
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ViewCellMyCastingDelegate

- (void) actionWith: (ViewCellMyCasting*) viewCellMyCasting endButtonImage: (CustomButton*) sender {
    
    NSLog(@"Основная картинка ячейки");
}

- (void) actionWith: (ViewCellMyCasting*) viewCellMyCasting endButtonReward: (CustomButton*) sender {
    
    NSLog(@"Кнопка награды");
}

- (void) actionWith: (ViewCellMyCasting*) viewCellMyCasting endButtonLike: (CustomButton*) sender {
    
    NSLog(@"Кнопка лайка");
}

- (void) actionWith: (ViewCellMyCasting*) viewCellMyCasting endButtonBookmark: (CustomButton*) sender {
    
    NSLog(@"Кнопка закладки");
}

- (void) actionWith: (ViewCellMyCasting*) viewCellMyCasting endButtonDelete: (CustomButton*) sender {
    
    NSLog(@"Кнопка удаления");
}

- (void) actionWith: (ViewCellMyCasting*) viewCellMyCasting endButtonConfirm: (CustomButton*) sender {
    
    NSLog(@"Кнопка подтвеждения");
}

#pragma mark - Actions

- (IBAction)actionButtonBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionButtonEdit:(id)sender {
    NSLog(@"Редактировать");
}

- (IBAction)actionButtonDelete:(id)sender {
    NSLog(@"Удалить");
}

- (IBAction)actionButtontextAdd:(CustomButton*)sender {
    
    CGFloat height;
    
    if (sender.isBool) {
        height = self.view.bounds.size.height - self.heightTextView;
        [sender setTitle:@"Свернуть" forState:UIControlStateNormal];
        //        self.imageHide.center = CGPointMake(9.5f, 3.5f);
        //rotate rect
        self.imageHide.transform = CGAffineTransformMakeRotation(M_PI); //rotation in radians
        sender.isBool = NO;
    } else {
        [sender setTitle:@"Развернуть" forState:UIControlStateNormal];
        self.imageHide.transform = CGAffineTransformMakeRotation(0); //rotation in radians
        height = 0;
        sender.isBool = YES;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rectForView = self.viewForMainText.frame;
        CGRect rectTextView = self.mainTextView.frame;
        rectTextView.size.height = height;
        rectForView.size.height = height;
        self.mainTextView.frame = rectTextView;
        self.viewForMainText.frame = rectForView;
    }];
    
}

- (IBAction)actionButtonConsideration:(CustomButton *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.mainScrollView.contentOffset = CGPointMake(0, 0);
        sender.userInteractionEnabled = NO;
        sender.alpha = 1.f;
        
        self.buttonConfirm.alpha = 0.45f;
        self.buttonConfirm.userInteractionEnabled = YES;
    }];
}

- (IBAction)actionButtonConfirm:(CustomButton *)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.mainScrollView.contentOffset = CGPointMake(CGRectGetWidth(self.mainScrollView.bounds), 0);
        sender.userInteractionEnabled = NO;
        sender.alpha = 1.f;
        
        self.buttonConsideration.alpha = 0.45f;
        self.buttonConsideration.userInteractionEnabled = YES;
    }];
}
@end
