//
//  CategoryView.m
//  PsychologistIOS
//
//  Created by Viktor on 01.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "CategoryView.h"
#import "UIColor+HexColor.h"

@interface CategoryView () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation CategoryView
{
    UITableView * mainTableView;
}

- (instancetype)initWithBackgroundView: (UIView*) view
{
    self = [super init];
    if (self) {
        //Фоновая картинка--------------------
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height - 64);
        UIImageView * backgroundView = [[UIImageView alloc] initWithFrame:self.frame];
        backgroundView.image = [UIImage imageNamed:@"fonAlpha.png"];
        [self addSubview:backgroundView];
    }
    return self;
}

- (instancetype)initWithContent: (UIView*) view
{
    self = [super init];
    if (self) {
        //Основной контент---------------------
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height - 64);
        
        //Вью поиска---------------------------
        UIView * viewSearch = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 40)];
        viewSearch.backgroundColor = [UIColor colorWithHexString:@"eb9285"];
        [self addSubview:viewSearch];
        
        //Окно поиска--------------------------
        UISearchBar * mainSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 240, 24)];
        mainSearchBar.center = viewSearch.center;
        mainSearchBar.backgroundImage = [UIImage imageNamed:@"Search1.png"];
        mainSearchBar.layer.cornerRadius = 10;
        mainSearchBar.placeholder = @"Поиск по категориям";
        mainSearchBar.searchBarStyle = UISearchBarStyleDefault;
        mainSearchBar.barTintColor = [UIColor colorWithHexString:@"eb9285"];
        mainSearchBar.tintColor = [UIColor redColor];
        mainSearchBar.showsBookmarkButton = NO;
        mainSearchBar.showsCancelButton = NO;
        mainSearchBar.showsScopeBar = NO;
        mainSearchBar.showsSearchResultsButton = NO;
        [viewSearch addSubview:mainSearchBar];
        
        mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.frame.size.width, self.frame.size.height - 40) style:UITableViewStylePlain];
        //Убираем полосы разделяющие ячейки------------------------------
//        mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        mainTableView.backgroundColor = [UIColor clearColor];
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        [self addSubview:mainTableView];
        
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"newFriendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.backgroundColor = nil;
    
    return cell;
}

#pragma mark - UITableViewDelegate
//Анимация нажатия ячейки--------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 128;
}

@end
