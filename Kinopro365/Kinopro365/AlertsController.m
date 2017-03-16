//
//  AlertsController.m
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 11.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "AlertsController.h"
#import "VacanciesCell.h"
#import "HexColors.h"

@interface AlertsController () <HVTableViewDataSource, HVTableViewDelegate, VacanciesCellDelegate>

//Тестовые данные
@property (strong, nonatomic) NSString * testStringText;
@property (strong, nonatomic) NSArray * arrayType;
@property (assign, nonatomic) CGFloat heightTextForCell;


@end

@implementation AlertsController

- (void) loadView {
    [super loadView];
    
    self.navigationController.navigationBarHidden = NO;
    
    UILabel * customText = [[UILabel alloc]initWithTitle:@"Оповещения"];
    self.navigationItem.titleView = customText;
    
    self.tableView.HVTableViewDelegate = self;
    self.tableView.HVTableViewDataSource = self;
    
    
    
    self.testStringText = @"Авианосцы типа «Лексингтон» (англ. Lexington class) — серия тяжёлых ударных авианосцев США постройки 1920-х годов. Первые полноценные боевые авианосцы США после экспериментального авианосца «Лэнгли». Построены в 1922—1927 годах на основе двух недостроенных линейных крейсеров одноимённого типа.";
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayType = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)actionButtonMenu:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.centerContainer toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

#pragma mark - HVTableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.arrayType.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath isExpanded:(BOOL)isExpanded {
    
    
    VacanciesCell * cell = [tableView dequeueReusableCellWithIdentifier:[VacanciesCell cellIdentifier]];
    cell.delegate = self;

    cell.buttonPush.layer.cornerRadius = 5.f;
    cell.mainTextLabel.text = self.testStringText;
    
    NSString * typeString = [self.arrayType objectAtIndex:indexPath.row];
    if ([typeString integerValue] == 5) {
        cell.imageType.image = [UIImage imageNamed:@"imageCellCastings"];
    } else if ([typeString integerValue] == 1) {
        cell.imageType.image = [UIImage imageNamed:@"imageCellInfo"];
        cell.buttonPush.alpha = 0.f;
    } else if ([typeString integerValue] == 2) {
        cell.imageType.image = [UIImage imageNamed:@"imageCellMoney"];
        cell.buttonPush.alpha = 0.f;
    } else if ([typeString integerValue] == 3) {
        cell.imageType.image = [UIImage imageNamed:@"imageCellVacancies"];
    } else if ([typeString integerValue] == 4) {
        cell.imageType.image = [UIImage imageNamed:@"imageCellCastings"];
    }
    
    if (!isExpanded) {
        
        CGRect rect = cell.mainTextLabel.frame;
        rect.size.height = 56.f;
        cell.mainTextLabel.frame = rect;
        
        cell.buttonPush.alpha = 0.f;

        cell.arrowImage.transform = CGAffineTransformMakeRotation(0);
        
        if ([typeString integerValue] == 5) {
            cell.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"EAF3FA"];
        } else {
            cell.contentView.backgroundColor = [UIColor whiteColor];
        }

    } else {

        CGRect rect = cell.mainTextLabel.frame;
        rect.size.height = self.heightTextForCell;
        cell.mainTextLabel.frame = rect;
        
        if ([typeString integerValue] != 1 && [typeString integerValue] != 2) {
            cell.buttonPush.alpha = 1.f;

        }
        cell.arrowImage.transform = CGAffineTransformMakeRotation(-M_PI+0.00);
        
        if ([typeString integerValue] == 5) {
            cell.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"EAF3FA"];
        } else {
            cell.contentView.backgroundColor = [UIColor whiteColor];
        }
    }
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView collapseCell: (VacanciesCell*)cell withIndexPath:(NSIndexPath*) indexPath {
    
    
    NSString * typeString = [self.arrayType objectAtIndex:indexPath.row];
    
    if ([typeString integerValue] == 5) {
        cell.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"EAF3FA"];
    } else {
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    
   [UIView animateWithDuration:0.2 animations:^{
       CGRect rect = cell.mainTextLabel.frame;
       rect.size.height = 56.f;
       cell.mainTextLabel.frame = rect;
       
       cell.buttonPush.alpha = 0.f;

       cell.arrowImage.transform = CGAffineTransformMakeRotation(0);
       
       
   }];
    
}
-(void)tableView:(UITableView *)tableView expandCell: (VacanciesCell*)cell withIndexPath:(NSIndexPath*) indexPath {
    
    NSString * typeString = [self.arrayType objectAtIndex:indexPath.row];
    
    if ([typeString integerValue] == 5) {
        cell.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"EAF3FA"];
    } else {
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    self.heightTextForCell = [self getLabelHeight:cell.mainTextLabel];
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = cell.mainTextLabel.frame;
        rect.size.height = self.heightTextForCell;
        cell.mainTextLabel.frame = rect;
        
        if ([typeString integerValue] != 1 && [typeString integerValue] != 2) {
            cell.buttonPush.alpha = 1.f;

        }
        
        cell.arrowImage.transform = CGAffineTransformMakeRotation(-M_PI+0.00);
    }];
    
}



#pragma mark - HVTableViewDelegate


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath isExpanded:(BOOL)isexpanded
{
    NSString * typeString = [self.arrayType objectAtIndex:indexPath.row];
    
    if (isexpanded) {
        if ([typeString integerValue] != 1 && [typeString integerValue] != 2) {
        return 90 + self.heightTextForCell;
        } else {
            return 55 + self.heightTextForCell;
        }
    } else {
    return 120;
    }
}

#pragma mark - VacanciesCellDelegate

- (void) actionCell: (VacanciesCell*) vacanciesCell endButtonDelete: (UIButton*) sender {
    NSLog(@"Перейти");
}
- (void) actionCell: (VacanciesCell*) vacanciesCell endButtonPush: (UIButton*) sender {
    NSLog(@"Удалить");
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
