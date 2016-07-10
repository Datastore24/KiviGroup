//
//  CatalogView.m
//  Dolpirog
//
//  Created by Виктор Мишустин on 05/07/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "CatalogView.h"

@interface CatalogView () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView * mainTableView;
@property (strong, nonatomic) NSArray * arrayMain;

@end

@implementation CatalogView

- (instancetype)initWithView: (UIView*) view andDate: (NSMutableArray*) arrayDate
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        
        //create table
        
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, self.frame.size.width, 300)];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.allowsSelection = NO;
        [self addSubview:_mainTableView];
        
        
        _arrayMain = arrayDate;
    
        
        
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayMain.count;
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
    NSDictionary * dictCell = [_arrayMain objectAtIndex:indexPath.row];
    
    if (_arrayMain.count != 0) {
        [cell.contentView addSubview:[self setTableCellWithName:[dictCell objectForKey:@"name"]
                                                   andImageName:[dictCell objectForKey:@"imageName"]]];
    } else {
        NSLog(@"Нет категорий");
    }
    
    
    return cell;
}

#pragma mark - UITableViewDelegate

#pragma mark - Custom Cell

#pragma mark - UITableViewDelegate
//Анимация нажатия ячейки--------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 46.f;
}

#pragma mark - CustomCell

//Кастомная ячейка---------------------------------------
- (UIView*) setTableCellWithName: (NSString*) name
                           andImageName: (NSString*) imageName
{
    //Основное окно ячейки--------------------------------
    UIView * cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 46)];
    cellView.backgroundColor = nil;
    
    
    

    
    return cellView;
    
}


@end
