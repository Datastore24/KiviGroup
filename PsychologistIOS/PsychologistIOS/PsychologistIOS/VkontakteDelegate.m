//
//  VkontakteDelegate.m
//  PsychologistIOS
//
//  Created by Viktor on 13.05.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "VkontakteDelegate.h"

@implementation VkontakteDelegate

@synthesize username, realName, ID, photo, access_token, email, link;

+ (id)sharedInstance {
    static VkontakteDelegate *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[VkontakteDelegate alloc]init];
    });
    return __sharedInstance;
}
- (id) init {
    access_token = [[NSUserDefaults standardUserDefaults] objectForKey:@"vk_token"];
    ID = [[NSUserDefaults standardUserDefaults] objectForKey:@"vk_id"];
    return  self;
}
-(void) loginWithParams:(NSMutableDictionary *)params {
    ID = [params objectForKey:@"user_id"];
    access_token = [params objectForKey:@"access_token"];
    //Сохраняемся, ребят!
    [[NSUserDefaults standardUserDefaults] setValue:access_token forKey:@"vk_token"];
    [[NSUserDefaults standardUserDefaults] setValue:ID forKey:@"vk_id"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"access_token %@", access_token);
    NSLog(@"ID %@", ID);
    
    //Теперь попробуем вытяныть некую информацию
    NSString *urlString = [NSString stringWithFormat:@"https://api.vk.com/method/users.get?uid=%@&access_token=%@&fields=verified,sex,bdate,city,has_mobile,contacts", ID, access_token] ;
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    //Тут произошла странная вещь - ответ должен вернуться в словаре, ан нет!
    //У меня не получилось пропарсить стандартными средствами.
    //Строим костыли, простите...
    NSArray* userData = [responseString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\":{},[]"]];
    NSLog(@"%@", userData);
//    realName = [userData objectAtIndex:20];
//    NSLog(@"userData %@", userData);
//    realName = [realName stringByAppendingString:@" "];
//    realName = [realName stringByAppendingString:[userData objectAtIndex:20]];
//    //Кому надо, сохраняемся
//    [[NSUserDefaults standardUserDefaults] setValue:@"vkontakte" forKey:@"SignedUpWith"];
//    [[NSUserDefaults standardUserDefaults] setValue:realName forKey:@"RealUsername"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    
//    
//    NSLog(@"realName %@", realName);
    
}
-(void) postToWall {
    //напишем что-нибудь на стене (вместо пробелов ставим "+")
    NSString* message = @"oooops";
    NSString *urlString = [NSString stringWithFormat:@"https://api.vk.com/method/wall.post?uid=%@&message=%@&attachments=https://pp.vk.me/c623316/v623316359/3e441/f8U_GvVIOXo.jpg&access_token=%@", ID, message,access_token] ;
    NSURL *url = [NSURL URLWithString:urlString];
    //Теперь, если очень хочется, можно взглянуть на ответ
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
}

@end
