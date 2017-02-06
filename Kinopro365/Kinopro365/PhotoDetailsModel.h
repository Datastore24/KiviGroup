//
//  PhotoDetailsModel.h
//  Kinopro365
//
//  Created by Виктор Мишустин on 2/6/17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIManger.h"
#import "SingleTone.h"

@protocol PhotoDetailsModelDelegate <NSObject>

@required

- (void) loadPhotos: (NSArray *) array;

@end

@interface PhotoDetailsModel : NSObject

@property (assign, nonatomic) id <PhotoDetailsModelDelegate> delegate;

- (void) getPhotosArrayWithOffset: (NSString *) offset andCount: (NSString *) count;

@end
