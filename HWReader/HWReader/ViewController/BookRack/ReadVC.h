//
//  readVC.h
//  HWReader
//
//  Created by LPanda on 14-7-30.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "BaseVC.h"
#import "EmailSender.h"
#import "ReadSearchVC.h"
#import "FeedBackView.h"


@interface ReadVC : BaseVC<UIGestureRecognizerDelegate,UITextViewDelegate,
SKPSMTPMessageDelegate,FeedBackViewDelegate,ReadSearchVCDelegate,FeedBackViewDelegate>
{
    
}

@property (weak, nonatomic) IBOutlet UIWebView *readWebView;

@property (weak, nonatomic) IBOutlet UIView *editBar;
@property (nonatomic ,copy) NSString *baseUrl;
@property(nonatomic, copy) NSString *url;

- (IBAction)curlPage:(UIButton*)sender;

- (IBAction)changeFont:(UISlider*)slider;

- (IBAction)editAction:(UIButton *)sender;


@end
