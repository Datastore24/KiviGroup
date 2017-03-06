//
//  MyVacanciesController.m
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 02.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "MyVacanciesController.h"
#import "MyVacanciesCell.h"

@interface MyVacanciesController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation MyVacanciesController

- (void) loadView {
    [super loadView];
    
    self.view.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"EAF3FA"];
    self.mainTableView.backgroundColor = [UIColor clearColor];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UILabel * CustomText = [[UILabel alloc]initWithTitle:@"Мои вакансии"];
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
    
    MyVacanciesCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.mainImage.layer.cornerRadius = 5.f;
    if (indexPath.row == 2) {
        cell.mainImage.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"EAF3FA"];
    } else {
    cell.mainImage.image = [UIImage imageNamed:@"vacanciesTestImage.png"];
    }
    cell.titleLabel.text = @"На три месяца ищется звукорежиссер со своими микрофонами.";
    cell.countryLabel.text = @"Москва (Россия)";
    cell.ActivelyLabel.text = @"Активно до 20.11";
    cell.viewForNumber.layer.cornerRadius = 10;
    cell.labelNumber.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    
    //Временная условия для статуса
    if (indexPath.row == 0) {
        cell.labelStatus.text = @"Статус 1";
        cell.labelStatus.textColor = [UIColor redColor];
    } else if (indexPath.row == 1) {
        cell.labelStatus.text = @"Статус 2";
        cell.labelStatus.textColor = [UIColor greenColor];
    } else if (indexPath.row == 2) {
        cell.labelStatus.text = @"Статус 3";
        cell.labelStatus.textColor = [UIColor blueColor];
    }else if (indexPath.row == 3) {
        cell.labelStatus.text = @"Статус 4";
        cell.labelStatus.textColor = [UIColor blackColor];
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
