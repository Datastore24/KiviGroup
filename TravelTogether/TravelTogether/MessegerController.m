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

@interface MessegerController () <MessegerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) NSArray * arrayData;
@property (strong, nonatomic) UIImagePickerController *picker;

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
        }
        

        
    }
}
- (void) HideImageControllerAction: (id) sender {
    [self.picker dismissViewControllerAnimated:YES
                                           completion:nil];
}


- (void) buttonBackActionTest: (id) sender {
    [self.picker popViewControllerAnimated:YES];
}

- (void)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



// IMAGE PICKER DELEGATE =================
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICATION_SEND_IMAGE_FOR_DUSCUSSIONS_VIEW" object:image];
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
