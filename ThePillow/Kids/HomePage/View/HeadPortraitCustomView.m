//
//  HeadPortraitCustomView.m
//  GOSPEL
//
//  Created by 陈镇池 on 16/5/31.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import "HeadPortraitCustomView.h"

@implementation HeadPortraitCustomView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        
        _headIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, width)];
        [self addSubview:_headIV];
        
        _messageLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width/4, width/4)];
        _messageLb.center = CGPointMake(width-width/8, width/6);
        _messageLb.textAlignment = NSTextAlignmentCenter;
        _messageLb.font = [UIFont systemFontOfSize:8];
        _messageLb.backgroundColor = [UIColor redColor];
        _messageLb.layer.borderColor = [[UIColor whiteColor]CGColor];;
        _messageLb.layer.borderWidth = 1;
        _messageLb.layer.cornerRadius = (width/4)/2;
        _messageLb.clipsToBounds = YES;
//        [self addSubview:self.messageLb];
        
        _nameLB = [[UILabel alloc]initWithFrame:CGRectMake(0, height_y(_headIV)+3, width, height-_headIV.height-3)];
        _nameLB.textAlignment = NSTextAlignmentCenter;
        _nameLB.font = [UIFont systemFontOfSize:10];
        _nameLB.backgroundColor = [UIColor whiteColor];
        _nameLB.layer.borderColor = [RGB(238, 238, 238)CGColor];
        _nameLB.layer.borderWidth = 1;
        _nameLB.layer.cornerRadius = (height-_headIV.height-3)/2;
        _nameLB.clipsToBounds = YES;
        [self addSubview:self.nameLB];
        
        
    }
    return self;
}

@end
