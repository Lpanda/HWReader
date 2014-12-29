//
//  readVC.m
//  HWReader
//
//  Created by LPanda on 14-7-30.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "ReadVC.h"
#import "NormalNaviBar.h"
#import "MenuBookmarkVC.h"
#import "UserSettingVC.h"
#import "AppDelegate.h"

//  layOut
#define FEEDBACKVIEW_HEIGHT 100
#define HANDLEVIEW_SIDE 50

//  Animation
#define SHOW_NAVIFUNC_DELAY   0.9f
#define PAGECURL_DURATION   0.6f

// Bar Action
#define FONTRESIZE  0
#define SEARCH  1
#define ADDBOOKMARK    2

@interface ReadVC (){
    
    FeedBackView *feedbackView;
    UIView *handleView;
    UIInterfaceOrientation interOrtnFlag;
    NSString *curlType;
    BOOL    isClickUrl;
}

@property (weak, nonatomic) IBOutlet UIView *changeFontView;

- (IBAction)tapWebView:(id)sender;

- (void)tapWebViewWithOutUrl;

- (void)barShowOrHide;

- (void)drawHandle;

- (void)drawFeedbackView;

@end

@implementation ReadVC

@synthesize readWebView = _readWebView;
@synthesize editBar =_editBar;
@synthesize changeFontView = _changeFontView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self applicationCanRotation:YES];
    }
    return self;
}

#define TEST_HTML_PATH @"/Users/zhaochao/Library/Application Support/iPhone Simulator/7.0.3-64/Applications/A40BE93B-A8A9-47C7-BDA7-7F31809A071A/Documents/unZipFiles/BSC6900 UMTS 产品文档 V900R015C00/bsc6900-documents--new-15.0-ZH-app/SRAN(GUL)-Doc-Guide/zh-cn_topic_0001708472.html"

- (NSString *)URLEncodedString:(NSString*) url
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)url,
                                            (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                            NULL,
                                            kCFStringEncodingUTF8));
    return encodedString;
}

- (NSData *) toUTF8:(NSData *)sourceData
{
    CFStringRef gbkStr = CFStringCreateWithBytes(NULL, [sourceData bytes], [sourceData length], kCFStringEncodingGB_18030_2000, false);
    
    if (gbkStr == NULL) {
        return nil;
    }
    else
    {
        NSString *gbkString = (__bridge NSString *)gbkStr;
        
        NSString *utf8_string = [gbkString
                                 stringByReplacingOccurrencesOfString:@"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=gb2312\">"
                                 withString:@"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">"];
        
        return [utf8_string dataUsingEncoding:NSUTF8StringEncoding];
        
    }
}


- (void)viewDidLoad
{
    interOrtnFlag = self.interfaceOrientation;
    NSData *htmlData = [NSData dataWithContentsOfFile:_url];
    htmlData = [self toUTF8:htmlData];
    NSString *html = [[NSString alloc] initWithData:htmlData encoding:NSUTF8StringEncoding];
    NSURL*base = [NSURL fileURLWithPath:[_url stringByDeletingLastPathComponent]];
    
    NSLog(@"webview didload , base url is : %@", base);
    [_readWebView loadHTMLString:html baseURL:base];
    _editBar.alpha = 0.0f;
    
    _changeFontView.hidden = YES;
    
    [self drawFeedbackView];

    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    NSNotificationCenter *notifiCenter = [NSNotificationCenter defaultCenter];
    [notifiCenter addObserver:self selector:@selector(keyboardShow:)
                         name:UIKeyboardDidShowNotification object:nil];
    
    [notifiCenter addObserver:self selector:@selector(keyboardHidden:)
                         name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

# pragma mark 设置顶部导航栏及门把手

- (BaseNaviBar *)drawTopNaviBar{
    NormalNaviBar *readNaviBar = [[NormalNaviBar alloc]initWithDelegate:self HideBtn:None Title:@"阅读BTS3902E"];
    readNaviBar.alpha = 0.0f;
    readNaviBar.backgroundColor = [UIColor whiteColor];
    [readNaviBar.rightBtn setImage:[UIImage imageNamed:BOOKMARK_IMG] forState:UIControlStateNormal];
    return readNaviBar;
}

-(void)drawHandle{
    handleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HANDLEVIEW_SIDE, HANDLEVIEW_SIDE)];
    handleView.center = CGPointMake(25, SELF_VIEW_HEIGHT / 2);
    handleView.userInteractionEnabled = YES;
    handleView.backgroundColor = [UIColor blackColor];
    handleView.alpha = 0.5f;
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self
                                                                               action:@selector(swipeAction)];
    [handleView addGestureRecognizer:swipe];
    
    [self.view addSubview:handleView];
}

- (void)drawFeedbackView{
    feedbackView = [[[NSBundle mainBundle] loadNibNamed:@"FeedBackView"
                                                  owner:self options:nil]lastObject];
    feedbackView.hidden = YES;
    feedbackView.delegate = self;
    [self.view addSubview:feedbackView];
}

# pragma mark 按钮和手势

- (void)rightBtnAction{
    
}

-(void)leftBtnAction{
    [self applicationCanRotation:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:CHANGE_INTERTERFACEORIENTATION
                                                        object:[NSNumber numberWithInt:UIInterfaceOrientationPortrait]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)swipeAction{
    MenuBookmarkVC *menuBookmarkVC = [[MenuBookmarkVC alloc]init];
    menuBookmarkVC.view.frame = CGRectMake(0, 0, -SELF_VIEW_WIDTH, SELF_VIEW_HEIGHT);
    [self addChildViewController:menuBookmarkVC];
    [self.view addSubview:menuBookmarkVC.view];
    
    [UIView animateWithDuration:BASEANIMATION_DURATION animations:^{
        menuBookmarkVC.view.frame = CGRectMake(0, 0, SELF_VIEW_WIDTH, SELF_VIEW_HEIGHT);
    }];
}

# pragma mark 手势代理

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    isClickUrl = NO;
    
    return YES;
}

# pragma mark UIWebView 代理

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType{
    return isClickUrl = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
}

# pragma mark 底部和顶部Bar 隐藏和显示逻辑

- (IBAction)tapWebView:(id)sender {
    [self performSelector:@selector(tapWebViewWithOutUrl) withObject:nil afterDelay:SHOW_NAVIFUNC_DELAY];
}

- (void)tapWebViewWithOutUrl{
    if (!isClickUrl)
        [self barShowOrHide];
}

- (void)barShowOrHide{
    [UIView animateWithDuration:BASEANIMATION_DURATION animations:^{
        float showType[2] = {0.0f, 0.7f};
        BOOL isShow = !_editBar.alpha;
        _editBar.alpha = showType[isShow];
        self.naviBar.alpha = (double)!self.naviBar.alpha;
        _changeFontView.hidden = YES;
    }];
}

# pragma mark 翻页动画

-(IBAction)curlPage:(UIButton*)sender{

    curlType = sender.tag ? TRANSITION_TYPE_PAGECURL : TRANSITION_TYPE_PAGEUNCURL;
    
    [AnimationKit showTransitionByType:curlType
                               subType:TRANSITION_FROM_TOP
                              duration:PAGECURL_DURATION
                        timingFunction:TRANSITION_TIMING_DEFAULT
                               atLayer:_readWebView.layer
                            animations:^{
//                                [_readWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.cocoachina.com"]]];
                            }
                            completion:nil];
}

# pragma mark 底部Bar代理

# pragma mark 样式切换及功能按钮响应
- (void)FeedBackTextViewIsEdit:(BOOL)isEdit{
    _changeFontView.hidden = YES;
    
    handleView.hidden = isEdit;
}

- (IBAction)editAction:(UIButton *)sender {
    switch (sender.tag) {
        case FONTRESIZE:{
            _changeFontView.hidden = !_changeFontView.hidden;
        }
            break;
            
        case SEARCH:{
            
            [self barShowOrHide];
            
            ReadSearchVC *searchVC = [[ReadSearchVC alloc]initWithNibName:@"ReadSearchVC" bundle:nil];
            searchVC.delegate = self;
            searchVC.curDirection = interOrtnFlag;
            [self addChildViewController:searchVC];
            
            [AnimationKit showTransitionByType:TRANSITION_TYPE_PUSH
                                       subType:TRANSITION_FROM_TOP
                                      duration:BASEANIMATION_DURATION
                                timingFunction:TRANSITION_TIMING_EASEINEASEOUT
                                       atLayer:searchVC.view.layer
                                    animations:^{
                                        [self.view addSubview:searchVC.view];
                                    }];
        }
            break;
            
        case ADDBOOKMARK:{
            
        }
            break;
            
        default:
            break;
    }
}

# pragma mark 改变字体

- (IBAction)changeFont:(UISlider *)slider {
    NSString* changeFontJS =[NSString stringWithFormat:
                             @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%f%%'",slider.value];
    
    [_readWebView stringByEvaluatingJavaScriptFromString:changeFontJS];
}

# pragma mark 发送反馈信息

-(void)feedbackMessage:(NSString *)msg{
    if ([msg isEmptyOrNull]) {
        return;
    }
    
    FeedBackEmail *feedbackMail = [[FeedBackEmail alloc]initWithContent:msg Subject:@"信息反馈"];
    
    if (!feedbackMail.user.nickName) {
        UserSettingVC *userSettingVC = [[UserSettingVC alloc]initWithNibName:@"UserSettingVC" bundle:nil];
        [self presentViewController:userSettingVC animated:YES completion:nil];
        return;
    }
    
    [EmailSender sendMail:feedbackMail Delegate:self];
}

# pragma mark 邮件发送代理

-(void)messageSent:(SKPSMTPMessage *)message{
    NSLog(@"We Get It!!!");
}

-(void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error{
    NSLog(@"We Fuck That!!!");
}

# pragma mark 搜索代理

-(void)cancelSearch{
    [self barShowOrHide];
}

# pragma mark UITextView 代理

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    _changeFontView.hidden = YES;
    [textView resignFirstResponder];
    return YES;
}

- (void)keyboardShow:(NSNotification *)notifi{
    NSDictionary *notifiInfo = [notifi userInfo];
    CGSize keyboardSize = [[notifiInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    CGFloat keyboardHeight ,feedbackViewWidth;
    
    if (interOrtnFlag == UIInterfaceOrientationPortrait) {
        keyboardHeight = keyboardSize.height;
        feedbackViewWidth = SELF_VIEW_WIDTH;
    }else{
        keyboardHeight = keyboardSize.width;
        feedbackViewWidth = SCREEN_HEIGHT;
    }
    
    feedbackView.hidden = NO;
    feedbackView.frame = CGRectMake(0,
                                    SELF_VIEW_HEIGHT - keyboardHeight - FEEDBACKVIEW_HEIGHT,
                                    feedbackViewWidth,
                                    FEEDBACKVIEW_HEIGHT);
    [feedbackView.text becomeFirstResponder];
}

- (void)keyboardHidden:(NSNotification *)notifi{
    feedbackView.hidden = YES;
}

# pragma mark 横竖屏切换

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                               duration:(NSTimeInterval)duration
{
    interOrtnFlag = toInterfaceOrientation;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CHANGE_INTERTERFACEORIENTATION
                                                        object:[NSNumber numberWithInt:toInterfaceOrientation]];
    
}


@end

