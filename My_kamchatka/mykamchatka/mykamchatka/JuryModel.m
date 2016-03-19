//
//  JuryModel.m
//  mykamchatka
//
//  Created by Viktor on 18.03.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "JuryModel.h"

@implementation JuryModel

- (NSMutableArray *) setArrayJuri
{
    NSMutableArray * arrayJury = [[NSMutableArray alloc] init];
    
    NSArray * arrayTitle = [NSArray arrayWithObjects:
                            @"Яровая", @"Говорухин", @"Фетисов",
                            @"Горшков", @"Шпиленок", nil];
    
    NSArray * arraySubTitle = [NSArray arrayWithObjects:
                               @"Ирина Анатольевна", @"Станислав Сергеевич",
                               @"Вечеслав Александрович",@"Сергей Владимирович",
                               @"Игорь Петрович", nil];
    
    NSArray * textJuriArray = [NSArray arrayWithObjects:
                               @"Депутат Государственной думы Федерального \nСобрания РФ, председатель комитета\nГосударственной думы по безопасности и \nпротиводействию коррупции",
                               
                               @"Советский и российский кинорежиссёр, \nсценарист, актёр, народный артист Российской \nФедерации. Депутат Государственной думы, \nпредседатель комитета Государственной думы \nпо культуре. Сопредседатель центрального \nштаба Общероссийского народного фронта",
                               
                               @"Советский и российский хоккеист, заслуженный \nмастер спорта СССР, заслуженный тренер \nРоссии. Председатель правления Российской \nлюбительской хоккейной лиги",
                               
                               @"Российский фотограф дикой природы. \nУчредитель Российского Союза фотографов \nдикой природы, автор многочисленных \nфотоальбомов, в том числе «Камчатская \nодиссея», «Медведь», «Исчезающий мир ",
                               
                               @"Фотограф-натуралист, снимает дикую природу и \nдиких животных. Основатель и первый директор \nзаповедника «Брянский лес». Автор фотокниг о \nдикой природе. \nЧлен Международной Лиги природоохранных фотографов.", nil];
    
    NSArray * imageJuri = [NSArray arrayWithObjects:@"yarovaya.png", @"govoruhin.png", @"fetisov.png",
                           @"gorshkov.png", @"shpilyonok.png", nil];
    
    
    for (int i = 0; i < 5; i++) {
        
        NSDictionary * dictJury = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [arrayTitle objectAtIndex:i], @"title",
                                   [arraySubTitle objectAtIndex:i], @"subTitle",
                                   [textJuriArray objectAtIndex:i], @"text",
                                   [imageJuri objectAtIndex:i], @"image", nil];
        
        [arrayJury addObject:dictJury];
    }
    
    return arrayJury;
}

@end
