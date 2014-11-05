//
//  BookRackCell.h
//  HWReader
//
//  Created by LPanda on 14-9-25.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookView.h"


@interface BookRackCell : UITableViewCell{
    NSMutableArray *bookViews;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier BookCnt:(NSInteger)cnt;

-(void)bookRackShow:(NSArray *)books;

-(void)clearContentView;

-(void)hideBookView;

@end
