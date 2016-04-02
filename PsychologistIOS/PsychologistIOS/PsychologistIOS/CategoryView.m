//
//  CategoryView.m
//  PsychologistIOS
//
//  Created by Viktor on 01.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "CategoryView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"

@interface CategoryView () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation CategoryView
{
    UITableView * mainTableView;
    NSMutableArray * mainArray;
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

- (instancetype)initWithContent: (UIView*) view andArray: (NSMutableArray*) array
{
    self = [super init];
    if (self) {
        //Основной контент---------------------
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height - 64);
        
        NSLog(@"array %@", array);
        mainArray = array;
        
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
        mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        mainTableView.backgroundColor = [UIColor clearColor];
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.showsVerticalScrollIndicator = NO;
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
    
    NSDictionary * dictCell = [mainArray objectAtIndex:indexPath.row];
    
    [cell addSubview:[self setTableCellWithTitle:[dictCell objectForKey:@"title"]
                                     andSubTitle:[dictCell objectForKey:@"subTitle"]
                                        andMoney:[[dictCell objectForKey:@"money"] boolValue]
                                        andImage:[dictCell objectForKey:@"image"]]];
    
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

- (UIView*) setTableCellWithTitle: (NSString*) string
                      andSubTitle: (NSString*) subTitle
                         andMoney: (BOOL) money
                         andImage: (NSString*) image
{
    //Основное окно ячейки--------------------------------
    UIView * cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 128)];
    cellView.backgroundColor = nil;
    
    //Создаем картинку------------------------------------
    UIImageView * imageViewCategory = [[UIImageView alloc] initWithFrame:CGRectMake(16, 16, 96, 96)];
    imageViewCategory.layer.cornerRadius = 0.5;
    imageViewCategory.image = [UIImage imageNamed:image];
    [cellView addSubview:imageViewCategory];
    
    //Заголовок-------------------------------------------
    UILabel * labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(136, 16, 216, 24)];
    labelTitle.text = string;
    labelTitle.numberOfLines = 0;
    labelTitle.textColor = [UIColor colorWithHexString:@"d46458"];
    labelTitle.font = [UIFont fontWithName:FONTLITE size:23];
    [labelTitle sizeToFit];
    [cellView addSubview:labelTitle];
    
    //Подзаголовок----------------------------------------
    UILabel * labelSubTitle = [[UILabel alloc] initWithFrame:CGRectMake(136, 16 + labelTitle.frame.size.height, 216, 16)];
    labelSubTitle.text = subTitle;
    labelSubTitle.textColor = [UIColor colorWithHexString:@"c0c0c0"];
    labelSubTitle.numberOfLines = 0;
    labelSubTitle.font = [UIFont fontWithName:FONTLITE size:16];
    [labelSubTitle sizeToFit];
    [cellView addSubview:labelSubTitle];
    
    //Платная или нет-------------------------------------
    UIImageView * moneyImage = [[UIImageView alloc] initWithFrame:CGRectMake(80, 8, 40, 40)];
    moneyImage.image = [UIImage imageNamed:@"imageMoney.png"];
    [cellView addSubview:moneyImage];
    if (!money) {
        moneyImage.alpha = 0.f;
    }
    
    //Стрелка перехода------------------------------------
    UIImageView * arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(cellView.frame.size.width - 48, 40, 16, 48)];
    arrowImage.image = [UIImage imageNamed:@"arrowImage.png"];
    [cellView addSubview:arrowImage];

    //Граница ячейки--------------------------------------
    UIView * viewBorder = [[UIView alloc] initWithFrame:CGRectMake(16, 127, cellView.frame.size.width - 32, 1)];
    viewBorder.backgroundColor = [UIColor colorWithHexString:@"c0c0c0"];
    [cellView addSubview:viewBorder];

    
    
    
    return cellView;
}

@end
