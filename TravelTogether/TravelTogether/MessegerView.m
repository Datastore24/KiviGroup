//
//  MessegerView.m
//  TravelTogether
//
//  Created by Виктор Мишустин on 23/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "MessegerView.h"
#import "UIView+BorderView.h"
#import "HexColors.h"
#import "Macros.h"
#import "InputTextToView.h"
#import "CustomTextView.h"
#import "UIButton+ButtonImage.h"
#import "CustomLabels.h"

@interface MessegerView () <UIScrollViewDelegate>

//Main

@property (strong, nonatomic) NSArray * arrayData;
@property (strong, nonatomic) UIScrollView * chatScrollView;
@property (assign, nonatomic) NSInteger lineCount; //Сохраняемое значение колличества строк
@property (assign, nonatomic) CGFloat scrollHeight; //Параметр для создания онаимации текст филда
@property (assign, nonatomic) CGFloat inputTextHeight; //Параметр для создания онаимации текст филда

//SendView

@property (strong, nonatomic) UIView * sendView;
@property (strong, nonatomic) UIView * sendViewCust;
@property (strong, nonatomic) InputTextToView * inputText;
@property (strong, nonatomic) UIImageView * imageAddMessage;
@property (strong, nonatomic) UIButton * sendButton;

@property (strong, nonatomic) UIImage * sendImage; //Параметр для сохранения локальной картинки для добавления ее в чат

//Floats for count scroll messege

@property (assign,nonatomic) CGFloat messegeViewHeight; //
@property (assign, nonatomic) CGFloat contentOffcet;



@end

@implementation MessegerView

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 0.f, view.frame.size.width, view.frame.size.height);
        self.arrayData = data;
        self.lineCount = 1;
        self.chatScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 529.5f - 80.f, self.frame.size.width, self.frame.size.height - 38.5f)];

        self.scrollHeight = self.chatScrollView.frame.size.height;
        self.chatScrollView.delegate = self;
        [self addSubview:self.chatScrollView];
        
        self.messegeViewHeight = 0;
        
        //SendView
        self.sendView = [self createSendViewWithView:self];
        [self addSubview:self.sendView];
        
        //Bild Scroll Message------------------
        
        for (int i = 0; i < self.arrayData.count; i++) {
            NSDictionary * dictMessege = [self.arrayData objectAtIndex:i];
            UIView * messageView = [self createMessegeViewWithWhoMessege:[[dictMessege objectForKey:@"who"] boolValue] andName:[dictMessege objectForKey:@"name"] andImage:[dictMessege objectForKey:@"imageName"] andTextMessage:[dictMessege objectForKey:@"text"] andDate:[dictMessege objectForKey:@"date"] andSend:[dictMessege objectForKey:@"send"] andType:[dictMessege objectForKey:@"type"] whoSend:NO];
            [self.chatScrollView addSubview:messageView];
        }
    }
    return self;
}

#pragma mark - sendView

- (UIView*) createSendViewWithView: (UIView*) view {
    self.sendViewCust = [[UIView alloc] initWithFrame:CGRectMake(0.f, self.frame.size.height - 38.5f, self.frame.size.width, 38.5f)];

    self.inputText = [[InputTextToView alloc] initWithTextViewFrame:CGRectMake(45.f, 5.f, self.frame.size.width - 110.f, 38.5f)];
    self.inputText.placeholder = @"Напишите сообщение";
    [self.sendViewCust addSubview:self.inputText];
    [UIView borderViewWithHeight:0.f andWight:0.f andView:self.sendViewCust andColor:@"cdcdcd"];
    
    self.inputTextHeight = self.inputText.frame.size.height;
    
    UIButton * buttomAddImage = [UIButton createButtonWithImage:@"imageAddMessage.png" anfFrame:CGRectMake(14.f, 38.5f / 2.f - 8.75f, 17.5f, 17.5f)];
    [buttomAddImage addTarget:self action:@selector(buttomAddImageAction) forControlEvents:UIControlEventTouchUpInside];
    [self.sendViewCust addSubview:buttomAddImage];
    
    self.sendButton = [UIButton createButtonWithImage:@"buttonSendImage.png" anfFrame:CGRectMake(self.frame.size.width - 60.f, 38.5f / 2.f - 10.5f, 47.5f, 21.f)];
    [self.sendButton addTarget:self action:@selector(sendButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.sendButton.userInteractionEnabled = NO;
    [self.sendViewCust addSubview:self.sendButton];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyboard:)
                                                 name:UITextViewTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyboard:)
                                                 name:UITextViewTextDidEndEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkText:)
                                                 name:UITextViewTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getImage:) name:@"NOTIFICATION_SEND_IMAGE_FOR_DUSCUSSIONS_VIEW" object:nil];
    
    return self.sendViewCust;
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - MessegeView

- (UIView*) createMessegeViewWithWhoMessege: (BOOL) whoMessege
                                    andName: (NSString*) name
                                   andImage: (NSString*) imageName
                             andTextMessage: (NSString*) textMessege
                                    andDate: (NSString*) date
                                    andSend: (NSString*) send
                                    andType: (NSString*) type
                                    whoSend: (BOOL) whosend { //Кто отправляет если YES то отправляем мы, если NO приходит с сервера
    
    
    UIView * messegeView = [[UIView alloc] init]; //Основное окно
    UIView * messegeTextView = [[UIView alloc] init]; //Окно сообщения
    
    CustomLabels * labelMessage = [[CustomLabels alloc] initLabelTableWithWidht:10.f andHeight:5.f andSizeWidht:179.f andSizeHeight:40.f andColor:@"000000" andText:textMessege];
    labelMessage.numberOfLines = 0;
    labelMessage.textAlignment = NSTextAlignmentLeft;
    labelMessage.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_LIGHT size:12];
    [labelMessage sizeToFit];
    
    //Если сообщение идет от нас
    
    if (whoMessege) {
        
        if ([type integerValue] == 2) {
                messegeTextView.frame = CGRectMake(self.frame.size.width - (32.5 + 117.5f), 20.f, 121.5f, 121.5);
                messegeTextView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"e4b8cb"];
                UIImageView * viewTailRight = [[UIImageView alloc] initWithFrame:CGRectMake(messegeTextView.frame.size.width - 6.4f, messegeTextView.frame.size.height - 8.4f, 10.f, 8.f)];
                viewTailRight.image = [UIImage imageNamed:@"tailRight.png"];
                [messegeTextView addSubview:viewTailRight];
                UIImageView * testImage = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 117.5f, 117.5)];
                [messegeTextView addSubview:testImage];
                if (whosend) {
                    testImage.image = self.sendImage;
                } else {
                testImage.image = [UIImage imageNamed:textMessege];
                }
                testImage.clipsToBounds = YES;
                testImage.layer.cornerRadius = 10.f;
                labelMessage.alpha = 0.f;
        } else {
            messegeTextView.frame = CGRectMake(self.frame.size.width - (32.5 + labelMessage.frame.size.width), 20.f, labelMessage.frame.size.width + 20.f, labelMessage.frame.size.height + 10.f);
            messegeTextView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"e4b8cb"];
            UIImageView * viewTailRight = [[UIImageView alloc] initWithFrame:CGRectMake(messegeTextView.frame.size.width - 6.4f, messegeTextView.frame.size.height - 8.4f, 10.f, 8.f)];
            viewTailRight.image = [UIImage imageNamed:@"tailRight.png"];
            [messegeTextView addSubview:viewTailRight];
        }

        CustomLabels * labelName = [[CustomLabels alloc] initLabelTableWithWidht:self.frame.size.width - 80.f andHeight: 0.f andSizeWidht:60.f andSizeHeight:20.f andColor:@"A6A6AA" andText:name];
        labelName.textAlignment = NSTextAlignmentRight;
        labelName.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_LIGHT size:8];
        [messegeView addSubview:labelName];
        
        CustomLabels * labelDate = [[CustomLabels alloc] initLabelTableWithWidht:self.frame.size.width - 100.f andHeight:messegeTextView.frame.size.height + 20.f andSizeWidht:60.f andSizeHeight:20.f andColor:@"A6A6AA" andText:date];
        labelDate.textAlignment = NSTextAlignmentRight;
        labelDate.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_LIGHT size:8];
        [messegeView addSubview:labelDate];
        
        UIImageView * imageSend = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 38.f, messegeTextView.frame.size.height + 25.f, 20.f, 8.f)];
        if ([send integerValue] == 1) {
            imageSend.image = [UIImage imageNamed:@"imageMessegeSendNO.png"];
        } else if ([send integerValue] == 2) {
            imageSend.image = [UIImage imageNamed:@"sendMessegeImageYES.png"];
        } else if ([send integerValue] == 0) {
            imageSend.image = [UIImage imageNamed:@"sendMessegeImageSend.png"];
        }
        [messegeView addSubview:imageSend];
    
    //Если идет от другого пользователя
        
    } else {
        
        
        if ([type integerValue] == 2) {
            messegeTextView.frame = CGRectMake(50.f, 20.f, 121.5f, 121.5);
            messegeTextView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"e5e5ea"];
            UIImageView * viewTailLeft = [[UIImageView alloc] initWithFrame:CGRectMake(- 3.f, messegeTextView.frame.size.height - 8.4f, 10.f, 8.f)];
            viewTailLeft.image = [UIImage imageNamed:@"tailLeft.png"];
            [messegeTextView addSubview:viewTailLeft];
            UIImageView * testImage = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 117.5f, 117.5)];
            [messegeTextView addSubview:testImage];
            testImage.image = [UIImage imageNamed:textMessege];
            testImage.clipsToBounds = YES;
            testImage.layer.cornerRadius = 10.f;
            labelMessage.alpha = 0.f;
        } else {
            messegeTextView.frame = CGRectMake(50.f, 20.f, labelMessage.frame.size.width + 20.f, labelMessage.frame.size.height + 10.f);
            UIImageView * viewTailLeft = [[UIImageView alloc] initWithFrame:CGRectMake(- 3.f, messegeTextView.frame.size.height - 8.4f, 10.f, 8.f)];
            viewTailLeft.image = [UIImage imageNamed:@"tailLeft.png"];
            [messegeTextView addSubview:viewTailLeft];
            messegeTextView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"e5e5ea"];
        }
        
        CustomLabels * labelName = [[CustomLabels alloc] initLabelTableWithWidht:55.f andHeight: 0.f andSizeWidht:100.f andSizeHeight:20.f andColor:@"A6A6AA" andText:name];
        labelName.textAlignment = NSTextAlignmentLeft;
        labelName.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_LIGHT size:8];
        [messegeView addSubview:labelName];
        
        CustomLabels * labelDate = [[CustomLabels alloc] initLabelTableWithWidht:55.f andHeight:messegeTextView.frame.size.height + 20.f andSizeWidht:60.f andSizeHeight:20.f andColor:@"A6A6AA" andText:date];
        labelDate.textAlignment = NSTextAlignmentLeft;
        labelDate.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_LIGHT size:8];
        [messegeView addSubview:labelDate];
        
        UIImageView * avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(12.f, messegeTextView.frame.size.height + 5.f, 26.f, 26.f)];
        avatarView.image = [UIImage imageNamed:imageName];
        [messegeView addSubview:avatarView];
    }
    
    messegeTextView.layer.cornerRadius = 10.f;
    messegeView.frame = CGRectMake(0.f, self.messegeViewHeight, self.frame.size.width, messegeTextView.frame.size.height + 35.5f);
    [messegeView addSubview:messegeTextView];
    [messegeTextView addSubview:labelMessage];
    
//Подсчет ведется пудем подъема скрол вью на высоту сообщения, если общая сумма высот сообщения превышает высоту скрол вью но начинает опускаться оффсет скрол вью
    
    self.messegeViewHeight += messegeView.frame.size.height;
    
    if (self.messegeViewHeight <= self.chatScrollView.frame.size.height - 64.f) {
        
        NSLog(@"Норм");
        
        CGRect rect = self.chatScrollView.frame;
        rect.origin.y -= messegeView.frame.size.height;
        self.chatScrollView.frame = rect;
    } else {
        
        NSLog(@"Больше");
        
        CGRect rect = self.chatScrollView.frame;
        rect.origin.y = 0.f;
        self.chatScrollView.frame = rect;
        self.chatScrollView.contentSize = CGSizeMake(0, self.messegeViewHeight);
        if (whosend) {
            self.chatScrollView.contentOffset = CGPointMake(0, self.messegeViewHeight - (self.chatScrollView.frame.size.height));
        } else {
            self.chatScrollView.contentOffset = CGPointMake(0, self.messegeViewHeight - (self.chatScrollView.frame.size.height - 64));
        }
    }
    self.contentOffcet = self.chatScrollView.contentOffset.y;
    return messegeView;
}

#pragma mark - Notification Methods


- (void)showKeyboard:(NSNotification*)notification
{
    [UIView animateWithDuration:0.2f animations:^{
        
        CGRect chatScrollRect = self.chatScrollView.frame;
        chatScrollRect.origin.y -= 216.f;
        chatScrollRect.size.height -= 216.f;
        self.chatScrollView.frame = chatScrollRect;
        
        CGRect sendViewRect = self.sendView.frame;
        sendViewRect.origin.y -= 216.f;
        self.sendView.frame = sendViewRect;
        self.chatScrollView.contentSize = CGSizeMake(0, self.messegeViewHeight + 100);
        
        if (self.messegeViewHeight > self.chatScrollView.frame.size.height - 64) {
            chatScrollRect.origin.y = 0.f;
            self.chatScrollView.frame = chatScrollRect;
            self.chatScrollView.contentSize = CGSizeMake(0, self.messegeViewHeight);
            self.chatScrollView.contentOffset = CGPointMake(0, self.messegeViewHeight - self.chatScrollView.frame.size.height);
        } else {
            NSLog(@"Меньше");
        }
        
        self.contentOffcet = self.chatScrollView.contentOffset.y;
        
    }];
}

- (void)hideKeyboard:(NSNotification*)notification
{
    self.inputText.mainTextView.text = @"";
    self.sendButton.userInteractionEnabled = NO;
    [self.inputText backAnimation];
    [self animathionMethodWithDurqction:0.f];
    [UIView animateWithDuration:0.2f animations:^{
        CGRect chatScrollRect = self.chatScrollView.frame;
        chatScrollRect.origin.y += 216.f;
        chatScrollRect.size.height += 216.f;
        self.chatScrollView.frame = chatScrollRect;
        
        CGRect sendViewRect = self.sendView.frame;
        sendViewRect.origin.y += 216.f;
        self.sendView.frame = sendViewRect;
        
        if (self.messegeViewHeight > self.chatScrollView.frame.size.height - 64) {
            chatScrollRect.origin.y = 0.f;
            self.chatScrollView.frame = chatScrollRect;
            self.chatScrollView.contentSize = CGSizeMake(0, self.messegeViewHeight);
            self.chatScrollView.contentOffset = CGPointMake(0, self.messegeViewHeight - self.chatScrollView.frame.size.height);
        } else {
            chatScrollRect.origin.y = (self.frame.size.height - (38.5f + 64.f)) - self.messegeViewHeight;
            self.chatScrollView.frame = chatScrollRect;
        }

    }];
}

- (void)checkText:(NSNotification*)notification
{
    [self animathionMethodWithDurqction:0.2f];
    if (self.inputText.mainTextView.text.length > 0) {
        self.sendButton.userInteractionEnabled = YES;
    } else {
        self.sendButton.userInteractionEnabled = NO;
    }
}

#pragma mark - Actions

- (void) getImage: (NSNotification*) notification {
    
    self.sendImage = notification.object;
    
    UIView * messageView = [self createMessegeViewWithWhoMessege:YES andName:@"Виктор" andImage:nil andTextMessage:@"" andDate:@"22:45" andSend: @"1" andType: @"2" whoSend:YES];
    [self.chatScrollView addSubview:messageView];
}

- (void) sendButtonAction {
    NSString * stringText = self.inputText.mainTextView.text;
    self.inputText.mainTextView.text = @"";
    [self.inputText backAnimation];
    [self animathionMethodWithDurqction:0.f];
    UIView * messageView = [self createMessegeViewWithWhoMessege:YES andName:@"Виктор" andImage:nil andTextMessage:stringText andDate:@"22:45" andSend: @"1" andType: @"1" whoSend:YES];
    [self.chatScrollView addSubview:messageView];
}

//Загрузка картинки
- (void) buttomAddImageAction {
    [self.delegate addImage:self];
}

#pragma mark - Other

//метод вычисляет колличество строк в тексте

- (NSInteger) countTextLineInText: (CustomTextView*) textView {
    NSInteger countLine = (NSInteger)round((textView.contentSize.height - textView.textContainerInset.top - textView.textContainerInset.bottom) / textView.font.lineHeight);
    
    return countLine;
}

- (void) animathionMethodWithDurqction: (CGFloat) dutaction {
    NSInteger countLine = [self countTextLineInText:self.inputText.mainTextView];
    //Сравнение строк
    if (countLine != self.lineCount) {
        self.lineCount = countLine;
        [UIView animateWithDuration:dutaction animations:^{
            
            CGRect chatScrollRect = self.chatScrollView.frame;
            chatScrollRect.size.height = (self.scrollHeight - 216.f) - 15.f * (self.lineCount - 1);
            self.chatScrollView.frame = chatScrollRect;
            
            CGRect sendViewRect = self.sendView.frame;
            sendViewRect.size.height = self.inputTextHeight + 15 * (self.lineCount - 1);
            sendViewRect.origin.y = (self.scrollHeight - 216.f) - 15 * (self.lineCount - 1);
            self.sendView.frame = sendViewRect;
            
            CGRect inputTextRect = self.inputText.frame;
            inputTextRect.size.height = self.inputTextHeight + 15.f * (self.lineCount - 1);
            self.inputText.frame = inputTextRect;
            
            CGRect inputTextViewRect = self.inputText.mainTextView.frame;
            inputTextViewRect.size.height = self.inputTextHeight + 15.f * (self.lineCount - 1);
            self.inputText.mainTextView.frame = inputTextViewRect;
            
            CGRect inputTextViewImage = self.imageAddMessage.frame;
            inputTextViewImage.origin.y = (self.inputTextHeight / 2.f - 8.75f) + 15 * (self.lineCount - 1);
            self.imageAddMessage.frame = inputTextViewImage;
            
            CGRect inputTextViewButton = self.sendButton.frame;
            inputTextViewButton.origin.y = (self.inputTextHeight / 2.f - 10.5f) + 15 * (self.lineCount - 1);
            self.sendButton.frame = inputTextViewButton;
            
            self.chatScrollView.contentOffset = CGPointMake(0, self.contentOffcet + 15 * (self.lineCount - 1));
            
            
            
        } completion:^(BOOL finished) { }];
    }
}

@end
