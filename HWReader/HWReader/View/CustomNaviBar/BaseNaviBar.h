//
//  BaseNaviBar.h
//  HWReader
//
//  Created by LPanda on 14-7-22.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BAR_HEIGHT   (ISPAD ? 100 : 50)
#define BAR_WIDTH    (ISPAD ? 1136 : 320)

typedef enum {
    All,
    Right,
    Left,
    None
}TopBtnHideStyle;

@protocol NaviActionDelegate <NSObject>

@optional
- (void)naviAction:(id)sender;

- (void)rightBtnAction;

- (void)leftBtnAction;

@end

@interface BaseNaviBar : UIView{
    UIImageView *backgroundImg;
}

@property (strong,  nonatomic)    UIButton *rightBtn;
@property (strong,  nonatomic)    UIButton *leftBtn;
@property (assign,  nonatomic)    id<NaviActionDelegate> naviDelegate;

- (id)initWithDelegate:(id)delegate HideBtn:(TopBtnHideStyle)hideStyle Title:(NSString*)title;

- (id)initWithDelegate:(id)delegate HideBtn:(TopBtnHideStyle)hideStyle;

- (void)hideBtn:(TopBtnHideStyle)style;

- (void)setBehavior:(id)behavior;

- (id)getBehavior;

- (void)rightBtnClick;

- (void)leftBtnClick;

- (void)portraitFrame;

- (void)landscapeFrame;

- (void)subViewLayout;

@end
