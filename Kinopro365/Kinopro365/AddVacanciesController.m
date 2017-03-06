//
//  AddVacanciesController.m
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 02.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "AddVacanciesController.h"
#import "HexColors.h"
#import "HMImagePickerController.h"

@interface AddVacanciesController () <UITextFieldDelegate, UITextViewDelegate, HMImagePickerControllerDelegate>

@property (strong, nonatomic) NSDictionary * dictKeyboard;
@property (assign, nonatomic) CGFloat heightForText;
@property (strong, nonatomic) HMImagePickerController * pickerVacencies;
@property (strong, nonatomic) UIImage * imageVacancies;


@property (strong, nonatomic) NSArray * testArrayProfessions;




@end

@implementation AddVacanciesController

- (void) loadView {
    [super loadView];
    
    UILabel * CustomText = [[UILabel alloc]initWithTitle:@"Создать вакансию"];
    self.navigationItem.titleView = CustomText;
    
    self.viewForComment.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"4682AC"].CGColor;
    self.viewForComment.layer.borderWidth = 1.f;
    self.viewForComment.layer.cornerRadius = 5.f;
    
    self.mainScrollView.userInteractionEnabled = YES;
    
    self.buttonCreate.layer.cornerRadius = 5.f;
    
    self.textView.placeholder = @"Какая концепция проекта? Кто нужен для проекта? Что нужно делать? Сколько платят?";
    self.textView.placeholderColor = [[UIColor hx_colorWithHexRGBAString:@"517BA2"] colorWithAlphaComponent:0.45];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.heightForText = 55;
    
    self.testArrayProfessions = [NSArray arrayWithObjects:@"Актер", @"Режесер", @"Каскадер", @"Звукооператор", @"Модель", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showTextFildText:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
    
    
    
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
    
}

- (void) showTextFildText: (NSNotification*) notification {
    
    NSLog(@"%@", self.textFildName.text);
    
}

#pragma mark - Action

- (IBAction)actionButtonBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionButtonAddImage:(id)sender {
    self.pickerVacencies = [[HMImagePickerController alloc] initWithSelectedAssets:nil];
    self.pickerVacencies.pickerDelegate = self;
    self.pickerVacencies.targetSize = CGSizeMake(600, 600);
    self.pickerVacencies.maxPickerCount = 1;
    
    [self presentViewController:self.pickerVacencies animated:YES completion:nil];
}

- (IBAction)actionButtonDate:(id)sender {
    [self showDataPickerBirthdayWithButton:sender endBool:YES];
}

- (IBAction)actionButtonProfession:(id)sender {
    [self showViewPickerWithButton:sender andTitl:@"Выберите профессию" andArrayData:self.testArrayProfessions andKeyTitle:nil andKeyID:nil andDefValueIndex:nil];
}

- (IBAction)actionButtonCountry:(id)sender {
    
    NSLog(@"Выбор страны");
    
}

- (IBAction)actionButtonCity:(id)sender {
    
    NSLog(@"Выбор города");
    
}

- (IBAction)actionButtonCreate:(id)sender {
    
    NSLog(@"Вы созвади вакансию");
    [self showAlertWithMessageWithBlock:@"Вы создали вакансию" block:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}

#pragma mark - Notifications

- (void) keyboardWillShow: (NSNotification*) notification {
    
    self.dictKeyboard = [self paramsKeyboardWithNotification:notification];
}

- (void) keyboardWillHide: (NSNotification*) notification {
    
    self.dictKeyboard = [self paramsKeyboardWithNotification:notification];
}

#pragma mark - UITextViewDelegate


- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self animationMethodWithDictParams:self.dictKeyboard];
    
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    [self animationMethodWithDictParams:self.dictKeyboard];

}

- (void)textViewDidChange:(UITextView *)textView {
    
    CGFloat textHeight = [self getLabelHeight:textView];
    NSLog(@"%@", textView.text);
    
    if (textHeight >= 55) {
        [self animationsForViewWithTextHeight:textHeight];
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

- (NSDictionary*) paramsKeyboardWithNotification: (NSNotification*) notification {
    
    CGFloat animationDuration = [[notification.userInfo objectForKey:@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    NSValue* keyboardFrameBegin = [notification.userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    CGFloat heightValue = keyboardFrameBeginRect.origin.y;
    CGFloat heightCount = keyboardFrameBeginRect.size.height;
    
    NSDictionary * dictParams = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithFloat:animationDuration], @"animation",
                                 [NSNumber numberWithFloat:heightValue], @"height",
                                 [NSNumber numberWithFloat:heightCount], @"count", nil];
    
    NSLog(@"Hello2");
    return dictParams;
}

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

#pragma mark - Animations

- (void) animationMethodWithDictParams: (NSDictionary*) dict{
    
    [UIView animateWithDuration:[[dict objectForKey:@"animation"] floatValue] animations:^{
        CGRect newRect = self.view.frame;
        newRect.origin.y = [[dict objectForKey:@"height"] floatValue] - (CGRectGetHeight(newRect));
        self.view.frame = newRect;
    }];
}

- (void) animationsForViewWithTextHeight: (CGFloat) textHeight {
    
    static CGFloat constHeight;
    
    if (textHeight > self.heightForText) {
        constHeight = 18.f;
    } else if (textHeight < self.heightForText) {
        constHeight = -18.f;
    }
   
    if (textHeight != self.heightForText) {
        [UIView animateWithDuration:0.3 animations:^{
            
            [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
            
            CGRect rectForView = self.viewForComment.frame;
            CGRect rectForText = self.textView.frame;
            CGRect rectForButton = self.buttonCreate.frame;
            
            rectForView.size.height += constHeight;
            rectForText.size.height += constHeight;
            rectForButton.origin.y += constHeight;
            self.mainScrollView.contentSize = CGSizeMake(0, self.view.bounds.size.height + (constHeight - 64));
            self.mainScrollView.contentOffset = CGPointMake(0, self.mainScrollView.contentOffset.y + constHeight);
            
            self.viewForComment.frame = rectForView;
            self.textView.frame = rectForText;
            self.buttonCreate.frame = rectForButton;
            
        } completion:^(BOOL finished) {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            self.heightForText = textHeight;
        }];
    }

}

#pragma mark - HMImagePickerControllerDelegate
- (void)imagePickerController:(HMImagePickerController *)picker
      didFinishSelectedImages:(NSArray<UIImage *> *)images
               selectedAssets:(NSArray<PHAsset *> *)selectedAssets {
    
    self.imageVacancies = [images objectAtIndex:0];
    [self.buttonAddImage setImage:self.imageVacancies forState:UIControlStateNormal];
    self.buttonAddImage.layer.cornerRadius = 3.f;
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
