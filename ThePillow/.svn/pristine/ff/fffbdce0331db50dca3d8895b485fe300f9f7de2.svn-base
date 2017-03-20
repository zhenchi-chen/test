//
//  UILabel+MyLabel.h
//  LanouCProject
//
//  Created by lanou on 15/8/21.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (MyLabel)

//声明计算label高度的方法
+(CGFloat)getLabelHeight:(CGFloat)wordSize labelWidth:(CGFloat)labelWidth content:(NSString *)content;

//自适应宽度
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;


//自适应高度
+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;

#pragma mark - 根据文字获取Label的实时大小
+(CGRect)getAttributedStringHeight:(NSString*)strDes andSpaceWidth:(CGFloat)fWidth andFont:(UIFont*)font;

@end
