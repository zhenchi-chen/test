//
//  CardChartView.h
//  KIDS
//
//  Created by 陈镇池 on 16/8/12.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KIDS-Bridging-Header.h"

@interface CardChartView : UIView

@property (nonatomic,strong)UILabel *titleLb; //标题
@property (strong,nonatomic)LineChartView *lineChartView; //线状图
@property (nonatomic, strong)CandleStickChartView *barChartView; //柱状图
@property (nonatomic,strong)UILabel *maxLb; //最高
@property (nonatomic,strong)UILabel *minLb; //最低
@property (nonatomic,strong)UILabel *midLb; //平均
@property (nonatomic,strong)UILabel *hrMaxLb; //最高
@property (nonatomic,strong)UILabel *hrMinLb; //最低
@property (nonatomic,strong)UILabel *averageLb; //平均


@end
