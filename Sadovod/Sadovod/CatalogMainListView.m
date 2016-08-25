//
//  CatalogMainListView.m
//  Sadovod
//
//  Created by Виктор Мишустин on 19/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "CatalogMainListView.h"
#import "CustomLabels.h"
#import "HexColors.h"
#import "Macros.h"
#import "UIView+BorderView.h"
#import "CheckDataServer.h"

@interface CatalogMainListView () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView * tableCatalog;
@property (strong, nonatomic) NSArray * arrayData;

@end

@implementation CatalogMainListView

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 64.f, view.frame.size.width, view.frame.size.height-64.f);
        
        self.arrayData = data;
        
        //Создание таблицы заказов----
        self.tableCatalog = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
        //Убираем полосы разделяющие ячейки------------------------------
        self.tableCatalog.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableCatalog.backgroundColor = nil;
        self.tableCatalog.dataSource = self;
        self.tableCatalog.delegate = self;
        self.tableCatalog.showsVerticalScrollIndicator = NO;
        
        //Очень полездное свойство, отключает дествие ячейки-------------
        //        self.tableCatalog.allowsSelection = NO;
        [self addSubview:self.tableCatalog];
        
        
    }
    return self;
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    [CheckDataServer checkDataServer:self.arrayData andMessage:@"Нет категорий для отображения" view:tableView];
    
    
    return self.arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    static NSString *CellIdentifier = @"newFriendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    for (UIView * view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    cell.backgroundColor = nil;
    
    NSDictionary * dict = [self.arrayData objectAtIndex:indexPath.row];
    
    
        [cell.contentView addSubview:[self createCustomCellWithName:[dict objectForKey:@"cat_name"]
                                                           andCount:[dict objectForKey:@"prod_cnt"]]];
   
   
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
//Анимация нажатия ячейки--------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary * dict = [self.arrayData objectAtIndex:indexPath.row];

   
    [self.delegate pushToCatalogListController:self andCatId:[dict objectForKey:@"cat_id"]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 46.f;
}

- (UIView*) createCustomCellWithName: (NSString*) name
                            andCount: (NSString*) count {
    UIView * customCell = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, 46.f)];
    
    CustomLabels * nameLabel = [[CustomLabels alloc] initLabelTableWithWidht:10.f andHeight:0.f andSizeWidht:200.f andSizeHeight:46.f andColor:@"000000" andText:name];
    nameLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    [customCell addSubview:nameLabel];
    
    UILabel * labelCount = [[UILabel alloc] init];
    labelCount.text = count;
    labelCount.textColor = [UIColor whiteColor];
    labelCount.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
    labelCount.textAlignment = NSTextAlignmentCenter;
    labelCount.frame = CGRectMake(customCell.frame.size.width - (10.f + (15.f + 10.f * labelCount.text.length)), 12.f, 15.f + 10.f * labelCount.text.length, 22.f);
    
    UIView * viewLabel = [[UIView alloc] initWithFrame:labelCount.frame];
    viewLabel.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_800];
    viewLabel.layer.cornerRadius = 3.f;
    [customCell addSubview:viewLabel];
    [customCell addSubview:labelCount];
    
    [UIView borderViewWithHeight:45.9f andWight:0.f andView:customCell andColor:VM_COLOR_200];
    
    return customCell;
}

@end
