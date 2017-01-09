//
//  ChooseProfessionViewController.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 16.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "ChooseProfessionViewController.h"
#import "UILabel+TitleCategory.h"
#import "ChooseProfessionalModel.h"
#import "SingleTone.h"

@interface ChooseProfessionViewController () <ChooseProfessionViewControllerDelegate>

@property (strong, nonatomic) NSMutableString * professianString;

@end

@implementation ChooseProfessionViewController

- (void) loadView {
    [super loadView];
    [self.navigationController setNavigationBarHidden: NO animated:YES];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.buttonSave.layer.cornerRadius = 5.f;
    
    if ([[[SingleTone sharedManager] professionControllerCode] isEqualToString:@"0"]) {
        UILabel * CustomText = [[UILabel alloc]initWithTitle:@"Выберите профессию"];
        self.navigationItem.titleView = CustomText;
    } else {
        UILabel * CustomText = [[UILabel alloc]initWithTitle:@"Выберите языки"];
        self.navigationItem.titleView = CustomText;
    }
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.mainArrayData = [ChooseProfessionalModel setArrayData];
    self.professianString = [NSMutableString string];
    self.mainArrayData = [NSArray new];
    ChooseProfessionalModel * model = [[ChooseProfessionalModel alloc] init];
    model.delegate = self;
    [model getProfessionalArrayToTableView:^{
        NSLog(@"DICT %@",self.mainArrayData);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.mainArrayData.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * identifier = @"Cell";
    
    ProfeccionalTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    NSMutableDictionary * dictData = [self.mainArrayData objectAtIndex:indexPath.row];
    
    cell.customTextLabel.text = [[dictData objectForKey:@"name"] objectForKey:@"name_plural"];
    cell.mainImage.image = [UIImage imageNamed:[dictData objectForKey:@"image"]];
    if ([[dictData objectForKey:@"choose"]boolValue]) {
        cell.checkImage.image = [UIImage imageNamed:@"activ_galka.png"];
    } else {
        cell.checkImage.image = [UIImage imageNamed:@"neactiv_galka.png"];
    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSMutableDictionary * dictData = [self.mainArrayData objectAtIndex:indexPath.row];
    ProfeccionalTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([[dictData objectForKey:@"choose"]boolValue]) {
        cell.checkImage.image = [UIImage imageNamed:@"neactiv_galka.png"];
        [dictData setObject:[NSNumber numberWithBool:NO] forKey:@"choose"];
        [self creationStringWithString:[[dictData objectForKey:@"name"] objectForKey:@"name_plural"] andChooseParams:NO];
    } else {
        cell.checkImage.image = [UIImage imageNamed:@"activ_galka.png"];
        [dictData setObject:[NSNumber numberWithBool:YES] forKey:@"choose"];
        [self creationStringWithString:[[dictData objectForKey:@"name"] objectForKey:@"name_plural"] andChooseParams:YES];
    }
}

#pragma mark - Actons

- (IBAction)actionBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionButtonSave:(UIButton *)sender {
    if ([self.professianString isEqualToString:@""]) {
        if ([[[SingleTone sharedManager] professionControllerCode] isEqualToString:@"0"]) {
            [self showAlertWithMessage:@"\nВыберите хотя-бы одну\nпрофессию\n"];
        } else {
            [self showAlertWithMessage:@"\nВыберите хотя-бы один\nязык\n"];
        }
        

    } else {
        [self.delegate setTitlForButtonDelegate:self withTitl:self.professianString];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Other

- (void) creationStringWithString: (NSString*) string andChooseParams: (BOOL) chooseParams {
    
    string = [self methodCodeLenguageWithString:string];
    
    
    if (chooseParams) {
        if ([self.professianString isEqualToString:@""]) {
            [self.professianString appendString:string];
        } else {
            [self.professianString appendString:[NSString stringWithFormat:@"/%@", string]];
        }
    } else {
        NSString * tmpString = [NSString stringWithFormat:@"/%@", string];
        NSString * tmpString2 = [NSString stringWithFormat:@"%@/", string];
        if ([self.professianString rangeOfString:tmpString].location != NSNotFound) {
            [self helpMethodForRange:tmpString];
        } else if ([self.professianString rangeOfString:tmpString2].location != NSNotFound) {
            [self helpMethodForRange:tmpString2];
        } else {
            [self helpMethodForRange:string];
        }
    }
    
}

- (void) helpMethodForRange: (NSString*) string {
    NSRange range = [self.professianString rangeOfString:string];
    [self.professianString deleteCharactersInRange:range];
}


//Преобразование языка в код
- (NSString*) methodCodeLenguageWithString: (NSString*) string {
    
    NSArray * arrayNames = [NSArray arrayWithObjects:@"Русский", @"Английский", @"Немецкий",  @"Французский",
                            @"Испанский", @"Китайский", @"Итальянский", @"Японский", nil];
    
    NSArray * arrayCode = [NSArray arrayWithObjects:@"RU", @"EG", @"DE", @"FR", @"ES", @"CN", @"IT", @"JP", nil];
    
    for (int i = 0; i < arrayNames.count; i++) {
    
        if ([string isEqualToString:[arrayNames objectAtIndex:i]]) {
            string = [arrayCode objectAtIndex:i];
        }
        
    }
    
    return string;
    
}

-(void) reloadTable{
    NSLog(@"RELOAD");
    [self.tableView reloadData];
}





@end
