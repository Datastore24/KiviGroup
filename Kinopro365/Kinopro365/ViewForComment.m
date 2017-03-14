//
//  ViewForComment.m
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 09.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "ViewForComment.h"
#import "HexColors.h"
#import "Macros.h"

@interface ViewForComment () <UITextViewDelegate>



@end

@implementation ViewForComment

- (instancetype)initWithMainView: (UIView*) view endHeight: (CGFloat) height
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, height, CGRectGetWidth(view.bounds), 120.f);
        self.userInteractionEnabled = YES;
        
        UILabel * titleLabel = [self creationLabelWithFrame:CGRectMake(12.f, 10.f, 296.f, 16)
                                                    endText:@"Описание и типажи"];
        [self addSubview:titleLabel];
        
        self.textView = [self createtextViewWithFrame:CGRectMake(14.f, 36, 296.f, 80.f)
                                                      endTextPlaceHolder:@"Какая концепция проекта? Кто нужен\nдля проекта? Что нужно делать?\nСколько платят?"];
        self.textView.delegate = self;
        [self addSubview:self.textView];
        
    }
    return self;
}

- (instancetype)initHideWithMainView: (UIView*) view endHeight: (CGFloat) height
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, height, CGRectGetWidth(view.bounds), 160.f);
        self.userInteractionEnabled = YES;
        
        UILabel * titleLabel = [self creationLabelWithFrame:CGRectMake(12.f, 10.f, 296.f, 40)
                                                    endText:@"Информация  и контакты для\nутвержденных анкет"];
        titleLabel.numberOfLines = 2;
        [self addSubview:titleLabel];
        
        self.textViewHide = [self createtextViewWithFrame:CGRectMake(14.f, 54, 296.f, 98.f)
                                                      endTextPlaceHolder:@"Адрес и время проведения кастинга.\nКонтакты для связи.\n(Отправляется в оповещение\nодобренным пользователям)."];
        self.textViewHide.delegate = self;
        [self addSubview:self.textViewHide];
        
    }
    return self;
}

- (UILabel*) creationLabelWithFrame: (CGRect) frame endText: (NSString*) text {
    
    UILabel * label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textColor = [UIColor hx_colorWithHexRGBAString:@"343536"];
    label.font = [UIFont fontWithName:FONT_ISTOK_REGULAR size:16];
    
    return label;

}

- (UIPlaceHolderTextView*) createtextViewWithFrame: (CGRect) frame endTextPlaceHolder: (NSString*) text {
    
    UIPlaceHolderTextView * textView = [[UIPlaceHolderTextView alloc] initWithFrame:frame];
    textView.editable = YES;
    textView.autocorrectionType = UITextAutocorrectionTypeNo;
    textView.placeholder = text;
    textView.placeholderColor = [UIColor hx_colorWithHexRGBAString:@"517BA2" alpha:0.45f];
    textView.font = [UIFont fontWithName:FONT_ISTOK_REGULAR size:15];
    
    textView.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"5581A8"].CGColor;
    textView.layer.borderWidth = 2.f;
    textView.layer.cornerRadius = 5.f;
    
    
    return textView;
    
}

#pragma mark - UITextViewDelegate


- (void)textViewDidBeginEditing:(UITextView *)textView {
    

        [self.delegate startTextView:self endTextView:textView];

    
}
- (void)textViewDidEndEditing:(UITextView *)textView {

        [self.delegate endTextView:self endTextView:textView];

}

- (void)textViewDidChange:(UITextView *)textView {
    
    CGFloat textHeight = [self getLabelHeight:textView];
    
    if ([textView isEqual:self.textView]) {
        if (textHeight > 55) {
            [self animationWithTextView:textView endBool:YES endHeight:textHeight endHide:NO];
        } else {
            [self animationWithTextView:textView endBool:NO endHeight:textHeight endHide:NO];
        }
        
    } else if ([textView isEqual:self.textViewHide]) {
        if (textHeight > 73) {
            [self animationWithTextView:textView endBool:YES endHeight:textHeight endHide:YES];
        } else {
            [self animationWithTextView:textView endBool:NO endHeight:textHeight endHide:YES];
        }
    }
    
    if ([textView isEqual:self.textView]) {
        [self.delegate checkOnHeight:textView];
    }  else {
        [self.delegate checkOnHideHeight:textView];
    }
    
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - Other
- (CGFloat)getLabelHeight:(UITextView*)textView
{
    CGSize constraint = CGSizeMake(textView.frame.size.width - 10, CGFLOAT_MAX);
    CGSize size;
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [textView.text boundingRectWithSize:constraint
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:@{NSFontAttributeName:textView.font}
                                                     context:context].size;
    
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    
    return size.height;
}

#pragma mark - Animation

- (void) animationWithTextView: (UITextView*) textView endBool: (BOOL) isBool endHeight: (CGFloat) height endHide: (BOOL) hide {
    
    if (isBool) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect textViewRect = textView.frame;
            textViewRect.size.height = height + 25;
            textView.frame = textViewRect;
            
            CGRect rectForView = self.frame;
            if (!hide) {
                rectForView.size.height = height + 65;
            } else {
                rectForView.size.height = height + 87;
            }
            
            self.frame = rectForView;
            
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect textViewRect = textView.frame;
            if (!hide) {
                textViewRect.size.height = 80;
            } else {
               textViewRect.size.height = 98;
            }
            textView.frame = textViewRect;
            
            CGRect rectForView = self.frame;
             if (!hide) {
                 rectForView.size.height = 120;
             } else {
                 rectForView.size.height = 160;
             }
            self.frame = rectForView;
        }];
    }
}

@end
