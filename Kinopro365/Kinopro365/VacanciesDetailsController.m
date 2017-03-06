//
//  VacanciesDetailsController.m
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 02.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "VacanciesDetailsController.h"

@interface VacanciesDetailsController ()

@end

@implementation VacanciesDetailsController

- (void) loadView {
    [super loadView];
    
    UILabel * CustomText = [[UILabel alloc]initWithTitle:@"Вакансии"];
    self.navigationItem.titleView = CustomText;
    
    
    self.twoWithView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.twoWithView.layer.shadowOffset = CGSizeMake(0.0f, -1.0f);
    self.twoWithView.layer.shadowOpacity = 1.0f;
    self.twoWithView.layer.shadowRadius = 4.0f;
    self.buttonApply.layer.cornerRadius = 5;
    
    
    
    self.mainTextLabel.text = @"Если Вы копируете статьи в Википедию со своего сайта, то, чтобы не возникало обвинений в нарушении авторских прав желательно показать соответствие между владельцем сайта и участником Википедии — напишите об этом на своём сайте, на своей странице участника Википедии, на странице обсуждения Вашей статьи. Помните, что тексты размещаются в Википедии";
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    CGFloat textFloat = [self getLabelHeight:self.mainTextLabel];
    
    if (textFloat > 80.f) {
        [self animationViewForHeightText:textFloat];
    }
    
    
    
    
    
}

#pragma mark - Actions

- (IBAction)actionButtonBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionButtonVK:(id)sender {
    
    NSLog(@"Поделить в контакте");
    
}

- (IBAction)actionButtonFacebook:(id)sender {
    
    NSLog(@"Поделить в фэйсбуке");
}

- (IBAction)actionButtonApply:(id)sender {
    
    NSLog(@"Принять заявку");
    [self showAlertWithMessageWithBlock:@"Ваша заявка принета" block:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}

#pragma mark - Animations

- (void) animationViewForHeightText: (CGFloat) heightText {
    

        
        CGRect frameForTextView = self.viewForMainText.frame;
        frameForTextView.size.height += (heightText - 80);
        self.viewForMainText.frame = frameForTextView;
        
        
        for (UIView * view in self.arrayForAnimation) {
            CGRect rectForView = view.frame;
            rectForView.origin.y += (heightText - 80);
            view.frame = rectForView;
        }
        
        self.mainScrollView.contentSize = CGSizeMake(0, self.view.frame.size.height + (heightText - 80 - 64));
        

    
    
}

#pragma mark - Other

- (CGFloat)getLabelHeight:(UILabel*)label
{
    CGSize constraint = CGSizeMake(label.frame.size.width, CGFLOAT_MAX);
    CGSize size;
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [label.text boundingRectWithSize:constraint
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:label.font}
                                                  context:context].size;
    
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    
    return size.height;
}
@end
