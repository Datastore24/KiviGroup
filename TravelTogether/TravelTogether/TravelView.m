//
//  TravelView.m
//  TravelTogether
//
//  Created by Виктор Мишустин on 07/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "TravelView.h"
#import "UIButton+ButtonImage.h"
#import "UIView+BorderView.h"
#import "HexColors.h"
#import "Macros.h"
#import "CustomLabels.h"

@interface TravelView () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView * tableTravel;
@property (strong, nonatomic) NSArray * arrayData;


//ShareView

@property (strong, nonatomic) UIView * viewShare;

//AlertPrice

@property (strong, nonatomic) UIView * viewAlertPrice;

@property (assign, nonatomic) BOOL isBoolStar; //Временная переменная

@end

@implementation TravelView

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 64.f, view.frame.size.width, view.frame.size.height- 64.f);
        
        self.arrayData = data;
        
        self.isBoolStar = NO;
        
        UIButton * buttonBuyTicket = [UIButton createButtonWithImage:@"buttonBuyImageNewNo.png" anfFrame:CGRectMake(self.frame.size.width / 2.f - 140.f + 2, 15.f, 139.f - 139 / 3, 21.25f)];
        [buttonBuyTicket setImage:[UIImage imageNamed:@"buttonBuyImageNewYes.png"] forState:UIControlStateHighlighted];
        [self addSubview:buttonBuyTicket];
        UIButton * buttonAddOnMyTravel = [UIButton createButtonWithImage:@"buttonAddImageNewNo.png" anfFrame:CGRectMake(self.frame.size.width / 2.f + 139 / 3, 15.f, 139.f - 139 / 3, 21.25f)];
        [buttonAddOnMyTravel setImage:[UIImage imageNamed:@"buttonAddImageNewYes.png"] forState:UIControlStateHighlighted];
        [self addSubview:buttonAddOnMyTravel];
        
        UIButton * buttonSharenMyTravel = [UIButton createButtonWithImage:@"buttonShareImageNewNo.png" anfFrame:CGRectMake(buttonBuyTicket.frame.size.width + buttonBuyTicket.frame.origin.y + 6, 15.f, 139.f - 139 / 3, 21.25f)];
        [buttonSharenMyTravel setImage:[UIImage imageNamed:@"buttonShareImageNewYes.png"] forState:UIControlStateHighlighted];
        [buttonSharenMyTravel addTarget:self action:@selector(buttonSharenMyTravelAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonSharenMyTravel];
        
        self.tableTravel = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 40.f, self.frame.size.width, self.frame.size.height - 30.f)];
        //Убираем полосы разделяющие ячейки------------------------------
        self.tableTravel.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableTravel.backgroundColor = nil;
        self.tableTravel.dataSource = self;
        self.tableTravel.delegate = self;
        self.tableTravel.showsVerticalScrollIndicator = NO;
        //Очень полездное свойство, отключает дествие ячейки-------------
        self.tableTravel.allowsSelection = NO;
        [self addSubview:self.tableTravel];
        
        
        self.viewAlertPrice = [self createAlertPriceView];
        self.viewAlertPrice.alpha = 0.f;
        [self addSubview:self.viewAlertPrice];
        
        self.viewShare = [self createShareView];
        self.viewShare.alpha = 0.f;
        [self addSubview:self.viewShare];
        
        
    }
    return self;
}

#pragma mark - UITableViewDataSource

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
    
    NSDictionary * dict = [self.arrayData objectAtIndex:indexPath.row];
    
    cell.backgroundColor = nil;
    if (self.arrayData.count != 0) {
        
        [cell.contentView addSubview:[self setCustomCellWithView:cell andImage:[dict objectForKey:@"image"]
                                                         andName:[dict objectForKey:@"name"] andAge:[dict objectForKey:@"age"]
                                                         andCity:[dict objectForKey:@"city"] andMessage:[dict objectForKey:@"message"]
                                                 andColorMessage:[[dict objectForKey:@"colorMessage"] boolValue] andNumberCell:indexPath.row]];

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
        return 73.f;

}

#pragma mark - CustomCell

- (UIView*) setCustomCellWithView: (UIView*) view andImage: (NSString*) imageName
                          andName: (NSString*) name andAge: (NSString*) age
                          andCity: (NSString*) city andMessage: (NSString*) message
                  andColorMessage: (BOOL) colorMessage andNumberCell: (NSInteger) numberCell {
    UIView * customCellView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, view.frame.size.width, view.frame.size.width)];
    
    
    UIImageView * imagePhoto = [[UIImageView alloc] initWithFrame:CGRectMake(21.5f, 12.75f, 47.5f, 47.5f)];
    imagePhoto.image = [UIImage imageNamed:imageName];
    [customCellView addSubview:imagePhoto];
    
    CustomLabels * labelName = [[CustomLabels alloc] initLabelWithWidht:85.f andHeight:29.f andColor:@"787676"
                                                                andText:[NSString stringWithFormat:@"%@,", name] andTextSize:10 andLineSpacing:0.f fontName:VM_FONT_BEAU_SANS_BOLD];
    [customCellView addSubview:labelName];
    
    CustomLabels * labelAge = [[CustomLabels alloc] initLabelWithWidht:85.f + labelName.frame.size.width + 3.f andHeight:30.5f andColor:@"787676"
                                                                andText:[NSString stringWithFormat:@"%@ лет", age] andTextSize:8 andLineSpacing:0.f fontName:VM_FONT_BEAU_SANS_REGULAR];
    [customCellView addSubview:labelAge];
    
    CustomLabels * labelCity = [[CustomLabels alloc] initLabelWithWidht:85.f andHeight:42.f andColor:@"c4c2c2"
                                                                andText:city andTextSize:10 andLineSpacing:0.f fontName:VM_FONT_BEAU_SANS_REGULAR];
    [customCellView addSubview:labelCity];
    
    if (![message isEqualToString:@""]) {
        UIView * massageView = [[UIView alloc] initWithFrame:CGRectMake(57.f, 50.f, 11.f, 11.f)];
        if (colorMessage) {
            massageView.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK];
        } else {
            massageView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"818181"];
        }
        massageView.layer.cornerRadius = 5.5f;
        massageView.layer.borderColor = [UIColor whiteColor].CGColor;
        massageView.layer.borderWidth = 1.f;
        [customCellView addSubview:massageView];
        
        CustomLabels * labelMessage = [[CustomLabels alloc] initLabelTableWithWidht:0.2f andHeight:0.3f andSizeWidht:11.f andSizeHeight:11.f andColor:@"ffffff" andText:message];
        labelMessage.font = [UIFont fontWithName:VM_FONT_BEAU_SANS_REGULAR size:6];
        labelMessage.textAlignment = NSTextAlignmentCenter;
        [massageView addSubview:labelMessage];
    }
    
    UIButton * buttonDetail = [UIButton createButtonWithImage:@"buttonDetailImageNO.png" anfFrame:CGRectMake(self.frame.size.width - 94.f, 25.88f, 72.5f, 21.25f)];
    [buttonDetail setImage:[UIImage imageNamed:@"buttonDetailImageYES.png"] forState:UIControlStateHighlighted];
    buttonDetail.tag = 40 + numberCell;
    [buttonDetail addTarget:self action:@selector(buttonDetailAction:) forControlEvents:UIControlEventTouchUpInside];
    [customCellView addSubview:buttonDetail];
        [UIView borderViewWithHeight:72.f andWight:21.5f andView:customCellView andColor:@"c1c1c1"];

    
    
    return customCellView;
}


#pragma mark - ShareView

- (UIView*) createShareView {
    UIView * foneView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
    foneView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"000000" alpha:0.4];
    UIImageView * alertShareView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 100.f, self.frame.size.height / 2 - 100.f, 200.f, 178.f)];
    alertShareView.backgroundColor = [UIColor whiteColor];
    alertShareView.layer.cornerRadius = 5.f;
    alertShareView.userInteractionEnabled = YES;
    [foneView addSubview:alertShareView];
    
    
    NSArray * arrayImagesNetwork = [NSArray arrayWithObjects:@"vkImageTravel.png", @"faceImageTravel.png", @"instImageTravel.png", @"okImageTravel.png", nil];
    for (int i = 0; i < arrayImagesNetwork.count; i++) {
        UIButton * buttonSocNetwork = [UIButton createButtonWithImage:[arrayImagesNetwork objectAtIndex:i] anfFrame:CGRectMake(20, 20 + 38.f * i, 160.f, 28.f)];
        [buttonSocNetwork addTarget:self action:@selector(buttonSocNetworkAction) forControlEvents:UIControlEventTouchUpInside];
        [alertShareView addSubview:buttonSocNetwork];
    }

    return foneView;
}


#pragma mark - AlertPrice

- (UIView*) createAlertPriceView {
    UIView * foneView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
    foneView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"000000" alpha:0.4];
    UIImageView * alertPriceView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 100.f, self.frame.size.height / 2 - 100.f, 200.f, 178.f)];
    alertPriceView.userInteractionEnabled = YES;
    alertPriceView.image = [UIImage imageNamed:@"alertPrice.png"];
    [foneView addSubview:alertPriceView];

    
    for (int i = 0; i < 5; i++) {
        UIButton * buttonStar = [UIButton createButtonWithImage:@"imageStarNO.png" anfFrame:CGRectMake(22.f + 32.f * i, 70.f, 25.f, 25.f)];
        if (i == 0) {
            [buttonStar setImage:[UIImage imageNamed:@"imageStarYES.png"] forState:UIControlStateNormal];
        }
        buttonStar.tag = 100 + i;
        [buttonStar addTarget:self action:@selector(buttonStar:) forControlEvents:UIControlEventTouchUpInside];
        [alertPriceView addSubview:buttonStar];
    }
    
    NSArray * arrayNameButtonStar = [NSArray arrayWithObjects:@"Написать отзыв", @"Написать потом", nil];
    
    for (int i = 0; i < 2; i++) {
        UIButton * buttonStarAction = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonStarAction.frame = CGRectMake(alertPriceView.frame.size.width / 2 - 74.5f, 110.5f + 32.f * i, 149.f, 21.f);
        buttonStarAction.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"cacaca"].CGColor;
        buttonStarAction.layer.borderWidth = 1.f;
        buttonStarAction.layer.cornerRadius = 10.5f;
        [buttonStarAction setTitle:[arrayNameButtonStar objectAtIndex:i] forState:UIControlStateNormal];
        [buttonStarAction setTitleColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK] forState:UIControlStateNormal];
        buttonStarAction.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:10];
        [buttonStarAction addTarget:self action:@selector(buttonStarActionSelect:) forControlEvents:UIControlEventTouchUpInside];
        buttonStarAction.tag = 200 + i;
        [alertPriceView addSubview:buttonStarAction];
    }
    
    
    return foneView;
}

#pragma mark - Actions

//Действие кнопки Поделиться
- (void) buttonSharenMyTravelAction {
    [UIView animateWithDuration:0.3 animations:^{
        self.viewShare.alpha = 1.f;
    }];
}

//Действие выбора соц сети
- (void) buttonSocNetworkAction {
    [UIView animateWithDuration:0.3 animations:^{
        self.viewShare.alpha = 0.f;
    }];
}

- (void) buttonStarActionSelect: (UIButton*) button {
    if (button.tag == 200) {
        [UIView animateWithDuration:0.3 animations:^{
            self.viewAlertPrice.alpha = 0.f;
        }];
    } else if (button.tag == 201) {
        [UIView animateWithDuration:0.3 animations:^{
            self.viewAlertPrice.alpha = 0.f;
        }];
    }
}

- (void) buttonDetailAction: (UIButton*) button {
    for (int i = 0; i < self.arrayData.count; i++) {
        if (button.tag == 40 + i) {
            if (!self.isBoolStar) {
                [UIView animateWithDuration:0.3 animations:^{
                    self.viewAlertPrice.alpha = 1.f;
                }];
                self.isBoolStar = YES;
            } else {
                [self.delegate pushToHumanDetail:self andID:[NSString stringWithFormat:@"%d", i]];
            }
        }
    }
}

- (void) buttonStar: (UIButton*) button {
    for (int i = 0; i < 5; i++) {
        if (button.tag == 100 + i) {
            for (int j = 0; j < 5; j++) {
                UIButton * otherButton = (UIButton*)[self viewWithTag:100 + j];
                if (otherButton.tag <= button.tag) {
                    [UIView animateWithDuration:0.4 animations:^{
                        [otherButton setImage:[UIImage imageNamed:@"imageStarYES.png"] forState:UIControlStateNormal];
                    }];
                } else {
                    [UIView animateWithDuration:0.4 animations:^{
                        [otherButton setImage:[UIImage imageNamed:@"imageStarNO.png"] forState:UIControlStateNormal];
                    }];
                }
            }
        }
    }
}

@end
