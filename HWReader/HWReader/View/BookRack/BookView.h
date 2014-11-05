//
//  BookView.h
//  HWReader
//
//  Created by LPanda on 14-9-25.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BookViewDelegate <NSObject>

- (void)bookClick;

@end

@interface BookView : UIImageView

@property (strong,  nonatomic)  UILabel *nameLB;
@property (assign,  nonatomic)  id<BookViewDelegate>    delegate;

@end
