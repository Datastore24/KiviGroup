//
//  ChatCellView.h
//  ITDolgopa
//
//  Created by Viktor on 26.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatCellView : UIView

- (instancetype)initWhithFirstView: (UIView*) view
                      andDate: (NSString*) date
                andImagePhoto: (NSString*) imagePhoto
                     andFrame: (CGRect) frame;

@end
