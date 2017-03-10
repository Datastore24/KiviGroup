//
//  VacanciesListController.m
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 02.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "VacanciesListController.h"
#import "VacanciesListModel.h"
#import "VacanciesDetailsController.h"
#import "HexColors.h"
#import "VacanciesListCell.h"
#import <SDWebImage/UIImageView+WebCache.h> //Загрузка изображения
#import "DateTimeMethod.h"
#import "CountryViewController.h"
#import "SingleTone.h"
#import "AddVacanciesController.h"
#import "ChooseProfessionalModel.h"
#import "CastingDetailsController.h"


@interface VacanciesListController () <UITableViewDelegate, UITableViewDataSource, VacanciesListModelDelegate,CountryViewControllerDelegate>
@property (strong, nonatomic) VacanciesListModel * vacanciesListModel;
@property (strong, nonatomic) NSArray * vacanArray;

@end

@implementation VacanciesListController

- (void) loadView {
    [super loadView];
    
    self.view.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"EAF3FA"];
    self.mainTableView.backgroundColor = [UIColor clearColor];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UILabel * customText;
    NSString * stringWriteBarButton;
    if ([[[SingleTone sharedManager] typeView] integerValue] == 0) {
        customText = [[UILabel alloc]initWithTitle:@"Вакансии"];
        stringWriteBarButton = @"myVacansieImage";
    } else {
        customText = [[UILabel alloc]initWithTitle:@"Кастинги"];
        stringWriteBarButton = @"my_cas";
    }
    
    UIImage *myImage = [UIImage imageNamed:stringWriteBarButton];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *myVacansiesButton = [[UIBarButtonItem alloc] initWithImage:myImage style:UIBarButtonItemStylePlain
                                                                      target:self action:@selector(pushMyVocansies:)];
    self.navigationItem.rightBarButtonItem = myVacansiesButton;
    
    UIImage *addImage = [UIImage imageNamed:@"buttonAddOn"];
    addImage = [addImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *addVacansiesButton = [[UIBarButtonItem alloc] initWithImage:addImage style:UIBarButtonItemStylePlain
                                                                         target:self action:@selector(addVocansies:)];
    self.navigationItem.rightBarButtonItem = addVacansiesButton;
    
    NSArray *tempArray2= [[NSArray alloc] initWithObjects:addVacansiesButton, myVacansiesButton, nil];
    self.navigationItem.rightBarButtonItems=tempArray2;
    
    
    
    
    self.navigationItem.titleView = customText;
    self.vacanciesListModel = [[VacanciesListModel alloc] init];
    self.vacanciesListModel.delegate = self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[SingleTone sharedManager] setCitySearchID:nil];
    [[SingleTone sharedManager] setCountrySearchID:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) loadVacancies:(NSDictionary *) vacanDict{
    if([[vacanDict objectForKey:@"items"] isKindOfClass:[NSArray class]]){
        self.vacanArray = [vacanDict objectForKey:@"items"];
        if ([[[SingleTone sharedManager] typeView] integerValue] == 0) {
            self.labelListVacancies.text = [NSString stringWithFormat:@"%@ активных вакансий",[vacanDict objectForKey:@"count"]];
        }else{
            self.labelListVacancies.text = [NSString stringWithFormat:@"%@ активных кастингов",[vacanDict objectForKey:@"count"]];
        }
        [self.mainTableView reloadData];
        [self deleteActivitiIndicator];
    }
   
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    NSString * coutryID;
    NSString * cityID;
    [self createActivitiIndicatorAlertWithView];
    
    if([[SingleTone sharedManager] countrySearchID]){
        coutryID = [[SingleTone sharedManager] countrySearchID];
    }else{
        coutryID = @"";
    }
    
    if([[SingleTone sharedManager] citySearchID]){
        cityID = [[SingleTone sharedManager] citySearchID];
    }else{
        cityID = @"";
    }
    
    if ([[[SingleTone sharedManager] typeView] integerValue] == 0) {
        //Вакансии
        
        
        [self.vacanciesListModel loadVacanciesFromServerOffset:@"0" andCount:@"1000"
                                                  andCountryID:coutryID andCityID:cityID];
        
    }else{
        //Кастинги
        [self.vacanciesListModel loadCastingsFromServerOffset:@"0" andCount:@"1000" andCountryID:coutryID andCityID:cityID andProfessionID:@"" andProjectTypeID:@""];
    }
   
    

}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.vacanArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * identifier = @"Cell";
    
    NSDictionary * dictVacan = [self.vacanArray objectAtIndex:indexPath.row];
        VacanciesListCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.backgroundColor = [UIColor whiteColor];
    
    
        cell.mainImage.layer.cornerRadius = 5.f;
    
    if(![[dictVacan objectForKey:@"logo_url"] isEqual:[NSNull null]]){
        NSURL *imgURL = [NSURL URLWithString:[dictVacan objectForKey:@"logo_url"]];
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:imgURL
                              options:0
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 // progression tracking code
                             }
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished,
                                        NSURL *imageURL) {
                                
                                if(image){
                                    cell.mainImage.contentMode = UIViewContentModeScaleAspectFill;
                                    cell.mainImage.clipsToBounds = YES;
                                    cell.mainImage.layer.cornerRadius = 5;
                                    cell.mainImage.image = image;
                                    
                                    
                                    
                                }else{
                                    //Тут обработка ошибки загрузки изображения
                                }
                            }];
    }
    
    
        cell.titleLabel.text = [dictVacan objectForKey:@"name"];
    
    //Профессия
    
    NSArray * professionArray = [ChooseProfessionalModel getArrayProfessions];
    
    NSArray *filtered = [professionArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(id == %@)", [dictVacan objectForKey:@"profession_id"]]];
    NSDictionary *item;
    if(filtered.count>0){
        item = [filtered objectAtIndex:0];
    }
    
    
    if([item objectForKey:@"name"]){
        cell.labelProfession.text = [item objectForKey:@"name"];
    }else{
        cell.labelProfession.text = @"";
    }
    
    
    
    //
    
        cell.countryLabel.text = [NSString stringWithFormat:@"%@ (%@)",[dictVacan objectForKey:@"city_name"],[dictVacan objectForKey:@"country_name"]];

        NSDate * endDate = [DateTimeMethod timestampToDate:[dictVacan objectForKey:@"end_at"]];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        NSString *stringDate = [dateFormatter stringFromDate:endDate];
    
        cell.activelyLabel.text = [NSString stringWithFormat:@"Активно до: %@ ",stringDate];
        
        return cell;

}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
       return 112;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if ([[[SingleTone sharedManager] typeView] integerValue] == 0) {
        VacanciesListCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        
        NSDictionary * dict = [self.vacanArray objectAtIndex:indexPath.row];
        
        VacanciesDetailsController * vacanciesDetailsController = [self.storyboard instantiateViewControllerWithIdentifier:@"VacanciesDetailsController"];
        
        vacanciesDetailsController.vacancyID = [dict objectForKey:@"id"];
        vacanciesDetailsController.vacancyURL = [dict objectForKey:@"logo_url"];
        vacanciesDetailsController.vacancyName = [dict objectForKey:@"name"];
        vacanciesDetailsController.vacancyImage = cell.mainImage.image;

        [self.navigationController pushViewController:vacanciesDetailsController animated:YES];
    } else {
        
        VacanciesListCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        
        NSDictionary * dict = [self.vacanArray objectAtIndex:indexPath.row];
        
        CastingDetailsController * castingDetailsController = [self.storyboard instantiateViewControllerWithIdentifier:@"CastingDetailsController"];
        
        castingDetailsController.castingID = [dict objectForKey:@"id"];
        castingDetailsController.castingURL = [dict objectForKey:@"logo_url"];
        castingDetailsController.castingName = [dict objectForKey:@"name"];
        castingDetailsController.castingImage = cell.mainImage.image;
        
        [self.navigationController pushViewController:castingDetailsController animated:YES];
    }
    
    
    
    
}

#pragma mark - Actions

- (IBAction)leftSideButtonMenu:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.centerContainer toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (IBAction)pushMyVocansies:(id)sender {
    [self pushCountryControllerWithIdentifier:@"MyVacanciesController"];
}

- (IBAction)addVocansies:(id)sender {
    
    if ([[[SingleTone sharedManager] typeView] integerValue] == 0) {
        [self pushCountryControllerWithIdentifier:@"AddVacanciesController"];
    } else {
        [self pushCountryControllerWithIdentifier:@"AddCastingController"];
    }
    
    
}



- (IBAction)actionButtonCountry:(id)sender {

    NSLog(@"Переход на окно выбора страны");
    [[SingleTone sharedManager] setCountry_citi:@"country"];
    [self pushCountryController];
}

- (IBAction)actionButtonCity:(id)sender {
    
    NSLog(@"Переход на окно выбора Города");
    if ([self.buttonCountry.titleLabel.text isEqualToString:@"Страна"]) {
        [self showAlertWithMessage:@"\nВведите страну!\n"];
    } else {
        [[SingleTone sharedManager] setCountry_citi:@"city"];
        [self pushCountryController];
    }
}

#pragma mark - Other
- (void) pushCountryController {
    CountryViewController * detai = [self.storyboard instantiateViewControllerWithIdentifier:@"CountryViewController"];
    detai.delegate = self;
    detai.isSearch = YES;
    [self.navigationController pushViewController:detai animated:YES];
}

#pragma mark - CountryViewControllerDelegate

- (void) changeButtonTextInSearch: (CountryViewController*) controller withString: (NSString*) string {
    
    if ([[[SingleTone sharedManager] country_citi] isEqualToString:@"country"]) {
        [self.buttonCountry setTitle:string forState:UIControlStateNormal];
    } else {
        [self.buttonCity setTitle:string forState:UIControlStateNormal];
    }
}


@end
