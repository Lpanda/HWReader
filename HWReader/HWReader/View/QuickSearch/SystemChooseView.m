//
//  SystemChooseView.m
//  HWReader
//
//  Created by LPanda on 14-11-6.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "SystemChooseView.h"
#import "DocManager.h"

static NSString *FILENAME = @"SystemNames";
static CGFloat BTN_ORIGN_X = 0.0f;
static CGFloat DEFAULT_ORIGN_Y = 0.0f;
static const CGFloat BTN_HEIGHT = 30.0f;
static const CGFloat BTN_WIDTH = 120.0f;
static const CGFloat BORDER_WIDTH = 1.5f;
static const int TAG_OFFSET = 100;

@interface SystemChooseView (){
    CGFloat btnOrignY;
}

- (void)drawChooseBtns;

@end

@implementation SystemChooseView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        NSString *filePath = [[NSBundle mainBundle]pathForResource:FILENAME ofType:@"plist"];
        systems = [[NSArray alloc]initWithContentsOfFile:filePath];
        [self drawChooseBtns];
    }
    return self;
}

-(void)drawChooseBtns{
    if (systems.count == 0) {
        return;
    }
    
    for (int i = 0; i < [systems count]; ++ i) {
        if (i % 2 == 0) {
            BTN_ORIGN_X = 0.0f;
            btnOrignY = DEFAULT_ORIGN_Y + BTN_HEIGHT * (i / 2);
        }else{
            BTN_ORIGN_X = BTN_WIDTH;
        }
        UIButton *chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        chooseBtn.frame = CGRectMake(BTN_ORIGN_X, btnOrignY, BTN_WIDTH, BTN_HEIGHT);
        chooseBtn.backgroundColor = [UIColor clearColor];
        chooseBtn.layer.borderWidth = BORDER_WIDTH;
        chooseBtn.layer.borderColor = [UIColor grayColor].CGColor;
        [chooseBtn setTitle:systems[i] forState:UIControlStateNormal];
        [chooseBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        chooseBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        chooseBtn.tag = TAG_OFFSET + i;
        [self addSubview:chooseBtn];
    }
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, SELF_WIDTH, BTN_HEIGHT * systems.count);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
