//
//  ChatController.m
//  PsychologistIOS
//
//  Created by Viktor on 16.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "ChatController.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "TitleClass.h"
#import "ChatView.h"
#import "OpenSubjectModel.h"

@implementation ChatController

- (void) viewDidLoad
{
#pragma mark - Header
    
    self.navigationController.navigationBarHidden = NO;
    //Заголовок-----------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"ВЕБИНАР"];
    self.navigationItem.titleView = title;
    
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"d46559"];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
#pragma mark - Initialization
    
    //Вью контент---------------------------------------------
    ChatView * viewContent = [[ChatView alloc] initWithView:self.view andArray:[OpenSubjectModel setArrayChat]];
    [self.view addSubview:viewContent];
    
    //Получаем нотификацию из вью о загрузке галереи------------
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifictionActionChooseImage) name:NOTIFICATION_REQUEST_IMAGE_FOR_CHAT object:nil];
    
}

#pragma mark - DEALLOC

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - ACTION METHODS

//Метод нотификации о выборе картинки--------------------------
- (void) notifictionActionChooseImage
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        
        [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        picker.allowsEditing = NO;
        [self presentViewController:picker animated:true completion:nil];
        
    }
    
}

// IMAGE PICKER DELEGATE =================
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_SEND_IMAGE_FOR_CHAT_VIEW object:image];
    [self dismissViewControllerAnimated:true completion:nil];
}


@end
