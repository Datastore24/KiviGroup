//
//  ListMessegesView.m
//  TravelTogether
//
//  Created by Виктор Мишустин on 29/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "ListMessegesView.h"
#import "UIButton+ButtonImage.h"
#import "UIView+BorderView.h"
#import "HexColors.h"
#import "Macros.h"
#import "CustomLabels.h"

@interface ListMessegesView () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView * tableMesseges;
@property (strong, nonatomic) NSArray * arrayData;

@end

@implementation ListMessegesView

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 0.f, view.frame.size.width, view.frame.size.height);
        
        self.arrayData = data;
        
        self.tableMesseges = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
        //Убираем полосы разделяющие ячейки------------------------------
        self.tableMesseges.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableMesseges.backgroundColor = nil;
        self.tableMesseges.dataSource = self;
        self.tableMesseges.delegate = self;
        self.tableMesseges.showsVerticalScrollIndicator = NO;
        //Очень полездное свойство, отключает дествие ячейки-------------
        self.tableMesseges.allowsSelection = NO;
        [self addSubview:self.tableMesseges];
        
        
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
                                                         andCity:[dict objectForKey:@"textMessege"] andMessage:[dict objectForKey:@"message"]
                                                 andColorMessage:[[dict objectForKey:@"colorMessage"] boolValue] andNumberCell:indexPath.row andDate:[dict objectForKey:@"date"]]];
        
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
                  andColorMessage: (BOOL) colorMessage andNumberCell: (NSInteger) numberCell andDate: (NSString*) date {
    UIView * customCellView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, view.frame.size.width, view.frame.size.width)];

    
    
    UIImageView * imagePhoto = [[UIImageView alloc] initWithFrame:CGRectMake(21.5f, 12.75f, 47.5f, 47.5f)];
    imagePhoto.image = [UIImage imageNamed:imageName];
    [customCellView addSubview:imagePhoto];
    
    CustomLabels * labelName = [[CustomLabels alloc] initLabelWithWidht:85.f andHeight:20.5f andColor:@"787676"
                                                                andText:[NSString stringWithFormat:@"%@,", name] andTextSize:10 andLineSpacing:0.f fontName:VM_FONT_BEAU_SANS_BOLD];
    [customCellView addSubview:labelName];
    
    CustomLabels * labelAge = [[CustomLabels alloc] initLabelWithWidht:85.f + labelName.frame.size.width + 3.f andHeight:20.5f andColor:@"787676"
                                                               andText:[NSString stringWithFormat:@"%@ лет", age] andTextSize:8 andLineSpacing:0.f fontName:VM_FONT_BEAU_SANS_REGULAR];
    [customCellView addSubview:labelAge];
    
    CustomLabels * labelMessegeText = [[CustomLabels alloc] initLabelTableWithWidht:85.f andHeight:30.f andSizeWidht:135.f andSizeHeight:12.f andColor:@"c4c2c2" andText:city];
    labelMessegeText.font = [UIFont fontWithName:VM_FONT_BEAU_SANS_REGULAR size:10];
    labelMessegeText.textAlignment = NSTextAlignmentLeft;
    [customCellView addSubview:labelMessegeText];
    
    CustomLabels * labelDate = [[CustomLabels alloc] initLabelWithWidht:85.f andHeight:45.f andColor:@"787878"
                                                               andText:date andTextSize:8 andLineSpacing:0.f fontName:VM_FONT_BEAU_SANS_REGULAR];
    [customCellView addSubview:labelDate];
    
    
    
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
    
    UIButton * buttonDetail = [UIButton createButtonWithImage:@"buttonMessegeNO.png" anfFrame:CGRectMake(self.frame.size.width - 94.f, 25.88f, 72.5f, 21.25f)];
    [buttonDetail setImage:[UIImage imageNamed:@"buttonMessegeYES.png"] forState:UIControlStateHighlighted];
    buttonDetail.tag = 40 + numberCell;
    [buttonDetail addTarget:self action:@selector(buttonDetailAction:) forControlEvents:UIControlEventTouchUpInside];
    [customCellView addSubview:buttonDetail];
        [UIView borderViewWithHeight:72.f andWight:21.5f andView:customCellView andColor:@"c1c1c1"];

    
    return customCellView;
}

#pragma mark - Actions

- (void) buttonDetailAction: (UIButton*) button {
    for (int i = 0; i < self.arrayData.count; i++) {
        if (button.tag == 40 + i) {
            
            [self.delegate pushToMesseger:self];

        }
    }
}

@end
