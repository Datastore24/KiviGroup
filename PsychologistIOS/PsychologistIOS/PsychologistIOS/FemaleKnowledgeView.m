//
//  FemaleKnowledgeView.m
//  PsychologistIOS
//
//  Created by Viktor on 16.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "FemaleKnowledgeView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"

@interface FemaleKnowledgeView () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation FemaleKnowledgeView
{
    UITableView * mainTableView;
    NSMutableArray * mainArray;
}

- (instancetype)initWithView: (UIView*) view andArray: (NSMutableArray*) array
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height - 64);
        
        mainArray = array;
        
        mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 24, self.frame.size.width, self.frame.size.height - 40) style:UITableViewStylePlain];
        if (isiPhone6) {
            mainTableView.frame = CGRectMake(0, 5, self.frame.size.width, self.frame.size.height - 40);
        } else if (isiPhone5) {
            mainTableView.frame = CGRectMake(0, 5, self.frame.size.width, self.frame.size.height - 40);
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
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"newFriendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor = nil;
    
    NSDictionary * dictTable = [mainArray objectAtIndex:indexPath.row];
    
    [cell addSubview:[self setTableCellWithName:[dictTable objectForKey:@"Name"]
                                     andSumName:[dictTable objectForKey:@"SubName"]]];
    
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
//Анимация нажатия ячейки--------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_PUSH_FAMELE_WITH_CHAT object:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isiPhone6) {
        return 190;
    } else if (isiPhone5) {
        return 170;
    }else {
        return 216;
    }
    
}

#pragma mark - CustomCell

//Кастомная ячейка---------------------------------------
- (UIView*) setTableCellWithName: (NSString*) name
                      andSumName: (NSString*) subName
{
    //Основное окно ячейки--------------------------------
    UIView * cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 216)];
    if (isiPhone6) {
        cellView.frame = CGRectMake(0, 0, self.frame.size.width, 190);
    } else if (isiPhone5) {
        cellView.frame = CGRectMake(0, 0, self.frame.size.width, 170);
    }
    cellView.backgroundColor = nil;
    
    //Стрелка перехода------------------------------------
    UIImageView * arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(cellView.frame.size.width - 48, 80, 16, 48)];
    if (isiPhone5) {
        arrowImage.frame = CGRectMake(cellView.frame.size.width - 48, 60, 14, 42);
    }
    arrowImage.image = [UIImage imageNamed:@"arrowImage.png"];
    [cellView addSubview:arrowImage];
    
    //Основная картинка----------------------------------
    UIImageView * mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 16, 320, 180)];
    if (isiPhone6) {
        mainImageView.frame = CGRectMake(20, 20, 260, 146);
    } else if (isiPhone5) {
        mainImageView.frame = CGRectMake(20, 20, 220, 140);
    }
    mainImageView.image = [UIImage imageNamed:@"imageFamele.png"];
    [cellView addSubview:mainImageView];
    
    //Название вебинара-----------------------------------
    UILabel * labelName = [[UILabel alloc] initWithFrame:CGRectMake(32, 144, 232, 24)];
    labelName.text = name;
    labelName.textColor = [UIColor colorWithHexString:@"d46458"];
    labelName.font = [UIFont fontWithName:FONTLITE size:24];
    if (isiPhone6) {
        labelName.frame = CGRectMake(32, 125, 232, 20);
        labelName.font = [UIFont fontWithName:FONTLITE size:20];
    } else if (isiPhone5) {
        labelName.frame = CGRectMake(32, 115, 232, 20);
        labelName.font = [UIFont fontWithName:FONTLITE size:16];
    }
    [cellView addSubview:labelName];
    
    //Описание-------------------------------------------
    UILabel * subLabel = [[UILabel alloc] initWithFrame:CGRectMake(32, 172, 232, 16)];
    subLabel.text = subName;
    subLabel.textColor = [UIColor colorWithHexString:@"676766"];
    subLabel.font = [UIFont fontWithName:FONTLITE size:16];
    if (isiPhone6) {
        subLabel.frame = CGRectMake(32, 145, 232, 16);
        subLabel.font = [UIFont fontWithName:FONTLITE size:15];
    } else if (isiPhone5) {
        subLabel.frame = CGRectMake(32, 135, 232, 16);
        subLabel.font = [UIFont fontWithName:FONTLITE size:13];
    }
    [cellView addSubview:subLabel];
    
    //Картинка монетки------------------------------------
    UIImageView * imageMoney = [[UIImageView alloc] initWithFrame:CGRectMake(mainImageView.frame.size.width - 16, 155, 56, 56)];
    if (isiPhone6) {
        imageMoney.frame = CGRectMake(mainImageView.frame.size.width - 16, 135, 50, 50);
    } else if (isiPhone5) {
        imageMoney.frame = CGRectMake(mainImageView.frame.size.width - 14, 120, 44, 44);
    }
    imageMoney.image = [UIImage imageNamed:@"imageMoneyWeb.png"];
    [cellView addSubview:imageMoney];
    
    //Граница ячейки--------------------------------------
    UIView * viewBorder = [[UIView alloc] initWithFrame:CGRectMake(16, 215, cellView.frame.size.width - 32, 1)];
    if (isiPhone6) {
        viewBorder.frame = CGRectMake(16, 189, cellView.frame.size.width - 32, 1);
    } else if (isiPhone5) {
        viewBorder.frame = CGRectMake(16, 169, cellView.frame.size.width - 32, 1);
    }
    viewBorder.backgroundColor = [UIColor colorWithHexString:@"c0c0c0"];
    [cellView addSubview:viewBorder];
    
    return cellView;
    
}

@end
