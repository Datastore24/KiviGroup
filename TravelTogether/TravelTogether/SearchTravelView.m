//
//  SearchTravelView.m
//  TravelTogether
//
//  Created by Виктор Мишустин on 04/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "SearchTravelView.h"
#import "HexColors.h"
#import "Macros.h"
#import "CustomLabels.h"
#import "InputTextView.h"
#import "MBSwitch.h"
#import "JBWatchActivityIndicator.h"
#import "UIView+BorderView.h"
#import "UIButton+ButtonImage.h"

@interface SearchTravelView () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIButton * buttonAircraft;
@property (strong, nonatomic) UIButton * buttonTrain;

@property (strong, nonatomic) MBSwitch * swithMale;
@property (strong, nonatomic) MBSwitch * swithFemale;
@property (strong, nonatomic) UIImageView * imageMale;
@property (strong, nonatomic) UIImageView * imageFemale;
@property (strong, nonatomic) UIView * timeView;
@property (strong, nonatomic) UIButton * buttonDateThere;
@property (strong, nonatomic) UIButton * buttonDateThence;
@property (strong, nonatomic) UIView * fonView;
@property (strong, nonatomic) InputTextView * inputTextName;

@property (assign, nonatomic) NSInteger takeButton;

//Свойства поиска
@property (strong, nonatomic) UIView * searchView;
@property (strong, nonatomic) NSArray * arrayCountry;
@property (strong, nonatomic) UITableView * tableSearch;
@property (strong, nonatomic) InputTextView * inputText;
@property (strong, nonatomic) NSArray * timeArray;

//Свойства пикера
@property (strong, nonatomic) UIView * pickerView;
@property (assign, nonatomic) NSInteger labelDateTag;
@property (strong, nonatomic) UIDatePicker * datePicker;


@end

@implementation SearchTravelView

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initMainViewSearchTravelWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 64.f, view.frame.size.width, view.frame.size.height - 64.f);
        
        //Сохранение нажатой кнопки;
        self.takeButton = 0;
        self.labelDateTag = 0;
        
        self.arrayCountry = [NSArray arrayWithObjects:
                             @"Австралия", @"Австрия",@"Азербайджан",@"Белоруссия",@"Бенин",
                             @"Вануату",@"Венесуэла",@"Гамбия",@"Германия",@"Иран",@"Казахстан",@"Лаос", nil];
        self.timeArray = self.arrayCountry;
        
        
        NSArray * arrayTintText = [NSArray arrayWithObjects:               //Массив имен мелких заголовков
                                   @"Номер рейса", @"Выберете направление", @"Откуда", @"Туда", @"Куда", @"Обратно", @"", nil];
        
        NSArray * arrayPlaysholders = [NSArray arrayWithObjects:@"PTX 5467", @"Страна", @"Город", @"Домодедово", @"19 августа, вт", @"Рим", @"29 августа, пн", nil];
        
        
        //Air view
        UIView * viewAircraft = [[UIView alloc] initWithFrame:
                                 CGRectMake(12.5f, 39.f, self.frame.size.width / 2.f - 12.5f, 21.f)];
        viewAircraft.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK];
        [self customRadiusWithView:viewAircraft andRadius:10.5f];
        [self addSubview:viewAircraft];
        
        self.buttonAircraft = [UIButton buttonWithType:UIButtonTypeSystem];
        self.buttonAircraft.frame = CGRectMake(13.5f, 40.f, self.frame.size.width / 2.f - 14.5f, 19.f);
        self.buttonAircraft.backgroundColor = [UIColor whiteColor];
        [self customRadiusWithView:self.buttonAircraft andRadius:9.5f];
        self.buttonAircraft.userInteractionEnabled = NO;
        self.buttonAircraft.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_WHITE alpha:0.f];
        [self.buttonAircraft setTitle:@"Самолет" forState:UIControlStateNormal];
        [self.buttonAircraft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.buttonAircraft.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
        [self.buttonAircraft addTarget:self action:@selector(buttonAircraftAction)
                 forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.buttonAircraft];
        
        
        //Train view
        UIView * viewTrain = [[UIView alloc] initWithFrame:
                              CGRectMake(self.frame.size.width / 2, 39.f,
                                         self.frame.size.width / 2.f - 12.5f, 21.f)];
        viewTrain.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK];
        [self customRightRadiusWithView:viewTrain andRadius:10.5f];
        [self addSubview:viewTrain];
        
        self.buttonTrain = [UIButton buttonWithType:UIButtonTypeSystem];
        self.buttonTrain.frame = CGRectMake(viewTrain.frame.origin.x + 1.f, 40.f,
                                       self.frame.size.width / 2.f - 14.5f, 19.f);
        self.buttonTrain.backgroundColor = [UIColor whiteColor];
        [self customRightRadiusWithView:self.buttonTrain andRadius:9.5f];
        self.buttonTrain.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_WHITE alpha:1.f];
        [self.buttonTrain setTitle:@"Поезд" forState:UIControlStateNormal];
        [self.buttonTrain setTitleColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK] forState:UIControlStateNormal];
        self.buttonTrain.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
        [self.buttonTrain addTarget:self action:@selector(buttonTrainAction)
                      forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.buttonTrain];
        
        //Наносим повторяющиеся элементы-------------------
        
        for (int i = 0; i < 7; i++) {
            CustomLabels * tintLabels = [[CustomLabels alloc] initLabelWithWidht:12.5f andHeight:75.f + 46.25 * i
                                                                        andColor:VM_COLOR_DARK_GREY
                                                                         andText:[arrayTintText objectAtIndex:i] andTextSize:10
                                                                  andLineSpacing:0.f fontName:VM_FONT_REGULAR];
            if (i == 0) {
                tintLabels.tag = 1000;
            }

            
            UIView * groudView = [[UIView alloc] initWithFrame:CGRectMake(12.5f, 87.5f + 46.f * i, 142.5f, 20.f)];
            groudView.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK];
            
            UIView * borderView = [[UIView alloc] initWithFrame:CGRectMake(13.5f, 88.5f + 46.f * i, 140.5f, 18.f)];
            borderView.backgroundColor = [UIColor whiteColor];
            
            
            UIButton * inputTextButton = [UIButton buttonWithType:UIButtonTypeSystem];
            inputTextButton.tag = 50 + i;
            inputTextButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [inputTextButton setTitle:[arrayPlaysholders objectAtIndex:i] forState:UIControlStateNormal];
            [inputTextButton setTitleColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_LIGHT_GREY] forState:UIControlStateNormal];
            inputTextButton.titleLabel.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:10];
            inputTextButton.frame = CGRectMake(13.5f + 10.f, 88.5f + 46.f * i, 140.5f - 10.f, 18.f);
            
            
            if (i == 0) {
                inputTextButton.alpha = 0.f;
                groudView.alpha = 0.f;
                borderView.alpha = 0.f;
                self.inputTextName = [[InputTextView alloc] initInputTextWithView:self andRect:CGRectMake(13.5f, 88.5f, 140.5 - 10.f, 18.f) andImage:nil andTextPlaceHolder:@"PTX 5467" colorBorder:VM_COLOR_PINK];
                self.inputTextName.layer.borderWidth = 1.f;
                self.inputTextName.layer.borderColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK].CGColor;
                self.inputTextName.layer.cornerRadius = 9.f;
                self.inputTextName.textFieldInput.textColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_LIGHT_GREY];
                self.inputTextName.textFieldInput.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:10];
                [self addSubview:self.inputTextName];
            }
            
            
            
            if (i > 1 && i < 4) {
                tintLabels.frame = CGRectMake(26.f, 75.f + 46.25f * (i + 1.f), 100.f, 20.f);
                [tintLabels sizeToFit];
            } else if (i > 3) {
                tintLabels.frame = CGRectMake(175.f, 75.f + 46.25f * (i - 1.f), 100.f, 20.f);
                [tintLabels sizeToFit];
            }
            
            if (i == 4 || i == 6) {
                [inputTextButton addTarget:self action:@selector(actionDatePicker:) forControlEvents:UIControlEventTouchUpInside];
            } else {
                [inputTextButton addTarget:self action:@selector(inputTextButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            if (i > 2 && i < 5) {
                [self customRadiusWithView:groudView andRadius:10.f];
                [self customRadiusWithView:borderView andRadius:9.f];
            } else if (i > 4) {
                groudView.frame = CGRectMake(self.frame.size.width - 12.5f - 142.5f, 87.5f + 46.f * (i - 2.f), 142.5f, 20.f);
                borderView.frame = CGRectMake(self.frame.size.width - 11.5f - 142.5f, 88.5f + 46.f * (i - 2.f), 140.5f, 18.f);
                inputTextButton.frame = CGRectMake(self.frame.size.width - 11.5f - 142.5f + 10.f, 88.5f + 46.f * (i - 2.f), 140.5f - 10.f, 18.f);

                [self customRightRadiusWithView:groudView andRadius:10.f];
                [self customRightRadiusWithView:borderView andRadius:9.f];
                
                
            } else {
                [self customAllRadiusWithView:groudView andRadius:10.f];
                [self customAllRadiusWithView:borderView andRadius:9.f];
            }

            [self addSubview: tintLabels];
            [self addSubview:groudView];
            [self addSubview:borderView];
            [self addSubview:inputTextButton];
        }
        
        self.buttonDateThere = [UIButton buttonWithType:UIButtonTypeCustom];
        self.buttonDateThere.frame = CGRectMake(130.f, 275.f, 12.5f, 12.5f);
        self.buttonDateThere.tag = 20;
        UIImage * buttonDateImage = [UIImage imageNamed:@"imageData.png"];
        [self.buttonDateThere setImage:buttonDateImage forState:UIControlStateNormal];
        [self.buttonDateThere addTarget:self action:@selector(actionDatePicker:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.buttonDateThere];
        
        self.buttonDateThence = [UIButton buttonWithType:UIButtonTypeCustom];
        self.buttonDateThence.frame = CGRectMake(self.frame.size.width - 36.f, 275.f, 12.5f, 12.5f);
        self.buttonDateThence.tag = 21;
        self.buttonDateThence.enabled = NO;
        [self.buttonDateThence setImage:buttonDateImage forState:UIControlStateNormal];
        [self.buttonDateThence addTarget:self action:@selector(actionDatePicker:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.buttonDateThence];
        
        
        
        self.swithMale.onTintColor = [UIColor hx_colorWithHexRGBAString:@"e9e5e5"];
        self.swithMale.offTintColor = [UIColor hx_colorWithHexRGBAString:@"e9e5e5"];
        self.swithMale.thumbTintColor = [UIColor hx_colorWithHexRGBAString:@"b7b7b7"];
        [self.swithMale addTarget:self action:@selector(swichMaleAction) forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.swithMale];
        
        self.swithFemale.onTintColor = [UIColor hx_colorWithHexRGBAString:@"e9e5e5"];
        self.swithFemale.offTintColor = [UIColor hx_colorWithHexRGBAString:@"e9e5e5"];
        self.swithFemale.thumbTintColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK];
        self.swithFemale.on = YES;
        [self.swithFemale addTarget:self action:@selector(swichFemaleAction) forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.swithFemale];
        
        
        self.imageMale = [[UIImageView alloc] initWithFrame:CGRectMake(97.f, self.swithMale.frame.origin.y - 50.5f, 20.f, 43.5f)];
        self.imageMale.image = [UIImage imageNamed:@"sexManNo.png"];
        [self addSubview:self.imageMale];
        
        self.imageFemale = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 97.f - 20.f,
                                                                                  self.swithMale.frame.origin.y - 50.5f, 20.f, 43.5f)];
        self.imageFemale.image = [UIImage imageNamed:@"sexFemaleYes.png"];
        [self addSubview:self.imageFemale];
        
        
        
        UIButton * mainButtonSearch = [UIButton buttonWithType:UIButtonTypeSystem];
        mainButtonSearch.frame = CGRectMake(self.frame.size.width / 2 - 112.5f, self.frame.size.height - 95.f, 225.f, 46.f);
        mainButtonSearch.layer.cornerRadius = 23.f;
        mainButtonSearch.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK];
        [mainButtonSearch setTitle:@"НАЧАТЬ ПОИСК" forState:UIControlStateNormal];
        [mainButtonSearch setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        mainButtonSearch.titleLabel.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:13];
        [mainButtonSearch addTarget:self action:@selector(mainButtonSearchAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:mainButtonSearch];
        
        
        JBWatchActivityIndicator * activiti = [[JBWatchActivityIndicator alloc] initWithType:JBWatchActivityIndicatorTypeDotsSmall];
        activiti.indicatorScale = 2.f;
        activiti.indicatorRadius = 15.f;
        activiti.segmentRadius = 2.f;
        activiti.numberOfSegments = 12;

        
        self.timeView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
        self.timeView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"000000" alpha:0.8f];
        self.timeView.alpha = 0.f;
        [self addSubview:self.timeView];
        
        
        UIImageView * imaheView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 19.f, 167.5f, 38.f, 38.f)];
        imaheView.image = [activiti animatedImageWithDuration:1.f];
        [self.timeView addSubview:imaheView];
        
        UILabel * timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 205.f, self.frame.size.width, 60.f)];
        timeLabel.text = @"ОЖИДАЙТЕ\nИДЕТ ПОИСК РЕЙСА";
        timeLabel.textColor = [UIColor whiteColor];
        timeLabel.numberOfLines = 2;
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:13];
        [self.timeView addSubview:timeLabel];
        
        
        
        //ViewSerach
        self.searchView = [self searchViewWith:self];
        [self addSubview:self.searchView];
        
        self.fonView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
        self.fonView.backgroundColor = [UIColor blackColor];
        self.fonView.alpha = 0.f;
        [self addSubview:self.fonView];
        
        //PickrView
        self.pickerView = [self createDatePickerWithView:self];
        [self addSubview:self.pickerView];
        
        
        
        
        
    }
    return self;
}





#pragma mark - SearchView

- (UIView*) searchViewWith: (UIView*) view {
    UIView * viewSearch = [[UIView alloc] initWithFrame:CGRectMake(view.frame.size.width, 0.f, view.frame.size.width, view.frame.size.height)];
    viewSearch.backgroundColor = [UIColor whiteColor];
    
    self.inputText = [[InputTextView alloc] initInputTextSearchWithView:viewSearch andRect:CGRectMake(0.f, 10.f, viewSearch.frame.size.width, 15.f) andImage:nil andTextPlaceHolder:@"Страна" colorBorder:nil];
    [viewSearch addSubview:self.inputText];

        [UIView borderViewWithHeight:35.f andWight:0.f andView:viewSearch andColor:VM_COLOR_PINK];

    
    
    UIButton * buttonCancel = [UIButton createButtonWithImage:@"buttonCityCancel.png" anfFrame:CGRectMake(self.frame.size.width - 50.f, 3.f, 30.f, 30.f)];
    [buttonCancel addTarget:self action:@selector(buttonCancelAction) forControlEvents:UIControlEventTouchUpInside];
    [viewSearch addSubview:buttonCancel];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishInputSearchText) name:UITextFieldTextDidChangeNotification object:nil];
    
    self.tableSearch = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 40.f, viewSearch.frame.size.width, viewSearch.frame.size.height - 40.f)];
     //Убираем полосы разделяющие ячейки------------------------------
    self.tableSearch.backgroundColor = nil;
    self.tableSearch.dataSource = self;
    self.tableSearch.delegate = self;
    self.tableSearch.showsVerticalScrollIndicator = NO;
    [viewSearch addSubview:self.tableSearch];
    
    return viewSearch;
}


#pragma mark - Action Methods


- (void) buttonCancelAction {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.searchView.frame;
        rect.origin.x += self.searchView.frame.size.width;
        self.searchView.frame = rect;
        [self.inputText.textFieldInput resignFirstResponder];
    } completion:^(BOOL finished) {
        self.inputText.textFieldInput.text = @"";
        self.arrayCountry = self.timeArray;
        [self reloadData:YES];
        if (!self.inputText.textFieldInput.isBoll) {
            [UIView animateWithDuration:0.25f animations:^{
                CGRect rect;
                rect = self.inputText.labelPlaceHoldInput.frame;
                rect.origin.x = rect.origin.x - 100.f;
                self.inputText.labelPlaceHoldInput.frame = rect;
                self.inputText.labelPlaceHoldInput.alpha = 1.f;
                self.inputText.textFieldInput.isBoll = YES;
            }];
        }
    }];
}

- (void) buttonAircraftAction
{
    
    UILabel * labelAction = (UILabel*)[self viewWithTag:1000];
    if ([labelAction.text isEqualToString:@"Номер поезда"]) {
        labelAction.text = @"Номер рейса";
        [labelAction sizeToFit];
    }
    self.buttonAircraft.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.3f animations:^{
        self.buttonAircraft.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_WHITE alpha:0.f];
        [self.buttonAircraft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.buttonTrain.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_WHITE alpha:1.f];
        [self.buttonTrain setTitleColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK] forState:UIControlStateNormal];

    } completion:^(BOOL finished) {
        self.buttonTrain.userInteractionEnabled = YES;
        
        //Остальной код действия кнопки
        
    }];
}

- (void) buttonTrainAction
{
    UILabel * labelAction = (UILabel*)[self viewWithTag:1000];
    if ([labelAction.text isEqualToString:@"Номер рейса"]) {
        labelAction.text = @"Номер поезда";
        [labelAction sizeToFit];
    }
    self.buttonTrain.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.3f animations:^{
        self.buttonTrain.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_WHITE alpha:0.f];
        [self.buttonTrain setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.buttonAircraft.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_WHITE alpha:1.f];
        [self.buttonAircraft setTitleColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK] forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        self.buttonAircraft.userInteractionEnabled = YES;
        
        //Остальной код действия кнопки
        
    }];
}

- (void) inputTextButtonAction: (UIButton*) button {
    for (int i = 0; i < 7; i++) {
        if (button.tag == 50 + i) {
            
            [self.inputTextName.textFieldInput resignFirstResponder];
            
            self.takeButton = button.tag;
            [UIView animateWithDuration:0.2f animations:^{
                CGRect rect = self.searchView.frame;
                rect.origin.x -= self.searchView.frame.size.width;
                self.searchView.frame = rect;
            } completion:^(BOOL finished) { }];
        }
    }
}

- (void) actionDatePicker: (UIButton*) button {
    
    [self.inputTextName.textFieldInput resignFirstResponder];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.pickerView.frame;
        
        self.fonView.alpha = 0.4;
            rect.origin.y -= 230;
        self.pickerView.frame = rect;
    }];
    if (button.tag == 20) {
        self.labelDateTag = 54;
    } else {
        self.labelDateTag = 56;
    }
    
    self.buttonDateThence.enabled = NO;
    self.buttonDateThere.enabled = NO;
    
    UIButton * buttonLabel = [self viewWithTag:self.labelDateTag];
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"d MMMM, E"];
    [buttonLabel setTitle:[format stringFromDate:[self.datePicker date]] forState:UIControlStateNormal];
}

- (void) buttonConfirmAction: (UIButton*) button {
    [UIView animateWithDuration:0.3 animations:^{
        
        
        self.fonView.alpha = 0.f;
        
        
        CGRect rect = self.pickerView.frame;

            rect.origin.y += 230;

        self.pickerView.frame = rect;
    }];
    self.buttonDateThence.enabled = YES;
    self.buttonDateThere.enabled = YES;
    
}


#pragma mark - Swich Actions

- (void) swichMaleAction
{
    if (self.swithMale.on) {
        [self.swithFemale setOn:NO animated:YES];
        self.swithMale.thumbTintColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK];
        self.swithFemale.thumbTintColor = [UIColor hx_colorWithHexRGBAString:@"b7b7b7"];
        [UIView animateWithDuration:0.3f animations:^{
            self.imageMale.image = [UIImage imageNamed:@"sexMaleYes.png"];
            self.imageFemale.image = [UIImage imageNamed:@"sexFemaleNO.png"];
        }];
    } else {
        [self.swithFemale setOn:YES animated:YES];
        self.swithMale.thumbTintColor = [UIColor hx_colorWithHexRGBAString:@"b7b7b7"];
        self.swithFemale.thumbTintColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK];
        [UIView animateWithDuration:0.3f animations:^{
            self.imageMale.image = [UIImage imageNamed:@"sexManNo.png"];
            self.imageFemale.image = [UIImage imageNamed:@"sexFemaleYes.png"];
        }];
    }
}

- (void) swichFemaleAction
{
    if (self.swithFemale.on) {
        [self.swithMale setOn:NO animated:YES];
    } else {
        [self.swithMale setOn:YES animated:YES];
    }
}

- (void) mainButtonSearchAction {
    [UIView animateWithDuration:0.3f animations:^{
        self.timeView.alpha = 1.f;
    }];
    
    [self performSelector:@selector(pushAction) withObject:self afterDelay:3.f];
}

- (void) pushAction {
    [self.delegate pushToSearchList:self];
    
}

#pragma mark - UITableViewDelegate

//Анимация нажатия ячейки--------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIButton * button = [self viewWithTag:self.takeButton];
    UIButton * buttonCity = [self viewWithTag:52];
    buttonCity.userInteractionEnabled = YES;
    
    [button setTitle:[self.arrayCountry objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    [self.inputText.textFieldInput resignFirstResponder];
    [UIView animateWithDuration:0.3f animations:^{
        CGRect rect = self.searchView.frame;
        rect.origin.x += self.searchView.frame.size.width;
        self.searchView.frame = rect;
    }];
    
    self.inputText.textFieldInput.text = @"";
    self.arrayCountry = self.timeArray;
    [self reloadData:YES];
    if (!self.inputText.textFieldInput.isBoll) {
        [UIView animateWithDuration:0.25f animations:^{
            CGRect rect;
            rect = self.inputText.labelPlaceHoldInput.frame;
            rect.origin.x = rect.origin.x - 100.f;
            self.inputText.labelPlaceHoldInput.frame = rect;
            self.inputText.labelPlaceHoldInput.alpha = 1.f;
            self.inputText.textFieldInput.isBoll = YES;
        }];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayCountry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * identifier = @"identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [self.arrayCountry objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:13];
    cell.textLabel.textColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_DARK_GREY];
    
    
    return cell;
    
}

#pragma mark - DatePicker

- (UIView*) createDatePickerWithView: (UIView*) view {
    UIView * pickerView = [[UIView alloc] initWithFrame:CGRectMake(0.f, self.frame.size.height, self.frame.size.width, 230.f)];
    pickerView.userInteractionEnabled = YES;
    pickerView.backgroundColor = [UIColor whiteColor];
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.f, 0.f, pickerView.frame.size.width, 190)];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    [self.datePicker addTarget:self action:@selector(datePickerAction:) forControlEvents:UIControlEventValueChanged];
    self.datePicker.minimumDate = [NSDate date];
    [pickerView addSubview:self.datePicker];
    
    UIButton * buttonConfirm = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonConfirm.frame = CGRectMake(pickerView.frame.size.width / 2.f + 50, 190.f, 80.f, 20.f);
    [buttonConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [buttonConfirm setTitle:@"Готово" forState:UIControlStateNormal];
    [buttonConfirm setTitleColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK] forState:UIControlStateNormal];

    //    self.buttonPushDate.layer.borderWidth = 0.7f;
    //    self.buttonPushDate.layer.borderColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK].CGColor;
    buttonConfirm.layer.cornerRadius = 10.f;
    buttonConfirm.titleLabel.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:15];
    [buttonConfirm addTarget:self action:@selector(buttonConfirmAction:) forControlEvents:UIControlEventTouchUpInside];
    [pickerView addSubview:buttonConfirm];
    
    return pickerView;
}

- (void) datePickerAction: (UIDatePicker*) datePicker {
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"d MMMM, E"];
    NSString * newDate = [format stringFromDate:[datePicker date]];
    
    UIButton * button = [self viewWithTag:self.labelDateTag];
    [button setTitle:newDate forState:UIControlStateNormal];
}



#pragma mark - Other

- (void) finishInputSearchText {
    
    NSMutableArray * arrayRefrash = [NSMutableArray array];
    
    if (self.inputText.textFieldInput.text.length != 0) {
        for (int i = 0; i < self.timeArray.count; i++) {

            if ([[self.timeArray objectAtIndex:i] rangeOfString:self.inputText.textFieldInput.text].location != NSNotFound) {
                [arrayRefrash addObject:[self.timeArray objectAtIndex:i]];
            }
        }
        self.arrayCountry = arrayRefrash;
        [self reloadData:YES];
    } else {
        self.arrayCountry = self.timeArray;
        [self reloadData:YES];
    }

}

- (void)reloadData:(BOOL)animated
{
    [UIView transitionWithView:self.tableSearch
                      duration:0.3f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^(void) {
                        [self.tableSearch reloadData];
                    } completion:NULL];
}


- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


//Два метода для создания загругления------

- (void) customRadiusWithView: (UIView*) view
                    andRadius: (CGFloat) radius
{
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                     byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft)
                                           cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

- (void) customRightRadiusWithView: (UIView*) view
                         andRadius: (CGFloat) radius
{
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                     byRoundingCorners:(UIRectCornerTopRight | UIRectCornerBottomRight)
                                           cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

- (void) customAllRadiusWithView: (UIView*) view
                       andRadius: (CGFloat) radius
{
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                     byRoundingCorners:(UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerTopLeft | UIRectCornerBottomLeft)
                                           cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}



@end
