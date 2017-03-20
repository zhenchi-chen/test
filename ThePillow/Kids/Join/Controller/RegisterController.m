//
//  RegisterController.m
//  PingHuoTuan
//
//  Created by athudong04 on 15/12/25.
//  Copyright © 2015年 丁小城. All rights reserved.
//

#import "RegisterController.h"
#import "UITextFieldX.h"
#import "LoginController.h"
#import "AddViewController.h"



@interface RegisterController ()<UITextFieldDelegate>


// 手机号
@property (nonatomic,strong) UITextField *phoneTxf;
// 验证码
@property (nonatomic,strong) UITextField *verifyCodeTxf;
// 密码
@property (nonatomic,strong) UITextField *passwordTxf;
// 注册
@property (nonatomic,strong) UIButton *registerBtn;

@end

@implementation RegisterController

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
            NSDictionary *dataDic = (NSDictionary *)baseModel.data;
            if (baseModel.code == 200) {
               
                NSMutableDictionary *saveDic = [NSMutableDictionary dictionary];
                [saveDic setValue:[dataDic objectForKey:@"username"] forKey:@"username"];
                [saveDic setValue:[dataDic objectForKey:@"token"] forKey:@"token"];
                [saveDic setValue:_passwordTxf.text forKey:@"userpassword"];
                [[ListTheCacheClass sharedManager]saveData:saveDic];
                
                kAppDelegate.window.rootViewController = kAppDelegate.nc2;
                [de setValue:@"1" forKey:@"bind_myTag"];

            }
        } else {
            
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_wrong_prompt", nil)];
        }
        
        
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MainColorWhite;
    
//    [self navSet:@"注册"];
    
    [self initView];
}

#pragma mark 初始化界面
-(void)initView{
    
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 64)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundView];
    
    UILabel *backgroundLb = [[UILabel alloc]initWithFrame:CGRectMake(MainScreenWidth/2-50, 34, 100,20)];
    backgroundLb.text = @"注册账号";
//    backgroundLb.textColor = RGB(178, 178, 178);
    backgroundLb.textAlignment = NSTextAlignmentCenter;
    backgroundLb.font = [UIFont systemFontOfSize:20];
    [backgroundView addSubview:backgroundLb];
    
    //返回按钮
    UIButton *returnBt = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBt.tag = 1;
    returnBt.frame = CGRectMake(5*Width, 30, 30, 30);
    [returnBt setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    [returnBt addTarget:self action:@selector(returnAction:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:returnBt];
    
    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(50*Width,height_y(backgroundView), MainScreenWidth-100*Width, 20*Height)];
    titleLb.text = @"注册账号";
    titleLb.font = [UIFont systemFontOfSize:20];
    titleLb.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:titleLb];
    
    
    
    UILabel *lbl_text = [[UILabel alloc]initWithFrame:CGRectMake(titleLb.x,height_y(backgroundView)+20*Height, titleLb.width, 20*Height)];
    lbl_text.font = [UIFont systemFontOfSize:12];
    lbl_text.textAlignment = NSTextAlignmentCenter;
    lbl_text.text = @"请输入用户名和密码\n用户名可以是手机号码或邮箱";
    lbl_text.numberOfLines = 0;//多行显示，计算高度
    lbl_text.textColor = RGB(178, 178, 178);
    CGFloat heightLb = [UILabel getLabelHeight:12 labelWidth:lbl_text.width content:lbl_text.text];
    lbl_text.height = heightLb;
    [self.view addSubview:lbl_text];
    
    // 手机号
    _phoneTxf = [[UITextField alloc] initWithFrame:CGRectMake(50*Width, height_y(lbl_text)+60*Height, MainScreenWidth-100*Width, 50)];
    _phoneTxf.placeholder = NSLocalizedString(@"login_fragment_hint", nil);
    _phoneTxf.clearsOnBeginEditing = YES;
    _phoneTxf.clearButtonMode = UITextFieldViewModeAlways;
    _phoneTxf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //提示居中
    _phoneTxf.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_phoneTxf];
    
    
    UIView  *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(_phoneTxf.x, height_y(_phoneTxf)-10, _phoneTxf.width, 1)];
    lineView1.backgroundColor = RGB(199, 199, 199);
    [self.view addSubview:lineView1];
    
    
    // 密码
    _passwordTxf = [[UITextField alloc] initWithFrame:CGRectMake(_phoneTxf.x, height_y(_phoneTxf), _phoneTxf.width, 50)];
    _passwordTxf.textColor = RGB(178, 178, 178);
    _passwordTxf.placeholder = NSLocalizedString(@"register_fragment_password_hint", nil);
    _passwordTxf.clearsOnBeginEditing = YES;
    _passwordTxf.clearButtonMode = UITextFieldViewModeAlways;
    _passwordTxf.secureTextEntry = YES;
    _passwordTxf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //提示居中
    _passwordTxf.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_passwordTxf];
    
    UIView  *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(_phoneTxf.x, height_y(_passwordTxf)-10, _phoneTxf.width, 1)];
    lineView2.backgroundColor = RGB(199, 199, 199);
    [self.view addSubview:lineView2];
    
    //注册观察者
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification"
                                              object:_passwordTxf];
    
   
    
    // 验证码
    _verifyCodeTxf = [[UITextField alloc] initWithFrame:CGRectMake(_passwordTxf.x, height_y(_passwordTxf), _passwordTxf.width, 50)];
    _verifyCodeTxf.tag = 5;
    _verifyCodeTxf.textColor = RGB(178, 178, 178);
    _verifyCodeTxf.placeholder = NSLocalizedString(@"register_fragment_password_again_hint", nil);
    _verifyCodeTxf.clearsOnBeginEditing = YES;
    _verifyCodeTxf.clearButtonMode = UITextFieldViewModeAlways;
    _verifyCodeTxf.secureTextEntry = YES;
    _verifyCodeTxf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //提示居中
    _verifyCodeTxf.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_verifyCodeTxf];
    
    
    UIView  *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(_phoneTxf.x, height_y(_verifyCodeTxf)-10, _phoneTxf.width, 1)];
    lineView3.backgroundColor = RGB(199, 199, 199);
    [self.view addSubview:lineView3];
  
    // 注册
    _registerBtn = [self buildBtn:NSLocalizedString(@"register_fragment_register", nil) action:@selector(returnAction:) frame:CGRectMake(100*Width, height_y(_verifyCodeTxf)+30*Height, MainScreenWidth-200*Width, 50)];
    _registerBtn.tag = 2;
    [self.view addSubview:_registerBtn];

    
/*
    
    // 获取验证码
    UIButton *getVerifyCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [getVerifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getVerifyCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    getVerifyCodeBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    getVerifyCodeBtn.layer.borderWidth = 1;
    getVerifyCodeBtn.layer.cornerRadius = 3;
    getVerifyCodeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:getVerifyCodeBtn];
    

    
     查看密码
    UIButton *viewPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [viewPwdBtn setImage:[UIImage imageNamed:@"106"] forState:UIControlStateNormal];
    [self.view addSubview:viewPwdBtn];
    
    
    // 同意协议
    UIButton *protocalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    protocalBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [protocalBtn setTitleColor:placeholderLabelColor forState:UIControlStateNormal];
    [protocalBtn setTitle:@"我已阅读并同意《拼货团协议》" forState:UIControlStateNormal];
//    [protocalBtn setImage:[UIImage imageNamed:@"104"] forState:UIControlStateNormal];
//    [protocalBtn setImage:[UIImage imageNamed:@"101"] forState:UIControlStateSelected];
    [protocalBtn addTarget:self action:@selector(protocalBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:protocalBtn];
    
 // 去登陆
 UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
 [loginBtn setTitle:@"已有账号，去登录" forState:UIControlStateNormal];
 [loginBtn setTitleColor:RGB(225, 7, 59) forState:UIControlStateNormal];
 loginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
 [loginBtn addTarget:self action:@selector(gotoLogin) forControlEvents:UIControlEventTouchUpInside];
 [self.view addSubview:loginBtn];

 
 
    */
    
}

#pragma mark 同意协议点击
-(void)protocalBtnTapped:(UIButton *)sender{
    sender.selected = !sender.selected;
    _registerBtn.enabled = sender.selected;
}

#pragma mark 去登录
-(void)gotoLogin{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)returnAction:(UIButton *)returnAction
{
    
    if (returnAction.tag == 1) {
        [GWNotification pushHandle:nil withName:@"更新设备列表"];
        // 返回上个页面
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if (returnAction.tag == 2) {
  
        if (![LoginAuthentication customValidateDetailedPhone:_phoneTxf.text] && ![LoginAuthentication validateEmail:_phoneTxf.text]) {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"register_fragment_warn_3", nil)];
            return;
        }
        if (![_passwordTxf.text isEqualToString:_verifyCodeTxf.text]) {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"register_fragment_warn_6", nil)];
            return;
        }
        if (_passwordTxf.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"register_fragment_warn_2", nil)];
            return;
        }
        if (_passwordTxf.text.length < 6) {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"register_fragment_warn_4", nil)];
            return;
        }
        
        HttpBaseRequestUtil *req = [[HttpBaseRequestUtil alloc] init];
        req.myDelegate = self;
        NSMutableDictionary *reqDic = [NSMutableDictionary dictionary];
        [reqDic setValue:@"第一页" forKey:@"api"];
        [reqDic setValue:_phoneTxf.text forKey:@"username"];
        [reqDic setValue:_passwordTxf.text forKey:@"password"];
        [req reqDataWithUrl:REGISTER reqDic:reqDic reqHeadDic:nil];
        
    }
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
