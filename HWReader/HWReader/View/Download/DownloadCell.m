//
//  DownloadCell.m
//  HWReader
//
//  Created by LPanda on 14-10-15.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "DownloadCell.h"

#define CENTER_POINT  SELF_HEIGHT / 2
const CGFloat IMG_SIZE = 30.0f;
const CGFloat LABEL_ORIGN_X = 20.0f;

@interface DownloadCell (){
    NSString    *downloadImgName;
}

@end

@implementation DownloadCell

@synthesize downloadProgress;
@synthesize request;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        downloadImgName = DOWNLOAD_STOP_RED;
        
        docNameLB = [[UILabel alloc]init];
        docNameLB.text = @"";
        [self addSubview:docNameLB];
        
        downloadStatusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        downloadStatusBtn.frame = CGRectMake(0, 0, IMG_SIZE, IMG_SIZE);
        downloadStatusBtn.center = CGPointMake(SELF_WIDTH - IMG_SIZE, CENTER_POINT);
        [downloadStatusBtn setImage:[UIImage imageNamed:downloadImgName] forState:UIControlStateNormal];
        [downloadStatusBtn addTarget:self action:@selector(clickDownloadBtn)
                    forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:downloadStatusBtn];
        
        downloadProgress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        downloadProgress.frame = CGRectMake(200, 36.5, 60, 9);
        [self.contentView addSubview:downloadProgress];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)showDownloadHistory{
    downloadStatusBtn.hidden = YES;
}

-(void)showDownloadingContent{
    downloadStatusBtn.hidden = NO;
    
    //  progress.....
}

- (void)clickDownloadBtn{
    if ([downloadImgName isEqualToString:DOWNLOAD_STOP_RED]) {
        //用户点击了暂停，那暂停下载，把图标变成开始
        [self.request clearDelegatesAndCancel];
        downloadImgName = DOWNLOAD_BEGIN_RED;
    }else{
        //用户点击开始，那继续，图标变暂停
        [request startAsynchronous];
        downloadImgName = DOWNLOAD_STOP_RED;
    }
    
    [downloadStatusBtn setImage:[UIImage imageNamed:downloadImgName] forState:UIControlStateNormal];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat labelWidth = SELF_WIDTH - LABEL_ORIGN_X - IMG_SIZE * 2;
    docNameLB.frame = CGRectMake(LABEL_ORIGN_X, 0, labelWidth, SELF_HEIGHT);
    
}


@end
