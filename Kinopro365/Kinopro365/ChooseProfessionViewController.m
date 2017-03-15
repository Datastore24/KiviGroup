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
#import "ProfessionsTable.h"
#import "AddParamsController.h"
#import "AdditionalTable.h"
#import "UserInformationTable.h"

@interface ChooseProfessionViewController () <ChooseProfessionalModelDelegate,AddParamsControllerDelegate>

@property (strong, nonatomic) NSMutableArray * langArray;
@end

@implementation ChooseProfessionViewController

- (void) loadView {
    [super loadView];
    [self.navigationController setNavigationBarHidden: NO animated:YES];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.buttonSave.layer.cornerRadius = 5.f;
    
    if(!self.isLanguage){
        UILabel * CustomText = [[UILabel alloc]initWithTitle:@"Выберите профессию"];
        self.navigationItem.titleView = CustomText;
    } else {
        UILabel * CustomText = [[UILabel alloc]initWithTitle:@"Выберите языки"];
        self.navigationItem.titleView = CustomText;
        self.langArray = [NSMutableArray new];
    }
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.mainArrayData = [ChooseProfessionalModel setArrayData];
    self.professianString = [NSMutableString string];
    
    if(!self.isLanguage){
        ChooseProfessionalModel * model = [[ChooseProfessionalModel alloc] init];
        model.delegate = self;
        [model getProfessionalArrayToTableView];
    }else{
        AddParamsController * addParamsController = [[AddParamsController alloc] init];
        addParamsController.delegate = self;
    }
    
    
    
    
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
    if(self.isLanguage){
        cell.customTextLabel.text = [dictData objectForKey:@"name"];
        //Узнаем есть ли избранное
        NSString * resultName = [NSString stringWithFormat:@"ex_languages[%@]",[dictData objectForKey:@"id"]];
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"additionalID = %@",
                             resultName];
        RLMResults *outletTableDataArray = [AdditionalTable objectsWithPredicate:pred];
        
        if(outletTableDataArray.count>0){
            [dictData setObject:[NSNumber numberWithBool:YES] forKey:@"choose"];
        }
        
        
    }else{
        cell.customTextLabel.text = [dictData objectForKey:@"name"];
        cell.mainImage.image = [UIImage imageNamed:[dictData objectForKey:@"image"]];
        
    }
    if(!self.isSearch){
        if ([[dictData objectForKey:@"choose"]boolValue]) {
            cell.checkImage.image = [UIImage imageNamed:@"activ_galka.png"];
        } else {
            cell.checkImage.image = [UIImage imageNamed:@"neactiv_galka.png"];
        }
    }else{
        cell.checkImage.image = [UIImage imageNamed:@"neactiv_galka.png"];
    }
    
    
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSMutableDictionary * dictData = [self.mainArrayData objectAtIndex:indexPath.row];
    ProfeccionalTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if(!self.isSearch){
        RLMResults *profTableDataArray = [UserInformationTable allObjects];
        
        if(profTableDataArray.count>0){
            
            UserInformationTable * userTable = [profTableDataArray objectAtIndex:0];
            RLMRealm *realm = [RLMRealm defaultRealm];
            [realm beginWriteTransaction];
            userTable.isSendToServer = @"0";
            [realm commitWriteTransaction];
            
        }
        
        
        
        
        if ([[dictData objectForKey:@"choose"] boolValue]) {
            cell.checkImage.image = [UIImage imageNamed:@"neactiv_galka.png"];
            [dictData setObject:[NSNumber numberWithBool:NO] forKey:@"choose"];
            
            if(!self.isLanguage){
                
                [self creationStringWithString:[dictData objectForKey:@"name"] andChooseParams:NO andString:self.professianString];
                
                //Узнаем есть ли избранное
                NSPredicate *pred = [NSPredicate predicateWithFormat:@"professionID = %@",
                                     [dictData objectForKey:@"profID"]];
                RLMResults *outletTableDataArray = [ProfessionsTable objectsWithPredicate:pred];
                ProfessionsTable * professionalTable = [outletTableDataArray objectAtIndex:0];
                
                [[RLMRealm defaultRealm] beginWriteTransaction];
                [[RLMRealm defaultRealm] deleteObject:professionalTable];
                [[RLMRealm defaultRealm] commitWriteTransaction];
            }else{
                
                //Узнаем есть ли избранное
                NSString * resultName = [NSString stringWithFormat:@"ex_languages[%@]",[dictData objectForKey:@"id"]];
                NSPredicate *pred = [NSPredicate predicateWithFormat:@"additionalID = %@",
                                     resultName];
                RLMResults *outletTableDataArray = [AdditionalTable objectsWithPredicate:pred];
                NSLog(@"RESSSS %@",outletTableDataArray);
                if(outletTableDataArray.count>0){
                    AdditionalTable * professionalTable = [outletTableDataArray objectAtIndex:0];
                    
                    [[RLMRealm defaultRealm] beginWriteTransaction];
                    [[RLMRealm defaultRealm] deleteObject:professionalTable];
                    [[RLMRealm defaultRealm] commitWriteTransaction];
                }
                
                
            }
            
            
        } else {
            NSLog(@"TEMPDICT %@",dictData);
            cell.checkImage.image = [UIImage imageNamed:@"activ_galka.png"];
            [dictData setObject:[NSNumber numberWithBool:YES] forKey:@"choose"];
            
            if(!self.isLanguage){
                
                [self creationStringWithString:[dictData objectForKey:@"name"] andChooseParams:YES andString:self.professianString];
                
                ProfessionsTable * professionalTable = [[ProfessionsTable alloc] init];
                [professionalTable insertDataIntoDataBaseWithName:[dictData objectForKey:@"profID"] andProfessionName:[dictData objectForKey:@"name"]];
            }else{
                AdditionalTable * addTable = [[AdditionalTable alloc] init];
                NSString * resultName = [NSString stringWithFormat:@"ex_languages[%@]",[dictData objectForKey:@"id"]];
                [addTable insertDataIntoDataBaseWithName:resultName andAdditionalName:[dictData objectForKey:@"name"] andAdditionalValue:[dictData objectForKey:@"id"]];
            }
            
            
        }
    }else{
        cell.checkImage.image = [UIImage imageNamed:@"activ_galka.png"];
        [dictData setObject:[NSNumber numberWithBool:YES] forKey:@"choose"];
        [self.langArray addObject:@{@"id":[dictData objectForKey:@"id"],
                                    @"name":[dictData objectForKey:@"name"]}];
        
    }
    
    
}

#pragma mark - Actons

- (IBAction)actionBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionButtonSave:(UIButton *)sender {
    
    if(!self.isSearch){
        RLMResults *outletTableDataArray;
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"additionalID BEGINSWITH %@",
                             @"ex_languages"];
        
        outletTableDataArray = [AdditionalTable objectsWithPredicate:pred];
    
    
        if(!self.isLanguage && [self.professianString isEqualToString:@""]){
            
            [self showAlertWithMessage:@"\nВыберите хотя-бы одну\nпрофессию\n"];
            
        } else if(self.isLanguage && outletTableDataArray.count==0){

            [self showAlertWithMessage:@"\nВыберите хотя-бы один\nязык\n"];
            
        } else{
            if(!self.isLanguage){
              [self.delegate setTitlForButtonDelegate:self withTitl:self.professianString];
            }
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        
        NSUInteger numberOfViewControllersOnStack = [self.navigationController.viewControllers count];
        
        AddParamsController * addParam = [self.navigationController.viewControllers objectAtIndex:numberOfViewControllersOnStack-2];
        
        
        addParam.langArray = self.langArray;
        
        [self.navigationController popToViewController:addParam animated:YES];
    }
}

#pragma mark - Other

- (void) creationStringWithString: (NSString*) string andChooseParams: (BOOL) chooseParams andString: (NSMutableString *) proffesianString {
   
    string = [self methodCodeLenguageWithString:string];
    
    
    if (chooseParams) {
        if ([proffesianString isEqualToString:@""]) {
            [proffesianString appendString:string];
        } else {
            [proffesianString appendString:[NSString stringWithFormat:@"/%@", string]];
        }
    } else {
        NSString * tmpString = [NSString stringWithFormat:@"/%@", string];
        NSString * tmpString2 = [NSString stringWithFormat:@"%@/", string];
        if ([proffesianString rangeOfString:tmpString].location != NSNotFound) {
            [self helpMethodForRange:tmpString andString:proffesianString];
        } else if ([self.professianString rangeOfString:tmpString2].location != NSNotFound) {
            [self helpMethodForRange:tmpString2 andString:proffesianString];
        } else {
            [self helpMethodForRange:string andString:proffesianString];
        }
    }
     NSLog(@"STRING %@", proffesianString);
    
}

- (void) helpMethodForRange: (NSString*) string andString: (NSMutableString *) proffesianString {
    NSRange range = [proffesianString rangeOfString:string];
    [proffesianString deleteCharactersInRange:range];
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
    NSLog(@"RELOAD PROF");
    [self.tableView reloadData];
}





@end
