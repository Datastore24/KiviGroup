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
#import "StringImage.h"
#import "ViewSectionTable.h"

@interface BookmarksView () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation BookmarksView
{
    NSMutableArray * mainArray;
    UITableView * mainTableView;
    NSDictionary * dictInform;
}

- (instancetype)initWithBackgroundView: (UIView*) view
{
    self = [super init];
    if (self) {
        //Фоновая картинка--------------------
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        UIImageView * backgroundView = [[UIImageView alloc] initWithFrame:self.frame];
        backgroundView.image = [UIImage imageNamed:@"fonAlpha.png"];
        [self addSubview:backgroundView];
    }
    return self;
}


- (instancetype)initWithContent: (UIView*) view andArray: (NSArray*) array
{
    self = [super init];
    if (self) {
        
        //Основной контент---------------------
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        mainArray = [NSMutableArray arrayWithArray:array];
        
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
        } else if (isiPhone5) {
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
    return mainArray.count;
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
    
    NSDictionary * dictCell = [mainArray objectAtIndex:indexPath.row];
    
    NSString * type;
    if ([[dictCell objectForKey:@"type"] isEqualToString:@"post"]) {
        type = @"Тема";
    } else if ([[dictCell objectForKey:@"type"] isEqualToString:@"subcategory"]) {
        type = @"Категория";
    } else if ([[dictCell objectForKey:@"type"] isEqualToString:@"category"]) {
        type = @"Раздел";
    } else {
        type = @"";
    }
    

    dictInform = [dictCell objectForKey:@"inform"];
    NSString * stringURL = [StringImage createStringImageURLWithString:[dictInform objectForKey:@"media_path"]];
    [cell.contentView addSubview:[self setTableCellWithTitle:[dictInform objectForKey:@"title"]
                                     andSubTitle:[dictInform objectForKey:@"description"]
                                        andImage:stringURL
                                        andTrial:nil
                                  andNotifiction:nil
                                         andType:type]];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView beginUpdates];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSDictionary * dictCell = [mainArray objectAtIndex:indexPath.row];
        NSLog(@"%@", dictCell);
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_DELET_CELL_BOOKMARK object:nil userInfo:dictCell];
        [mainArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
    }
    [tableView endUpdates];
}

#pragma mark - UITableViewDelegate
//Анимация нажатия ячейки--------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; 
    NSDictionary * dictCell = [mainArray objectAtIndex:indexPath.row];
    
    if ([[dictCell objectForKey:@"type"] isEqualToString:@"post"]) {
        NSDictionary * dictSubject = [dictCell objectForKey:@"inform"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_PUSH_BOOKMARK_SUBJECT object:nil userInfo:dictSubject];
        [[SingleTone sharedManager] setIdentifierSubjectModel:[dictSubject objectForKey:@"id"]];
        [[SingleTone sharedManager] setTitleSubject:[dictSubject objectForKey:@"title"]];
        NSLog(@"dictCell тема %@", dictCell);
    } else if ([[dictCell objectForKey:@"type"] isEqualToString:@"subcategory"]) {
        NSDictionary * dictSubCategory = [dictCell objectForKey:@"inform"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_PUSH_BOOKMARK_SUB_CATEGORY object:nil userInfo:dictSubCategory];
        [[SingleTone sharedManager] setIdentifierSubCategory:[dictSubCategory objectForKey:@"id"]];
        [[SingleTone sharedManager] setTitleSubCategory:[dictSubCategory objectForKey:@"title"]];
        NSLog(@"dictCell категория %@", dictCell);
    } else if ([[dictCell objectForKey:@"type"] isEqualToString:@"category"]) {
        NSDictionary * dictCategory = [dictCell objectForKey:@"inform"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_PUSH_BOOKMARK_CATEGORY object:nil userInfo:dictCategory];
        [[SingleTone sharedManager] setIdentifierCategory:[dictCategory objectForKey:@"id"]];
        [[SingleTone sharedManager] setTitleCategory:[dictCategory objectForKey:@"title"]];
        
    } else {
        NSLog(@"Error");
    }
    
//    [[SingleTone sharedManager] setTitleSubject:[dictInform objectForKey:@"title"]];
//    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_PUSH_BOOKMARKS_WITH_OPENSUBJECT object:[dictCell objectForKey:@"title"]];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isiPhone6) {
        return 112;
    } else if (isiPhone5) {
        return 100;
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
                          andType: (NSString*) type
{
    //Основное окно ячейки--------------------------------
    UIView * cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 128)];
    if (isiPhone6) {
        cellView.frame = CGRectMake(0, 0, self.frame.size.width, 112);
    } else if (isiPhone5) {
        cellView.frame = CGRectMake(0, 0, self.frame.size.width, 100);
    }
    cellView.backgroundColor = nil;
    
    
    //Создаем картинку------------------------------------
    UIView * imageViewCategory = [[UIView alloc] initWithFrame:CGRectMake(16, 10, 96, 96)];
    imageViewCategory.layer.cornerRadius = 0.5;
    if (isiPhone6) {
        imageViewCategory.frame = CGRectMake(12, 11, 88, 88);
    } else if (isiPhone5) {
        imageViewCategory.frame = CGRectMake(12, 11, 80, 80);
    }
    
    ViewSectionTable * viewSectionTable = [[ViewSectionTable alloc] initWithImageURL:image andView:nil andContentMode:UIViewContentModeScaleAspectFill];
    [imageViewCategory addSubview:viewSectionTable];
    
    
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
    } else if (isiPhone5) {
        labelTitle.frame = CGRectMake(100, 14, 200, 24);
        labelTitle.font = [UIFont fontWithName:FONTLITE size:18];
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
    } else if (isiPhone5) {
        labelSubTitle.frame = CGRectMake(100, 20 + labelTitle.frame.size.height, 216, 16);
        labelSubTitle.font = [UIFont fontWithName:FONTLITE size:12];
    }
    [cellView addSubview:labelSubTitle];
    
    //Тип----------------------------------------
    UILabel * labelType = [[UILabel alloc] initWithFrame:CGRectMake(136, 16 + labelSubTitle.frame.size.height + labelSubTitle.frame.origin.y, 216, 16)];
    labelType.text = type;
    labelType.textColor = [UIColor colorWithHexString:@"676766"];
    labelType.numberOfLines = 0;
    labelType.font = [UIFont fontWithName:FONTLITE size:16];
    if (isiPhone6) {
        labelType.frame = CGRectMake(120, 16 + labelTitle.frame.size.height, 216, 16);
        labelType.font = [UIFont fontWithName:FONTLITE size:15];
    } else if (isiPhone5) {
        labelType.frame = CGRectMake(100, 20 + labelTitle.frame.size.height, 216, 16);
        labelType.font = [UIFont fontWithName:FONTLITE size:12];
    }
    [cellView addSubview:labelType];
    
    //Граница ячейки--------------------------------------
    UIView * viewBorder = [[UIView alloc] initWithFrame:CGRectMake(16, 127, cellView.frame.size.width - 32, 1)];
    if (isiPhone6) {
        viewBorder.frame = CGRectMake(16, 111, cellView.frame.size.width - 32, 1);
    } else if (isiPhone5) {
        viewBorder.frame = CGRectMake(16, 99, cellView.frame.size.width - 32, 1);
    }
    viewBorder.backgroundColor = [UIColor colorWithHexString:@"c0c0c0"];
    [cellView addSubview:viewBorder];
    
    //Стрелка перехода------------------------------------
    UIImageView * arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(cellView.frame.size.width - 48, 40, 16, 48)];
    if (isiPhone6) {
        arrowImage.frame = CGRectMake(cellView.frame.size.width - 48, cellView.frame.size.height / 2 - 24, 16, 48);
    } else if (isiPhone5) {
        arrowImage.frame = CGRectMake(cellView.frame.size.width - 40, cellView.frame.size.height / 2 - 20, 13, 40);
    }
    arrowImage.image = [UIImage imageNamed:@"arrowImage.png"];
    [cellView addSubview:arrowImage];
    
//    //Нотификации-----------------------------------------
//    if ([notific integerValue] != 0) {
//        UIView * viewNotification = [[UIView alloc] initWithFrame:CGRectMake(cellView.frame.size.width - 56, 16, 40, 40)];
//        viewNotification.backgroundColor = [UIColor colorWithHexString:@"f92502"];
//        viewNotification.layer.cornerRadius = 20;
//        if (isiPhone6) {
//            viewNotification.frame = CGRectMake(cellView.frame.size.width - 56, 16, 34, 34);
//            viewNotification.layer.cornerRadius = 17;
//        } else if (isiPhone5) {
//            viewNotification.frame = CGRectMake(cellView.frame.size.width - 56, 16, 30, 30);
//            viewNotification.layer.cornerRadius = 15;
//        }
//        [cellView addSubview:viewNotification];
//        
//        UILabel * labelNotification = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//        labelNotification.text = [NSString stringWithFormat:@"%ld", (long)[notific integerValue]];
//        labelNotification.textColor = [UIColor whiteColor];
//        labelNotification.textAlignment = NSTextAlignmentCenter;
//        labelNotification.font = [UIFont fontWithName:FONTREGULAR size:19];
//        if (isiPhone6) {
//            labelNotification.frame = CGRectMake(0, 0, 34, 34);
//            labelNotification.font = [UIFont fontWithName:FONTREGULAR size:17];
//        } else if (isiPhone5) {
//            labelNotification.frame = CGRectMake(0, 0, 30, 30);
//            labelNotification.font = [UIFont fontWithName:FONTREGULAR size:15];
//        }
//        [viewNotification addSubview:labelNotification];
//    }
//    
//    //Срок действия------------------------------------------
//    // 0 - бесплатная, 1 - платная оплаченная, 2 - платная закончилась
//    if ([trial integerValue] == 1) {
//        UILabel * labelTrial = [[UILabel alloc] initWithFrame:CGRectMake(136, labelSubTitle.frame.size.height + labelSubTitle.frame.origin.y + 24, 200, 16)];
//        labelTrial.text = @"Доступен до 1.04.2016";
//        labelTrial.textColor = [UIColor colorWithHexString:@"676766"];
//        labelTrial.font = [UIFont fontWithName:FONTLITE size:13];
//        if (isiPhone6) {
//            labelTrial.frame = CGRectMake(120, labelSubTitle.frame.size.height + labelSubTitle.frame.origin.y + 14, 200, 16);
//            labelTrial.font = [UIFont fontWithName:FONTLITE size:12];
//        } else if (isiPhone5) {
//            labelTrial.frame = CGRectMake(100, labelSubTitle.frame.size.height + labelSubTitle.frame.origin.y + 14, 200, 16);
//            labelTrial.font = [UIFont fontWithName:FONTLITE size:10];
//        }
//        [cellView addSubview:labelTrial];
//    } else if ([trial integerValue] == 2) {
//        UIButton * buttonBuyTrial = [UIButton buttonWithType:UIButtonTypeSystem];
//        buttonBuyTrial.frame = CGRectMake(136, labelSubTitle.frame.size.height + labelSubTitle.frame.origin.y + 24, 110, 16);
//        [buttonBuyTrial setTitle:@"Продлить доступ" forState:UIControlStateNormal];
//        [buttonBuyTrial setTitleColor:[UIColor colorWithHexString:@"676766"] forState:UIControlStateNormal];
//        buttonBuyTrial.titleLabel.font = [UIFont fontWithName:FONTLITE size:13];
//        if (isiPhone6) {
//            buttonBuyTrial.frame = CGRectMake(111, labelSubTitle.frame.size.height + labelSubTitle.frame.origin.y + 14, 110, 16);
//            buttonBuyTrial.titleLabel.font = [UIFont fontWithName:FONTLITE size:12];
//        } else if (isiPhone5) {
//            buttonBuyTrial.frame = CGRectMake(90, labelSubTitle.frame.size.height + labelSubTitle.frame.origin.y + 14, 110, 16);
//            buttonBuyTrial.titleLabel.font = [UIFont fontWithName:FONTLITE size:10];
//        }
//        [buttonBuyTrial addTarget:self action:@selector(buttonBuyTrialActiob) forControlEvents:UIControlEventTouchUpInside];
//        [cellView addSubview:buttonBuyTrial];
//    }
    
    return cellView;
}

#pragma mark - Action Methods

//Действие кнопки продлить доступ
- (void) buttonBuyTrialActiob
{
    NSLog(@"Продлить доступ");
}


@end
