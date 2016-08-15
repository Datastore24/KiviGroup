//
//  BouquetsView.m
//  FlowersOnline
//
//  Created by Виктор Мишустин on 05.06.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "BouquetsView.h"
#import "UIColor+HexColor.h"
#import "CustomButton.h"
#import "CustomLabels.h"
#import "Macros.h"
#import "SingleTone.h"
#import "ViewSectionTable.h"
#import "TextMethodClass.h"
#import "MessagePopUp.h"

@interface BouquetsView ()

@property (strong, nonatomic) NSArray * arrayData;
@property (strong, nonatomic) NSArray * arrayCategory;
@property (strong, nonatomic) NSDictionary * mainDict;

@property (strong, nonatomic) NSArray * arrayPrice;
@property (strong, nonatomic) UIView * categoryMainView;

@property (strong, nonatomic) UITableView * tableCategory;
@property (strong, nonatomic) UIView * darkView;

@property (strong, nonatomic) UIView * viewDescription;
@property (strong, nonatomic) UILabel * labelDescriprion;
@property (strong, nonatomic) UIScrollView * scrollDescripton;
@property (strong, nonatomic) UIButton * buttonDescription;

@end

@implementation BouquetsView

{
    UIScrollView * mainScrollView;
    NSMutableArray * arrayScroll;
    NSMutableArray * arrayControl;
    NSMutableArray * buttonsArray;
    NSDictionary * dictPrice;
    UITableView * tablePrice;
    NSMutableArray * mArray;
    NSMutableArray * sort;
}


- (instancetype)initWithView: (UIView*) view andArrayData: (NSArray*) array andCategoryData: (NSArray*) catData
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 64, view.frame.size.width, view.frame.size.height - 64);
        
        self.arrayData = array;
        self.arrayCategory = catData;
        arrayScroll = [[NSMutableArray alloc] init];
        arrayControl = [[NSMutableArray alloc] init];
        buttonsArray = [[NSMutableArray alloc] init];
        mArray = [[NSMutableArray alloc] init];
        

        //Наносим основной скрол вью
        mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, self.frame.size.width, self.frame.size.height - 40)];
        mainScrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:mainScrollView];
        
                mainScrollView.contentSize = CGSizeMake(0, self.frame.size.width * self.arrayData.count);
        
        //Создаем циклБукетов
        for (int i = 0; i < self.arrayData.count; i++) {
            
            self.mainDict = [self.arrayData objectAtIndex:i];
            NSArray * arrayImages = [NSArray arrayWithArray:[self.mainDict objectForKey:@"img"]];
            
            //Инициализация scrollView-----------------------------------------
            UIScrollView * scrollImages = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.frame.size.width * i, self.frame.size.width, self.frame.size.width)];
            [scrollImages setDelegate:self];
            [scrollImages setPagingEnabled:YES];
            [scrollImages setContentSize:CGSizeMake(self.frame.size.width, self.frame.size.width)]; // задаем количество слайдов
            scrollImages.showsHorizontalScrollIndicator = NO;
            [scrollImages setBackgroundColor:[UIColor whiteColor]]; // цвет фона скролвью
            [arrayScroll addObject:scrollImages];
            [mainScrollView addSubview:scrollImages];
            NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [arrayImages objectAtIndex:0]]];
            UIImage * image = [UIImage imageWithData: imageData];
            
            
            UIImageView * view1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width)];
            view1.contentMode=UIViewContentModeScaleAspectFill;
            view1.image = image;
            [scrollImages addSubview:view1];
            
            //Фоновое вью для отображения цены и наименования-------------------
            UIView * borderView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f + self.frame.size.width * i, self.frame.size.width, 20.f)];
            borderView.backgroundColor = [UIColor blackColor];
            borderView.alpha = 0.7f;
            [mainScrollView addSubview:borderView];
            
            
            //Загаловок букета----------------------------------------------------
            CustomLabels * labelTitle = [[CustomLabels alloc] initLabelTableWithWidht:20 andHeight:0 + self.frame.size.width * i andSizeWidht:200 andSizeHeight:20 andColor:@"ffffff" andText:[self.mainDict objectForKey:@"name"]];
            labelTitle.font = [UIFont fontWithName:FONTLITE size:16];
            if (isiPhone5 || isiPhone4s) {
                labelTitle.font = [UIFont fontWithName:FONTLITE size:14];
            }
            labelTitle.textAlignment = NSTextAlignmentLeft;
            [mainScrollView addSubview:labelTitle];
            
            //Средняя цена букета--------------------------------------------------
       
            NSDictionary * variants = [[self.mainDict objectForKey:@"variants"] objectAtIndex:0];

            CustomLabels * labelPrice = [[CustomLabels alloc] initLabelTableWithWidht:self.frame.size.width - 100 andHeight:0 + self.frame.size.width * i andSizeWidht:80 andSizeHeight:20 andColor:@"ffffff" andText:[NSString stringWithFormat:@"%@ р.",[variants objectForKey:@"price"]]];
            labelPrice.font = [UIFont fontWithName:FONTLITE size:16];
            if (isiPhone5 || isiPhone4s) {
                labelPrice.font = [UIFont fontWithName:FONTLITE size:14];
            }
            labelPrice.textAlignment = NSTextAlignmentRight;
            [mainScrollView addSubview:labelPrice];
            
            //Кнопка подарить------------------------------------------------------
            UIButton * buttonToGive = [UIButton buttonWithType:UIButtonTypeSystem];
            buttonToGive.frame = CGRectMake (-5, (self.frame.size.width / 2 - 15) + (self.frame.size.width * i), 100, 30);
            buttonToGive.layer.cornerRadius = 3.f;
            buttonToGive.tag = 20 + i;
            buttonToGive.backgroundColor = [UIColor colorWithHexString:@"f45bd7"];
            [buttonToGive setTitle:@"Подарить" forState:UIControlStateNormal];
            [buttonToGive setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            buttonToGive.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:14];
            if (isiPhone5 || isiPhone4s) {
                buttonToGive.frame = CGRectMake (-5, (self.frame.size.width / 2 - 13) + (self.frame.size.width * i), 90, 26);
                buttonToGive.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:12];
            }
            [buttonToGive addTarget:self action:@selector(buttonToGiveAction:) forControlEvents:UIControlEventTouchUpInside];
            [mainScrollView addSubview:buttonToGive];
            
//            //Описание букета-------------------------------------------------------
//            NSString * fullText =[TextMethodClass stringByStrippingHTML:[self.mainDict objectForKey:@"body"]];
//            CustomLabels * labelText = [[CustomLabels alloc] initLabelTableWithWidht:20 andHeight:40 + self.frame.size.width * i andSizeWidht:200 andSizeHeight:20 andColor:@"ffffff" andText:fullText];
//            labelText.numberOfLines = 2;
//            labelText.font = [UIFont fontWithName:FONTLITE size:12];
//            if (isiPhone5 || isiPhone4s) {
//                labelText.font = [UIFont fontWithName:FONTLITE size:10];
//            }
//            labelText.textAlignment = NSTextAlignmentLeft;
//            [labelText sizeToFit];
//            [mainScrollView addSubview:labelText];
            
            //Создаем кнопку увеличения scrollView
            CustomButton * buttonScroll = [CustomButton buttonWithType:UIButtonTypeSystem];
            buttonScroll.frame = CGRectMake(0, 0, self.frame.size.width * 3, self.frame.size.width);
            buttonScroll.isBool = YES;
            [buttonScroll addTarget:self action:@selector(buttonScrollAction:) forControlEvents:UIControlEventTouchUpInside];
            [buttonsArray addObject:buttonScroll];
            [scrollImages addSubview:buttonScroll];
        }
        
#pragma mark - TablePrice
        
        //Скрытая таблица цен----------------------------------------------------
        //Создание таблицы заказов----
        tablePrice = [[UITableView alloc] initWithFrame:CGRectMake(0.f, self.frame.size.height, self.frame.size.width, self.frame.size.height - self.frame.size.width)];
        //Убираем полосы разделяющие ячейки------------------------------
        tablePrice.separatorStyle = UITableViewCellSeparatorStyleNone;
        tablePrice.dataSource = self;
        tablePrice.delegate = self;
        tablePrice.showsVerticalScrollIndicator = NO;
        tablePrice.scrollEnabled = NO;
        tablePrice.backgroundColor = [UIColor colorWithHexString:COLORGRAY];
        //Очень полездное свойство, отключает дествие ячейки-------------

        [self addSubview:tablePrice];
        
        CustomButton * buttonCategory = [CustomButton buttonWithType:UIButtonTypeSystem];
        buttonCategory.frame = CGRectMake(20.f, 4.f, self.frame.size.width - 40.f, 32.f);
        buttonCategory.layer.cornerRadius = 16.f;
        buttonCategory.isBool = NO;
        buttonCategory.layer.borderColor = [UIColor colorWithHexString:COLORGREEN].CGColor;
        buttonCategory.layer.borderWidth = 2.f;
        [buttonCategory setTitle:@"ВЫБРАТЬ КАТЕГОРИЮ" forState:UIControlStateNormal];
        [buttonCategory setTitleColor:[UIColor colorWithHexString:COLORGREEN] forState:UIControlStateNormal];
        [buttonCategory addTarget:self action:@selector(buttonCategoryAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonCategory];
        
        self.buttonDescription = [UIButton buttonWithType:UIButtonTypeSystem];
        self.buttonDescription.frame = CGRectMake(20, (tablePrice.frame.size.height / 3) + ((tablePrice.frame.size.height / 3) / 2 - 10), self.frame.size.width - 40, 40);
        self.buttonDescription.layer.cornerRadius = 20;
        self.buttonDescription.layer.borderColor = [UIColor colorWithHexString:COLORGREEN].CGColor;
        self.buttonDescription.layer.borderWidth = 2.f;
        [self.buttonDescription setTitle:@"ОПИСАНИЕ" forState:UIControlStateNormal];
        [self.buttonDescription setTitleColor:[UIColor colorWithHexString:COLORGREEN] forState:UIControlStateNormal];
        [self.buttonDescription addTarget:self action:@selector(buttonDescriptionAction) forControlEvents:UIControlEventTouchUpInside];
        [tablePrice addSubview:self.buttonDescription];

        
        
        self.darkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.darkView.backgroundColor = [UIColor blackColor];
        self.darkView.alpha = 0.f;
        [self addSubview:self.darkView];
        
        self.categoryMainView = [self caegoryViewWithView:self andData:nil];
        [self addSubview:self.categoryMainView];
        
        
        self.viewDescription = [self setViewDescription];
        [self addSubview:self.viewDescription];
        
    }
    return self;
}

#pragma mark - Buttons Action
//Действие тача на букет--------------------------
- (void) buttonScrollAction: (CustomButton*) button
{
    for (int i = 0; i < self.arrayData.count; i++) {
        if ([button isEqual:[buttonsArray objectAtIndex:i]]) {
            if (button.isBool) {
                mainScrollView.scrollEnabled = NO;
                [UIView animateWithDuration:0.3 animations:^{
                    //Метод оцентровки------------------------------------
                    mainScrollView.contentOffset = CGPointMake(0, ((self.frame.size.width) * i));
                    
                    CGRect tableRect = tablePrice.frame;
                    tableRect.origin.y -= (self.frame.size.height - self.frame.size.width);
                    tablePrice.frame = tableRect;
                    
                    [UIView animateWithDuration:0.3 animations:^{
                        UIButton * buttonGive = (UIButton*)[self viewWithTag:20 + i];
                        CGRect rectButton = buttonGive.frame;
                        rectButton.origin.x -= 100;
                        buttonGive.frame = rectButton;
                    }];
                } completion:^(BOOL finished) {
                }];
                button.isBool = NO;
                dictPrice = [self.arrayData objectAtIndex:i];
                self.arrayPrice = [dictPrice objectForKey:@"variants"];
                [tablePrice reloadData];
                
                NSMutableArray * testArray = [[SingleTone sharedManager] arrayBouquets];
                for (int i = 0; i < testArray.count; i++) {
                    if ([[[testArray objectAtIndex:i] objectForKey:@"product_id"] isEqualToString:[dictPrice objectForKey:@"product_id"]]) {
                        tablePrice.allowsSelection = NO;
                    }
                }
                
                
            } else {
                mainScrollView.scrollEnabled = YES;
                [UIView animateWithDuration:0.3 animations:^{
                    //Метод оцентровки------------------------------------
                    if (i == self.arrayData.count - 1) {
                        mainScrollView.contentOffset = CGPointMake(0, mainScrollView.contentOffset.y - tablePrice.frame.size.height);
                    }
                    CGRect tableRect = tablePrice.frame;
                    tableRect.origin.y += (self.frame.size.height - self.frame.size.width);
                    tablePrice.frame = tableRect;
                    
                    [UIView animateWithDuration:0.3 animations:^{
                        UIButton * buttonGive = (UIButton*)[self viewWithTag:20 + i];
                        CGRect rectButton = buttonGive.frame;
                        rectButton.origin.x += 100;
                        buttonGive.frame = rectButton;
                    }];
                    
                } completion:^(BOOL finished) {
                }];
                button.isBool = YES;
                tablePrice.allowsSelection = YES;
                
                
            }
        }
    }
}
//Действие кнопки подарить----------------------
- (void) buttonToGiveAction: (UIButton*) button
{
    for (int i = 0; i < self.arrayData.count; i++) {
        if (button.tag == 20 + i) {
            dictPrice = [self.arrayData objectAtIndex:i];
            self.arrayPrice = [dictPrice objectForKey:@"variants"];
            [tablePrice reloadData];
            mainScrollView.scrollEnabled = NO;
            CustomButton * buttonTup = (CustomButton*)[buttonsArray objectAtIndex:i];
            buttonTup.isBool = NO;
            [UIView animateWithDuration:0.3 animations:^{
                //Метод оцентровки------------------------------------
                mainScrollView.contentOffset = CGPointMake(0, ((self.frame.size.width) * i));
                CGRect tableRect = tablePrice.frame;
                tableRect.origin.y -= (self.frame.size.height - self.frame.size.width);
                tablePrice.frame = tableRect;
                [UIView animateWithDuration:0.3 animations:^{
                    UIButton * buttonGive = (UIButton*)[self viewWithTag:20 + i];
                    CGRect rectButton = buttonGive.frame;
                    rectButton.origin.x -= 100;
                    buttonGive.frame = rectButton;
                }];
            }];
            
            NSMutableArray * testArray = [[SingleTone sharedManager] arrayBouquets];
            for (int i = 0; i < testArray.count; i++) {
                if ([[[testArray objectAtIndex:i] objectForKey:@"product_id"] isEqualToString:[dictPrice objectForKey:@"product_id"]]) {
                    tablePrice.allowsSelection = NO;
                }
            }
        }
    }
}

- (void) buttonCategoryAction: (CustomButton*) button {
    

        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = self.categoryMainView.frame;
            rect.origin.x -= self.frame.size.width / 2 + 50.f;
            self.categoryMainView.frame = rect;
            self.darkView.alpha = 0.3f;
        } completion:^(BOOL finished) {}];
}

- (void) buttonCanselAction {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.categoryMainView.frame;
        rect.origin.x += self.frame.size.width / 2 + 50.f;
        self.categoryMainView.frame = rect;
        self.darkView.alpha = 0.f;
    } completion:^(BOOL finished) {}];
}

- (void) buttonCanselDescriptionAction {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.viewDescription.frame;
        rect.origin.x += self.frame.size.width;
        self.viewDescription.frame = rect;
    }];
    
    self.buttonDescription.userInteractionEnabled = YES;
}

- (void) buttonDescriptionAction {
    
    NSString * body = [dictPrice objectForKey:@"body"];
    self.labelDescriprion.text = [TextMethodClass stringByStrippingHTML:body];
    [self.labelDescriprion sizeToFit];
    self.scrollDescripton.contentSize = CGSizeMake(0, self.labelDescriprion.frame.size.height + 10);
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.viewDescription.frame;
        rect.origin.x -= self.frame.size.width;
        self.viewDescription.frame = rect;
    }];
    
    self.buttonDescription.userInteractionEnabled = NO;
}

#pragma mark - CategoryView

- (UIView*) caegoryViewWithView: (UIView*) view
                        andData: (NSArray*) data {
    UIView * categoryView = [[UIView alloc] initWithFrame:CGRectMake(view.frame.size.width, 0.f, view.frame.size.width / 2 + 50, view.frame.size.height)];
    categoryView.backgroundColor = [UIColor whiteColor];
    
    UIButton * buttonCansel = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonCansel.frame = CGRectMake(categoryView.frame.size.width - 40, 10, 30, 30);
    buttonCansel.layer.cornerRadius = 15.f;
    buttonCansel.layer.borderColor = [UIColor colorWithHexString:COLORGREEN].CGColor;
    buttonCansel.layer.borderWidth = 1.f;
    [buttonCansel setTitle:@"X" forState:UIControlStateNormal];
    [buttonCansel setTitleColor:[UIColor colorWithHexString:COLORGREEN] forState:UIControlStateNormal];
    [buttonCansel addTarget:self action:@selector(buttonCanselAction) forControlEvents:UIControlEventTouchUpInside];
    [categoryView addSubview:buttonCansel];
    
    self.tableCategory = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 40.f, categoryView.frame.size.width, categoryView.frame.size.height - 40.f)];
//    self.tableCategory.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableCategory.delegate = self;
    self.tableCategory.dataSource = self;
    self.tableCategory.showsVerticalScrollIndicator = NO;
    self.tableCategory.scrollEnabled = NO;
    [categoryView addSubview:self.tableCategory];
    
    
    return categoryView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.tableCategory]) {
        return self.arrayCategory.count;
    } else {
        return 1;
    }
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
    if ([tableView isEqual:self.tableCategory]) {
        if (indexPath.row == [[SingleTone sharedManager] chaneCategory]) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSDictionary * dictCellCat =[self.arrayCategory objectAtIndex:indexPath.row];
            [cell.contentView addSubview:[self setCustomCellWithName:[dictCellCat objectForKey:@"name"]
                                                            andImage:[dictCellCat objectForKey:@"img"]
                                                             andView:cell andIndexPash:indexPath.row]];

        
    } else {
    NSDictionary * dictCell = [self.arrayPrice objectAtIndex:0];
    [cell.contentView addSubview:[self setTableCellWithName:[dictCell objectForKey:@"name"]
                                                    andData:nil
                                                   andPrice:[dictCell objectForKey:@"price"]]];
        
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![tableView isEqual:self.tableCategory]) {
        return tablePrice.frame.size.height / 3;
    } else {
        return 40.f;
    }
    
}

//Анимация нажатия ячейки--------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![tableView isEqual:self.tableCategory]) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if ([[SingleTone sharedManager] arrayBouquets].count == 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"checkOrderNotification" object:nil];
        }
        [[[SingleTone sharedManager] arrayBouquets] addObject:dictPrice];
        tablePrice.allowsSelection = NO;
        NSInteger count = [[[SingleTone sharedManager] labelCountBasket].text integerValue];
        count += 1;
        [[SingleTone sharedManager] labelCountBasket].text = [NSString stringWithFormat:@"%ld", (long)count];
        [MessagePopUp showPopUpWithDelay:@"Товар добавлен в корзину" view:self delay:1.3f];
        [UIView animateWithDuration:0.15 animations:^{
            
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 animations:^{
                
            }];
        }];
    } else {
        if (indexPath.row != [[SingleTone sharedManager] chaneCategory]) {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            NSDictionary * dictCategory = [self.arrayCategory objectAtIndex:indexPath.row];
            [self.delegate setCategiry:self withIDString:[dictCategory objectForKey:@"id"]];
            [[SingleTone sharedManager] setChaneCategory:indexPath.row];
        }
    }
}

#pragma mark - CustomCell

//Кастомная ячейка---------------------------------------
- (UIView*) setTableCellWithName: (NSString *) name
                         andData: (NSString*) data
                        andPrice: (NSString*) price
{
    //Основное окно ячейки--------------------------------
    UIView * cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, tablePrice.frame.size.height / 3)];
    cellView.backgroundColor = [UIColor colorWithHexString:COLORGRAY];
    
    //Загаловок ячейки-----------------------------------
    CustomLabels * labelTitleCell = [[CustomLabels alloc] initLabelTableWithWidht:10 andHeight:0 andSizeWidht:self.frame.size.width - 130
                                                                    andSizeHeight:tablePrice.frame.size.height / 3 andColor:@"000000" andText:[dictPrice objectForKey:@"name"]];
    labelTitleCell.font = [UIFont fontWithName:FONTREGULAR size:20];
    if (isiPhone5) {;
        labelTitleCell.font = [UIFont fontWithName:FONTREGULAR size:18];
    } else if (isiPhone4s) {
        labelTitleCell.font = [UIFont fontWithName:FONTREGULAR size:14];
    }
    labelTitleCell.textAlignment = NSTextAlignmentLeft;
    [cellView addSubview:labelTitleCell];
    
    //Данные по доставке-------------------------------
    CustomLabels * labelDeliveryCell = [[CustomLabels alloc] initLabelTableWithWidht:20 andHeight:45 andSizeWidht:200 andSizeHeight:20 andColor:@"858383" andText:@""];
    labelDeliveryCell.font = [UIFont fontWithName:FONTREGULAR size:12];
    if (isiPhone5) {
        labelDeliveryCell.frame = CGRectMake(20, 35, 200, 20);
        labelDeliveryCell.font = [UIFont fontWithName:FONTREGULAR size:10];
    } else if (isiPhone4s) {
        labelDeliveryCell.frame = CGRectMake(20, 15, 200, 20);
        labelDeliveryCell.font = [UIFont fontWithName:FONTREGULAR size:9];
    }
    labelDeliveryCell.textAlignment = NSTextAlignmentLeft;
    [cellView addSubview:labelDeliveryCell];
    
    //Данные о цене-----------------------------------
    CustomLabels * labelCellPrice = [[CustomLabels alloc] initLabelTableWithWidht:self.frame.size.width - 140 andHeight:0 andSizeWidht:80 andSizeHeight:tablePrice.frame.size.height / 3 andColor:@"000000" andText:price];
    labelCellPrice.font = [UIFont fontWithName:FONTREGULAR size:20];
    if (isiPhone5) {
        labelCellPrice.font = [UIFont fontWithName:FONTREGULAR size:18];
    } else if (isiPhone4s) {
        labelCellPrice.font = [UIFont fontWithName:FONTREGULAR size:16];
    }
    labelCellPrice.textAlignment = NSTextAlignmentRight;
    [cellView addSubview: labelCellPrice];
    
    //Изображение корзинки-------------------------------
    UIImageView * imageBasket = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 50, (tablePrice.frame.size.height / 3) / 2 - 13 , 26, 26)];
    if (isiPhone5) {
        imageBasket.frame = CGRectMake(self.frame.size.width - 50, (tablePrice.frame.size.height / 3) / 2 - 10 , 20, 20);
    } else if (isiPhone4s) {
        imageBasket.frame = CGRectMake(self.frame.size.width - 50, (tablePrice.frame.size.height / 3) / 2 - 8 , 16, 16);
    }
    imageBasket.image = [UIImage imageNamed:@"iconBasketBlack.png"];
    [cellView addSubview:imageBasket];
    
    //Вью границы-----------------------------------------
    UIView * borderView = [[UIView alloc] initWithFrame:CGRectMake(0, (tablePrice.frame.size.height / 3) - 0.5, self.frame.size.width, 0.5f)];
    borderView.backgroundColor = [UIColor whiteColor];
    [cellView addSubview:borderView];
    
    
    
    return cellView;
    
}

- (UIView*) setCustomCellWithName: (NSString*) name
                         andImage: (NSString*) imageName
                          andView: (UIView*) view
                     andIndexPash: (NSInteger) indexPash {
    UIView * cellView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, view.frame.size.width, view.frame.size.height)];
    
    UILabel * labelNameCell = [[UILabel alloc] initWithFrame:CGRectMake(70.f, 0.f, view.frame.size.width - 40.f, view.frame.size.height)];
    labelNameCell.text = name;
    if (indexPash == [[SingleTone sharedManager] chaneCategory]) {
        labelNameCell.textColor = [UIColor colorWithHexString:COLORPINCK];
    } else {
    labelNameCell.textColor = [UIColor colorWithHexString:COLORGREEN];
    }
    labelNameCell.font = [UIFont fontWithName:FONTREGULAR size:18];
    [cellView addSubview:labelNameCell];
    
    imageName =
    [imageName stringByReplacingOccurrencesOfString:@" "
                                      withString:@"%20"];
    
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imageName]];
    
    UIImageView * imageViewCell = [[UIImageView alloc] initWithFrame:CGRectMake(15.f, 5.f, 30.f, 30.f)];
    imageViewCell.layer.cornerRadius = 5.f;
    imageViewCell.clipsToBounds = YES;
    imageViewCell.contentMode=UIViewContentModeScaleAspectFill;
    imageViewCell.image = [UIImage imageWithData: imageData];
    [cellView addSubview:imageViewCell];
    
    
    return cellView;
}

#pragma mark - View Description

- (UIView*) setViewDescription {
    UIView * viewDecrpt = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    viewDecrpt.backgroundColor = [UIColor whiteColor];
    
    self.scrollDescripton = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, self.frame.size.width, self.frame.size.height - ((tablePrice.frame.size.height / 3) * 2))];
    self.scrollDescripton.backgroundColor = [UIColor whiteColor];
    [viewDecrpt addSubview:self.scrollDescripton];
    
    self.labelDescriprion = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, self.scrollDescripton.frame.size.width - 40, self.scrollDescripton.frame.size.height - 20)];
    self.labelDescriprion.numberOfLines = 0;
    self.labelDescriprion.textColor = [UIColor blackColor];
    self.labelDescriprion.font = [UIFont fontWithName:FONTREGULAR size:13];
    [self.scrollDescripton addSubview:self.labelDescriprion];
    
    UIButton * buttonCanselDescription = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonCanselDescription.frame = CGRectMake(viewDecrpt.frame.size.width - 40, 10, 30, 30);
    buttonCanselDescription.layer.cornerRadius = 15.f;
    buttonCanselDescription.layer.borderColor = [UIColor colorWithHexString:COLORGREEN].CGColor;
    buttonCanselDescription.layer.borderWidth = 1.f;
    [buttonCanselDescription setTitle:@"X" forState:UIControlStateNormal];
    [buttonCanselDescription setTitleColor:[UIColor colorWithHexString:COLORGREEN] forState:UIControlStateNormal];
    [buttonCanselDescription addTarget:self action:@selector(buttonCanselDescriptionAction) forControlEvents:UIControlEventTouchUpInside];
    [viewDecrpt addSubview:buttonCanselDescription];
    
    
    return viewDecrpt;
}



@end
