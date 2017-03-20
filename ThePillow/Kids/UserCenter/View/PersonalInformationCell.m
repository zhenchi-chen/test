//
//  PersonalInformationCell.m
//  GOSPEL
//
//  Created by 陈镇池 on 16/6/28.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import "PersonalInformationCell.h"

@implementation PersonalInformationCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initMyCellView];
        
    }
    return self;
}

- (void)initMyCellView
{
    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(11*Width, 0, 80, 49)];
//    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = RGB(138, 138, 138);
    [self addSubview:self.titleLb];
    
    _iconIV = [[UIImageView alloc]initWithFrame:CGRectMake(MainScreenWidth-25, 16, 18, 18)];
    _iconIV.image = [UIImage imageNamed:@"return_2"];
    [self addSubview:_iconIV];
    
    _contentLb = [[UILabel alloc]initWithFrame:CGRectMake(width_x(_titleLb), 0, MainScreenWidth-35-11*Width-_titleLb.width, _titleLb.height)];
    _contentLb.textColor = RGB(138, 138, 138);
    _contentLb.textAlignment = NSTextAlignmentRight;
//    _contentLb.font = [UIFont systemFontOfSize:15];
    _contentLb.text = NSLocalizedString(@"personal_fragment_none",nil);
    [self addSubview:self.contentLb];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 49, MainScreenWidth, 1)];
    line.backgroundColor = RGB(238, 238, 238);
    [self addSubview:line];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
