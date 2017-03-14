//
//  MyCustingDetailsController.m
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 08.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "MyCustingDetailsController.h"
#import "ViewCellMyCasting.h"
#import "MyCustingDetailsModel.h"
#import "DateTimeMethod.h"
#import "AddParamsModel.h"


@interface MyCustingDetailsController () <ViewCellMyCastingDelegate, MyCustingDetailsModelDelegate>

@property (strong, nonatomic) UIScrollView * firstScrollView;
@property (strong, nonatomic) UIScrollView * secondScrollView;
@property (assign, nonatomic) CGFloat heightTextView;
@property (strong, nonatomic) NSDictionary * castingDict;
@property (strong, nonatomic) MyCustingDetailsModel * myCastingDetailsModel;

@end

@implementation MyCustingDetailsController

- (void) loadView {
    [super loadView];
    
    
    self.mainScrollView.scrollEnabled = NO;
    self.mainScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.mainScrollView.bounds) * 2, 0);
    self.firstScrollView = [[UIScrollView alloc] initWithFrame:self.mainScrollView.bounds];
    [self.mainScrollView addSubview:self.firstScrollView];
    self.secondScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.mainScrollView.bounds), 0, CGRectGetWidth(self.mainScrollView.bounds), CGRectGetHeight(self.mainScrollView.bounds))];
    [self.mainScrollView addSubview:self.secondScrollView];
    
//    self.heightTextView = self.mainTextView.frame.origin.y;
    self.viewForLabel.layer.cornerRadius = CGRectGetHeight(self.viewForLabel.bounds) / 2;
    self.buttonTextAdd.isBool = YES;
    
    self.buttonConsideration.userInteractionEnabled = NO;
    
    self.myCastingDetailsModel = [[MyCustingDetailsModel alloc] init];
    self.myCastingDetailsModel.delegate = self;
    [self.myCastingDetailsModel loadCastings:self.castingID];
    
    
    
    //работа со скролом текста------------------------------
    
    
    
    NSLog(@"%@", NSStringFromCGRect(self.viewForMainText.frame));

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

-(void) loadMyCastings:(NSDictionary *) castingsDict{
    self.castingDict = nil;
    self.castingDict = castingsDict;
    self.textLabel = [self.castingDict objectForKey:@"name"];
    
    //Заголовок
    AddParamsModel * addParamsModel = [[AddParamsModel alloc] init];
    
    NSArray * castingType = [addParamsModel getTypeCustings];
    NSDictionary * paramsCasting = [addParamsModel getInformationDictionary:[self.castingDict objectForKey:@"project_type_id"] andProfArray:castingType];
    
    NSLog(@"INF %@",[paramsCasting objectForKey:@"name"]);
    UILabel * CustomText = [[UILabel alloc]initWithTitle:[paramsCasting objectForKey:@"name"]];
    self.navigationItem.titleView = CustomText;
    //
    
    NSDate * endDate = [DateTimeMethod timestampToDate:[self.castingDict objectForKey:@"end_at"]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM"];
    NSString *stringDate = [dateFormatter stringFromDate:endDate];
    
    self.activelyLabel.text = [NSString stringWithFormat:@"Активно до: %@ ",stringDate];
    self.countryLabel.text = [NSString stringWithFormat:@"%@ (%@)",[self.castingDict objectForKey:@"city_name"],[self.castingDict objectForKey:@"country_name"]];
    self.labelConsideration.text =[NSString stringWithFormat:@"%@",[self.castingDict objectForKey:@"count_approved_offer"]];

    
    //Тестовые строки---------------------------------------
 
    self.hideTextLabel.text = [self.castingDict objectForKey:@"contact_info"];
    self.comTextLabel.text = [self.castingDict objectForKey:@"description"];
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
        height = self.view.bounds.size.height - self.viewForMainText.frame.origin.y;
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
//        CGRect rectTextView = self.mainTextView.frame;
//        rectTextView.size.height = height;
        rectForView.size.height = height;
//        self.mainTextView.frame = rectTextView;
        self.viewForMainText.frame = rectForView;
        self.scrollForText.frame = self.viewForMainText.bounds;
        
        CGFloat heightHideText = [self getLabelHeight:self.hideTextLabel];
        CGRect rectHideView = self.viewForHideText.frame;
        rectHideView.origin.y = 20.f;
        rectHideView.size.height = heightHideText;
        self.viewForHideText.frame = rectHideView;
        self.hideTextLabel.frame = CGRectMake(14.f, 0.f, self.viewForHideText.frame.size.width - 28.f, self.viewForHideText.frame.size.height);
        
        
        CGFloat heightComText = [self getLabelHeight:self.comTextLabel];
        CGRect rectComView = self.viewForComText.frame;
        rectComView.origin.y = CGRectGetMaxY(self.viewForHideText.frame) + 30;
        rectComView.size.height = heightComText;
        self.viewForComText.frame = rectComView;
        self.comTextLabel.frame = CGRectMake(14.f, 0.f, self.viewForComText.frame.size.width - 28.f, self.viewForComText.frame.size.height);
        self.scrollForText.contentSize = CGSizeMake(0, CGRectGetMaxY(self.viewForComText.frame) + 10.f);

        
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


@end
