//
//  MessegerController.m
//  TravelTogether
//
//  Created by Виктор Мишустин on 20/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "MessegerController.h"
#import "MessegerView.h"
#import "UIButton+ButtonImage.h"
#import "HexColors.h"
#import "Macros.h"

@interface MessegerController () <MessegerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) NSArray * arrayData;
@property (strong, nonatomic) UIImagePickerController *picker;
@property (strong, nonatomic) UIImageView * imageViewImage;
@property (strong, nonatomic) UIView * imageView;

@end

@implementation MessegerController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self initializeCartBarButton]; //Инициализация кнопок навигации
    [self setCustomTitle:@"СООБЩЕНИЯ"]; //Ввод заголовка    
    self.arrayData = [self setTemporaryArray];
    
    if (self.navigationController.viewControllers.count > 1) {
        //Кнопка Назад---------------------------------------------
        UIButton * buttonBack = [UIButton createButtonBack];
        [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
        self.navigationItem.leftBarButtonItem = mailbuttonBack;
    }
    
    
#pragma mark - View
    
    MessegerView * mainView = [[MessegerView alloc] initWithView:self.view andData:self.arrayData];
    mainView.delegate = self;
    [self.view addSubview:mainView];
    
}



#pragma mark - Custom Array
//создадим тестовый массив-----------
- (NSMutableArray *) setTemporaryArray
{
    NSMutableArray * temporaryArray = [[NSMutableArray alloc] init];
    
    NSArray * arrayName = [NSArray arrayWithObjects:
                                 @"Вы", @"Дженифер", @"Вы", @"Дженифер", @"Вы", @"Дженифер", nil];
    
    NSArray * arrayText = [NSArray arrayWithObjects:
                                 @"Привет! Не желаешь составить нам компанию?",
                                 @"photo1",
                                 @"photo1",
                                 @"Отличная идея!",
                                 @"Отлично!",
                                 @"Это просто супер здорово !!!", nil];
    
    NSArray * typeArray = [NSArray arrayWithObjects:@"1", @"2", @"2", @"1", @"1", @"1", nil]; //1 - сообщение    2 - картинка
    
    NSArray * arraySend = [NSArray arrayWithObjects:@"2", @"2", @"1", @"2", @"0", @"2", nil];
    
    
    NSArray * arrayWho =  [NSArray arrayWithObjects:
                                   [NSNumber numberWithBool:YES], [NSNumber numberWithBool:NO],
                                   [NSNumber numberWithBool:YES], [NSNumber numberWithBool:NO],
                                   [NSNumber numberWithBool:YES], [NSNumber numberWithBool:NO], nil];
    
    NSArray * arrayDate = [NSArray arrayWithObjects:
                                     @"Только что", @"17:30", @"17:37", @"17:34", @"17:32", @"19:28", nil];
    
    

    
    
    for (int i = 0; i < arrayName.count; i++) {
        
        NSDictionary * dictOrder =  [NSDictionary dictionaryWithObjectsAndKeys:
                                     [arrayName objectAtIndex:i],      @"name",
                                     [arrayText objectAtIndex:i],      @"text",
                                     [arrayWho objectAtIndex:i],     @"who",
                                     [arrayDate objectAtIndex:i],  @"date",
                                     [arraySend objectAtIndex:i], @"send",
                                     [typeArray objectAtIndex:i], @"type",
                                     @"imageAvatarChat.png", @"imageName", nil];
        
        [temporaryArray addObject:dictOrder];
    }
    
    return temporaryArray;
}

- (void) buttonBackAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - MessegerViewDelegate

- (void) addImage: (MessegerView*) messegerView {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        self.picker = [[UIImagePickerController alloc] init];
        self.picker.delegate = self;
        [self.picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        self.picker.allowsEditing = NO;
        [self presentViewController:self.picker animated:true completion:nil];
        
    }
}


- (void) navigationController: (UINavigationController *) navigationController  willShowViewController: (UIViewController *) viewController animated: (BOOL) animated {
    if (self.picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        UIButton * HideImageController = [UIButton createButtonCancel];
        [HideImageController addTarget:self action:@selector(HideImageControllerAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:HideImageController];
        viewController.navigationItem.rightBarButtonItems = [NSArray arrayWithObject:mailbuttonBack];
        
        if (navigationController.viewControllers.count > 1) {
                    UIButton * buttonBack = [UIButton createButtonBack];
                    [buttonBack addTarget:self action:@selector(buttonBackActionTest:) forControlEvents:UIControlEventTouchUpInside];
                    UIBarButtonItem *testMailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
                    viewController.navigationItem.leftBarButtonItems = [NSArray arrayWithObject:testMailbuttonBack];
            
            self.imageView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 64.f, viewController.view.frame.size.width, viewController.view.frame.size.height - 64.f)];
            self.imageView.backgroundColor = [UIColor whiteColor];
            self.imageView.alpha = 0.f;
            [viewController.view addSubview:self.imageView];
            self.imageViewImage = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, viewController.view.frame.size.width, viewController.view.frame.size.height - 120.f)];
//            self.imageViewImage.layer.borderWidth = 1.f;
//            self.imageViewImage.layer.borderColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK].CGColor;
            self.imageViewImage.contentMode = UIViewContentModeScaleAspectFill;
            self.imageViewImage.clipsToBounds = YES;
            [self.imageView addSubview:self.imageViewImage];
            
            NSArray * arrayNameButtons = [NSArray arrayWithObjects:@"Отмена", @"Выбрать", nil];
            for (int i = 0; i < 2; i ++) {
                UIButton * buttonImage = [UIButton buttonWithType:UIButtonTypeSystem];
                buttonImage.frame = CGRectMake(viewController.view.frame.size.width / 2 - 125 + 150 * i, viewController.view.frame.size.height - 106, 100, 30);
//                buttonImage.layer.borderColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK].CGColor;
//                buttonImage.layer.borderWidth = 1.f;
//                buttonImage.layer.cornerRadius = 15.f;
                buttonImage.tag = 2000 + i;
                [buttonImage setTitle:[arrayNameButtons objectAtIndex:i] forState:UIControlStateNormal];
                [buttonImage setTitleColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK] forState:UIControlStateNormal];
                buttonImage.titleLabel.font = [UIFont fontWithName:VM_FONT_BOLD size:15];
                [buttonImage addTarget:self action:@selector(buttonImageAction:) forControlEvents:UIControlEventTouchUpInside];
                [self.imageView addSubview:buttonImage];
            }
        }
        
    }
}
- (void) HideImageControllerAction: (id) sender {
    [self.picker dismissViewControllerAnimated:YES
                                           completion:nil];
    self.imageView = nil;
}


- (void) buttonBackActionTest: (id) sender {
    self.imageView.alpha = 0.f;
    self.imageView = nil;
    [self.picker popViewControllerAnimated:YES];
}

- (void)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) buttonImageAction: (UIButton*) button {
    if (button.tag == 2001) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICATION_SEND_IMAGE_FOR_DUSCUSSIONS_VIEW" object:self.imageViewImage.image];
            [self dismissViewControllerAnimated:true completion:nil];
    } else if (button.tag == 2000) {
        [UIView animateWithDuration:0.3 animations:^{
            self.imageView.alpha = 0.f;
        }];
    }
}



// IMAGE PICKER DELEGATE =================
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.imageViewImage.image = image;
    [UIView animateWithDuration:0.3 animations:^{
        self.imageView.alpha = 1.f;
    }];

}

@end
