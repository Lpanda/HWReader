//
//  BaseNaviBar.m
//  HWReader
//
//  Created by LPanda on 14-7-22.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "BaseNaviBar.h"
#import "WidgetLayOut.h"

@implementation BaseNaviBar

@synthesize rightBtn;
@synthesize leftBtn;
@synthesize naviDelegate;

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(id)initWithDelegate:(id)delegate HideBtn:(TopBtnHideStyle)hideStyle{
    return [self initWithDelegate:delegate HideBtn:hideStyle Title:nil];
}

- (id)initWithDelegate:(id)delegate HideBtn:(TopBtnHideStyle)hideStyle Title:(NSString*)title{
    if (self = [super init]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeInterfaceOritation:)
                                                     name:CHANGE_INTERTERFACEORIENTATION object:nil];
        
        self.frame = CGRectMake(0, 0, BAR_WIDTH, BAR_HEIGHT);
        
        backgroundImg = [[UIImageView alloc]initWithFrame:self.frame];
        backgroundImg.image = [UIImage imageNamed:TOPNAVI_BGIMG];
        backgroundImg.userInteractionEnabled = YES;
        [self addSubview:backgroundImg];
        
        leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(TOPRIGHTBTN_ORIGNX, TOPRIGHTBTN_ORIGNY,
                                   TOPBTN_WIDTH, TOPBTN_HEIGHT);
        [leftBtn setImage:[UIImage imageNamed:BACKBTN_IMG] forState:UIControlStateNormal];
        [leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [backgroundImg addSubview:leftBtn];
        
        rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(SELF_WIDTH - TOPRIGHTBTN_ORIGNX - TOPBTN_WIDTH, TOPRIGHTBTN_ORIGNY,
                                    TOPBTN_WIDTH, TOPBTN_HEIGHT);
        [rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [backgroundImg addSubview:rightBtn];
        
        self.NaviDelegate = delegate;
        
        [self hideBtn:hideStyle];
    }
    return self;
}


# pragma mark 隐藏按钮

- (void)hideBtn:(TopBtnHideStyle)style{
    
    switch (style) {
        case Right:{
            rightBtn.hidden = YES;
        }
            
            break;
            
        case Left:{
            leftBtn.hidden = YES;
        }
            break;
            
        case All:{
            rightBtn.hidden = YES;
            leftBtn.hidden = YES;
        }
            break;
            
        case None:{
            
        }
            break;
            
        default:
            break;
    }
}

# pragma mark 按钮方法

- (void)rightBtnClick{
    [naviDelegate rightBtnAction];
}

- (void)leftBtnClick{
    [naviDelegate leftBtnAction];
}

# pragma 横竖屏切换显示

- (void)changeInterfaceOritation:(NSNotification *)notifi{
    UIInterfaceOrientation interOrtn = [notifi.object intValue];
    
    if (interOrtn == UIInterfaceOrientationPortrait) {
        [self portraitFrame];
    }else{
        [self landscapeFrame];
    }
    
    backgroundImg.frame = self.frame;
    rightBtn.frame = CGRectMake(SELF_WIDTH - TOPRIGHTBTN_ORIGNX - TOPBTN_WIDTH, TOPRIGHTBTN_ORIGNY,
                                TOPBTN_WIDTH, TOPBTN_HEIGHT);
    [self subViewLayout];
}

-(void)portraitFrame{
    self.frame = CGRectMake(0, 0, BAR_WIDTH, BAR_HEIGHT);
}

-(void)landscapeFrame{
    self.frame = CGRectMake(0, 0, self.superview.frame.size.height, BAR_HEIGHT);
}

-(void)subViewLayout{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
