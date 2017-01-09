//
//  VideoViewController.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 25.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "VideoViewController.h"
#import "SingleTone.h"

@interface VideoViewController () 
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) UIColor * defaultColorButton;

@end

@implementation VideoViewController

- (void) loadView {
    [super loadView];
    
    self.burronSaveURL.layer.cornerRadius = 5.f;
    [self.navigationController setNavigationBarHidden: NO animated:YES];
    UILabel * CustomText = [[UILabel alloc]initWithTitle:@"Видео"];
    self.navigationItem.titleView = CustomText;
    self.webView.mediaPlaybackRequiresUserAction = NO;
    self.defaultColorButton = self.saveButton.backgroundColor;
    self.saveButton.userInteractionEnabled = NO;
    self.saveButton.backgroundColor = [UIColor grayColor];

    [self createActivitiIndicatorAlertWithView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * urlString = @"http://youtube.com";
    NSURL * url = [NSURL URLWithString:urlString];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
                                     navigationType:(UIWebViewNavigationType)navigationType {
    
    
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self deleteActivitiIndicator];
    
    if ([[[SingleTone sharedManager] stringAletForWebView] isEqualToString:@"0"]) {
        [self showAlertWithMessage:@"\nДля сохранения ссылки,\nнайдиет через поиск ваше видео,"
                                   @"\nзатем нажмите на кнопку\n\"Сохранить URL\"\n"];
        [[SingleTone sharedManager] setStringAletForWebView:@"1"];
    }
    
    NSString *stringUrl = [[self.webView.request URL] absoluteString];
    if ([stringUrl rangeOfString:@"watch?v="].location != NSNotFound) {
        self.saveButton.userInteractionEnabled = YES;
        self.saveButton.backgroundColor = self.defaultColorButton;
    }
    
    NSLog(@"URL %@", stringUrl);
    
    
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}


#pragma mark - Actions

- (IBAction)actionBackButton:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionButtonSaveURL:(UIButton *)sender {
    
    NSLog(@"%@", [[self.webView.request URL] absoluteString]);
    [self createActivitiIndicatorAlertWithView];
    [self performSelector:@selector(timeMethodDeletActiviti) withObject:nil afterDelay:2.f];
    
}

- (void) timeMethodDeletActiviti {
    [self deleteActivitiIndicator];
}
@end