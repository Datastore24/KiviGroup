//
//  CatalogListView.m
//  Sadovod
//
//  Created by Виктор Мишустин on 19/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "CatalogListView.h"
#import "CustomLabels.h"
#import "Macros.h"
#import "UIView+BorderView.h"
#import "HexColors.h"
#import "CustomButton.h"


@interface CatalogListView () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView * tableCatalog;
@property (strong, nonatomic) NSArray * arrayData;
@property (strong, nonatomic) NSMutableArray * arrayHiden;

@end

@implementation CatalogListView

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 64.f, view.frame.size.width, view.frame.size.height-64.f);
        
        self.arrayData = data;
        self.arrayHiden = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.arrayData.count; i++) {
            NSArray * arrayCell = [[self.arrayData objectAtIndex:i] objectForKey:@"array"];
            NSNumber * number = [NSNumber numberWithInteger:arrayCell.count];
            [self.arrayHiden addObject:number];
        }
        
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

    NSInteger intCount = [[self.arrayHiden objectAtIndex:section] integerValue];
    return intCount;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGRect frame = tableView.frame;
    
    NSDictionary * dict = [self.arrayData objectAtIndex:section];
    
    
    CustomButton *hideButton = [CustomButton buttonWithType:UIButtonTypeSystem];
    UILabel * labelIdentifier = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 13.f, 20.f, 20.f)];
     hideButton.frame = CGRectMake(0.f, 0.f, frame.size.width, 46.f);
    [hideButton setTitle:[dict objectForKey:@"n"] forState:UIControlStateNormal];
    [hideButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if ([[self.arrayHiden objectAtIndex:section] integerValue] > 0) {
        hideButton.isBool = YES;
        labelIdentifier.text = @"-";
    } else {
        hideButton.isBool = NO;
        labelIdentifier.text = @"+";
    }
    labelIdentifier.textColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_800];
    labelIdentifier.textAlignment = NSTextAlignmentCenter;
    labelIdentifier.font = [UIFont fontWithName:VM_FONT_BOLD size:20];
    hideButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_100];
    hideButton.tag = 20 + section;
    [hideButton addTarget:self action:@selector(hideButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, frame.size.width, frame.size.height)];;
    if([[dict objectForKey:@"l"] integerValue]==0){
        [headerView addSubview:hideButton];
        [hideButton addSubview:labelIdentifier];
    }
    
    
    return headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)mTableView
{
    return self.arrayData.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary * dict = [self.arrayData objectAtIndex:indexPath.section];
    NSArray * array;
    if([[dict objectForKey:@"l"] integerValue]==0){
        array = [dict objectForKey:@"t"];
        
    }
    
    
//    NSArray * arrayCount = [dict objectForKey:@"arrayCount"];
//    
//    
    static NSString *CellIdentifier = @"newFriendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    for (UIView * view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    cell.backgroundColor = nil;
    
    
    
    if (self.arrayData.count != 0 && [[dict objectForKey:@"l"] integerValue]==0) {
        [cell.contentView addSubview:[self createCustomCellWithName:[[array objectAtIndex:indexPath.row] objectForKey:@"n"]
                                                           andCount:[[[array objectAtIndex:indexPath.row] objectForKey:@"c"] stringValue]]];

    } else {
        NSLog(@"Нет категорий");
    }
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
//Анимация нажатия ячейки--------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];    
    //Для логики выбора в каждой секции необходимо выполнить условие indexPath.section
    NSDictionary * dict = [self.arrayData objectAtIndex:indexPath.section];
    NSArray * array;
    if([[dict objectForKey:@"l"] integerValue]==0){
        array = [dict objectForKey:@"t"];
        
    }
    [self.delegate pushToCatalogDetail:self andCatId:[[array objectAtIndex:indexPath.row] objectForKey:@"i"]
     andCatName:[[array objectAtIndex:indexPath.row] objectForKey:@"n"]];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 46.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
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

#pragma mark - Actions

- (void) hideButtonAction: (CustomButton*) button {
    for (int i = 0; i < self.arrayData.count; i++) {
        if (button.tag == 20 + i) {
            if (!button.isBool) {
                NSArray * arrayCell = [[self.arrayData objectAtIndex:i] objectForKey:@"t"];
                [self.arrayHiden replaceObjectAtIndex:i withObject:[NSNumber numberWithInteger:arrayCell.count]];
            } else {
                [self.arrayHiden replaceObjectAtIndex:i withObject:[NSNumber numberWithInteger:0]];
            }
            [UIView transitionWithView: self.tableCatalog
                              duration: 0.35f
                               options: UIViewAnimationOptionTransitionNone
                            animations: ^(void)
             {
                 [self.tableCatalog reloadData];
             }
                            completion: nil];
            button.isBool = YES;

        }
    }
}


@end
