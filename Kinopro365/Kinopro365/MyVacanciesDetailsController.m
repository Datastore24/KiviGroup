//
//  MyVacanciesDetailsController.m
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 02.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "MyVacanciesDetailsController.h"
#import "MyVacanciesDetailsModel.h"
#import "HexColors.h"
#import "ViewCellMyVacancies.h"
#import "DateTimeMethod.h"
#import <SDWebImage/UIImageView+WebCache.h> //Загрузка изображения
#import "ProfessionDetailModel.h"
#import "ProfessionDetailController.h"


@interface MyVacanciesDetailsController () <ViewCellMyVacanciesDelegate,MyVacanciesDetailsModelDelegate>

@property (assign, nonatomic) CGFloat heightTextView;
@property (strong, nonatomic) MyVacanciesDetailsModel * myVacanciesDetailsModel;


@end

@implementation MyVacanciesDetailsController

- (void) loadView {
    [super loadView];
    
    UILabel * CustomText = [[UILabel alloc]initWithTitle:@"Вакансии"];
    self.navigationItem.titleView = CustomText;

    self.viewForPerson.layer.cornerRadius = self.viewForPerson.bounds.size.height / 2;
    
    self.buttonAddText.isBool = YES;
    self.heightTextView = self.mainTextView.frame.origin.y;
    self.myVacanciesDetailsModel = [[MyVacanciesDetailsModel alloc] init];
    self.myVacanciesDetailsModel.delegate = self;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    
    [self.myVacanciesDetailsModel loadVacancies:self.vacancyID];
    
    
}

-(void) loadMyVacancies:(NSDictionary *) vacanciesDict{
    
    self.mainTextView.text = [vacanciesDict objectForKey:@"description"];
    self.titleVacancies.text =[vacanciesDict objectForKey:@"name"];
    
    NSDate * endDate = [DateTimeMethod timestampToDate:[vacanciesDict objectForKey:@"end_at"]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM"];
    NSString *stringDate = [dateFormatter stringFromDate:endDate];
    
    self.activelyLabel.text = [NSString stringWithFormat:@"Активно до: %@ ",stringDate];
    self.countryLabel.text = [NSString stringWithFormat:@"%@ (%@)",[vacanciesDict objectForKey:@"city_name"],[vacanciesDict objectForKey:@"country_name"]];
    self.labelNumberRecall.text =[NSString stringWithFormat:@"%@",[vacanciesDict objectForKey:@"count_offer"]];
    
    
    NSURL *imgURL = [NSURL URLWithString:[vacanciesDict objectForKey:@"logo_url"]];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:imgURL
                          options:0
                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                             // progression tracking code
                         }
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished,
                                    NSURL *imageURL) {
                            
                            if(image){
                                self.mainImageVacancies.contentMode = UIViewContentModeScaleAspectFill;
                                self.mainImageVacancies.clipsToBounds = YES;
                                self.mainImageVacancies.layer.cornerRadius = 5;
                                self.mainImageVacancies.image = image;
                                
                                
                            }else{
                                //Тут обработка ошибки загрузки изображения
                            }
                        }];
    
    
    [self.myVacanciesDetailsModel loadOffersProfile:self.vacancyID andOffset:@"0" andCount:@"1000" complitionBlock:^(id response) {
        
        if([response isKindOfClass:[NSDictionary class]]){
            NSArray * respOffers = [response objectForKey:@"items"];
            
            for (UIView * view in self.scrollViewForVacansies.subviews) {
                [view removeFromSuperview];
            }
            
            NSLog(@"RESPARRAY %@",respOffers);
            
            for (int i = 0; i < respOffers.count; i++) {
                
                NSDictionary * dictOffers = [respOffers objectAtIndex:i];
                NSArray *phones =  [dictOffers objectForKey:@"phones"];
                NSString * phone1;
                NSString * phone2;
                if(phones.count>0){
                    if(phones.count>1){
                        phone1=[[phones objectAtIndex:0] objectForKey:@"phone_number"];
                        phone2=[[phones objectAtIndex:1] objectForKey:@"phone_number"];
                    }else{
                        phone1=[[phones objectAtIndex:0] objectForKey:@"phone_number"];
                        phone2=@"";
                    }
                }else{
                    phone1=@"";
                    phone2=@"";
                }
                
                ViewCellMyVacancies * cell = [[ViewCellMyVacancies alloc] initWithMainView:self.scrollViewForVacansies endHeight:235.f * i endImageName:[dictOffers objectForKey:@"photo_url"] endName:[dictOffers objectForKey:@"first_name"] endCountry:[NSString stringWithFormat:@"%@ (%@)",[dictOffers objectForKey:@"city_name"],[dictOffers objectForKey:@"country_name"]] endAge:[NSString stringWithFormat:@"%@ лет", [dictOffers objectForKey:@"age"]] endIsReward:[[dictOffers objectForKey:@"is_reward"] boolValue] endRewardNumber:[NSString stringWithFormat:@"%@",[dictOffers objectForKey:@"count_rewards"]] endIsLike:[[dictOffers objectForKey:@"is_like"] boolValue] endLikeNumber:[NSString stringWithFormat:@"%@",[dictOffers objectForKey:@"count_likes"]] endIsBookmark:[[dictOffers objectForKey:@"is_favourite"] boolValue] endPhoneOne:phone1 endPhoneTwo:phone2 endEmail:@"" endProfileID:[dictOffers objectForKey:@"id"]];
                cell.delegate = self;
                [self.scrollViewForVacansies addSubview:cell];
            }
            
            self.scrollViewForVacansies.contentSize = CGSizeMake(0, 235.f * respOffers.count-1);

        }
        
    }];

    
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
    
    [self showAlertWithMessageWithTwoBlock:@"Вы уверены,\nчто хотите удалить вакансию?" nameButtonOK:@"Удалить" blockOK:^{
        [self.myVacanciesDetailsModel deleteVacancy:self.vacancyID complitionBlock:^(id response) {
            NSLog(@"RESPONSE %@",response); 
            if([response objectForKey:@"error_code"]){
                
                NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                      [response objectForKey:@"error_msg"]);
                NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
                if(errorCode == 651){
                    [self showAlertWithMessage:@"Вакансия не найдена"];
                }else if(errorCode == 652){
                    [self showAlertWithMessage:@" Вакансия с переданным id не принадлежит пользователю"];
                    
                }
            }else{
                if([[response objectForKey:@"response"] integerValue] == 1){
                    [self showAlertWithMessageWithBlock:@"Вакансия успешно удалена" block:^{
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                    
                }
            }
        }];

    } nameButtonCancel:@"Отменить" blockCancel:^{
        
    }];
    
   
}

#pragma mark - ViewCellMyVacanciesDelegate

- (void) actionWith: (ViewCellMyVacancies*) viewCellMyVacancies endButtonImage: (CustomButton*) sender {
    
    NSLog(@"Переход на страницу пользователя");
    ProfessionDetailController * profController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfessionDetailController"];
    
    profController.profileID = sender.customID;
    profController.profName = self.profName;
    profController.profID = self.profID;
    profController.buttonBookmarkBack = sender.customButton;
    
    [self.navigationController pushViewController:profController animated:YES];
    
}

- (void) actionWith: (ViewCellMyVacancies*) viewCellMyVacancies endButtonReward: (CustomButton*) sender {
    
    ProfessionDetailModel * supportModel = [[ProfessionDetailModel alloc] init];
    if(!sender.isBool){
        [supportModel sendIsReward:NO andProfileID:sender.customID complitionBlock:^(id response) {
             if([response objectForKey:@"error_code"]){
                 NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
                 if(errorCode == 561){
                     [self showAlertWithMessage:@"Награду может выдавать\nтолько подтвержденный заказчик."];
                 }else if(errorCode == 563){
                     [self showAlertWithMessage:@"Нельзя выдать награду самому себе"];
                 }else if(errorCode == 564){
                     [self showAlertWithMessage:@"Пользователю уже была выдана награда"];
                 }
             }else{
                 [sender setImage:[UIImage imageNamed:@"isRewarImageOn"] forState:UIControlStateNormal];
                 NSInteger numberReward = [viewCellMyVacancies.numberRewar.text integerValue];
                 numberReward += 1;
                 viewCellMyVacancies.numberRewar.text = [NSString stringWithFormat:@"%ld", numberReward];
                 sender.isBool = YES;
             }
            
        }];
        
        
    }else{
        
        [supportModel sendIsReward:YES andProfileID:sender.customID complitionBlock:^(id response) {
            
            if([response objectForKey:@"error_code"]){
                NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
                if(errorCode == 572){
                    [self showAlertWithMessage:@"Вы не выдавали награду пользователю."];
                }
                
            }else{
                [sender setImage:[UIImage imageNamed:@"isRewarImageOn"] forState:UIControlStateNormal];
                NSInteger numberReward = [viewCellMyVacancies.numberRewar.text integerValue];
                numberReward -= 1;
                viewCellMyVacancies.numberRewar.text = [NSString stringWithFormat:@"%ld", numberReward];
                sender.isBool = NO;
            }
            
        }];
        
        
    }
    

    
}

- (void) actionWith: (ViewCellMyVacancies*) viewCellMyVacancies endButtonLike: (CustomButton*) sender {
    
    
    ProfessionDetailModel * supportModel = [[ProfessionDetailModel alloc] init];
    if(!sender.isBool){
        [supportModel sendIsLike:NO andProfileID:sender.customID complitionBlock:^(id response) {
            if([response objectForKey:@"error_code"]){
                NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
                if(errorCode == 541){
                    [self showAlertWithMessage:@"Нельзя поставить лайк самому себе"];
                }else if(errorCode == 543){
                    [self showAlertWithMessage:@"Пользователю уже поставлен лайк"];
                }
                
            }else{
                [sender setImage:[UIImage imageNamed:@"isLikeImageOn"] forState:UIControlStateNormal];
                NSInteger numberLike = [viewCellMyVacancies.numberLike.text integerValue];
                numberLike += 1;
                viewCellMyVacancies.numberLike.text = [NSString stringWithFormat:@"%ld", numberLike];
                sender.isBool = YES;
            }
        }];
    }else{
        [supportModel sendIsLike:YES andProfileID:sender.customID complitionBlock:^(id response) {
            if([response objectForKey:@"error_code"]){
                NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
                if(errorCode == 552){
                    [self showAlertWithMessage:@"Пользователю не был поставлен лайк"];
                }
                
            }else{
                [sender setImage:[UIImage imageNamed:@"likeImage"] forState:UIControlStateNormal];
                NSInteger numberLike = [viewCellMyVacancies.numberLike.text integerValue];
                numberLike -= 1;
                viewCellMyVacancies.numberLike.text = [NSString stringWithFormat:@"%ld", numberLike];
                sender.isBool = NO;
            }
        }];
        
    }
    
    

    
}

- (void) actionWith: (ViewCellMyVacancies*) viewCellMyVacancies endButtonBookmark: (CustomButton*) sender {
    
    ProfessionDetailModel * supportModel = [[ProfessionDetailModel alloc] init];
    if(!sender.isBool){
        [supportModel sendIsFavourite:NO andProfileID:sender.customID complitionBlock:^(id response) {
            if([response objectForKey:@"error_code"]){
                NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
                if(errorCode == 552){
                    [self showAlertWithMessage:@"Пользователю не был поставлен лайк"];
                }
                
            }else{
                sender.isBool = YES;
                [sender setImage:[UIImage imageNamed:@"professionImageBookmarkOn"] forState:UIControlStateNormal];
            }
        }];
    }else{
        [supportModel sendIsFavourite:YES andProfileID:sender.customID complitionBlock:^(id response) {
            if([response objectForKey:@"error_code"]){
                NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
                if(errorCode == 552){
                    [self showAlertWithMessage:@"Пользователю не был поставлен лайк"];
                }
                
            }else{
                sender.isBool = NO;
                [sender setImage:[UIImage imageNamed:@"professionImageBookmark"] forState:UIControlStateNormal];;
            }
        }];
        
    }
    
    
    if (sender.isBool) {
        
    } else {
        
    }
    
}

- (void) actionWith: (ViewCellMyVacancies*) viewCellMyVacancies endButtonPhoneOne: (CustomButton*) sender {
    
    NSLog(@"звоним на - %@", sender.titleLabel.text);
}

- (void) actionWith: (ViewCellMyVacancies*) viewCellMyVacancies endButtonPhoneTwo: (CustomButton*) sender {
    
    NSLog(@"звоним на - %@", sender.titleLabel.text);
}

- (void) actionWith: (ViewCellMyVacancies*) viewCellMyVacancies endButtonEmail: (CustomButton*) sender {
   
    NSLog(@"сохраняем в буфер - %@", sender.titleLabel.text);
}



@end
