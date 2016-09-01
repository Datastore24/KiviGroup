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

@end

@implementation TravelView

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 64.f, view.frame.size.width, view.frame.size.height- 64.f);
        
        self.arrayData = data;
        
        UIButton * buttonBuyTicket = [UIButton createButtonWithImage:@"buttonBuyTicketNONew.png" anfFrame:CGRectMake(self.frame.size.width / 2.f - 140.f, 15.f, 139.f, 21.25f)];
        if (isiPhone6) {
            buttonBuyTicket.frame = CGRectMake(self.frame.size.width / 2.f - 162.5f, 17.5f, 163.5f, 25.f);
        }
        [buttonBuyTicket setImage:[UIImage imageNamed:@"buttonBuyTicketYESNew.png"] forState:UIControlStateHighlighted];
        [self addSubview:buttonBuyTicket];
        UIButton * buttonAddOnMyTravel = [UIButton createButtonWithImage:@"ButtonAddToMyTravelNONew.png" anfFrame:CGRectMake(self.frame.size.width / 2.f + 1.f, 15.f, 139.f, 21.25f)];
        if (isiPhone6) {
            buttonAddOnMyTravel.frame = CGRectMake(self.frame.size.width / 2.f - 1, 17.5f, 163.5f, 25.f);
        }
        [buttonAddOnMyTravel setImage:[UIImage imageNamed:@"ButtonAddToMyTravelYESNew.png"] forState:UIControlStateHighlighted];
        [self addSubview:buttonAddOnMyTravel];
        
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
    
    if (isiPhone6) {
        return 85.f;
    } else {
        return 73.f;
    }
}

#pragma mark - CustomCell

- (UIView*) setCustomCellWithView: (UIView*) view andImage: (NSString*) imageName
                          andName: (NSString*) name andAge: (NSString*) age
                          andCity: (NSString*) city andMessage: (NSString*) message
                  andColorMessage: (BOOL) colorMessage andNumberCell: (NSInteger) numberCell {
    UIView * customCellView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, view.frame.size.width, view.frame.size.width)];
    if (isiPhone6) {
        customCellView.frame = CGRectMake(0.f, 0.f, self.frame.size.width, 85.f);
    }
    
    
    UIImageView * imagePhoto = [[UIImageView alloc] initWithFrame:CGRectMake(21.5f, 12.75f, 47.5f, 47.5f)];
    if (isiPhone6) {
        imagePhoto.frame = CGRectMake(21.5f, 15.f, 55.f, 55.f);
    }
    imagePhoto.image = [UIImage imageNamed:imageName];
    [customCellView addSubview:imagePhoto];
    
    CustomLabels * labelName = [[CustomLabels alloc] initLabelWithWidht:85.f andHeight:29.f andColor:@"787676"
                                                                andText:[NSString stringWithFormat:@"%@,", name] andTextSize:10 andLineSpacing:0.f fontName:VM_FONT_BEAU_SANS_BOLD];
    if (isiPhone6) {
        labelName.frame = CGRectMake(95.f, 35.f, 10.f, 20.f);
        labelName.font = [UIFont fontWithName:VM_FONT_BEAU_SANS_BOLD size:12];
        [labelName sizeToFit];
    }
    [customCellView addSubview:labelName];
    
    CustomLabels * labelAge = [[CustomLabels alloc] initLabelWithWidht:85.f + labelName.frame.size.width + 3.f andHeight:30.5f andColor:@"787676"
                                                                andText:[NSString stringWithFormat:@"%@ лет", age] andTextSize:8 andLineSpacing:0.f fontName:VM_FONT_BEAU_SANS_REGULAR];
    if (isiPhone6) {
        labelAge.frame = CGRectMake(95.f + labelName.frame.size.width + 3.f, 37.5f, 10.f, 20.f);
        labelAge.font = [UIFont fontWithName:VM_FONT_BEAU_SANS_REGULAR size:10];
        [labelAge sizeToFit];
    }
    [customCellView addSubview:labelAge];
    
    CustomLabels * labelCity = [[CustomLabels alloc] initLabelWithWidht:85.f andHeight:42.f andColor:@"c4c2c2"
                                                                andText:city andTextSize:10 andLineSpacing:0.f fontName:VM_FONT_BEAU_SANS_REGULAR];
    if (isiPhone6) {
        labelCity.frame = CGRectMake(95.f, 50.f, 10.f, 20.f);
        labelCity.font = [UIFont fontWithName:VM_FONT_BEAU_SANS_BOLD size:12];
        [labelCity sizeToFit];
    }
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
        if (isiPhone6) {
            massageView.frame = CGRectMake(63.5f, 57.75f, 12.5f, 12.5f);
            massageView.layer.cornerRadius = 12.5f / 2;
            massageView.layer.borderWidth = 1.5f;
        }
        [customCellView addSubview:massageView];
        
        CustomLabels * labelMessage = [[CustomLabels alloc] initLabelTableWithWidht:0.2f andHeight:0.3f andSizeWidht:11.f andSizeHeight:11.f andColor:@"ffffff" andText:message];
        labelMessage.font = [UIFont fontWithName:VM_FONT_BEAU_SANS_REGULAR size:6];
        if (isiPhone6) {
            labelMessage.frame = CGRectMake(0.3f, 0.4f, 12.5f, 12.5f);
            labelMessage.font = [UIFont fontWithName:VM_FONT_BEAU_SANS_REGULAR size:7];
        }
        labelMessage.textAlignment = NSTextAlignmentCenter;
        [massageView addSubview:labelMessage];
    }
    
    UIButton * buttonDetail = [UIButton createButtonWithImage:@"buttonDetailImageNO.png" anfFrame:CGRectMake(self.frame.size.width - 94.f, 25.88f, 72.5f, 21.25f)];
    if (isiPhone6) {
        buttonDetail.frame = CGRectMake(self.frame.size.width - 105.f, 30.f, 85.f, 25.f);
    }
    [buttonDetail setImage:[UIImage imageNamed:@"buttonDetailImageYES.png"] forState:UIControlStateHighlighted];
    buttonDetail.tag = 40 + numberCell;
    [buttonDetail addTarget:self action:@selector(buttonDetailAction:) forControlEvents:UIControlEventTouchUpInside];
    [customCellView addSubview:buttonDetail];
    if (isiPhone6) {
        [UIView borderViewWithHeight:84.f andWight:21.5f andView:customCellView andColor:@"c1c1c1"];
    } else {
        [UIView borderViewWithHeight:72.f andWight:21.5f andView:customCellView andColor:@"c1c1c1"];
    }
    
    
    return customCellView;
}

#pragma mark - Actions

- (void) buttonDetailAction: (UIButton*) button {
    for (int i = 0; i < self.arrayData.count; i++) {
        if (button.tag == 40 + i) {
            [self.delegate pushToHumanDetail:self andID:[NSString stringWithFormat:@"%d", i]];
        }
    }
}


@end
