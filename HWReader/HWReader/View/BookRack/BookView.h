//
//  BookView.h
//  HWReader
//
//  Created by LPanda on 14-9-25.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *BOOKCLICKNOTIFI = @"BookClickNotifi";


@interface BookView : UIImageView{
    UIButton *clickBtn;
}

@property (strong,  nonatomic)  UILabel *nameLB;
@property (strong, nonatomic) NSDictionary *book;
@end
