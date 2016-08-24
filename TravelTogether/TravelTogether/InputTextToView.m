//
//  InputTextToView.m
//  Dolpirog
//
//  Created by Виктор Мишустин on 21/07/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "InputTextToView.h"
#import "HexColors.h"
#import "Macros.h"

@interface InputTextToView () <UITextViewDelegate>


@property (strong, nonatomic) UILabel * placeHolderLabel;

@end

@implementation InputTextToView

- (instancetype)initWithTextViewFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        self.frame = frame;
        _mainTextView = [[CustomTextView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _mainTextView.delegate = self;
        _mainTextView.isBool = NO;
        _mainTextView.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_LIGHT size:12];
        _mainTextView.textColor = [UIColor hx_colorWithHexRGBAString:@"c8c8ce"];
        _mainTextView.autocorrectionType = UITextAutocorrectionTypeNo;
        [self addSubview:_mainTextView];
        _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 5, 200, 20)];
        _placeHolderLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"c8c8ce"];
        _placeHolderLabel.textAlignment = NSTextAlignmentLeft;
        _placeHolderLabel.font = _mainTextView.font;
        [_mainTextView addSubview:_placeHolderLabel];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationMethod) name:UITextViewTextDidChangeNotification object:nil];
        
        
    }
    return self;
}

- (void) setPlaceholder:(NSString *)placeholder
{
    _placeHolderLabel.text = placeholder;
}


- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) animationMethod
{
    if (_mainTextView.text.length != 0) {
        if (!_mainTextView.isBool) {
            [UIView animateWithDuration:0.2 animations:^{
                _placeHolderLabel.alpha = 0.f;
                
                CGRect rect = _placeHolderLabel.frame;
                rect.origin.x += 100;
                _placeHolderLabel.frame = rect;
            }];
            _mainTextView.isBool = YES;
        }
    } else if (_mainTextView.text.length == 0) {
        if (_mainTextView.isBool) {
            [UIView animateWithDuration:0.2 animations:^{
                _placeHolderLabel.alpha = 1.f;
                
                CGRect rect = _placeHolderLabel.frame;
                rect.origin.x -= 100;
                _placeHolderLabel.frame = rect;
            }];
            _mainTextView.isBool = NO;
        }
    }

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

@end
