//
//  PacketVC.h
//  HWReader
//
//  Created by LPanda on 14-7-23.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "BookRackVC.h"
#import "DDMenuController.h"
#define HHCNODES_PARSE_DONE_NOTIFY @"HHCNODES_PARSE_DONE_NOTIFY"

@interface PacketVC : BookRackVC
@property (nonatomic, copy) NSDictionary *book;
@property (nonatomic, assign) DDMenuController *menuVC;
@end
