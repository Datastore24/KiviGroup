//
//  APIClass.h
//  Sadovod
//
//  Created by Кирилл Ковыршин on 18.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface APIGetClass : NSObject
//Метод получающий данные с сервера
-(void) getDataFromServerWithParams: (NSDictionary *) params method:(NSString*) method complitionBlock: (void (^) (id response)) compitionBack; //Стандартный метод гет

-(void) getDataFromServerWithAudioParams: (NSDictionary *) params andAudioURL: (NSURL*) audioUrl method:(NSString*) method complitionBlock: (void (^) (id response)) compitionBack; //Пост аудио

-(void) getDataFromServerWithImageParams: (NSDictionary *) params //пост картинки
                                andImage: (UIImage*) image
                                  method:(NSString*) method
                         complitionBlock: (void (^) (id response)) compitionBack;
@end
