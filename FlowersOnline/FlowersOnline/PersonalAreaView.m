//
//  PersonalAreaView.m
//  FlowersOnline
//
//  Created by Виктор Мишустин on 05.06.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "PersonalAreaView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "CustomLabels.h"
#import "Auth.h"
#import "AuthDBClass.h"

@interface PersonalAreaView ()

@property (strong, nonatomic) NSArray * arrayData;

@end

@implementation PersonalAreaView
{
    UITableView * mainTableView;
    NSMutableArray * testArray;
}

- (instancetype)initWithView: (UIView*) view andData: (NSArray*) dataArray
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 64, view.frame.size.width, view.frame.size.height);
        
        self.arrayData = dataArray;
        

        //Имя пользовтаеля---------------------
        CustomLabels * labelName = [[CustomLabels alloc] initLabelBondWithWidht:20 andHeight:15 andColor:COLORTEXTGRAY andText:@"Гость"];

        
        
        //Заголовк телефон-------------------
        CustomLabels * labelTintPhone = [[CustomLabels alloc] initLabelBondWithWidht:20
                                                                           andHeight:labelName.frame.origin.y + labelName.frame.size.height + 2
                                                                            andColor:COLORGREEN andText:@"Тел:"];
        
        
        
        
        //Данные Телефон
        CustomLabels * labelTintPhoneAct = [[CustomLabels alloc] initLabelRegularWithWidht:25 + labelTintPhone.frame.size.width
                                                                           andHeight:labelName.frame.origin.y + labelName.frame.size.height + 2
                                                                            andColor:COLORTEXTGRAY andText:@"+7 xxx xxx xx xx"];

        
        
        //Заголовк почта-------------------
        CustomLabels * labelTintEmail = [[CustomLabels alloc] initLabelBondWithWidht:20
                                                                           andHeight:labelTintPhone.frame.origin.y + labelTintPhone.frame.size.height + 2
                                                                            andColor:COLORGREEN andText:@"Email:"];
        
        
        
        //Заголовк почта изменяемый-------------------
        CustomLabels * labelTintEmailAct = [[CustomLabels alloc] initLabelRegularWithWidht:25 + labelTintEmail.frame.size.width
                                                                           andHeight:labelTintPhone.frame.origin.y + labelTintPhone.frame.size.height + 2
                                                                            andColor:COLORTEXTGRAY andText:@"goust@email.com"];
        
        
        AuthDBClass * authDbClass = [AuthDBClass new];
        if([authDbClass checkRegistration]){
            NSLog(@"ДАННЫЕ ЕСТЬ");
            NSArray * userArray = [authDbClass showAllUsers];
            Auth * auth = [userArray objectAtIndex:0];
            labelName.text = auth.name;
            [labelName sizeToFit];
            labelTintPhoneAct.text = auth.phone;
            [labelTintPhoneAct sizeToFit];
            labelTintEmailAct.text = auth.email;
            [labelTintEmailAct sizeToFit];
        }
        
        [self addSubview:labelName];
        [self addSubview:labelTintPhone];
        [self addSubview:labelTintPhoneAct];
        [self addSubview:labelTintEmail];
        [self addSubview:labelTintEmailAct];
        
        //Вью Фон Для таблицы-------
        UIView * viewFoneForTable = [[UIView alloc] initWithFrame:CGRectMake(0, labelTintEmail.frame.origin.y + labelTintEmail.frame.size.height + 15, self.frame.size.width, 40)];
        viewFoneForTable.backgroundColor = [UIColor colorWithHexString:COLORGRAY];
        [self addSubview:viewFoneForTable];
        
        //Заголовок для таблицы------
        CustomLabels * labelTintTable = [[CustomLabels alloc] initLabelBondWithWidht:20 andHeight:viewFoneForTable.frame.origin.y + 11 andColor:COLORTEXTGRAY andText:@"Мои заказы"];
        [self addSubview:labelTintTable];
        
        //Создание таблицы заказов----
        mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, viewFoneForTable.frame.origin.y + viewFoneForTable.frame.size.height, self.frame.size.width, self.frame.size.height - (viewFoneForTable.frame.origin.y + viewFoneForTable.frame.size.height) - 64)];
        //Убираем полосы разделяющие ячейки------------------------------
        mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.showsVerticalScrollIndicator = NO;
        //Очень полездное свойство, отключает дествие ячейки-------------
        mainTableView.allowsSelection = NO;
        [self addSubview:mainTableView];
        
        

    }
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
    NSDictionary * dictCell = [self.arrayData objectAtIndex:indexPath.row];
    
    if (self.arrayData.count != 0) {
        [cell.contentView addSubview:[self setTableCellWithDate:[dictCell objectForKey:@"date"]
                                                          andID:[dictCell objectForKey:@"id"]
                                                        andSumm:[dictCell objectForKey:@"total_price"]
                                                      andStatus:[dictCell objectForKey:@"status"]]];
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
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 46.f;
}

#pragma mark - CustomCell

//Кастомная ячейка---------------------------------------
- (UIView*) setTableCellWithDate: (NSString*) date
                      andID: (NSString*) textID
                         andSumm: (NSString*) summ
                           andStatus: (NSString*) status
{
    //Основное окно ячейки--------------------------------
    UIView * cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 46)];
    cellView.backgroundColor = nil;
    
    //Лэйбл даты-------------
    CustomLabels * labelDate = [[CustomLabels alloc] initLabelTableWithWidht:0 andHeight:0 andSizeWidht:cellView.frame.size.width / 4 andSizeHeight:46 andColor:COLORTEXTGRAY andText:date];
    labelDate.font = [UIFont fontWithName:FONTREGULAR size:13];
    if (isiPhone5 || isiPhone4s) {
        labelDate.font = [UIFont fontWithName:FONTREGULAR size:11];
    }
    [cellView addSubview:labelDate];
    
    //Лейбл id
    NSString * numOrder = [NSString stringWithFormat:@"№ %@",textID];
    CustomLabels * labelID = [[CustomLabels alloc] initLabelTableWithWidht:labelDate.frame.size.width - 10 andHeight:0 andSizeWidht:labelDate.frame.size.width andSizeHeight:46 andColor:COLORTEXTGRAY andText:numOrder];
    labelID.font = [UIFont fontWithName:FONTREGULAR size:13];
    if (isiPhone5 || isiPhone4s) {
        labelID.font = [UIFont fontWithName:FONTREGULAR size:11];
    }
    [cellView addSubview:labelID];
    
    //Лейбл суммы
    
    NSString * summOrder = [NSString stringWithFormat:@"%@ руб.",summ];
    CustomLabels * labelName = [[CustomLabels alloc] initLabelTableWithWidht:labelDate.frame.size.width * 2 - 10 andHeight:0 andSizeWidht:labelDate.frame.size.width + 12 andSizeHeight:46 andColor:COLORTEXTGRAY andText:summOrder];
    labelName.font = [UIFont fontWithName:FONTBOND size:13];
    if (isiPhone5 || isiPhone4s) {
        labelName.font = [UIFont fontWithName:FONTBOND size:11];
    }
    [cellView addSubview:labelName];
    
    //Лейбл статуса
    if ([status isEqualToString:@"0"]) {
        CustomLabels * labelStatus = [[CustomLabels alloc] initLabelTableWithWidht:8 + labelDate.frame.size.width * 3 andHeight:0 andSizeWidht:labelDate.frame.size.width andSizeHeight:46 andColor:COLORGREEN andText:@"Новый"];
        labelStatus.font = [UIFont fontWithName:FONTREGULAR size:13];
        if (isiPhone5 || isiPhone4s) {
            labelStatus.font = [UIFont fontWithName:FONTREGULAR size:11];
        }
        [cellView addSubview:labelStatus];
    } else if ([status isEqualToString:@"1"]) {
        CustomLabels * labelStatus = [[CustomLabels alloc] initLabelTableWithWidht:8 + labelDate.frame.size.width * 3 andHeight:0 andSizeWidht:labelDate.frame.size.width andSizeHeight:46 andColor:COLORGREEN andText:@"Принят"];
        labelStatus.font = [UIFont fontWithName:FONTREGULAR size:13];
        if (isiPhone5 || isiPhone4s) {
            labelStatus.font = [UIFont fontWithName:FONTREGULAR size:11];
        }
        [cellView addSubview:labelStatus];
    
    } else if ([status isEqualToString:@"2"]) {
        CustomLabels * labelStatus = [[CustomLabels alloc] initLabelTableWithWidht:labelDate.frame.size.width * 3 andHeight:0 andSizeWidht:labelDate.frame.size.width andSizeHeight:46 andColor:@"b7b8b6" andText:@"Выполнен"];
        labelStatus.font = [UIFont fontWithName:FONTREGULAR size:13];
        if (isiPhone5 || isiPhone4s) {
            labelStatus.font = [UIFont fontWithName:FONTREGULAR size:11];
        }
        [cellView addSubview:labelStatus];
    } else if ([status isEqualToString:@"3"]) {
        CustomLabels * labelStatus = [[CustomLabels alloc] initLabelTableWithWidht:labelDate.frame.size.width * 3 andHeight:0 andSizeWidht:labelDate.frame.size.width andSizeHeight:46 andColor:@"b7b8b6" andText:@"Удален"];
        labelStatus.font = [UIFont fontWithName:FONTREGULAR size:13];
        if (isiPhone5 || isiPhone4s) {
            labelStatus.font = [UIFont fontWithName:FONTREGULAR size:11];
        }
        [cellView addSubview:labelStatus];

    } else {
        NSLog(@"Error");
    }
    
    return cellView;

}






//создадим тестовый массив-----------
- (NSMutableArray *) setArrayTest
{
    NSMutableArray * arrayOrder = [[NSMutableArray alloc] init];
    
    NSArray * arrayDate = [NSArray arrayWithObjects:
                            @"25.04.2016", @"21.04.2016", @"21.04.2016",
                            @"21.04.2016", @"12.02.2015", nil];
    
    NSArray * arrayID = [NSArray arrayWithObjects:
                               @"№ 456453", @"№ 456453",
                               @"№ 456453", @"№ 456453", @"№ 456421", nil];
    
    
    NSArray * arrayName = [NSArray arrayWithObjects:
                           @"Букет “Сатурн”", @"Букет “5 роз”", @"Букет “Палитра”",
                           @"Букет “5 роз”", @"Букет “5 роз”", nil];
    
    NSArray * arrayStatus = [NSArray arrayWithObjects:
                           @"В пути", @"В пути", @"В пути",
                           @"Выполнен", @"Выполнен", nil];
    
    
    for (int i = 0; i < arrayDate.count; i++) {
        
        NSDictionary * dictOrder = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [arrayDate objectAtIndex:i], @"date",
                                   [arrayID objectAtIndex:i], @"id",
                                   [arrayName objectAtIndex:i], @"name",
                                   [arrayStatus objectAtIndex:i], @"status", nil];
        
        [arrayOrder addObject:dictOrder];
    }
    
    return arrayOrder;
}






@end
