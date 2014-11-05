//
//  DownloadCell.h
//  HWReader
//
//  Created by LPanda on 14-10-15.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface DownloadCell : UITableViewCell{
    UILabel *docNameLB;
    UIButton *downloadStatusBtn;
    UIProgressView *downloadProgress;
}

- (void)showDownloadHistory;

- (void)showDownloadingContent;

@end
