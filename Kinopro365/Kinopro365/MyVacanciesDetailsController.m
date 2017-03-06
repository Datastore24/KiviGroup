//
//  MyVacanciesDetailsController.m
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 02.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "MyVacanciesDetailsController.h"
#import "HexColors.h"
#import "ViewCellMyVacancies.h"


@interface MyVacanciesDetailsController () <ViewCellMyVacanciesDelegate>

@property (assign, nonatomic) CGFloat heightTextView;


@end

@implementation MyVacanciesDetailsController

- (void) loadView {
    [super loadView];
    
    UILabel * CustomText = [[UILabel alloc]initWithTitle:@"Вакансии"];
    self.navigationItem.titleView = CustomText;

    self.viewForPerson.layer.cornerRadius = self.viewForPerson.bounds.size.height / 2;
    
    self.buttonAddText.isBool = YES;
    self.heightTextView = self.mainTextView.frame.origin.y;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    for (UIView * view in self.scrollViewForVacansies.subviews) {
        [view removeFromSuperview];
    }
    
    
    for (int i = 0; i < 5; i++) {
        ViewCellMyVacancies * cell = [[ViewCellMyVacancies alloc] initWithMainView:self.scrollViewForVacansies endHeight:235.f * i endImageName:@"testImageVacancies.png" endName:@"Виктор Мишустин" endCountry:@"Сочи (Россия)" endAge:@"28 лет" endIsReward:NO endRewardNumber:@"5" endIsLike:NO endLikeNumber:@"15" endIsBookmark:NO endPhoneOne:@"7(909) 134 23 14" endPhoneTwo:@"7(909) 555 20 10" endEmail:@"ivanov@gmail.com"];
        cell.delegate = self;
        [self.scrollViewForVacansies addSubview:cell];
    }
    
    self.scrollViewForVacansies.contentSize = CGSizeMake(0, 235.f * 4);
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)actionBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionButtonTextAdd:(CustomButton*)sender {
    
    
    CGFloat height;
    
    if (sender.isBool) {
        height = self.view.bounds.size.height - self.heightTextView;
        [sender setTitle:@"-" forState:UIControlStateNormal];
        sender.isBool = NO;
    } else {
        [sender setTitle:@"+" forState:UIControlStateNormal];
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

- (IBAction)actionEditButton:(id)sender {
    
    NSLog(@"Редактировать вакансию");
}

- (IBAction)actionDeleteButton:(id)sender {
    
    NSLog(@"Удалить вакансию");    
}

#pragma mark - ViewCellMyVacanciesDelegate

- (void) actionWith: (ViewCellMyVacancies*) viewCellMyVacancies endButtonImage: (CustomButton*) sender {
    
    NSLog(@"Переход на страницу пользователя");
    
}

- (void) actionWith: (ViewCellMyVacancies*) viewCellMyVacancies endButtonReward: (CustomButton*) sender {
    
    [sender setImage:[UIImage imageNamed:@"isRewarImageOn"] forState:UIControlStateNormal];
    NSInteger numberReward = [viewCellMyVacancies.numberRewar.text integerValue];
    numberReward += 1;
    viewCellMyVacancies.numberRewar.text = [NSString stringWithFormat:@"%ld", numberReward];
    sender.userInteractionEnabled = NO;
    
}

- (void) actionWith: (ViewCellMyVacancies*) viewCellMyVacancies endButtonLike: (CustomButton*) sender {
    [sender setImage:[UIImage imageNamed:@"isLikeImageOn"] forState:UIControlStateNormal];
    NSInteger numberLike = [viewCellMyVacancies.numberLike.text integerValue];
    numberLike += 1;
    viewCellMyVacancies.numberLike.text = [NSString stringWithFormat:@"%ld", numberLike];
    sender.userInteractionEnabled = NO;
    
}

- (void) actionWith: (ViewCellMyVacancies*) viewCellMyVacancies endButtonBookmark: (CustomButton*) sender {
    
    if (sender.isBool) {
        sender.isBool = NO;
        [sender setImage:[UIImage imageNamed:@"professionImageBookmarkOn"] forState:UIControlStateNormal];
    } else {
        sender.isBool = YES;
        [sender setImage:[UIImage imageNamed:@"professionImageBookmark"] forState:UIControlStateNormal];
    }
    
}

- (void) actionWith: (ViewCellMyVacancies*) viewCellMyVacancies endButtonPhoneOne: (CustomButton*) sender {
    
    NSLog(@"звоним на - %@", sender.titleLabel.text);
}

- (void) actionWith: (ViewCellMyVacancies*) viewCellMyVacancies endButtonPhoneTwo: (CustomButton*) sender {
    
    NSLog(@"звоним на - %@", sender.titleLabel.text);
}

- (void) actionWith: (ViewCellMyVacancies*) viewCellMyVacancies endButtonEmail: (CustomButton*) sender {
   
    NSLog(@"сохраняем в буыфер - %@", sender.titleLabel.text);
}



@end
