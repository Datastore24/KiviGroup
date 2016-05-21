//
//  ChatView.m
//  PsychologistIOS
//
//  Created by Viktor on 16.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "ChatView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"

@interface ChatView () <UITextViewDelegate, UIImagePickerControllerDelegate>

@end

@implementation ChatView
{
    
    UIScrollView * mainScrollView;
    //Переменные вью отправки------------
    BOOL isBool;
    UITextView * textFieldChat;
    UILabel * labelPlaceHolderChat;
    
    //Переменные чата---------------------
    UIScrollView * viewScrollChat;
    NSMutableArray * mArrayForPushButton;
    CGFloat countFor; //customHeight
    CGFloat mainFloat;
    CGFloat testFloat;
    UIView * viewMessage;
    UIButton * imageViewChat;
    
    //Счетчик картинок--------------------
    NSInteger buttonsNumber;
    //Массив картинок---------------------
    NSMutableArray * buttonsArray;
    BOOL buttonImageChange;
    
    UIImageView * imageFull;
    
}


- (instancetype)initWithView: (UIView*) view andArray: (NSMutableArray*) array
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height - 64);
        
        //Дополнительный переменные---------------
        isBool = YES;
        mArrayForPushButton = [NSMutableArray new];
        countFor = 0.f;
        buttonsNumber = 9;
        buttonsArray = [NSMutableArray new];
        buttonImageChange = NO;
        
        UIImageView * imageViewPlayer = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 232)];
        if (isiPhone6) {
            imageViewPlayer.frame = CGRectMake(0, 0, self.frame.size.width, 210);
        } else if (isiPhone5) {
            imageViewPlayer.frame = CGRectMake(0, 0, self.frame.size.width, 160);
        }
//        imageViewPlayer.image = [UIImage imageNamed:@"imagePlayer.png"];
        [self addSubview:imageViewPlayer];
        
        mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 210, self.frame.size.width, self.frame.size.height - 210)];
        [self addSubview:mainScrollView];
        
        //Получаем ответ в виде нотификации с обектом картинки--
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationSentImage:) name:NOTIFICATION_SEND_IMAGE_FOR_CHAT_VIEW object:nil];
        
#pragma mark - Chat
        
        //Вью чата--------------------------------------------------------------------
        viewScrollChat = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 10, mainScrollView.frame.size.width, mainScrollView.frame.size.height - 60)];
        [mainScrollView addSubview:viewScrollChat];
        //Загружаем данные------------------------------------------------------------
        [self sendMessageWithArray:array andSend:NO];
        
#pragma mark - Push Message
        
        //Раздел для ввода данных-----
        UIView * mainViewPush = [[UIView alloc] initWithFrame:CGRectMake(0, mainScrollView.frame.size.height - 50, mainScrollView.frame.size.width, 50)];
        [mainScrollView addSubview:mainViewPush];
        
        //Ввод текста----------------
        UIView * inputText = [[UIView alloc] initWithFrame:CGRectMake(64, 10, 248, 32)];
        if (isiPhone6) {
            inputText.frame = CGRectMake(60, 10, 236, 28);
        } else if (isiPhone5) {
            inputText.frame = CGRectMake(40, 15, 220, 24);
        }
        inputText.backgroundColor = nil;
        inputText.layer.borderColor = [UIColor colorWithHexString:@"c7c7cc"].CGColor;
        inputText.layer.borderWidth = 0.4f;
        inputText.layer.cornerRadius = 5;
        [mainViewPush addSubview:inputText];
        
        //Ввод телефона-----------------------------------------------------------------
        textFieldChat = [[UITextView alloc] initWithFrame:CGRectMake(16, 8, 216, 16)];
        textFieldChat.delegate = self;
        textFieldChat.autocorrectionType = UITextAutocorrectionTypeNo;
        textFieldChat.font = [UIFont fontWithName:FONTLITE size:19];
        if (isiPhone6) {
            textFieldChat.font = [UIFont fontWithName:FONTLITE size:16];
        } else if (isiPhone5) {
            textFieldChat.font = [UIFont fontWithName:FONTLITE size:14];
            textFieldChat.frame = CGRectMake(16, 5, 216, 16);
        }
        textFieldChat.textColor = [UIColor colorWithHexString:@"c7c7cc"];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationLabelChat:) name:UITextViewTextDidChangeNotification object:textFieldChat];
        [inputText addSubview:textFieldChat];
        
        //Плэйс холдер телефона----------------------------------------------------------
        labelPlaceHolderChat = [[UILabel alloc] initWithFrame:CGRectMake(16, 8, 216, 16)];
        labelPlaceHolderChat.tag = 3022;
        labelPlaceHolderChat.text = @"Сообщение";
        labelPlaceHolderChat.textColor = [UIColor colorWithHexString:@"c7c7cc"];
        labelPlaceHolderChat.font = [UIFont fontWithName:FONTLITE size:19];
        if (isiPhone6) {
            labelPlaceHolderChat.font = [UIFont fontWithName:FONTLITE size:16];
        } else if (isiPhone5) {
            labelPlaceHolderChat.font = [UIFont fontWithName:FONTLITE size:14];
            labelPlaceHolderChat.frame = CGRectMake(16, 4, 216, 16);
            
        }
        [inputText addSubview:labelPlaceHolderChat];
        
        //Кнопка отправить---------------------------------------------------------------
        UIButton * pushButton = [UIButton buttonWithType:UIButtonTypeCustom];
        pushButton.frame = CGRectMake(320, 10, 32, 32);
        if (isiPhone6) {
            pushButton.frame = CGRectMake(305, 10, 28, 28);
        } else if (isiPhone5) {
            pushButton.frame = CGRectMake(265, 16, 22, 22);
        }
        pushButton.layer.cornerRadius = 16;
        UIImage * imageButtonPush = [UIImage imageNamed:@"pushMessageImage.png"];
        [pushButton setImage:imageButtonPush forState:UIControlStateNormal];
        [pushButton addTarget:self action:@selector(pushButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [mainViewPush addSubview:pushButton];
        
        //Кнопка создания аудио дорожки---------------------------------------------------
        UIButton * soundButton = [UIButton buttonWithType:UIButtonTypeCustom];
        soundButton.frame = CGRectMake(363, 10, 32, 32);
        if (isiPhone6) {
            soundButton.frame = CGRectMake(340, 10, 28, 28);
        } else if (isiPhone5) {
            soundButton.frame = CGRectMake(290, 16, 22, 22);
        }
        soundButton.layer.cornerRadius = 16;
        UIImage * imageSoundButton = [UIImage imageNamed:@"soundButton.png"];
        [soundButton setImage:imageSoundButton forState:UIControlStateNormal];
        [soundButton addTarget:self action:@selector(soundButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [mainViewPush addSubview:soundButton];
        
        //Кнопка отправки фото------------------------------------------------------------
        UIButton * cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cameraButton.frame = CGRectMake(18, 15, 32, 21);
        if (isiPhone6) {
            cameraButton.frame = CGRectMake(18, 15, 28, 18);
        } else if (isiPhone5) {
            cameraButton.frame = CGRectMake(12, 18, 22, 16);
        }
        UIImage * cameraButtonButton = [UIImage imageNamed:@"buttonCameraImage.png"];
        [cameraButton setImage:cameraButtonButton forState:UIControlStateNormal];
        [cameraButton addTarget:self action:@selector(cameraButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [mainViewPush addSubview:cameraButton];
        
        
        imageFull = [[UIImageView alloc] initWithFrame:self.frame];
        imageFull.alpha = 0.f;
        imageFull.userInteractionEnabled = YES;
        imageFull.backgroundColor = [UIColor whiteColor];
        imageFull.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageFull];
        
        UIButton * buttonCanselImage = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonCanselImage.frame = CGRectMake(imageFull.frame.size.width - 70, 10, 50, 50);
        buttonCanselImage.layer.cornerRadius = 25;
        UIImage * imageButtonCansel = [UIImage imageNamed:@"imageCancel.png"];
        [buttonCanselImage setImage:imageButtonCansel forState:UIControlStateNormal];
        [buttonCanselImage addTarget:self action:@selector(buttonCanselImageAction) forControlEvents:UIControlEventTouchUpInside];
        [imageFull addSubview:buttonCanselImage];
        
    }
    return self;
}

#pragma mark - main Method send Message

//Метод Отправки сообщения---------------
- (void) sendMessageWithArray: (NSMutableArray*) array andSend: (BOOL) send
{
    for (int i = 0; i < array.count; i++) {
        NSDictionary * dictChat = [array objectAtIndex:i];
        
        if ([[dictChat objectForKey:@"Users"] isEqualToString:@"Пользователь 1"]) {
            // Имя пользователя---------------
            UILabel * labelUser = [[UILabel alloc] initWithFrame:CGRectMake(viewScrollChat.frame.size.width - 32 - 73, 8 + countFor, 88, 12)];
            labelUser.textColor = [UIColor colorWithHexString:@"8e8e93"];
            labelUser.font = [UIFont fontWithName:FONTLITE size:12];
            if (isiPhone5) {
                labelUser.font = [UIFont fontWithName:FONTLITE size:10];
            }
            labelUser.text = [dictChat objectForKey:@"Users"];
            [viewScrollChat addSubview:labelUser];
            
            //Если приходит текст-------------------------------------------
            if ([[dictChat objectForKey:@"Type"] integerValue] == 1) {
                
                //Текст сообщения------------------
                UILabel * labelText = [[UILabel alloc] initWithFrame:CGRectMake(viewScrollChat.frame.size.width - 24, 32 + countFor, 300, 12)];
                labelText.numberOfLines = 0;
                labelText.textColor = [UIColor whiteColor];
                labelText.text = [dictChat objectForKey:@"Message"];
                labelText.font = [UIFont fontWithName:FONTLITE size:18];
                if (isiPhone6) {
                    labelText.font = [UIFont fontWithName:FONTLITE size:16];
                } else if (isiPhone5) {
                    labelText.font = [UIFont fontWithName:FONTLITE size:12];
                    labelText.frame = CGRectMake(viewScrollChat.frame.size.width - 24, 28 + countFor, 200, 12);
                }
                [labelText sizeToFit];
                labelText.frame = CGRectMake((viewScrollChat.frame.size.width - labelText.frame.size.width) - 32, labelText.frame.origin.y, labelText.frame.size.width, labelText.frame.size.height);
                
                //Вью сообщения----------------------
                viewMessage = [[UIView alloc] initWithFrame:CGRectMake(labelText.frame.origin.x - 10, labelText.frame.origin.y - 5, labelText.frame.size.width + 20, labelText.frame.size.height + 10)];
                if (isiPhone6) {
                    viewMessage.frame = CGRectMake(labelText.frame.origin.x - 10, labelText.frame.origin.y - 3, labelText.frame.size.width + 20, labelText.frame.size.height + 6);
                } else if (isiPhone5) {
                    viewMessage.frame = CGRectMake(labelText.frame.origin.x - 10, labelText.frame.origin.y - 3, labelText.frame.size.width + 20, labelText.frame.size.height + 6);
                }
                viewMessage.backgroundColor = [UIColor colorWithHexString:@"f69679"];
                viewMessage.layer.cornerRadius = 7.f;
                [viewScrollChat addSubview:viewMessage];
                [viewScrollChat addSubview:labelText];
                
                //Создаем хвостик--------------------
                UIImageView * bubbleView = [[UIImageView alloc] initWithFrame:CGRectMake(viewMessage.frame.origin.x + viewMessage.frame.size.width - 9, viewMessage.frame.origin.y + viewMessage.frame.size.height - 7, 16, 8)];
                bubbleView.image = [UIImage imageNamed:@"bubble.png"];
                [viewScrollChat addSubview:bubbleView];
                
                //Если приходит картинка----------------------------------------
            } else if ([[dictChat objectForKey:@"Type"] integerValue] == 2) {
                
                //Создаем картинку--------------------
                imageViewChat = [UIButton buttonWithType:UIButtonTypeCustom];
                buttonsNumber += 1;
                imageViewChat.tag = buttonsNumber;
                imageViewChat.frame = CGRectMake(viewScrollChat.frame.size.width - 282, 32 + countFor, 250, 200);
                if (isiPhone5) {
                    imageViewChat.frame = CGRectMake(viewScrollChat.frame.size.width - 222, 32 + countFor, 200, 150);
                }
                [imageViewChat setImage:[dictChat objectForKey:@"Message"] forState:UIControlStateNormal];
                
                [imageViewChat addTarget:self action:@selector(imageViewChatAction:) forControlEvents:UIControlEventTouchUpInside];
                [viewScrollChat addSubview:imageViewChat];
                [buttonsArray addObject:imageViewChat];
                
                //Если приходит аудиофайл---------------------------------------
            } else if ([[dictChat objectForKey:@"Type"] integerValue] == 3) {
                
                //Ошибка------------------------------------------------
            } else {
                NSLog(@"Error");
            }
            
            //Лейбл даты-----------------------
            UILabel * labelData = [[UILabel alloc] initWithFrame:CGRectMake(viewScrollChat.frame.size.width - 32 - 40, viewMessage.frame.origin.y + viewMessage.frame.size.height + 5, 40, 12)];
            if ([[dictChat objectForKey:@"Type"] integerValue] == 2) {
                labelData.frame = CGRectMake(viewScrollChat.frame.size.width - 32 - 40, imageViewChat.frame.origin.y + imageViewChat.frame.size.height + 5, 40, 12);
            }
            labelData.textColor = [UIColor colorWithHexString:@"8e8e93"];
            labelData.font = [UIFont fontWithName:FONTLITE size:12];
            if (isiPhone5) {
                labelData.font = [UIFont fontWithName:FONTLITE size:10];
            }
            labelData.text = [dictChat objectForKey:@"Data"];
            [labelData sizeToFit];
            labelData.frame = CGRectMake(viewScrollChat.frame.size.width - 24 - labelData.frame.size.width, labelData.frame.origin.y, labelData.frame.size.width, labelData.frame.size.height);
            [viewScrollChat addSubview:labelData];
            
            //Создаем отступ-------------------
            if ([[dictChat objectForKey:@"Type"] integerValue] == 1) {
                countFor += viewMessage.frame.size.height + 50;
            } else if ([[dictChat objectForKey:@"Type"] integerValue] == 2) {
                countFor += imageViewChat.frame.size.height + 50;
            } else {
                NSLog(@"Error");
            }
            
        } else {
            // Имя пользователя---------------
            UILabel * labelUser = [[UILabel alloc] initWithFrame:CGRectMake(28, 8 + countFor, 88, 12)];
            labelUser.textColor = [UIColor colorWithHexString:@"8e8e93"];
            labelUser.font = [UIFont fontWithName:FONTLITE size:12];
            if (isiPhone5) {
                labelUser.font = [UIFont fontWithName:FONTLITE size:10];
            }
            labelUser.text = [dictChat objectForKey:@"Users"];
            [viewScrollChat addSubview:labelUser];
            
            //Если приходит текст-------------------------------------------
            if ([[dictChat objectForKey:@"Type"] integerValue] == 1) {
                
                UILabel * labelText = [[UILabel alloc] initWithFrame:CGRectMake(38, 32 + countFor, 300, 12)];
                labelText.numberOfLines = 0;
                labelText.text = [dictChat objectForKey:@"Message"];
                labelText.font = [UIFont fontWithName:FONTLITE size:18];
                if (isiPhone6) {
                    labelText.font = [UIFont fontWithName:FONTLITE size:16];
                } else if (isiPhone5) {
                    labelText.font = [UIFont fontWithName:FONTLITE size:12];
                    labelText.frame = CGRectMake(38, 28 + countFor, 200, 12);
                }
                [labelText sizeToFit];
                
                //Вью Сообщения---------------------
                viewMessage = [[UIView alloc] initWithFrame:CGRectMake(labelText.frame.origin.x - 10, labelText.frame.origin.y - 5, labelText.frame.size.width + 20, labelText.frame.size.height + 10)];
                if (isiPhone6) {
                    viewMessage.frame = CGRectMake(labelText.frame.origin.x - 10, labelText.frame.origin.y - 3, labelText.frame.size.width + 20, labelText.frame.size.height + 6);
                } else if (isiPhone5) {
                    viewMessage.frame = CGRectMake(labelText.frame.origin.x - 10, labelText.frame.origin.y - 3, labelText.frame.size.width + 20, labelText.frame.size.height + 6);
                }
                viewMessage.backgroundColor = [UIColor colorWithHexString:@"e5e5ea"];
                viewMessage.layer.cornerRadius = 7.f;
                [viewScrollChat addSubview:viewMessage];
                [viewScrollChat addSubview:labelText];
                
                //Создаем хвостик------------------
                UIImageView * bubbleView = [[UIImageView alloc] initWithFrame:CGRectMake(32 - 7, viewMessage.frame.origin.y + viewMessage.frame.size.height - 7, 16, 8)];
                bubbleView.image = [UIImage imageNamed:@"bubble - gray.png"];
                [viewScrollChat addSubview:bubbleView];
                
                //Если приходит картинка----------------------------------------
            } else if ([[dictChat objectForKey:@"Type"] integerValue] == 2) {
                
                //Создаем картинку--------------------
                
                imageViewChat = [UIButton buttonWithType:UIButtonTypeCustom];
                imageViewChat.frame = CGRectMake(32, 32 + countFor, 250, 200);
                if (isiPhone5) {
                    imageViewChat.frame = CGRectMake(32, 32 + countFor, 200, 150);
                }
                buttonsNumber += 1;
                imageViewChat.tag = buttonsNumber;
                [imageViewChat addTarget:self action:@selector(imageViewChatAction:) forControlEvents:UIControlEventTouchUpInside];
                [imageViewChat setImage:[dictChat objectForKey:@"Message"] forState:UIControlStateNormal];
                
                [viewScrollChat addSubview:imageViewChat];
                
                [buttonsArray addObject:imageViewChat];
                
                
                //Если приходит аудиофайл---------------------------------------
            } else if ([[dictChat objectForKey:@"Type"] integerValue] == 3) {
                
                
                //Ошибка------------------------------------------------
            } else {
                NSLog(@"Error");
            }
            
            //Лейбл даты-----------------------
            UILabel * labelData = [[UILabel alloc] initWithFrame:CGRectMake(28, viewMessage.frame.origin.y + viewMessage.frame.size.height + 5, 40, 12)];
            if ([[dictChat objectForKey:@"Type"] integerValue] == 2) {
                labelData.frame = CGRectMake(28, imageViewChat.frame.origin.y + imageViewChat.frame.size.height + 5, 60, 12);
            }
            labelData.textColor = [UIColor colorWithHexString:@"8e8e93"];
            labelData.font = [UIFont fontWithName:FONTLITE size:12];
            if (isiPhone5) {
                labelData.font = [UIFont fontWithName:FONTLITE size:10];
            }
            labelData.text = [dictChat objectForKey:@"Data"];
            [viewScrollChat addSubview:labelData];
            
            //Создаем отступ-------------------
            if ([[dictChat objectForKey:@"Type"] integerValue] == 1) {
                countFor += viewMessage.frame.size.height + 50;
            } else if ([[dictChat objectForKey:@"Type"] integerValue] == 2) {
                countFor += imageViewChat.frame.size.height + 50;
            } else {
                NSLog(@"Error");
            }
        }
        
        viewScrollChat.contentSize = CGSizeMake(self.frame.size.width, 20 + countFor);
        viewScrollChat.contentOffset =
        CGPointMake(0, viewScrollChat.contentSize.height - viewScrollChat.frame.size.height);
    }
}


#pragma mark - DEALLOC

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

//Анимация Лейблов при вводе Телефона------------------------
- (void) animationLabelChat: (NSNotification*) notification
{
    UITextField * testField = notification.object;
    
    if (testField.text.length != 0 && isBool) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderChat.frame;
            rect.origin.x = rect.origin.x + 100.f;
            labelPlaceHolderChat.frame = rect;
            labelPlaceHolderChat.alpha = 0.f;
            isBool = NO;
        }];
    } else if (testField.text.length == 0 && !isBool) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderChat.frame;
            rect.origin.x = rect.origin.x - 100.f;
            labelPlaceHolderChat.frame = rect;
            labelPlaceHolderChat.alpha = 1.f;
            isBool = YES;
        }];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView isEqual:textFieldChat]) {
        if (textView.text.length != 0 && isBool) {
            [UIView animateWithDuration:0.3 animations:^{
                CGRect rect;
                rect = labelPlaceHolderChat.frame;
                rect.origin.x = rect.origin.x + 100.f;
                labelPlaceHolderChat.frame = rect;
                labelPlaceHolderChat.alpha = 0.f;
                isBool = NO;
            }];
        }
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        mainScrollView.contentOffset = (CGPoint){
            0, // ось x нас не интересует
            230 // Скроллим скролл к верхней границе текстового поля - Вы можете настроить эту величину по своему усмотрению
        };
    }];
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView isEqual:textFieldChat]) {
        if (textView.text.length == 0 && !isBool) {
            [UIView animateWithDuration:0.3 animations:^{
                CGRect rect;
                rect = labelPlaceHolderChat.frame;
                rect.origin.x = rect.origin.x - 100.f;
                labelPlaceHolderChat.frame = rect;
                labelPlaceHolderChat.alpha = 1.f;
                isBool = YES;
            }];
        }
    }
    [UIView animateWithDuration:0.3 animations:^{
        mainScrollView.contentOffset = (CGPoint){0, 0}; // Возвращаем скролл в начало, так как редактирование текстового поля закончено
    }];
}

#pragma mark - Action Methods

//Действие кнопки отправить сообщение---
- (void) pushButtonAction
{
    if (textFieldChat.text.length == 0) {
        NSLog(@"Введите текст");
    } else {
        
        BOOL isBoolen = arc4random() % 2;
        NSString * testString;
        
        if (isBoolen) {
            testString = @"Пользователь 1";
        } else {
            testString = @"Пользователь 2";
        }
        
        NSDictionary * dictPushText = [NSDictionary dictionaryWithObjectsAndKeys:
                                       testString, @"Users",
                                       textFieldChat.text, @"Message",
                                       @"Моя датка", @"Data", @"1", @"Type", nil];
        
        [mArrayForPushButton addObject:dictPushText];
        [self sendMessageWithArray:mArrayForPushButton andSend:YES];
        textFieldChat.text = nil;
        
        if (textFieldChat.text.length == 0) {
            [UIView animateWithDuration:0.3 animations:^{
                CGRect rect;
                rect = labelPlaceHolderChat.frame;
                rect.origin.x = rect.origin.x - 100.f;
                labelPlaceHolderChat.frame = rect;
                labelPlaceHolderChat.alpha = 1.f;
                isBool = YES;
            }];
        }
        
        [mArrayForPushButton removeAllObjects];
        
    }
}

//Действие кнопки загрузить аудиозапись--
- (void) soundButtonAction
{
    NSLog(@"Загрузить аудиозапись");
}

//Действие кнопки загрузить фото---------
- (void) cameraButtonAction
{
    //Нотификация на запрос получения фото из галлереи---
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_REQUEST_IMAGE_FOR_DUSCUSSIONS object:nil];
}

//Загружаем фото а архив
- (void) notificationSentImage: (NSNotification*) notification
{
    BOOL isBoolen = arc4random() % 2;
    NSString * testString;
    
    if (isBoolen) {
        testString = @"Пользователь 1";
    } else {
        testString = @"Пользователь 2";
    }
    
    NSDictionary * dictPushText = [NSDictionary dictionaryWithObjectsAndKeys:
                                   testString, @"Users",
                                   notification.object, @"Message",
                                   @"Моя датка", @"Data", @"2", @"Type", nil];
    
    [mArrayForPushButton addObject:dictPushText];
    
    
    [self sendMessageWithArray:mArrayForPushButton andSend:YES];
    
    [mArrayForPushButton removeAllObjects];
    
    
    
}

//Действие на тап картинки------------------------------
- (void) imageViewChatAction: (UIButton*) button
{
    NSLog(@"CLICK");
    for (int i = 0; i < buttonsArray.count; i++) {
        if (button.tag == 10 + i) {
            imageFull.image = button.imageView.image;
            [UIView animateWithDuration:0.3 animations:^{
                imageFull.alpha = 1.f;
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

- (void) buttonCanselImageAction
{
    [UIView animateWithDuration:0.3 animations:^{
        imageFull.alpha = 0.f;
    } completion:^(BOOL finished) {
        
    }];
}


@end
