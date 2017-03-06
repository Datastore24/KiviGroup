//
//  VacanciesListController.m
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 02.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "VacanciesListController.h"
#import "HexColors.h"
#import "VacanciesListCell.h"


@interface VacanciesListController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation VacanciesListController

- (void) loadView {
    [super loadView];
    
    
    self.view.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"EAF3FA"];
    self.mainTableView.backgroundColor = [UIColor clearColor];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UILabel * CustomText = [[UILabel alloc]initWithTitle:@"Вакансии"];
    self.navigationItem.titleView = CustomText;

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * identifier = @"Cell";
    
        VacanciesListCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.backgroundColor = [UIColor whiteColor];
        
        cell.mainImage.layer.cornerRadius = 5.f;
        cell.mainImage.image = [UIImage imageNamed:@"vacanciesTestImage.png"];
        cell.titleLabel.text = @"На три месяца ищется звукорежиссер со своими микрофонами.";
        cell.countryLabel.text = @"Москва (Россия)";
        cell.activelyLabel.text = @"Активно до 20.11";
        
        return cell;

}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
       return 93;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self pushCountryControllerWithIdentifier:@"VacanciesDetailsController"];
    
    
}

#pragma mark - Actions

- (IBAction)leftSideButtonMenu:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.centerContainer toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (IBAction)pushMyVocansies:(id)sender {
    [self pushCountryControllerWithIdentifier:@"MyVacanciesController"];
}

- (IBAction)actionButtonCountry:(id)sender {

    NSLog(@"Переход на окно выбора страны");
}

- (IBAction)actionButtonCity:(id)sender {
    
    NSLog(@"Переход на окно выбора Города"); 
}
@end
