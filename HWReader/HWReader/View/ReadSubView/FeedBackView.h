//
//  FeedBackView.h
//  HWReader
//
//  Created by LPanda on 14-9-23.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FeedBackViewDelegate <NSObject>

- (void)feedbackMessage:(NSString *)msg;

@end

@interface FeedBackView : UIView<UITextViewDelegate>{
    UITextView  *feedbackTextView;
    UIButton *sendBtn;
    UIButton *cancelBtn;
}

@property (weak, nonatomic) IBOutlet UITextView *text;
@property (assign,  nonatomic)  id<FeedBackViewDelegate>    delegate;

- (IBAction)sendFeedbackMessage:(UIButton *)sender;

- (IBAction)cancelInput:(id)sender;

@end
