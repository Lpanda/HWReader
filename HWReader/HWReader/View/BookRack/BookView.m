//
//  BookView.m
//  HWReader
//
//  Created by LPanda on 14-9-25.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "BookView.h"

#define ZEROLINE    0
#define NAMELB_ORIGNX   20

@implementation BookView

@synthesize nameLB;
@synthesize delegate = _delegate;

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(hideSelf) name:@"HideBookRackView" object:nil];
        
        self.image = [UIImage imageNamed:BOOKBG];
        
        self.nameLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        nameLB.backgroundColor = [UIColor clearColor];
        nameLB.numberOfLines = ZEROLINE;
        nameLB.lineBreakMode = NSLineBreakByCharWrapping;
        nameLB.font = [UIFont systemFontOfSize:14.0f];
        [self addSubview:nameLB];
        
        UIButton *clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        clickBtn.frame = self.bounds;
        clickBtn.backgroundColor = [UIColor clearColor];
        [clickBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:clickBtn];
    }
    return self;
}

-(void)btnAction{
    [_delegate bookClick];
}

-(void)hideSelf{
    self.hidden = YES;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    nameLB.frame = CGRectMake(NAMELB_ORIGNX, 0, SELF_WIDTH - NAMELB_ORIGNX, SELF_HEIGHT);
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
