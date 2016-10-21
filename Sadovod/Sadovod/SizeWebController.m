//
//  SizeWebController.m
//  Sadovod
//
//  Created by Виктор Мишустин on 21.10.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "SizeWebController.h"
#import "SingleTone.h"


@interface SizeWebController ()

@end

@implementation SizeWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCustomTitle:[[SingleTone sharedManager] titlSize] andBarButtonAlpha: YES andButtonBasket: YES]; //Ввод заголовка
    
    //Кнопка Назад---------------------------------------------
    UIButton * buttonBack = [UIButton createButtonBack];
    [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = mailbuttonBack;
    
    UIWebView * webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:[[SingleTone sharedManager] htmlSize] ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [webView loadHTMLString:htmlString baseURL: [[NSBundle mainBundle] bundleURL]];
    [self.view addSubview:webView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void) buttonBackAction {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
