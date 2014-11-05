//
//  WidgetLayOut.h
//  HWReader
//
//  Created by LPanda on 14-7-22.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#ifndef HWReader_WidgetLayOut_h
#define HWReader_WidgetLayOut_h

//  Tabbar
#define TABBAR_HEIGHT    50.0f
#define TABBAR_BGIMG_SIZE CGSizeMake(320, 49)
#define TABBAR_ICON_SIZE  CGSizeMake(30, 30)
#define TABBAR_ICONIMG_INSETS UIEdgeInsetsMake(5, 0, -5, 0)

// TopBtn
#define TOPRIGHTBTN_ORIGNX   (ISPAD ? 16.0f : 8.0f)
#define TOPRIGHTBTN_ORIGNY   (ISPAD ? 28.0f : 14.0f)
#define TOPBTN_WIDTH    (ISPAD ? 60.0f : 30.0f)
#define TOPBTN_HEIGHT   (ISPAD ? 60.0f : 30.0f)

//  BaseTableCell
#define BASETABLECELL_HEIGHT 90.0f

//  View Or VC's View
#define SELF_VIEW_WIDTH   self.view.bounds.size.width
#define SELF_VIEW_HEIGHT  self.view.bounds.size.height
#define SELF_WIDTH   self.bounds.size.width
#define SELF_HEIGHT  self.bounds.size.height

//  Screen
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height

#endif
