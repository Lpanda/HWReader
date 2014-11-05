//
//  SegmentedNaviBar.m
//  HWReader
//
//  Created by LPanda on 14-7-23.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "SegmentedNaviBar.h"

#define SEGMENTEDBAR_WIDTH   (SELF_WIDTH - SEGMENTEDBTN_RIGHT_ORIGNX * 2)/2
#define SEGMENTEDBTN_RIGHT_ORIGNX (TOPBTN_WIDTH + TOPRIGHTBTN_ORIGNX + 10)
#define SEGMENTEDBAR_HEIGHT  BAR_HEIGHT - 20
#define SEGMENTEDBAR_CENTERY self.center.y - 13
#define SELECTEDCOLOR  [UIColor colorWithRed:213/255.0 green:213/255.0 blue:213/255.0 alpha:1.0]
#define UNSELECTEDCOLOR [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0]

@implementation SegmentedNaviBar

@synthesize segmentedControl;

- (id)initWithDelegate:(id)delegate HideBtn:(TopBtnHideStyle)hideStyle Segments:(NSArray *)segMents{
    
    if (self = [super initWithDelegate:delegate HideBtn:hideStyle Title:nil]) {
        for (int i = 0; i != [segMents count]; ++ i) {
            segmentedBtn[i] = [UIButton buttonWithType:UIButtonTypeCustom];
            segmentedBtn[i].frame = CGRectMake(SEGMENTEDBTN_RIGHT_ORIGNX + (i * SEGMENTEDBAR_WIDTH),
                                               SEGMENTEDBAR_CENTERY,
                                            SEGMENTEDBAR_WIDTH, SEGMENTEDBAR_HEIGHT);
            [segmentedBtn[i] setTitle:[segMents objectAtIndex:i] forState:UIControlStateNormal];
            segmentedBtn[i].backgroundColor = UNSELECTEDCOLOR;
            [segmentedBtn[i] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            segmentedBtn[i].tag = i;
            [segmentedBtn[i] addTarget:self action:@selector(chooseSeg:)
                      forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:segmentedBtn[i]];
        }
    }
    return self;
}

-(void)setDefaultIndex:(int)index{
    [self chooseSeg:segmentedBtn[index]];
}

# pragma mark UISegmentedControl 绑定方法

- (void)chooseSeg:(UIButton *)segBtn{
    segBtn.backgroundColor = SELECTEDCOLOR;
    
    NSInteger another = !segBtn.tag;
    
    segmentedBtn[another].backgroundColor = UNSELECTEDCOLOR;
    
    NSNumber *selectedNum = [NSNumber numberWithInteger:segBtn.tag];
    
    if ([self.naviDelegate respondsToSelector:@selector(naviAction:)]) {
        [self.naviDelegate naviAction:selectedNum];
    }
}

@end
