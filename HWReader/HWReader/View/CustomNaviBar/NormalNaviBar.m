//
//  NormalNaviBar.m
//  HWReader
//
//  Created by LPanda on 14-7-23.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "NormalNaviBar.h"

#define TITLELB_WIDTH    (ISPAD ? 400 : 200)
#define TITLELB_HEIGHT   (ISPAD ? 60 : 30)
#define TITLELB_CENTERY  BAR_HEIGHT/2 + 3
#define TITLELB_FONT_SIZE 20.0f

@implementation NormalNaviBar

@synthesize titleLB;

- (id)initWithDelegate:(id)delegate HideBtn:(TopBtnHideStyle)hideStyle Title:(NSString *)title
{
    if (self = [super initWithDelegate:delegate HideBtn:hideStyle Title:title]) {
        self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, TITLELB_WIDTH, TITLELB_HEIGHT)];
        titleLB.backgroundColor = [UIColor clearColor];
        titleLB.center = CGPointMake(self.center.x, TITLELB_CENTERY);
        titleLB.text = title;
        titleLB.font = [UIFont systemFontOfSize:TITLELB_FONT_SIZE];
        titleLB.textAlignment = TEXTALIGNMENT_CENTER;
        [backgroundImg addSubview:titleLB];
        
    }
    return self;
}

-(void)subViewLayout{
    titleLB.center = CGPointMake(self.center.x, TITLELB_CENTERY);
}

-(void)setBehavior:(id)behavior{
    NSString *title = behavior;
    titleLB.text = title;
}

-(id)getBehavior{
    return titleLB;
}


@end
