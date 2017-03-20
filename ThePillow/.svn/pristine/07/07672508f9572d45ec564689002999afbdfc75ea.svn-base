//
//  UILabel+MyLabel.m
//  LanouCProject
//
//  Created by lanou on 15/8/21.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "UILabel+MyLabel.h"

@implementation UILabel (MyLabel)

//实现计算lable高度的方法
+(CGFloat)getLabelHeight:(CGFloat)wordSize labelWidth:(CGFloat)labelWidth content:(NSString *)content
{
    
    //1写一个cgsize
    CGSize size = CGSizeMake(labelWidth,10000);
    //定义一个字典
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:wordSize] forKey:NSFontAttributeName];
    
    
    //计算高度
    CGRect rect = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    return rect.size.height;
}

//自适应宽度
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    return label.frame.size.height;
}

//自适应高度
+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}


#pragma mark - 根据文字获取Label的实时大小
+(CGRect)getAttributedStringHeight:(NSString*)strDes andSpaceWidth:(CGFloat)fWidth andFont:(UIFont*)font
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithData:[strDes dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    [attributedString addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                     font,
                                     NSFontAttributeName,
                                     [UIColor grayColor],
                                     NSForegroundColorAttributeName,nil]
                              range:NSMakeRange(0, attributedString.length)];
    
    UITextView *temp = [[UITextView alloc]initWithFrame:CGRectMake(100.0f, 100.0f, [UIScreen mainScreen].bounds.size.width - fWidth, 1)];
    [temp setBackgroundColor:[UIColor whiteColor]];
    temp.textColor = [UIColor grayColor];
    temp.font = font;
    [temp setEditable:NO];
    [temp setScrollEnabled:NO];
    temp.attributedText = attributedString;
    // 计算 text view 的高度
    CGRect textSize;
    textSize = temp.bounds;
    // 计算 text view 的高度
    CGSize maxSize=CGSizeMake(textSize.size.width,CGFLOAT_MAX);
    CGSize newSize1=[temp sizeThatFits:maxSize];
    textSize.size = newSize1;
    //XNLog(@"%f",temp.contentSize.height);
    return textSize;
}

@end
