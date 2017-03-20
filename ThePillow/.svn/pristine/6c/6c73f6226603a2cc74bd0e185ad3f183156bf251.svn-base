//
//  UITextFieldX.m
//  PingHuoTuan
//
//  Created by athudong04 on 15/12/10.
//  Copyright © 2015年 陈镇池. All rights reserved.
//

#import "UITextFieldX.h"

@implementation UITextFieldX

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,[self screenSize].width,30)];
    toolBar.barStyle = UIBarStyleDefault;
    
    UIButton *btnFinished = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 25)];
    [btnFinished setTitleColor:[self RGB:4 g:170 b:174] forState:UIControlStateNormal];
    [btnFinished setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [btnFinished setTitle:NSLocalizedString(@"replace_weight_fragment_yes",nil) forState:UIControlStateNormal];
    [btnFinished addTarget:self action:@selector(finishTapped:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithCustomView:btnFinished];
    
    UIView *space = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [self screenSize].width - btnFinished.frame.size.width - 30, 25)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:space];
    
    [toolBar setItems:@[item,item2] animated:YES];
    
    self.inputAccessoryView = toolBar;
}

-(void)finishTapped:(UIButton *)sender{
    [self resignFirstResponder];
}

-(CGSize)screenSize{
    return [UIScreen mainScreen].bounds.size;
}

-(UIColor *)RGB:(CGFloat)r g:(CGFloat)g b:(CGFloat)b{
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
}




@end
