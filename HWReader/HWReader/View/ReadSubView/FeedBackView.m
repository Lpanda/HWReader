//
//  FeedBackView.m
//  HWReader
//
//  Created by LPanda on 14-9-23.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "FeedBackView.h"


@implementation FeedBackView

@synthesize text = _text;
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)sendFeedbackMessage:(UIButton *)sender {
    [_delegate feedbackMessage:_text.text];
    [_text resignFirstResponder];
}

- (IBAction)cancelInput:(id)sender {
    _text.text = nil;
    [self sendFeedbackMessage:nil];
}

# pragma mark UITextView 代理

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [self sendFeedbackMessage:nil];
    }
    return YES;
}

@end
