//
//  SnoreAuxiliaryCell.m
//  Kids
//
//  Created by 陈镇池 on 2016/12/14.
//  Copyright © 2016年 chen_zhenchi_lehu. All rights reserved.
//

#import "SnoreAuxiliaryCell.h"

@implementation SnoreAuxiliaryCell



#pragma -mark代码创建cell的时候执行的方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //初始化的代码
        [self layoutCell];
    }
    
    return self;
}

#pragma -mark对cell进行排版的方法
-(void)layoutCell
{
    
    //标题
    self.nameLb = [[UILabel alloc]initWithFrame:CGRectMake(40*Width, 20, MainScreenWidth/3, 20)];
    //    self.nameLabel.backgroundColor = [UIColor brownColor];
    _nameLb.textColor = MainColorDarkGrey;
    [self.contentView addSubview:self.nameLb];
    
    //图片
    self.photoIV = [[UIImageView alloc]initWithFrame:CGRectMake(MainScreenWidth -20*Width -20, 20, 20, 20)];
    _photoIV.centerY = _nameLb.centerY;
    [self.contentView addSubview:self.photoIV];

}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
