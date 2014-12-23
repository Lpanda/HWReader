//
//  DownloadManagerVC.h
//  HWReader
//
//  Created by LPanda on 14-8-11.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "BaseTableVC.h"

typedef enum {
    Downloading = 0,
    Completed
}DownloadStatus;

@interface DownloadManagerVC : BaseTableVC{
    DownloadStatus  downloadStatus;
}

@end
