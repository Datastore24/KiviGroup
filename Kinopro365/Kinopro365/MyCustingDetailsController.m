//
//  MyCustingDetailsController.m
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 08.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "MyCustingDetailsController.h"
#import "ViewCellMyCasting.h"


@interface MyCustingDetailsController ()

@property (strong, nonatomic) UIScrollView * firstScrollView;

@end

@implementation MyCustingDetailsController

- (void) loadView {
    [super loadView];
    
    UILabel * CustomText = [[UILabel alloc]initWithTitle:@"Кастинги"];
    self.navigationItem.titleView = CustomText;
    
    self.firstScrollView = [[UIScrollView alloc] initWithFrame:self.mainScrollView.bounds];
    [self.mainScrollView addSubview:self.firstScrollView];
    
    
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    
    for (int i = 0; i < 5; i++) {
        ViewCellMyCasting * cell = [[ViewCellMyCasting alloc] initWithMainView:self.firstScrollView endHeight:130.f * i endImageName:@"testImageVacancies.png" endName:@"Анастасия Филатова" endCountry:@"Москва (Рoссия)" endAge:@"25 лет" endIsReward:NO endRewardNumber:@"5" endIsLike:NO endLikeNumber:@"15" endIsBookmark:NO endProfileID:nil enfGrowth:@"рост: 168 см"];
        [self.firstScrollView addSubview:cell];
    }
    
    self.firstScrollView.contentSize = CGSizeMake(0, 130.f * 5);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
