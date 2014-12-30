//
//  DownloadLinkCell.m
//  HWReader
//
//  Created by LPanda on 14-10-14.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "DownloadLinkCell.h"

#define DOWNLOADIMG_SIZE    30

@implementation DownloadLinkCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        downloadImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:DOWNLOAD_URL_IMG]];
        [self.contentView addSubview:downloadImg];
    }
    return self;
}

-(void)hideDownloadImg{
    downloadImg.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    downloadImg.frame = CGRectMake(0, 0, DOWNLOADIMG_SIZE, DOWNLOADIMG_SIZE);
    downloadImg.center = CGPointMake(SELF_WIDTH - (DOWNLOADIMG_SIZE / 2), SELF_HEIGHT / 2);
}
- (void)showDownLoadImg
{
    downloadImg.hidden = NO;
}
@end
