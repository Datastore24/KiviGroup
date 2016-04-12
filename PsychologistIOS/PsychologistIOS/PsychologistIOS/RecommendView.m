//
//  RecommendView.m
//  PsychologistIOS
//
//  Created by Viktor on 10.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "RecommendView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"

@interface RecommendView () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation RecommendView
{
    UITableView * mainTableViewRecommend;
}

- (instancetype)initWithView: (UIView*) view andArray: (NSMutableArray*) array;
{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height - 64);
        
        mainTableViewRecommend = [[UITableView alloc] initWithFrame:CGRectMake(0, 24, self.frame.size.width, self.frame.size.height - 24) style:UITableViewStylePlain];
        //Убираем полосы разделяющие ячейки------------------------------
        mainTableViewRecommend.separatorStyle = UITableViewCellSeparatorStyleNone;
        mainTableViewRecommend.dataSource = self;
        mainTableViewRecommend.delegate = self;
        mainTableViewRecommend.showsVerticalScrollIndicator = NO;
        [self addSubview:mainTableViewRecommend];
        
        
        
    }
    return self;
}

- (UIView*) setTableCellWithImage: (NSString*) image
                         andTitle: (NSString*) title
                      andSubTitle: (NSString*) subTitle
                          ansSite: (NSString*) site
                          andMail: (NSString*) mail
                     andButtonTag: (NSInteger) buttonTag
{
    //основное вью ячейки-----------------------------------------
    UIView * viewCell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 144)];
    
    //Картинка ячейки---------------------------------------------
    UIImageView * imageViewCell = [[UIImageView alloc] initWithFrame:CGRectMake(32, 16, 80, 80)];
    imageViewCell.image = [UIImage imageNamed:image];
    [viewCell addSubview:imageViewCell];
    
    //Заголовок---------------------------------------------------
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(144, 16, 200, 24)];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor colorWithHexString:@"8a8a8a"];
    titleLabel.font = [UIFont fontWithName:FONTREGULAR size:22];
    [viewCell addSubview:titleLabel];
    
    //Подзаголовок-----------------------------------------------
    UILabel * subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(144, 40, 200, 16)];
    subTitleLabel.text = subTitle;
    subTitleLabel.textColor = [UIColor colorWithHexString:@"f26e6e"];
    subTitleLabel.font = [UIFont fontWithName:FONTLITE size:12];
    [viewCell addSubview:subTitleLabel];
    
    //Сайт-------------------------------------------------------
    UILabel * labelSite = [[UILabel alloc] initWithFrame:CGRectMake(144, 56, 200, 16)];
    labelSite.text = site;
    labelSite.textColor = [UIColor colorWithHexString:@"777575"];
    labelSite.font = [UIFont fontWithName:FONTLITE size:12];
    [viewCell addSubview:labelSite];
    
    //Почта------------------------------------------------------
    UILabel * labelMail = [[UILabel alloc] initWithFrame:CGRectMake(32, 102, 90, 16)];
    labelMail.text = mail;
    labelMail.textColor = [UIColor colorWithHexString:@"f26e6e"];
    labelMail.font = [UIFont fontWithName:FONTLITE size:11];
    [viewCell addSubview:labelMail];
    
    //Кнопка подвонить-------------------------------------------
    UIButton * callButton = [UIButton buttonWithType:UIButtonTypeSystem];
    callButton.frame = CGRectMake(144, 76, viewCell.frame.size.width - 32 - 144, 24);
    callButton.backgroundColor = [UIColor colorWithHexString:@"36b34c"];
    [callButton setTitle:@"ПОЗВОНИТЬ" forState:UIControlStateNormal];
    callButton.tag = 50 + buttonTag;
    callButton.layer.cornerRadius = 10.f;
    [callButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    callButton.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:15];
    [callButton addTarget:self action:@selector(callButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewCell addSubview:callButton];
    
    //Кнопка обратный звонок----------------------------------------
    UIButton * backCallButton = [UIButton buttonWithType:UIButtonTypeSystem];
    backCallButton.frame = CGRectMake(144, 108, viewCell.frame.size.width - 32 - 144, 24);
    backCallButton.backgroundColor = [UIColor colorWithHexString:@"0076a2"];
    [backCallButton setTitle:@"ОБРАТНЫЙ ЗВОНОК" forState:UIControlStateNormal];
    backCallButton.tag = 60 + buttonTag;
    backCallButton.layer.cornerRadius = 10.f;
    [backCallButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backCallButton.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:15];
    [backCallButton addTarget:self action:@selector(backCallButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewCell addSubview:backCallButton];
    
    return viewCell;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"newFriendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.backgroundColor = nil;
    
    [cell addSubview:[self setTableCellWithImage:@"imageCellRecommend.png" andTitle:@"Ксения Буракова" andSubTitle:@"Профессиональный психолог" ansSite:@"www.soulsite.com" andMail:@"Soul@gmail.com" andButtonTag:indexPath.row]];
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 144;
}

#pragma mark - Action Methods

//Действие кнопки позвонить
- (void) callButtonAction: (UIButton*) button
{

    NSLog(@"Позвонить");
}

//Дествие кнопки обраный звонок
- (void) backCallButtonAction: (UIButton*) button
{
    NSLog(@"Обратный звонок");
}



@end
