//
//  PullDownNaviBar.m
//  HWReader
//
//  Created by LPanda on 14-7-22.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "PullDownNaviBar.h"

#define PULLDOWNBTN_WIDTH    (ISPAD ? 400 : 200)
#define PULLDOWNBTN_HEIGHT   (ISPAD ? 60 : 30)

@interface PullDownNaviBar(){

}

@end

@implementation PullDownNaviBar

@synthesize pullDownBtn;
@synthesize pullDownArrow;

- (id)initWithDelegate:(id)delegate HideBtn:(TopBtnHideStyle)hideStyle Title:(NSString*)title{
    if (self = [super initWithDelegate:delegate HideBtn:hideStyle Title:title]) {
        
        pullDownBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,
                                                                PULLDOWNBTN_WIDTH, PULLDOWNBTN_HEIGHT)];
        pullDownBtn.center = CGPointMake(self.center.x, BAR_HEIGHT/2);
        [pullDownBtn setTitle:title forState:UIControlStateNormal];
        pullDownBtn.titleLabel.font = [UIFont systemFontOfSize:20.0f];
        [pullDownBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [pullDownBtn addTarget:self action:@selector(chooseSys) forControlEvents:UIControlEventTouchUpInside];
        [backgroundImg addSubview:pullDownBtn];
        
        pullDownArrow = [[UIImageView alloc]initWithFrame:
                         CGRectMake(PULLDOWNBTN_WIDTH, (BAR_HEIGHT - PULLDOWNBTN_HEIGHT) / 2,
                                    PULLDOWNBTN_HEIGHT, PULLDOWNBTN_HEIGHT)];
        pullDownArrow.image = [UIImage imageWithFitInSize:TABBAR_ICON_SIZE
                                                  AndName:PULLDOWNBTN_DOWNIMG];
        [backgroundImg addSubview:pullDownArrow];
    }
    return self;
}

# pragma mark 按钮方法

- (void)chooseSys{
    if ([self.naviDelegate respondsToSelector:@selector(naviAction:)]) {
        [self.naviDelegate naviAction:nil];
    }
}

- (void)testSubClass{
    
}

-(void)setTitle:(NSString *)title{
    [pullDownBtn setTitle:title forState:UIControlStateNormal];
}

-(void)setBehavior:(id)behavior{
    [pullDownBtn setTitle:behavior forState:UIControlStateNormal];
}

-(id)getBehavior{
    return pullDownBtn;
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
