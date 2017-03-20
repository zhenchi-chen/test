//
//  AHRulerScrollView.m
//  Ruler
//
//  Created by 呜拉巴哈 on 16/2/1.
//  Copyright © 2016年 http://www.swiftnews.cn . All rights reserved.
//

#import "AHRulerScrollView.h"

@implementation AHRulerScrollView


- (void)setRulerValue:(CGFloat)rulerValue{
    _rulerValue = rulerValue;
}

- (void)drawRuler{
    _rulerAboutSpacing = 10;
    if (_rulerMin == 0) {
        _rulerAboutSpacing = 10;
    }else {
        _rulerAboutSpacing = _rulerAboutSpacing - _rulerMin*10;
    }
    
    CGMutablePathRef pathRef1 = CGPathCreateMutable();
    CGMutablePathRef pathRef2 = CGPathCreateMutable();
    
    CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
    shapeLayer1.lineWidth = 1.f;
    shapeLayer1.lineCap = kCALineCapButt;
    
    
    CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
    shapeLayer2.lineWidth = 1.f;
    shapeLayer2.lineCap = kCALineCapButt;
    
    if (_isRangingHeight) {
        shapeLayer1.strokeColor = [UIColor lightGrayColor].CGColor;
        shapeLayer1.fillColor = [UIColor clearColor].CGColor;
        shapeLayer2.strokeColor = [UIColor grayColor].CGColor;
        shapeLayer2.fillColor = [UIColor clearColor].CGColor;
    }else {
        shapeLayer1.strokeColor = [UIColor lightGrayColor].CGColor;
        shapeLayer1.fillColor = [UIColor clearColor].CGColor;
        shapeLayer2.strokeColor = [UIColor lightGrayColor].CGColor;
        shapeLayer2.fillColor = [UIColor clearColor].CGColor;
    }
    
    for (int i = 0; i <= self.rulerCount; i++) {
        UILabel *rule = [[UILabel alloc] init];
        if (_isText) {
            rule.textColor = MainColor;
        }else {
            rule.textColor = [UIColor clearColor];
        }
        rule.font = [UIFont systemFontOfSize:14];
        if (i * [self.rulerAverage floatValue]-10<0 || (i > _rulerCount-10)) {
            rule.text = @"";
        }else {
            rule.text = [NSString stringWithFormat:@"%.0f",i * [self.rulerAverage floatValue]-10];
        }
        
        CGSize textSize = [rule.text sizeWithAttributes:@{ NSFontAttributeName : rule.font }];
        if (i % 10 == 0) {
            if (_isRangingHeight) {
                CGPathMoveToPoint(pathRef2, NULL, _rulerAboutSpacing + DISTANCEVALUE * i , _distanceTopAndBottom);
                CGPathAddLineToPoint(pathRef2, NULL, _rulerAboutSpacing + DISTANCEVALUE * i, self.rulerHeight - _distanceTopAndBottom - textSize.height - 25);
            }else {
                CGPathMoveToPoint(pathRef2, NULL, _rulerAboutSpacing + DISTANCEVALUE * i , _distanceTopAndBottom);
                CGPathAddLineToPoint(pathRef2, NULL, _rulerAboutSpacing + DISTANCEVALUE * i, self.rulerHeight - _distanceTopAndBottom - textSize.height);
            }
            rule.frame = CGRectMake(_rulerAboutSpacing + DISTANCEVALUE * i - textSize.width / 2, self.rulerHeight - _distanceTopAndBottom - textSize.height-25, 0, 0);
            [rule sizeToFit];
            [self addSubview:rule];
            
        }else if (i % 5 == 0) {
            if (_isRangingHeight) {
                CGPathMoveToPoint(pathRef1, NULL, _rulerAboutSpacing + DISTANCEVALUE * i , _distanceTopAndBottom);
                CGPathAddLineToPoint(pathRef1, NULL, _rulerAboutSpacing + DISTANCEVALUE * i, self.rulerHeight - _distanceTopAndBottom - textSize.height - 35);
            }else {
                CGPathMoveToPoint(pathRef1, NULL, _rulerAboutSpacing + DISTANCEVALUE * i , _distanceTopAndBottom);
                CGPathAddLineToPoint(pathRef1, NULL, _rulerAboutSpacing + DISTANCEVALUE * i, self.rulerHeight - _distanceTopAndBottom - textSize.height);
            }
            
        }else{
            if (_isRangingHeight) {
                CGPathMoveToPoint(pathRef1, NULL, _rulerAboutSpacing + DISTANCEVALUE * i , _distanceTopAndBottom);
                CGPathAddLineToPoint(pathRef1, NULL, _rulerAboutSpacing + DISTANCEVALUE * i, self.rulerHeight - _distanceTopAndBottom - textSize.height - 40);
            }else {
                CGPathMoveToPoint(pathRef1, NULL, _rulerAboutSpacing + DISTANCEVALUE * i , _distanceTopAndBottom);
                CGPathAddLineToPoint(pathRef1, NULL, _rulerAboutSpacing + DISTANCEVALUE * i, self.rulerHeight - _distanceTopAndBottom - textSize.height);
                
            }
        }
    }
    
    
    
    shapeLayer1.path = pathRef1;
    shapeLayer2.path = pathRef2;
    
    [self.layer addSublayer:shapeLayer1];
    [self.layer addSublayer:shapeLayer2];
    
    self.frame = CGRectMake(0, 0, self.rulerWidth, self.rulerHeight);

    
    // 开启最小模式
    if (_mode) {
//        UIEdgeInsets edge = UIEdgeInsetsMake(0, 0, 0, self.rulerWidth / 2.f - _rulerAboutSpacing);
        UIEdgeInsets edge = UIEdgeInsetsMake(0, 0, 0, 0);
        self.contentInset = edge;
        self.contentOffset = CGPointMake(DISTANCEVALUE * (self.rulerValue / [self.rulerAverage floatValue]) - self.rulerWidth + (self.rulerWidth / 2.f + _rulerAboutSpacing), 0);
    }
    else{
        self.contentOffset = CGPointMake(DISTANCEVALUE * (self.rulerValue / [self.rulerAverage floatValue]) - self.rulerWidth / 2.f + _rulerAboutSpacing, 0);
    }
    
    self.contentSize = CGSizeMake(self.rulerCount * DISTANCEVALUE + _rulerAboutSpacing * 2.f, self.rulerHeight);
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
