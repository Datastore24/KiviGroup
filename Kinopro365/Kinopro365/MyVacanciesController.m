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
#import "MyVacanciesDetailsController.h"
#import "MyCustingDetailsController.h"
#import <SDWebImage/UIImageView+WebCache.h> //Загрузка изображения
#import "DateTimeMethod.h"
#import "ChooseProfessionalModel.h"
#import "SingleTone.h"
#import "AddParamsModel.h"

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
    
    if ([[[SingleTone sharedManager] typeView] integerValue] == 0) {
        UILabel * CustomText = [[UILabel alloc]initWithTitle:@"Мои вакансии"];
        self.navigationItem.titleView = CustomText;
    } else {
        UILabel * CustomText = [[UILabel alloc]initWithTitle:@"Мои кастинги"];
        self.navigationItem.titleView = CustomText;
    }
    
    
    self.myVacanciesModel = [[MyVacanciesModel alloc] init];
    self.myVacanciesModel.delegate = self;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self createActivitiIndicatorAlertWithView];
     if ([[[SingleTone sharedManager] typeView] integerValue] == 0) {
         [self.myVacanciesModel loadVacanciesFromServerOffset:@"0" andCount:@"1000" andIsActive:@""];
     }else{
         [self.myVacanciesModel loadСastingsFromServerOffset:@"0" andCount:@"1000" andIsActive:@""];
     }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadMyVacancies:(NSDictionary *) myVacanDict{
    if([[myVacanDict objectForKey:@"items"] isKindOfClass:[NSArray class]]){
        self.myVacanArray = [myVacanDict objectForKey:@"items"];
        
         if ([[[SingleTone sharedManager] typeView] integerValue] == 0) {
             self.labelListVacancies.text = [NSString stringWithFormat:@"%@ активных вакансий",[myVacanDict objectForKey:@"count"]];
         }else{
             self.labelListVacancies.text = [NSString stringWithFormat:@"%@ активных кастингов",[myVacanDict objectForKey:@"count"]];
         }
        
        
        [self.mainTableView reloadData];
        [self deleteActivitiIndicator];
    }
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.myVacanArray.count>0){
        if([[[self.myVacanArray objectAtIndex:0] objectForKey:@"name"] isEqual:[NSNull null]] ){
            return 0;
        }else{
            return self.myVacanArray.count;
        }
    }else{
        return 0;
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
                                cell.shadovView.backgroundColor = [UIColor groupTableViewBackgroundColor];
                                cell.shadovView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
                                [cell.shadovView.layer setShadowOffset:CGSizeMake(0, 3)];
                                [cell.shadovView.layer setShadowOpacity:0.7];
                                [cell.shadovView.layer setShadowRadius:2.0f];
                                [cell.shadovView.layer setShouldRasterize:YES];
                                [cell.shadovView.layer setCornerRadius:5.0f];
                                cell.mainImage.layer.cornerRadius = 5.f;
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
    
    cell.viewForNumber.layer.cornerRadius = CGRectGetHeight(cell.viewForNumber.bounds) / 2;
    
    
        if ([[[SingleTone sharedManager] typeView] integerValue] == 0) {
            cell.labelNumber.text = [NSString stringWithFormat:@"%@",
                                     [dictMyVacan objectForKey:@"count_offer"]];
            
            NSArray * professionArray = [ChooseProfessionalModel getArrayProfessions];
            
            NSArray *filtered = [professionArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(id == %@)", [dictMyVacan objectForKey:@"profession_id"]]];
            NSDictionary *item;
            if(filtered.count>0){
                item = [filtered objectAtIndex:0];
            }
            
            
            
            
            
            if([item objectForKey:@"name"]){
                cell.labelProfession.text = [NSString stringWithFormat:@"Профессия: %@",[item objectForKey:@"name"]];
            }else{
                cell.labelProfession.text = @"";
            }
        }else{
            cell.labelNumber.text = [NSString stringWithFormat:@"%@",
                                     [dictMyVacan objectForKey:@"count_pending_offer"]];
            
            AddParamsModel * addParamsModel = [[AddParamsModel alloc] init];
            
            NSArray * castingType = [addParamsModel getTypeCustings];
            NSDictionary * paramsCasting = [addParamsModel getInformationDictionary:[dictMyVacan objectForKey:@"project_type_id"] andProfArray:castingType];
            
            cell.labelProfession.text = [NSString stringWithFormat:@"%@",[paramsCasting objectForKey:@"name"]];
            
           
        }
   
    
    
   
    
    
    
    
    //Временная условия для статуса
    if(![[dictMyVacan objectForKey:@"review_status"] isEqual: [NSNull null]]){
        if ([[dictMyVacan objectForKey:@"review_status"] integerValue] == 3) {
            cell.labelStatus.text = @"Отклонена";
        } else if ([[dictMyVacan objectForKey:@"review_status"] integerValue] == 2) {
            cell.labelStatus.text = @"Одобрена";
        } else if ([[dictMyVacan objectForKey:@"review_status"] integerValue] == 1) {
            cell.labelStatus.text = @"Ожидает модерацию";
        }
    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 140;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSDictionary * dict = [self.myVacanArray objectAtIndex:indexPath.row];
    
    if ([[[SingleTone sharedManager] typeView] integerValue] == 0) {
        
        MyVacanciesDetailsController * myVacanciesDetailsController = [self.storyboard instantiateViewControllerWithIdentifier:@"MyVacanciesDetailsController"];
        
        myVacanciesDetailsController.vacancyID = [dict objectForKey:@"id"];
        myVacanciesDetailsController.vacancyURL = [dict objectForKey:@"logo_url"];
        myVacanciesDetailsController.vacancyName = [dict objectForKey:@"name"];
        myVacanciesDetailsController.profID = [dict objectForKey:@"profession_id"];
        
        NSArray * professionArray = [ChooseProfessionalModel getArrayProfessions];
        NSArray *filtered = [professionArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(id == %@)", [dict objectForKey:@"profession_id"]]];
        NSDictionary *item;
        if(filtered.count>0){
            item = [filtered objectAtIndex:0];
        }
        
        if(item.count > 0){
            myVacanciesDetailsController.profName = [item objectForKey:@"name"];
        }
        
        [self.navigationController pushViewController:myVacanciesDetailsController animated:YES];
        
        
    }else{
        
        MyCustingDetailsController * myCastingsDetailsController = [self.storyboard instantiateViewControllerWithIdentifier:@"MyCustingDetailsController"];
        
        myCastingsDetailsController.castingID = [dict objectForKey:@"id"];
        myCastingsDetailsController.castingURL = [dict objectForKey:@"logo_url"];
        myCastingsDetailsController.castingName = [dict objectForKey:@"name"];
        myCastingsDetailsController.profID = [dict objectForKey:@"profession_id"];
        
        NSArray * professionArray = [ChooseProfessionalModel getArrayProfessions];
        NSArray *filtered = [professionArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(id == %@)", [dict objectForKey:@"profession_id"]]];
        NSDictionary *item;
        if(filtered.count>0){
            item = [filtered objectAtIndex:0];
        }
        
        if(item.count > 0){
            myCastingsDetailsController.profName = [item objectForKey:@"name"];
        }
        
        
            [self.navigationController pushViewController:myCastingsDetailsController animated:YES];
  
        
    }
    
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma mark - Actions

- (IBAction)actionButtonBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionAddVacancies:(id)sender {
    if ([[[SingleTone sharedManager] typeView] integerValue] == 0) {
        [self pushCountryControllerWithIdentifier:@"AddVacanciesController"];
    } else {
        [self pushCountryControllerWithIdentifier:@"AddCastingController"];
    }
}
@end
