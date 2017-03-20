//
//  MessageTableViewCell.m
//  PingHuoTuan
//
//  Created by 陈镇池 on 15/12/25.
//  Copyright © 2015年 athudong. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initMyCellView];
        
    }
    return self;
}

- (void)initMyCellView
{
    _label1 = [[UILabel alloc]initWithFrame:CGRectMake(11*Width, 10, MainScreenWidth-22*Width, 15)];
    _label1.font = [UIFont systemFontOfSize:15];
    
    _label1.textColor = RGB(50, 133, 199);
    [self addSubview:self.label1];
    
    _label2 = [[UILabel alloc]initWithFrame:CGRectMake(11*Width, height_y(_label1)+5, MainScreenWidth-22*Width, 10)];
//    _label2.textColor = RGB(138, 138, 138);
    [self addSubview:self.label2];
    
    _label3 = [[UILabel alloc]initWithFrame:CGRectMake(11*Width, height_y(_label2)+5, MainScreenWidth-22*Width, 12)];
   
    _label3.textColor = RGB(138, 138, 138);
    _label3.font = [UIFont systemFontOfSize:12];
    [self addSubview:_label3];
    
    line = [[UIView alloc]initWithFrame:CGRectMake(0, height_y(_label3)+10, MainScreenWidth, 1)];
    line.backgroundColor = RGB(238, 238, 238);
    [self addSubview:line];
    
    self.cellHeight = height_y(line);
    
}

- (void)setModel:(NewsModel *)model
{
    _label1.text = model.title;
    _label2.text = model.content;
    _label2.numberOfLines = 0;
    _label2.font = [UIFont systemFontOfSize:10];
    CGFloat height = [UILabel getLabelHeight:10 labelWidth:_label2.width content:_label2.text];
    _label2.height = height;
    
    _label3.y = height_y(_label2)+5;
     _label3.text = model.create_at;
    
    line.y = height_y(_label3)+10;
    
    self.cellHeight = height_y(line);
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
