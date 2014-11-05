//
//  UserSettingVC.m
//  HWReader
//
//  Created by LPanda on 14-8-18.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "UserSettingVC.h"
#import "NormalNaviBar.h"

#define CHECKEMAILFORMAT_REGULAR    @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"

@interface UserSettingVC (){
    BOOL    hasBeenEdit;
    NSString    *error;
}

@property (weak, nonatomic) IBOutlet UITextField *nickNameTF;
@property (weak, nonatomic) IBOutlet UITextField *emailTF;

- (BOOL)errorFormat;

- (BOOL)errorEmailFormat;

@end

@implementation UserSettingVC

@synthesize nickNameTF;
@synthesize emailTF;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    nickNameTF.returnKeyType = UIReturnKeyNext;
    nickNameTF.placeholder = [userDefaults objectForKey:USERNICKNAME];
    
    emailTF.returnKeyType = UIReturnKeyDone;
    emailTF.placeholder = [userDefaults objectForKey:USERRECEIVEADDR];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)drawTopNaviBar{
    NormalNaviBar *userSettingNaviBar = [[NormalNaviBar alloc]
                                         initWithDelegate:self HideBtn:Right Title:@"用户信息设置"];
    [self.view addSubview:userSettingNaviBar];
}

-(void)leftBtnAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

# pragma mark 格式检查

-(BOOL)errorFormat{
    
    if ([nickNameTF.text isEmptyOrNull] && [emailTF.text isEmptyOrNull]) {
        error = @"昵称或邮箱不能为空";
        return YES;
    }
    
    if ([self errorEmailFormat]) {
        error = @"邮箱格式不正确";
        return YES;
    }
    
    return NO;
}

-(BOOL)errorEmailFormat{
    NSString *emailRegex = CHECKEMAILFORMAT_REGULAR;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return ![emailTest evaluateWithObject:emailTF.text];
}

# pragma mark UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == nickNameTF) {
        [emailTF becomeFirstResponder];
        return YES;
    }
    
    [emailTF resignFirstResponder];
    
    if (hasBeenEdit) {
        hasBeenEdit = NO;
        if ([self errorFormat]) {
            SHOWALERTVIEW(@"提示", error, nil, @"确定", nil);
            return YES;
        }
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:nickNameTF.text forKey:USERNICKNAME];
            [userDefaults setObject:emailTF.text forKey:USERRECEIVEADDR];
            [userDefaults synchronize];
            SHOWALERTVIEW(@"提示", @"用户信息保存成功", nil, @"确定", nil);
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    return hasBeenEdit = YES;
}


@end
