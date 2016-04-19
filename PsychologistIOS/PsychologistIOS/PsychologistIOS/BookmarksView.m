//
//  BookmarksView.m
//  PsychologistIOS
//
//  Created by Viktor on 12.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "BookmarksView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "SingleTone.h"

@interface BookmarksView () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation BookmarksView
{
    NSMutableArray * mainArray;
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


- (instancetype)initWithContent: (UIView*) view andArray: (NSMutableArray*) array
{
    self = [super init];
    if (self) {
        
        //Основной контент---------------------
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height - 64);
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
        if (isiPhone6) {
            mainTableView.frame = CGRectMake(0, 40, self.frame.size.width, self.frame.size.height - 40);
        }
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
                                        andImage:[dictCell objectForKey:@"image"]
                                        andTrial:[dictCell objectForKey:@"trial"]
                                  andNotifiction:[dictCell objectForKey:@"notification"]]];
    
    return cell;
}

#pragma mark - UITableViewDelegate
//Анимация нажатия ячейки--------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; 
    NSDictionary * dictCell = [mainArray objectAtIndex:indexPath.row];
    
    [[SingleTone sharedManager] setTitleSubject:[dictCell objectForKey:@"title"]];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_PUSH_BOOKMARKS_WITH_OPENSUBJECT object:[dictCell objectForKey:@"title"]];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isiPhone6) {
        return 112;
    } else {
        return 128;
    }
}

#pragma mark - CustomCell

//Кастомная ячейка---------------------------------------
- (UIView*) setTableCellWithTitle: (NSString*) string
                      andSubTitle: (NSString*) subTitle
                         andImage: (NSString*) image
                         andTrial: (NSNumber*) trial
                   andNotifiction: (NSNumber*) notific
{
    //Основное окно ячейки--------------------------------
    UIView * cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 128)];
    if (isiPhone6) {
        cellView.frame = CGRectMake(0, 0, self.frame.size.width, 112);
    }
    cellView.backgroundColor = nil;
    
    //Создаем картинку------------------------------------
    UIImageView * imageViewCategory = [[UIImageView alloc] initWithFrame:CGRectMake(16, 16, 96, 96)];
    imageViewCategory.layer.cornerRadius = 0.5;
    if (isiPhone6) {
        imageViewCategory.frame = CGRectMake(12, 11, 88, 88);
    }
    imageViewCategory.image = [UIImage imageNamed:image];
    [cellView addSubview:imageViewCategory];
    
    //Заголовок-------------------------------------------
    UILabel * labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(136, 16, 216, 24)];
    labelTitle.text = string;
    labelTitle.numberOfLines = 0;
    labelTitle.textColor = [UIColor colorWithHexString:@"d46458"];
    labelTitle.font = [UIFont fontWithName:FONTLITE size:23];
    if (isiPhone6) {
        labelTitle.frame = CGRectMake(120, 16, 216, 24);
        labelTitle.font = [UIFont fontWithName:FONTLITE size:22];
    }
    [labelTitle sizeToFit];
    [cellView addSubview:labelTitle];
    
    //Подзаголовок----------------------------------------
    UILabel * labelSubTitle = [[UILabel alloc] initWithFrame:CGRectMake(136, 16 + labelTitle.frame.size.height, 216, 16)];
    labelSubTitle.text = subTitle;
    labelSubTitle.textColor = [UIColor colorWithHexString:@"676766"];
    labelSubTitle.numberOfLines = 0;
    labelSubTitle.font = [UIFont fontWithName:FONTLITE size:16];
    if (isiPhone6) {
        labelSubTitle.frame = CGRectMake(120, 16 + labelTitle.frame.size.height, 216, 16);
        labelSubTitle.font = [UIFont fontWithName:FONTLITE size:15];
    }
    [labelSubTitle sizeToFit];
    [cellView addSubview:labelSubTitle];
    
    //Граница ячейки--------------------------------------
    UIView * viewBorder = [[UIView alloc] initWithFrame:CGRectMake(16, 127, cellView.frame.size.width - 32, 1)];
    if (isiPhone6) {
        viewBorder.frame = CGRectMake(16, 111, cellView.frame.size.width - 32, 1);
    }
    viewBorder.backgroundColor = [UIColor colorWithHexString:@"c0c0c0"];
    [cellView addSubview:viewBorder];
    
    //Нотификации-----------------------------------------
    if ([notific integerValue] != 0) {
        UIView * viewNotification = [[UIView alloc] initWithFrame:CGRectMake(cellView.frame.size.width - 56, 16, 40, 40)];
        viewNotification.backgroundColor = [UIColor colorWithHexString:@"f92502"];
        viewNotification.layer.cornerRadius = 20;
        if (isiPhone6) {
            viewNotification.frame = CGRectMake(cellView.frame.size.width - 56, 16, 34, 34);
            viewNotification.layer.cornerRadius = 17;
        }
        [cellView addSubview:viewNotification];
        
        UILabel * labelNotification = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        labelNotification.text = [NSString stringWithFormat:@"%ld", (long)[notific integerValue]];
        labelNotification.textColor = [UIColor whiteColor];
        labelNotification.textAlignment = NSTextAlignmentCenter;
        labelNotification.font = [UIFont fontWithName:FONTREGULAR size:19];
        if (isiPhone6) {
            labelNotification.frame = CGRectMake(0, 0, 34, 34);
            labelNotification.font = [UIFont fontWithName:FONTREGULAR size:17];
        }
        [viewNotification addSubview:labelNotification];
    }
    
    //Срок действия------------------------------------------
    // 0 - бесплатная, 1 - платная оплаченная, 2 - платная закончилась
    if ([trial integerValue] == 1) {
        UILabel * labelTrial = [[UILabel alloc] initWithFrame:CGRectMake(136, labelSubTitle.frame.size.height + labelSubTitle.frame.origin.y + 24, 200, 16)];
        labelTrial.text = @"Доступен до 1.04.2016";
        labelTrial.textColor = [UIColor colorWithHexString:@"676766"];
        labelTrial.font = [UIFont fontWithName:FONTLITE size:13];
        if (isiPhone6) {
            labelTrial.frame = CGRectMake(120, labelSubTitle.frame.size.height + labelSubTitle.frame.origin.y + 14, 200, 16);
            labelTrial.font = [UIFont fontWithName:FONTLITE size:12];
        }
        [cellView addSubview:labelTrial];
    } else if ([trial integerValue] == 2) {
        UIButton * buttonBuyTrial = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonBuyTrial.frame = CGRectMake(136, labelSubTitle.frame.size.height + labelSubTitle.frame.origin.y + 24, 110, 16);
        [buttonBuyTrial setTitle:@"Продлить доступ" forState:UIControlStateNormal];
        [buttonBuyTrial setTitleColor:[UIColor colorWithHexString:@"676766"] forState:UIControlStateNormal];
        buttonBuyTrial.titleLabel.font = [UIFont fontWithName:FONTLITE size:13];
        if (isiPhone6) {
            buttonBuyTrial.frame = CGRectMake(111, labelSubTitle.frame.size.height + labelSubTitle.frame.origin.y + 14, 110, 16);
            buttonBuyTrial.titleLabel.font = [UIFont fontWithName:FONTLITE size:12];
        }
        [buttonBuyTrial addTarget:self action:@selector(buttonBuyTrialActiob) forControlEvents:UIControlEventTouchUpInside];
        [cellView addSubview:buttonBuyTrial];
    }
    
    return cellView;
}

#pragma mark - Action Methods

//Действие кнопки продлить доступ
- (void) buttonBuyTrialActiob
{
    NSLog(@"Продлить доступ");
}


@end
