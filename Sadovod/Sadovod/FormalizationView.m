//
//  FormalizationView.m
//  Sadovod
//
//  Created by Виктор Мишустин on 05/09/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "FormalizationView.h"
#import "CustomLabels.h"
#import "Macros.h"
#import "HexColors.h"

@interface FormalizationView()

//Main
@property (strong, nonatomic) UIScrollView * mainScrollView;
@property (strong, nonatomic) NSMutableArray * arrayView; //массив всех вью

//TypeBuyer

@property (strong, nonatomic) UIView * viewBuyer;

//PersonalData

@property (strong, nonatomic) UIView * viewPersonalData;
@property (strong, nonatomic) UIView * whiteViewPerson;

//Address

@property (strong, nonatomic) UIView * viewaArddress;

@end



@implementation FormalizationView

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 0.f, view.frame.size.width, view.frame.size.height);
        self.arrayView = [[NSMutableArray alloc] init];
        self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
        self.mainScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:self.mainScrollView];
        
        self.viewBuyer = [self createBuyerView];
        [self.mainScrollView addSubview:self.viewBuyer];
        [self.arrayView addObject:self.viewBuyer];
        
        self.viewPersonalData = [self createPesonalData];
        [self.mainScrollView addSubview:self.viewPersonalData];
        [self.arrayView addObject:self.viewPersonalData];
        
        self.viewaArddress = [self createAddress];
        [self.mainScrollView addSubview:self.viewaArddress];
        [self.arrayView addObject:self.viewaArddress];
        
    }
    return self;
}

#pragma mark TypeBuyer

- (UIView*) createBuyerView {
    
    UIView * whiteView = [[UIView alloc] init];
    UIView * buyerView = [self customViewWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, 130) andTitlName:@"Тип плательщика" andView:whiteView andBlock:^{
        NSArray * arrayNameTitl = [NSArray arrayWithObjects:@"Физическое лицо", @"Юридическое лицо", nil];
        for (int i = 0; i < 2; i++) {
            UIButton * buttonFace = [UIButton buttonWithType:UIButtonTypeCustom];
            buttonFace.tag = 5 + i;
            buttonFace.frame = CGRectMake(0.f, 0.f + (whiteView.frame.size.height / 2) * i, whiteView.frame.size.width, whiteView.frame.size.height / 2);
            [buttonFace addTarget:self action:@selector(buttonFaceAction:) forControlEvents:UIControlEventTouchUpInside];
            [buttonFace setImage:[UIImage imageNamed:@"buttonBuyerYes.png"] forState:UIControlStateSelected];
            buttonFace.userInteractionEnabled = NO;
            [whiteView addSubview:buttonFace];
            
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10.f, 10.f, 20.f, 20.f)];
            imageView.image = [UIImage imageNamed:@"buttonFaceYes.png"];
            if (i == 1) {
                imageView.image = [UIImage imageNamed:@"buttonFaceNo.png"];
                buttonFace.userInteractionEnabled = YES;
            }
            imageView.tag = 10 + i;
            [buttonFace addSubview:imageView];
            
            CustomLabels * labelButtons = [[CustomLabels alloc] initLabelWithWidht:40.f andHeight:14 andColor:@"000000"
                                                                           andText:[arrayNameTitl objectAtIndex:i] andTextSize:15 andLineSpacing:0.f fontName:VM_FONT_REGULAR];
            [buttonFace addSubview:labelButtons];
        }
    }];
    return buyerView;
}

#pragma mark - PersonalData

- (UIView*) createPesonalData {
    self.whiteViewPerson = [[UIView alloc] init];
    UIView * personalDataView = [self customViewWithFrame:CGRectMake(0.f, self.viewBuyer.frame.size.height, self.frame.size.width, 170) andTitlName:@"Личные Данные" andView:self.whiteViewPerson andBlock:^{
        
        
    }];
    return personalDataView;
}

#pragma mark - Address

- (UIView*) createAddress {
    UIView * whiteView = [[UIView alloc] init];
    UIView * addressDataView = [self customViewWithFrame:CGRectMake(0.f, self.viewPersonalData.frame.size.height + self.viewPersonalData.frame.origin.y, self.frame.size.width, 170) andTitlName:@"Адрес доставки *" andView:whiteView andBlock:^{
        
        
    }];
    return addressDataView;
}


#pragma mark - Actions

- (void) buttonFaceAction: (UIButton*) button {
    UIButton * buttonOne = [self viewWithTag:5];
    UIButton * buttonTwo = [self viewWithTag:6];
    UIImageView * imageViewOne = [self viewWithTag:10];
    UIImageView * imageViewTwo = [self viewWithTag:11];
    
    if (button.tag == 5) {
        buttonOne.userInteractionEnabled = NO;
        buttonTwo.userInteractionEnabled = YES;
        [UIView animateWithDuration:0.3 animations:^{
            imageViewOne.image = [UIImage imageNamed:@"buttonFaceYes.png"];
            imageViewTwo.image = [UIImage imageNamed:@"buttonFaceNo.png"];
            [self animationUpPersonalData];
        }];
    } else if (button.tag == 6) {
        buttonOne.userInteractionEnabled = YES;
        buttonTwo.userInteractionEnabled = NO;
        [UIView animateWithDuration:0.3 animations:^{
            imageViewOne.image = [UIImage imageNamed:@"buttonFaceNo.png"];
            imageViewTwo.image = [UIImage imageNamed:@"buttonFaceYes.png"];
            [self animationDownPersonalData];

        }];
    }
}


//Методы анимации для персональных данных

- (void) animationUpPersonalData {
    CGRect rectData = self.viewPersonalData.frame;
    rectData.size.height -= 40.f;
    CGRect rectWhitePerson = self.whiteViewPerson.frame;
    rectWhitePerson.size.height -= 40.f;
    self.whiteViewPerson.frame = rectWhitePerson;
    for (int i = 0; i < self.arrayView.count; i++) {
        UIView * viewBlock = [self.arrayView objectAtIndex:i];
        if (i > 1) {
            CGRect rect = viewBlock.frame;
            rect.origin.y -= 40;
            viewBlock.frame = rect;
        }
    }
}

- (void) animationDownPersonalData {
    CGRect rectData = self.viewPersonalData.frame;
    rectData.size.height += 40.f;
    CGRect rectWhitePerson = self.whiteViewPerson.frame;
    rectWhitePerson.size.height += 40.f;
    self.whiteViewPerson.frame = rectWhitePerson;
    for (int i = 0; i < self.arrayView.count; i++) {
        UIView * viewBlock = [self.arrayView objectAtIndex:i];
        if (i > 1) {
            CGRect rect = viewBlock.frame;
            rect.origin.y += 40;
            viewBlock.frame = rect;
        }
    }
}

#pragma mark - Other

- (UIView*) customViewWithFrame: (CGRect) frame andTitlName: (NSString*) nameTitl andView: (UIView*) actionView andBlock: (void(^)(void)) block {
    UIView * viewTypeBuyer = [[UIView alloc] initWithFrame:frame];
    
    CustomLabels * labelBuyer = [[CustomLabels alloc] initLabelWithWidht:15.f andHeight:15.f andColor:VM_COLOR_900
                                                                 andText:nameTitl andTextSize:15 andLineSpacing:0.f fontName:VM_FONT_REGULAR];
    [viewTypeBuyer addSubview:labelBuyer];
    
    actionView.frame = CGRectMake(15.f, 40.f, self.frame.size.width - 30.f, viewTypeBuyer.frame.size.height - 50.f);
    actionView.backgroundColor = [UIColor whiteColor];
    actionView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    actionView.layer.borderWidth = 0.3f;
    actionView.layer.cornerRadius = 2.f;
    actionView.layer.shadowColor = [[UIColor blackColor] CGColor];
    actionView.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    actionView.layer.shadowRadius = 1.0f;
    actionView.layer.shadowOpacity = 0.5f;
    [viewTypeBuyer addSubview:actionView];

    block();
    
    return viewTypeBuyer;
}

@end
