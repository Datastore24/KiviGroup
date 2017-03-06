//
//  MyVacanciesController.m
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 02.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "MyVacanciesController.h"
#import "MyVacanciesCell.h"
#import "MyVacanciesModel.h"
#import <SDWebImage/UIImageView+WebCache.h> //Загрузка изображения
#import "DateTimeMethod.h"

@interface MyVacanciesController () <UITableViewDelegate, UITableViewDataSource,MyVacanciesModelDelegate>

@property (strong,nonatomic) MyVacanciesModel * myVacanciesModel;
@property (strong, nonatomic) NSArray * myVacanArray;

@end

@implementation MyVacanciesController

- (void) loadView {
    [super loadView];
    
    self.view.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"EAF3FA"];
    self.mainTableView.backgroundColor = [UIColor clearColor];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UILabel * CustomText = [[UILabel alloc]initWithTitle:@"Мои вакансии"];
    self.navigationItem.titleView = CustomText;
    
    self.myVacanciesModel = [[MyVacanciesModel alloc] init];
    self.myVacanciesModel.delegate = self;
    [self.myVacanciesModel loadVacanciesFromServerOffset:@"0" andCount:@"1000" andIsActive:@""];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadMyVacancies:(NSDictionary *) myVacanDict{
    if([[myVacanDict objectForKey:@"items"] isKindOfClass:[NSArray class]]){
        self.myVacanArray = [myVacanDict objectForKey:@"items"];
        self.labelListVacancies.text = [NSString stringWithFormat:@"%@ активных вакансий",[myVacanDict objectForKey:@"count"]];
        [self.mainTableView reloadData];
    }
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([[[self.myVacanArray objectAtIndex:0] objectForKey:@"name"] isEqual:[NSNull null]]){
        return 0;
    }else{
        return self.myVacanArray.count;
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * identifier = @"Cell";
    
    NSDictionary * dictMyVacan = [self.myVacanArray objectAtIndex:indexPath.row];
    
    MyVacanciesCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.mainImage.layer.cornerRadius = 5.f;
    

    
    if (indexPath.row == 2) {
        cell.mainImage.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"EAF3FA"];
    } else {
        if(![[dictMyVacan objectForKey:@"logo_url"] isEqual: [NSNull null]]){
            
            
            NSURL *imgURL = [NSURL URLWithString:[dictMyVacan objectForKey:@"logo_url"]];
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
    }
    cell.titleLabel.text = [dictMyVacan objectForKey:@"name"];
    cell.countryLabel.text = [NSString stringWithFormat:@"%@ (%@)",[dictMyVacan objectForKey:@"city_name"],[dictMyVacan objectForKey:@"country_name"]];
    if(![[dictMyVacan objectForKey:@"end_at"] isEqual: [NSNull null]]){
        NSDate * endDate = [DateTimeMethod timestampToDate:[dictMyVacan objectForKey:@"end_at"]];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        NSString *stringDate = [dateFormatter stringFromDate:endDate];
        
        cell.ActivelyLabel.text = [NSString stringWithFormat:@"Активно до %@",stringDate];
    
    }
    
    cell.viewForNumber.layer.cornerRadius = 10;
    cell.labelNumber.text = [NSString stringWithFormat:@"%@",[dictMyVacan objectForKey:@"count_offer"]];
    
    //Временная условия для статуса
    if(![[dictMyVacan objectForKey:@"review_status"] isEqual: [NSNull null]]){
        if ([[dictMyVacan objectForKey:@"review_status"] integerValue] == 3) {
            cell.labelStatus.text = @"Отклонена";
            cell.labelStatus.textColor = [UIColor redColor];
        } else if ([[dictMyVacan objectForKey:@"review_status"] integerValue] == 2) {
            cell.labelStatus.text = @"Одобрена";
            cell.labelStatus.textColor = [UIColor greenColor];
        } else if ([[dictMyVacan objectForKey:@"review_status"] integerValue] == 1) {
            cell.labelStatus.text = @"Ожидает модерацию";
            cell.labelStatus.textColor = [UIColor blueColor];
        }
    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 93;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self pushCountryControllerWithIdentifier:@"MyVacanciesDetailsController"];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma mark - Actions

- (IBAction)actionButtonBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionAddVacancies:(id)sender {
    [self pushCountryControllerWithIdentifier:@"AddVacanciesController"];
}
@end
