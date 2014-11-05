//
//  BookRackCell.m
//  HWReader
//
//  Created by LPanda on 14-9-25.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "BookRackCell.h"

#define BOOKVIEW_INTERVAL   10

#define BOOKVIEW_WIDTH  (SELF_WIDTH / 3) - BOOKVIEW_INTERVAL

#define BOOKVIEW_ORIGN_X(INDEX) \
        (BOOKVIEW_WIDTH + BOOKVIEW_INTERVAL) * INDEX + BOOKVIEW_INTERVAL / 2

#define BOOKVIEW_ORIGN_Y    10

static NSInteger BOOK_CNT;

@implementation BookRackCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier BookCnt:(NSInteger)cnt
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        BOOK_CNT = cnt;
        bookViews = [[NSMutableArray alloc]init];
        for (int i = 0; i != BOOK_CNT; ++ i) {
            BookView *bookView = [[BookView alloc]init];
            bookView.hidden = YES;
            [self.contentView addSubview:bookView];
            [bookViews addObject:bookView];
        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews{
    [super layoutSubviews];

    for (int i = 0; i != [bookViews count]; ++ i) {
        BookView *bookView = bookViews[i];
        bookView.frame = CGRectMake(
                                    BOOKVIEW_ORIGN_X(i),
                                    BOOKVIEW_ORIGN_Y,
                                    BOOKVIEW_WIDTH,
                                    SELF_HEIGHT - BOOKVIEW_ORIGN_Y);
    }
}

-(void)bookRackShow:(NSArray *)books{
    for (int i = 0; i != [books count]; ++ i) {
        BookView *tmp = bookViews[i];
        tmp.nameLB.text = books[i];
        tmp.hidden = NO;
    }
}

-(void)clearContentView{
    for (BookView *subView  in bookViews) {
        subView.hidden = YES;
    }
    self.textLabel.text = nil;
}

-(void)hideBookView{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HideBookRackView" object:nil];
}

@end
