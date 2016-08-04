//
//  MyTravelView.h
//  TravelTogether
//
//  Created by Виктор Мишустин on 02/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTravelView : UIView

+ (UIView*) customCellTableTravelHistoryWithCellView: (UIView*) cellView //Окно ячейки
                                       andNameFlight: (NSString*) nameFlight //Название рейса
                                       andTravelName: (NSString*) travelName //Куда летит и откуда
                                      andBuyOrSearch: (BOOL) buyOrSearch //Кубить билет или поиск попутчика
                                   andLabelTimeStart: (NSString*) labelTimeStart //Время отправления
                                  andLabelTimeFinish: (NSString*) labelTimeFinish //Время прибытия
                                         andStraight: (BOOL) straight //Прямой или нет
                                       andFlightTime: (NSString*) flightTime; //Время полета

@end
