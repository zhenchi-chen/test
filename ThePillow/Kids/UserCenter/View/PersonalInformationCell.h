//
//  PersonalInformationCell.h
//  GOSPEL
//
//  Created by 陈镇池 on 16/6/28.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalInformationCell : UITableViewCell

@property (nonatomic,strong)UILabel *titleLb;
@property (nonatomic,strong)UILabel *contentLb;
@property (nonatomic,strong)UIImageView *iconIV;

@property (nonatomic,assign)CGFloat cellHeight;

@end
