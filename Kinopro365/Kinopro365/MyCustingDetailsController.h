//
//  MyCustingDetailsController.h
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 08.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "MainViewController.h"

@interface MyCustingDetailsController : MainViewController

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

//Верхнее окно
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UILabel *activelyLabel;

//Парметры для показа текста
@property (weak, nonatomic) IBOutlet CustomButton *buttonTextAdd;
@property (weak, nonatomic) IBOutlet UITextView *mainTextView;
@property (weak, nonatomic) IBOutlet UIView *viewForMainText;
@property (weak, nonatomic) IBOutlet UIImageView *imageHide;

//Колличество на рассмотрении
@property (weak, nonatomic) IBOutlet UIView *viewForLabel;
@property (weak, nonatomic) IBOutlet UILabel *labelConsideration;

//Кнопки одобренно не рассмотрении
@property (weak, nonatomic) IBOutlet CustomButton *buttonConsideration;
@property (weak, nonatomic) IBOutlet CustomButton *buttonConfirm;

- (IBAction)actionButtonBack:(id)sender;
- (IBAction)actionButtonEdit:(id)sender;
- (IBAction)actionButtonDelete:(id)sender;
- (IBAction)actionButtontextAdd:(CustomButton*)sender;
- (IBAction)actionButtonConsideration:(CustomButton *)sender;
- (IBAction)actionButtonConfirm:(CustomButton *)sender;





@end
