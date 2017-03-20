//
//  LoginCustomView.m
//  GOSPEL
//
//  Created by 陈镇池 on 16/5/18.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import "LoginCustomView.h"

@implementation LoginCustomView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        
        _myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 55*Width, height)];
        _myImageView.image = [UIImage imageNamed:@"land_1"];
        [self addSubview:_myImageView];
        
        
        _backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(60*Width, 0, width-60*Width, height)];
        _backgroundImageView.image = [UIImage imageNamed:@"land_2"];
        _backgroundImageView.userInteractionEnabled = YES;
        [self addSubview:_backgroundImageView];
        
        self.myTextField = [[UITextField alloc]initWithFrame:CGRectMake(5, 0, _backgroundImageView.width-5, height)];
        self.myTextField.clearsOnBeginEditing = YES;
        self.myTextField.clearButtonMode = UITextFieldViewModeAlways;
        [_backgroundImageView addSubview:self.myTextField];
        self.myTextField.delegate = self;
      
    }
    return self;
}

//键盘回收
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
