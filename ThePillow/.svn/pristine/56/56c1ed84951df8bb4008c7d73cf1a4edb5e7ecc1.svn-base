//
//  ResetPasswordController.m
//  PingHuoTuan
//
//  Created by athudong04 on 15/12/25.
//  Copyright © 2015年 丁小城. All rights reserved.
//

#import "ResetPasswordController.h"
#import "UITextFieldX.h"

@interface ResetPasswordController ()<UITextFieldDelegate>

// 手机号
@property (nonatomic,strong) UITextField *phoneTxf;
// 验证码
@property (nonatomic,strong) UITextField *verifyCodeTxf;
// 密码
@property (nonatomic,strong) UITextField *passwordTxf;
// 重置
@property (nonatomic,strong) UIButton *resetBtn;


@end

@implementation ResetPasswordController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:@"UITextFieldTextDidChangeNotification"
                                                 object:_passwordTxf];
}

#pragma 网络数据返回
-(void)httpBaseRequestUtilDelegate:(NSData *)data api:(NSString *)api reqDic:(NSMutableDictionary *)reqDic reqHeadDic:(NSMutableDictionary *)reqHeadDic rspHeadDic:(NSMutableDictionary *)rspHeadDic{
    if ([api isEqualToString:@"第一页"]) {
        if (data != nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"dic = %@",dic);
            BaseDataModel *baseModel = [BaseDataModel objectWithKeyValues:dic];
            if (baseModel.code == 200) {
                [SVProgressHUD showSuccessWithStatus:@"恭喜你,重置密码成功!"];
                sleep(0.5);
                [self dismissViewControllerAnimated:YES completion:^{
                }];
            } 
        } else {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_wrong_prompt", nil)];
        }
        
        
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGB(243, 244, 246);

    [self initView];
}

#pragma mark 初始化界面
-(void)initView{
    
    
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 64)];
    backgroundView.backgroundColor = RGB(77, 207, 199);
    [self.view addSubview:backgroundView];
    
    UILabel *backgroundLb = [[UILabel alloc]initWithFrame:CGRectMake(MainScreenWidth/2-50, 34, 100,20)];
    backgroundLb.text = @"忘记密码";
    backgroundLb.textColor = [UIColor whiteColor];
    backgroundLb.textAlignment = NSTextAlignmentCenter;
    backgroundLb.font = [UIFont systemFontOfSize:20];
    [backgroundView addSubview:backgroundLb];
    //返回按钮
    UIButton *returnBt = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBt.frame = CGRectMake(5*Width, 30, 30, 30);
    [returnBt setImage:[UIImage imageNamed:@"return_1"] forState:UIControlStateNormal];
    [returnBt addTarget:self action:@selector(returnAction1:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:returnBt];

    UIView *backgroundView1 = [[UIView alloc]initWithFrame:CGRectMake(0, height_y(backgroundView)+19, MainScreenWidth, 49)];
    backgroundView1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundView1];
    // 手机号
    _phoneTxf = [[UITextField alloc] initWithFrame:CGRectMake(14*Width, 0, MainScreenWidth-14*Width, 49)];
    _phoneTxf.placeholder = @"请输入用户名手机/邮箱";
    _phoneTxf.clearsOnBeginEditing = YES;
    _phoneTxf.clearButtonMode = UITextFieldViewModeAlways;
    [backgroundView1 addSubview:_phoneTxf];
    
    
    UIView *backgroundView2 = [[UIView alloc]initWithFrame:CGRectMake(0, height_y(backgroundView1)+1, MainScreenWidth, 49)];
    backgroundView2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundView2];
    
    
    // 验证码
    _verifyCodeTxf = [[UITextField alloc] initWithFrame:CGRectMake(14*Width, 0, MainScreenWidth-100*Width, 49)];
    _verifyCodeTxf.tag = 5;
    _verifyCodeTxf.textColor = RGB(178, 178, 178);
    _verifyCodeTxf.placeholder = @"请输入验证码";
    _verifyCodeTxf.clearsOnBeginEditing = YES;
    _verifyCodeTxf.clearButtonMode = UITextFieldViewModeAlways;
    _verifyCodeTxf.secureTextEntry = YES;
    [backgroundView2 addSubview:_verifyCodeTxf];
    
    
    // 获取验证码
    UIButton *getVerifyCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    getVerifyCodeBtn.frame = CGRectMake(width_x(_verifyCodeTxf), 9, 80*Width, 27);
    [getVerifyCodeBtn setBackgroundImage:[UIImage imageNamed:@"verification_1"] forState:UIControlStateNormal];
    [getVerifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    getVerifyCodeBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [getVerifyCodeBtn addTarget:self action:@selector(getVerificationCode) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView2 addSubview:getVerifyCodeBtn];
    
    
    UIView *backgroundView3 = [[UIView alloc]initWithFrame:CGRectMake(0, height_y(backgroundView2)+1, MainScreenWidth, 49)];
    backgroundView3.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundView3];
    
    // 密码
    _passwordTxf = [[UITextField alloc] initWithFrame:CGRectMake(14*Width, 0, MainScreenWidth-14*Width, 49)];
    _passwordTxf.textColor = RGB(178, 178, 178);
    _passwordTxf.placeholder = @"请输入6-20位登录密码";
    _passwordTxf.clearsOnBeginEditing = YES;
    _passwordTxf.clearButtonMode = UITextFieldViewModeAlways;
    _passwordTxf.secureTextEntry = YES;
    [backgroundView3 addSubview:_passwordTxf];
    
    //注册观察者
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification"
                                              object:_passwordTxf];


    // 重置
    _resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _resetBtn.frame = CGRectMake(14*Width, height_y(backgroundView3)+21, MainScreenWidth-28*Width, 45);
    [_resetBtn setBackgroundImage:[UIImage imageNamed:@"button_1"] forState:UIControlStateNormal];
    [_resetBtn setTitle:@"重置密码" forState:UIControlStateNormal];
    _resetBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [_resetBtn addTarget:self action:@selector(resetBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_resetBtn];

    
    /*
    // 注册
    _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _registerBtn.frame = CGRectMake(14*Width, height_y(backgroundView3)+21, MainScreenWidth-28*Width, 45);
    _registerBtn.tag = 2;
    [_registerBtn setBackgroundImage:[UIImage imageNamed:@"button_1"] forState:UIControlStateNormal];
    [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    _registerBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [_registerBtn addTarget:self action:@selector(returnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registerBtn];
    

    
    
    
    
    
    // 分割线
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:line];
    
    
    // 验证码
    _verifyCodeTxf = (UITextField *)[_phoneTxf duplicate];
    _verifyCodeTxf.placeholder = @"请输入验证码";
    [_verifyCodeTxf setValue:placeholderLabelColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:_verifyCodeTxf];
    
    
    // 分割线
    UIView *line2 = [line duplicate];
    [self.view addSubview:line2];
    
    // 密码
    _passwordTxf = (UITextField *)[_phoneTxf duplicate];
    _passwordTxf.placeholder = @"请输入6-20位登录密码";
    [_passwordTxf setValue:placeholderLabelColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:_passwordTxf];
    
    
    // 查看密码
    UIButton *viewPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [viewPwdBtn setImage:[UIImage imageNamed:@"106"] forState:UIControlStateNormal];
    [self.view addSubview:viewPwdBtn];
    
    // 分割线
    UIView *line3 = [line duplicate];
    [self.view addSubview:line3];
    
    
    // 重置
    _resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_resetBtn setBackgroundImage:RGB(225, 7, 59).image forState:UIControlStateNormal];
    [_resetBtn setTitle:@"重置密码" forState:UIControlStateNormal];
    _resetBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _resetBtn.layer.cornerRadius = 3;
    _resetBtn.clipsToBounds = YES;
    [_resetBtn addTarget:self action:@selector(resetBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_resetBtn];
     */
    
}

#pragma mark 获取验证码
- (void)getVerificationCode
{
    
}


#pragma mark 重置密码
-(void)resetBtnTapped{
    
    if (_passwordTxf.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"密码不能为空,请重新输入"];
        return;
    }
    if (_passwordTxf.text.length < 6) {
        [SVProgressHUD showErrorWithStatus:@"密码长度要大于6位数,请重新输入"];
        return;
    }

    HttpBaseRequestUtil *req = [[HttpBaseRequestUtil alloc] init];
    req.myDelegate = self;
    NSMutableDictionary *reqDic = [NSMutableDictionary dictionary];
    [reqDic setValue:@"第一页" forKey:@"api"];
    [reqDic setValue:_phoneTxf.text forKey:@"username"];
    [reqDic setValue:_passwordTxf.text forKey:@"token"];
    [req reqDataWithUrl:FORGET_PASSWORD reqDic:reqDic reqHeadDic:nil];

}

-(void)returnAction1:(UIButton *)returnAction
{
    // 返回上个页面
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark 限制密码长度
-(void)textFiledEditChanged:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;
    
    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > kMaxLength) {
                textField.text = [toBeString substringToIndex:kMaxLength];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > kMaxLength) {
            textField.text = [toBeString substringToIndex:kMaxLength];
        }
    }
}


@end
