//
//  BookView.m
//  HWReader
//
//  Created by LPanda on 14-9-25.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "BookView.h"

#define NAMELB_ORIGNX   20

@implementation BookView

@synthesize nameLB = _nameLB;

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(hideSelf) name:@"HideBookRackView" object:nil];
        
        self.image = [UIImage imageNamed:BOOKBG];
        
        _nameLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _nameLB.backgroundColor = [UIColor clearColor];
        _nameLB.numberOfLines = 0;
        _nameLB.lineBreakMode = NSLineBreakByCharWrapping;
        _nameLB.font = [UIFont systemFontOfSize:14.0f];
        [self addSubview:_nameLB];
        
        clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        clickBtn.backgroundColor = [UIColor clearColor];
        [clickBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:clickBtn];
    }
    return self;
}

-(void)btnAction{
    [[NSNotificationCenter defaultCenter] postNotificationName:BOOKCLICKNOTIFI object:@""];
}

-(void)hideSelf{
    self.hidden = YES;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _nameLB.frame = CGRectMake(NAMELB_ORIGNX, 0, SELF_WIDTH - NAMELB_ORIGNX, SELF_HEIGHT);
    clickBtn.frame = self.bounds;
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
