//
//  DownloadLinkCell.h
//  HWReader
//
//  Created by LPanda on 14-10-14.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadLinkCell : UITableViewCell{
    UIImageView *downloadImg;
}

- (void)hideDownloadImg;
- (void)showDownLoadImg;
@end
