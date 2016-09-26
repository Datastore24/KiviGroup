//
//  QuestionView.m
//  Sadovod
//
//  Created by Виктор Мишустин on 08/09/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "QuestionView.h"
#import "InputTextView.h"
#import "CustomButton.h"
#import "CustomLabels.h"
#import "Macros.h"
#import "HexColors.h"
#import "UIView+BorderView.h"

@interface QuestionView () <UITextViewDelegate>

@property (strong, nonatomic) UILabel * labelNumberComments;

@end

@implementation QuestionView

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 64.f, view.frame.size.width, view.frame.size.height - 64.f);
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        
        UIView * viewCentre = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 130.f, 20.f, 260.f, self.frame.size.height - 90.f)];
        if (isiPhone6) {
            viewCentre.frame = CGRectMake(self.frame.size.width / 2 - 170.f, 60.f, 340.f, self.frame.size.height - 180.f);
        } else if (isiPhone6Plus) {
            viewCentre.frame = CGRectMake(self.frame.size.width / 2 - 170.f, 60.f, 340.f, self.frame.size.height - 240.f);
        }
        viewCentre.backgroundColor = [UIColor whiteColor];
        [viewCentre.layer setBorderColor:[UIColor colorWithWhite:0.8f alpha:0.6f].CGColor];
        viewCentre.layer.borderWidth = 1.5f;
        viewCentre.layer.cornerRadius = 5.f;
        [self addSubview:viewCentre];
        
        
        NSArray * arrayName = [NSArray arrayWithObjects:@"Чтобы знать как к Вам обращаться", @"Необязательно, но оперативнее", @"Сюда мы отправляем ответ на вопрос", nil];
        for (int i = 0; i < 3; i++) {
            InputTextView * inputText = [[InputTextView alloc] initInputTextWithView:viewCentre
                                                                             andRect:CGRectMake(5.f, 30.f + 70 * i, viewCentre.frame.size.width - 30.f, 40) andImage:nil
                                                                  andTextPlaceHolder:[arrayName objectAtIndex:i] colorBorder:nil];
            if (i == 0) {
                
            } else if (i == 1) {
                inputText.textFieldInput.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            } else if (i == 2) {
                inputText.textFieldInput.keyboardType = UIKeyboardTypeEmailAddress;
            }
            inputText.textFieldInput.font = [UIFont fontWithName:VM_FONT_REGULAR size:12];
            inputText.textFieldInput.textColor = [UIColor blackColor];
            inputText.labelPlaceHoldInput.font = [UIFont fontWithName:VM_FONT_REGULAR size:12];
            inputText.labelPlaceHoldInput.textColor = [UIColor lightGrayColor];
            [viewCentre addSubview:inputText];
            [UIView borderViewWithHeight:39.f andWight:10.f andView:inputText andColor:@"efeff4" andHieghtBorder:1.f];
        }
        
        NSArray * arrayTitls = [NSArray arrayWithObjects:@"Имя", @"Телефон", @"Email", @"Текст сообщения", nil];
        for (int i = 0; i < 4; i++) {
            CustomLabels * titlLabel = [[CustomLabels alloc] initLabelWithWidht:20.f andHeight:15 + 70 * i andColor:@"5C5C5C" andText:[arrayTitls objectAtIndex:i] andTextSize:13 andLineSpacing:0.f fontName:VM_FONT_REGULAR];
            [viewCentre addSubview:titlLabel];
        }
        
        
        UITextView * textView = [[UITextView alloc] initWithFrame:CGRectMake(15.f, 240.f, viewCentre.frame.size.width - 30.f, 100.f)];
        textView.textColor = [UIColor blackColor];
        textView.delegate = self;
        textView.font = [UIFont fontWithName:VM_FONT_REGULAR size:12];
        [viewCentre addSubview:textView];
        
        [UIView borderViewWithHeight:textView.frame.size.height - 1 andWight:10.f andView:textView andColor:@"efeff4" andHieghtBorder:1.f];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textStart) name:UITextViewTextDidBeginEditingNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textEnd) name:UITextViewTextDidEndEditingNotification object:nil];
    
        self.labelNumberComments = [[CustomLabels alloc] initLabelTableWithWidht:viewCentre.frame.size.width - 80.f andHeight:225.f andSizeWidht:60.f andSizeHeight:20.f andColor:VM_COLOR_300 andText:@"300"];
        self.labelNumberComments.font = [UIFont fontWithName:VM_FONT_BEAU_SANS_LITE size:12];
        self.labelNumberComments.textAlignment = NSTextAlignmentRight;
        [viewCentre addSubview:self.labelNumberComments];
    
        UIButton * buttonEntrance = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonEntrance.frame = CGRectMake(15.f, 355.f, viewCentre.frame.size.width - 30.f, 40);
        buttonEntrance.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_800];
        [buttonEntrance setTitle:@"Оставить вопрос" forState:UIControlStateNormal];
        [buttonEntrance setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonEntrance.layer.cornerRadius = 3.f;
        buttonEntrance.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:16];
        [buttonEntrance addTarget:self action:@selector(buttonEntranceActions) forControlEvents:UIControlEventTouchUpInside];
        [viewCentre addSubview:buttonEntrance];
        
        
    }
    
    return self;
}

#pragma mark - Actions

- (void) buttonEntranceActions {
    NSLog(@"Задать вопрос");
}

#pragma mark - Notification Actions

- (void) textStart {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rectView = self.frame;
        if (isiPhone5) {
            rectView.origin.y -= 180.f;
        } else {
            rectView.origin.y -= 180.f;
        }
        self.frame = rectView;
    }];
}

- (void) textEnd {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rectView = self.frame;
        if (isiPhone5) {
            rectView.origin.y += 180.f;
        } else {
            rectView.origin.y += 180.f;
        }
        self.frame = rectView;
    }];
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    NSUInteger newLength = (textView.text.length - range.length) + text.length;
    NSInteger labelCount = 300 - newLength;

        self.labelNumberComments.text = [NSString stringWithFormat:@"%ld", (long)labelCount];
    
    if(newLength <= 299)
    {
        return YES;
    } else {
        NSUInteger emptySpace = 299 - (textView.text.length - range.length);
        textView.text = [[[textView.text substringToIndex:range.location]
                          stringByAppendingString:[text substringToIndex:emptySpace]]
                         stringByAppendingString:[textView.text substringFromIndex:(range.location + range.length)]];
        return NO;
    }
}

#pragma mark - Other

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
