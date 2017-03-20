//
//  DetailViewController.m
//  GOSPEL
//
//  Created by 陈镇池 on 16/5/19.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import "DetailViewController.h"
#import "LoginController.h"
#import "DetailDataModel.h"
#import "EnvModel.h"
#import "ItemsModel.h"
#import "StatusModel.h"
#import "DataUtil.h"
#import "UploadFile1.h"
#import "LFCGzipUtility.h"
#import "SwitchingDeviceController.h"
#import "AboutViewController.h"
#import "DetailTableViewCell.h"
#import "SignsStatisViewController.h"
#import "ClockTimeBluetoothModel.h"
#import "SleepStatus.h"
#import "CardChartView.h"
#import "STPickerDate.h"

@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource,STPickerDateDelegate>
{
   
    UIView *headerView; //头部的View

    
    UILabel *averageScHrLb; //心率平均分
    UILabel *hrScMaxLb; //心率最高值
    UILabel *hrScMinLb; //心率最低值
    
    UIView *snoringTime;
    UILabel *snoringTimeTextLb; //打鼾时长
    UILabel *snoringTimeUnitLb; //打鼾单位
    UILabel *snoringTimeExplainLb; //打鼾说明
    UIView *line1;
    
    UIView *antiSnore; //止鼾
    UILabel *antiSnoreNumLb; //止鼾次数
    UILabel *antiSnoreUnitLb; //止鼾单位
    UILabel *antiSnoreExplainLb; //止鼾说明
    UIView *line2;
    
    UIView *AQI; //空气质量
    UILabel *oxygenSiaeLb; //氧气含量
    UILabel *oxygenNumLb; //氧气含量
    UILabel *oxygenUnitLb; //氧气单位
    UILabel *oxygenExplainLb; //氧气说明
    UIView *line3;
    
    UIView *line4;

    
    BluetoothOrder *bluetoothOrder; //蓝牙助手
    
    
    int stateWork; //1,同步 2,同步完成 3,同步失败 0,蓝牙断开
    
    UIImageView *photoIv; //头像
    UILabel *nameLb; //名字
    UILabel *deviceStatusLb; //设备状态
    NSInteger isWindow; //第几个窗口
    UIView *windowView; //弹窗

    UILabel *statusLb; //状态
    UILabel *heartRateLb; //心率
    UILabel *breatheLb; //呼吸
    
    DetailDataModel *detailModrel;
    DidInfoModel *didInfoModel;
    UserInfoModel *userInfoModel;
    Clock *clock;
    
    NSString *dateStr; //请求日期
    
   
    UIView *backgroundView; //弹窗底色
  

    int chooseAvatarNum; //你点击的图片
    
    int peripheralTimerNum; //寻找自己的蓝牙设备
    
    BOOL isHome; //是否是返回的主页
    
    BOOL isChangeHome; //是否改变主页
    
   
    
}

@property(nonatomic,strong) UIButton *scrollViewSelectedItem; //导航按钮,日,周,月报告
@property (nonatomic,strong)NSMutableArray *btArray; //导航按钮数组

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *itemsArray; //items数组
@property (assign,nonatomic)BOOL isConnectedDevices; //是否连接设备,0关闭,1打开
@property (nonatomic,assign)NSInteger power; //电量
@property (strong ,nonatomic)NSMutableArray *dataArr; //数据库拿出来的数据

//文件上传名字
@property (strong,nonatomic)NSString *textName; //加后缀文件名
@property (strong,nonatomic)NSString *textNameTail; //不加后缀文件名

@property (nonatomic,strong)NSMutableArray *listDidArr; //上传备份的did

@property (nonatomic,strong)NSMutableArray *clockTimeAllArray; //所有单个闹钟数组

@property (nonatomic,assign)__block int clockNumber; //设置下位机的闹钟个数




@end

@implementation DetailViewController


#pragma 网络数据返回
-(void)httpBaseRequestUtilDelegate:(NSData *)data api:(NSString *)api reqDic:(NSMutableDictionary *)reqDic reqHeadDic:(NSMutableDictionary *)reqHeadDic rspHeadDic:(NSMutableDictionary *)rspHeadDic{
    if ([api isEqualToString:@"第一页"]) {
        if (data != nil) {
            if (_itemsArray != nil) {
                [_itemsArray removeAllObjects];
            }else {
               _itemsArray = [NSMutableArray array];
            }
          
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
           
//            NSString * myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//            NSLog(@"dicmyString = %@",myString);
            BaseDataModel *baseModel = [BaseDataModel objectWithKeyValues:dic];
            if (baseModel.code == 200) {
                if (baseModel.data != nil) {
                    NSString * myString = [GWNSStringUtil convertToJSONString:(NSDictionary *)baseModel.data];
                    NSLog(@"data = %@",myString);
                    NSDictionary *dic = [GWNSStringUtil dictionaryToJsonString:myString];
//                    NSLog(@"dic = %@",dic);
                    
                    DeviceDataCacheModel *deviceDataCacheModel1 =[[[DeviceDataCacheTool alloc]init]queryDeviceDataCacheShowModelDevice:deviceModel.did andTime:dateStr];
                   
                    if (deviceDataCacheModel1.data == nil) {
                        DeviceDataCacheModel *deviceDataCacheModel2 = [[DeviceDataCacheModel alloc]init];
                        deviceDataCacheModel2.time = dateStr;
                        deviceDataCacheModel2.data = myString;
                        deviceDataCacheModel2.isVariable = 0;
                        deviceDataCacheModel2.deviceId = deviceModel.did;
//                        NSLog(@"tiem = %@,did = %@",dateStr,deviceModel.did);
                        [[[DeviceDataCacheTool alloc]init]insertDeviceDataCache:deviceDataCacheModel2];
                    }else {
                        if (![myString isEqualToString:deviceDataCacheModel1.data]){
                            [[[DeviceDataCacheTool alloc]init]updateDataDeviceId:deviceModel.did andChangeTime:dateStr andName:@"data" andData:myString];
                        }
                    }
                    
                    
                    detailModrel = [DetailDataModel objectWithKeyValues:(NSDictionary *)baseModel.data];
                    
                    
                    if (detailModrel.items != nil) {
                        for (NSDictionary *tempDic in detailModrel.items) {
                            ItemsModel *itemsModel = [ItemsModel objectWithKeyValues:tempDic];
                            [_itemsArray addObject:itemsModel];
                        }
                    }

                    //测试填充数据
                    [self headerViewFill];
                
                    [_tableView headerEndRefreshing];
    
                } else {
                    [_tableView headerEndRefreshing];
                    [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"detail_fragment_chart_no_data", nil)];
                }
            }else {
                [_tableView headerEndRefreshing]; //让下拉刷新控件消失
            }
        } else {
            [_tableView headerEndRefreshing];
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_wrong_prompt", nil)];
        }
        
        
    }

    for (int i = 0; i<_listDidArr.count; i++) {
        if ([api isEqualToString:_listDidArr[i]]) {
            if (data != nil) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                
//                NSString * myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                NSLog(@"dicmyString = %@",myString);
                BaseDataModel *baseModel = [BaseDataModel objectWithKeyValues:dic];
                if (baseModel.code == 200) {
                    
                    [[[DeviceListTool alloc]init]updateDataDevice:api andChangeName:@"isServer" andChange:@"1"];
                }
            } else {
                [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_wrong_prompt", nil)];
            }
        }
    }
    }


#pragma mark 请求图表网络数据
- (void)initDataDate:(NSString *)date{
    
    
    DeviceDataCacheModel *deviceDataCacheModel1 =[[[DeviceDataCacheTool alloc]init]queryDeviceDataCacheShowModelDevice:deviceModel.did andTime:date];
    if (deviceDataCacheModel1 != nil) {
        if (_itemsArray != nil) {
            [_itemsArray removeAllObjects];
        }else {
            _itemsArray = [NSMutableArray array];
        }
        detailModrel = [DetailDataModel objectWithKeyValues:[GWNSStringUtil dictionaryToJsonString:deviceDataCacheModel1.data]];
        if (detailModrel.items != nil) {
            for (NSDictionary *tempDic in detailModrel.items) {
                ItemsModel *itemsModel = [ItemsModel objectWithKeyValues:tempDic];
                [_itemsArray addObject:itemsModel];
            }
        }
        //测试填充数据
        [self headerViewFill];
        
        [_tableView headerEndRefreshing];
    }
    
    
    
    
    
    

    
    dateStr = date;
//    NSLog(@"date = %@",date);
    HttpBaseRequestUtil *req = [[HttpBaseRequestUtil alloc] init];
    req.myDelegate = self;
    NSMutableDictionary *reqDic = [NSMutableDictionary dictionary];
    [reqDic setValue:@"第一页" forKey:@"api"];
    [reqDic setValue:deviceModel.did forKey:@"deviceID"];
    [reqDic setValue:date forKey:@"date"];
    [reqDic setValue:[de valueForKey:@"username"] forKey:@"username"];
    [reqDic setValue:[de valueForKey:@"token"] forKey:@"token"];
    [req reqDataWithUrl:DAILY reqDic:reqDic reqHeadDic:nil];

}





#pragma mark 头部View填充
- (void)headerViewFill {
    
    //打鼾时间
    if (detailModrel.snore.length > 0) {
        snoringTimeTextLb.text = detailModrel.snore;
    }else {
        snoringTimeTextLb.text = @"--";
    }
    [snoringTimeTextLb sizeToFit];
    
    snoringTimeUnitLb.textColor = MainColorWhite;
    snoringTimeUnitLb.x = width_x(snoringTimeTextLb);
    snoringTimeUnitLb.centerY = snoringTimeTextLb.y+6*Height;
    line1.width = snoringTimeTextLb.width+snoringTimeUnitLb.width;
    snoringTimeExplainLb.centerX = line1.centerX;

    
    
    //止鼾成功次数
    if (detailModrel.hr.length > 0) {
        antiSnoreNumLb.text = detailModrel.hr;
    }else {
        antiSnoreNumLb.text = @"--";
    }
    [antiSnoreNumLb sizeToFit];

    antiSnoreUnitLb.textColor = MainColorWhite;
    antiSnoreUnitLb.x = width_x(antiSnoreNumLb);
    antiSnoreUnitLb.centerY = antiSnoreNumLb.y+6*Height;
    line2.width = antiSnoreNumLb.width+antiSnoreUnitLb.width;
    
    
    
    //AQIz指数
    if (detailModrel.cmov.length > 0) {
        oxygenNumLb.text = detailModrel.cmov;
    }else {
        oxygenNumLb.text = @"--";
    }
    oxygenSiaeLb.text = @"大于";
    [oxygenSiaeLb sizeToFit];
    oxygenSiaeLb.textColor = MainColorWhite;
    
    
    [oxygenNumLb sizeToFit];
    oxygenNumLb.x = width_x(oxygenSiaeLb);
    
    oxygenUnitLb.textColor = MainColorWhite;
    oxygenUnitLb.x = width_x(oxygenNumLb);
    oxygenUnitLb.centerY = oxygenNumLb.y+6*Height;
    line3.width = oxygenSiaeLb.width+oxygenNumLb.width+oxygenUnitLb.width;
}


#pragma mark 头部View显示
- (void)createHeaderView {
    
    headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 0)];
    headerView.backgroundColor = MainColor;
    
    photoIv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20*Height, 80, 80)];
    photoIv.image = [self choosePictureNum:[userInfoModel.portrait intValue]];
    photoIv.userInteractionEnabled = YES;
    photoIv.centerX = MainScreenWidth/4;
    [headerView addSubview:photoIv];
    
    
    nameLb = [[UILabel alloc]init];
    nameLb.y = height_y(photoIv)+5*Height;
    if (didInfoModel.deviceName.length != 0) {
        nameLb.text = didInfoModel.deviceName;
    }else {
        nameLb.text = @"--";
    }
    nameLb.textColor = MainColorWhite;
    nameLb.font = [UIFont systemFontOfSize:16];
    // 根据字体得到NSString的尺寸
    CGSize nameLbSize = [nameLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:nameLb.font,NSFontAttributeName, nil]];
    nameLb.size = nameLbSize;
    [nameLb sizeToFit];
    nameLb.centerX = photoIv.centerX;
    [headerView addSubview:nameLb];
    
    snoringTime = [[UIView alloc]init];
    snoringTime.size = photoIv.size;
    [headerView addSubview:snoringTime];
    
    //打鼾时间
    snoringTimeTextLb = [[UILabel alloc]init];
    snoringTimeTextLb.textColor = MainColorWhite;
    snoringTimeTextLb.y = 0;
    snoringTimeTextLb.x = 0;
    snoringTimeTextLb.text = @"--";
    snoringTimeTextLb.font = [UIFont systemFontOfSize:25];
    // 根据字体得到NSString的尺寸
    CGSize snoringTimeTextLbSize = [snoringTimeTextLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:snoringTimeTextLb.font,NSFontAttributeName, nil]];
    snoringTimeTextLb.size = snoringTimeTextLbSize;
    [snoringTimeTextLb sizeToFit];
    [snoringTime addSubview:snoringTimeTextLb];
    
    
    //打鼾单位
    snoringTimeUnitLb = [[UILabel alloc]init];
    snoringTimeUnitLb.textColor = [UIColor clearColor];
    snoringTimeUnitLb.font = [UIFont systemFontOfSize:12];
    snoringTimeUnitLb.textAlignment = NSTextAlignmentCenter;
    snoringTimeUnitLb.text = NSLocalizedString(@"detail_fragment_minute", nil);
    // 根据字体得到NSString的尺寸
    CGSize snoringTimeUnitLbSize = [snoringTimeUnitLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:snoringTimeUnitLb.font,NSFontAttributeName, nil]];
    snoringTimeUnitLb.size = snoringTimeUnitLbSize;
    [snoringTimeUnitLb sizeToFit];
    snoringTimeUnitLb.x = width_x(snoringTimeTextLb);
    snoringTimeUnitLb.centerY = snoringTimeTextLb.y;
    [snoringTime addSubview:snoringTimeUnitLb];
    
    line1  = [[UIView alloc]initWithFrame:CGRectMake(0, height_y(snoringTimeTextLb)+5, snoringTimeUnitLb.width+snoringTimeTextLb.width, 1)];
    line1.backgroundColor = MainColorWhite;
    [snoringTime addSubview:line1];
    
    //打鼾说明
    snoringTimeExplainLb = [[UILabel alloc]init];
    snoringTimeExplainLb.y = height_y(line1)+2;
    snoringTimeExplainLb.text = @"辅助后打鼾时间";
    snoringTimeExplainLb.font = [UIFont systemFontOfSize:12];
    snoringTimeExplainLb.textColor = MainColorWhite;
    // 根据字体得到NSString的尺寸
    CGSize snoringTimeExplainLbSize = [snoringTimeExplainLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:snoringTimeExplainLb.font,NSFontAttributeName, nil]];
    snoringTimeExplainLb.size = snoringTimeExplainLbSize;
    [snoringTimeExplainLb sizeToFit];
    snoringTimeExplainLb.centerX = line1.centerX;
    [snoringTime addSubview:snoringTimeExplainLb];
    
    snoringTime.size = CGSizeMake(line1.width, height_y(snoringTimeExplainLb));
    snoringTime.y = height_y(nameLb)+20*Height;
    snoringTime.centerX = photoIv.centerX;
//    snoringTime.backgroundColor = [UIColor orangeColor];

     //止鼾
    antiSnore = [[UIView alloc]init];
    [headerView addSubview:antiSnore];
    
    //止鼾次数
    antiSnoreNumLb = [[UILabel alloc]init];
    antiSnoreNumLb.textColor = MainColorWhite;
    antiSnoreNumLb.y = 0;
    antiSnoreNumLb.x = 0;
    antiSnoreNumLb.text = @"--";
    antiSnoreNumLb.font = [UIFont systemFontOfSize:40];
    // 根据字体得到NSString的尺寸
    CGSize antiSnoreNumLbSize = [antiSnoreNumLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:antiSnoreNumLb.font,NSFontAttributeName, nil]];
    antiSnoreNumLb.size = antiSnoreNumLbSize;
    [antiSnoreNumLb sizeToFit];
    [antiSnore addSubview:antiSnoreNumLb];
    
    //止鼾单位
    antiSnoreUnitLb = [[UILabel alloc]init];
    antiSnoreUnitLb.textColor = [UIColor clearColor];
    antiSnoreUnitLb.font = [UIFont systemFontOfSize:12];
    antiSnoreUnitLb.textAlignment = NSTextAlignmentCenter;
    antiSnoreUnitLb.text = @"次";
    // 根据字体得到NSString的尺寸
    CGSize antiSnoreUnitLbSize = [antiSnoreUnitLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:antiSnoreUnitLb.font,NSFontAttributeName, nil]];
    antiSnoreUnitLb.size = antiSnoreUnitLbSize;
    [antiSnoreUnitLb sizeToFit];
    antiSnoreUnitLb.x = width_x(antiSnoreNumLb);
    antiSnoreUnitLb.centerY = antiSnoreNumLb.y;
    [antiSnore addSubview:antiSnoreUnitLb];
    
    line2 = [[UIView alloc]initWithFrame:CGRectMake(antiSnoreNumLb.x, height_y(antiSnoreNumLb)+5, antiSnoreNumLb.width+antiSnoreUnitLb.width, 1)];
    line2.backgroundColor = MainColorWhite;
    [antiSnore addSubview:line2];
    
    //止鼾说明
    antiSnoreExplainLb = [[UILabel alloc]init];
    antiSnoreExplainLb.y = height_y(line2)+2;
    antiSnoreExplainLb.text = @"成功止鼾";
    antiSnoreExplainLb.font = [UIFont systemFontOfSize:12];
    antiSnoreExplainLb.textColor = MainColorWhite;
    // 根据字体得到NSString的尺寸
    CGSize antiSnoreExplainLbSize = [antiSnoreExplainLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:antiSnoreExplainLb.font,NSFontAttributeName, nil]];
    antiSnoreExplainLb.size = antiSnoreExplainLbSize;
    [antiSnoreExplainLb sizeToFit];
    antiSnoreExplainLb.centerX = line2.centerX;
    [antiSnore addSubview:antiSnoreExplainLb];
    
    antiSnore.size = CGSizeMake(antiSnoreUnitLb.width+antiSnoreNumLb.width, height_y(antiSnoreExplainLb));
    antiSnore.centerX = MainScreenWidth*2/3;
    antiSnore.centerY = photoIv.centerY;
    
    //AQI空气质量指数
    AQI = [[UIView alloc]init];
    [headerView addSubview:AQI];
    
    //氧气提示大小
    oxygenSiaeLb = [[UILabel alloc]init];
    oxygenSiaeLb.textColor = [UIColor clearColor];
    oxygenSiaeLb.y = 7*Height;
    oxygenSiaeLb.x = 0;
    oxygenSiaeLb.text = @"大于";
    oxygenSiaeLb.font = [UIFont systemFontOfSize:18];
    // 根据字体得到NSString的尺寸
    CGSize oxygenSiaeLbSize = [oxygenSiaeLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:oxygenSiaeLb.font,NSFontAttributeName, nil]];
    oxygenSiaeLb.size = oxygenSiaeLbSize;
    [oxygenSiaeLb sizeToFit];
    [AQI addSubview:oxygenSiaeLb];
    
    //氧气含量
    oxygenNumLb = [[UILabel alloc]init];
    oxygenNumLb.textColor = MainColorWhite;
    oxygenNumLb.y = 0;
    oxygenNumLb.x = width_x(oxygenSiaeLb);
    oxygenNumLb.text = @"--";
    oxygenNumLb.font = [UIFont systemFontOfSize:25];
    // 根据字体得到NSString的尺寸
    CGSize oxygenNumLbSize = [oxygenNumLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:oxygenNumLb.font,NSFontAttributeName, nil]];
    oxygenNumLb.size = oxygenNumLbSize;
    [oxygenNumLb sizeToFit];
    [AQI addSubview:oxygenNumLb];
    
    //止鼾单位
    oxygenUnitLb = [[UILabel alloc]init];
    oxygenUnitLb.textColor = [UIColor clearColor];
    oxygenUnitLb.font = [UIFont systemFontOfSize:12];
    oxygenUnitLb.textAlignment = NSTextAlignmentCenter;
    oxygenUnitLb.text = @"升";
    // 根据字体得到NSString的尺寸
    CGSize oxygenUnitLbSize = [antiSnoreUnitLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:antiSnoreUnitLb.font,NSFontAttributeName, nil]];
    oxygenUnitLb.size = oxygenUnitLbSize;
    [oxygenUnitLb sizeToFit];
    oxygenUnitLb.x = width_x(oxygenNumLb);
    oxygenUnitLb.centerY = oxygenNumLb.y;
    [AQI addSubview:oxygenUnitLb];
    
    line3 = [[UIView alloc]initWithFrame:CGRectMake(oxygenSiaeLb.x, height_y(oxygenNumLb)+5, oxygenSiaeLb.width+oxygenNumLb.width+oxygenUnitLb.width, 1)];
    line3.backgroundColor = MainColorWhite;
    [AQI addSubview:line3];
    
    //止鼾说明
    oxygenExplainLb = [[UILabel alloc]init];
    oxygenExplainLb.y = height_y(line3)+2;
    oxygenExplainLb.text = @"多吸入氧气";
    oxygenExplainLb.font = [UIFont systemFontOfSize:12];
    oxygenExplainLb.textColor = MainColorWhite;
    // 根据字体得到NSString的尺寸
    CGSize oxygenExplainLbSize = [oxygenExplainLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:oxygenExplainLb.font,NSFontAttributeName, nil]];
    oxygenExplainLb.size = oxygenExplainLbSize;
    [oxygenExplainLb sizeToFit];
    oxygenExplainLb.centerX = line3.centerX;
    [AQI addSubview:oxygenExplainLb];
    
    AQI.size = CGSizeMake(line3.width, height_y(oxygenExplainLb));
    AQI.centerX = antiSnore.centerX;
    AQI.y = snoringTime.y;
    
    line4 = [[UIView alloc]initWithFrame:CGRectMake(0, height_y(snoringTime)+10, MainScreenWidth, 1)];
    line4.backgroundColor = MainColorWhite;
    [headerView addSubview:line4];
    
    [self layoutNavigationView];
    
    
}

#pragma mark 日期按钮
- (void)layoutNavigationView {
    _btArray = [NSMutableArray array];
    CGFloat spacing = (MainScreenWidth - 300*Height)/6;
    for (int i = 0; i<5; i++) {
        UIButton *nvBt = [UIButton buttonWithType:UIButtonTypeCustom];
        nvBt.frame = CGRectMake((i+1)*spacing + i*60*Height, height_y(line4)+10*Height, 60*Height, 60*Height);
        //        NSLog(@"X = %f",nvBt.x);
        nvBt.titleLabel.font = [UIFont systemFontOfSize:9];
        nvBt.layer.borderWidth = 1;
        nvBt.layer.cornerRadius = 30*Height;
        nvBt.clipsToBounds = YES;
        
        if (i == 0) {
            nvBt.selected = YES;
            _scrollViewSelectedItem = nvBt;
            [nvBt setTitle:NSLocalizedString(@"detail_fragment_yesterday", nil) forState:UIControlStateNormal];
            nvBt.layer.borderColor = RGB(113, 254, 84).CGColor;
            
        }else if (i == 4) {
            nvBt.imageView.frame = CGRectMake(10*Height, 10*Height, 40*Height, 40*Height);
            [nvBt setBackgroundImage:[UIImage imageNamed:@"datepicker"] forState:UIControlStateNormal];
            nvBt.layer.borderColor = RGB(238, 238, 238).CGColor;
        }else {
            NSDate *yesterdayDate=[NSDate dateWithTimeIntervalSinceNow:-24*60*60*(i+1)];
            NSString *time = [[NSString alloc] initWithDate:yesterdayDate format:@"dd"];
            //                                NSLog(@"time100 = %@",time);
            NSString *week = [self weekdayStringFromDate:yesterdayDate];
            nvBt.titleLabel.numberOfLines = 2;
            nvBt.titleLabel.textAlignment = NSTextAlignmentCenter;
            [nvBt setTitle:[NSString stringWithFormat:@"%@\n%@",week,time] forState:UIControlStateNormal];
            nvBt.layer.borderColor = RGB(238, 238, 238).CGColor;
            
        }
        [nvBt setTitleColor:MainColorWhite forState:UIControlStateNormal];
        nvBt.tag = i;
        [nvBt addTarget:self action:@selector(nvBTAction:) forControlEvents:UIControlEventTouchUpInside];
        [_btArray addObject:nvBt];
        [headerView addSubview:nvBt];
        
    }
    
    headerView.height = height_y(line4)+80*Height;
    
}

#pragma mark 导航按钮执行方法
- (void)nvBTAction:(UIButton *)button {
    
    if (button.tag == 4) {
        STPickerDate *datePicker = [[STPickerDate alloc]initWithDelegate:self];
        [datePicker show];
    }
    if (_scrollViewSelectedItem == button) {
        return;
    }
    _scrollViewSelectedItem.selected = NO;
    _scrollViewSelectedItem.layer.borderColor = RGB(238, 238, 238).CGColor;
    button.layer.borderColor = RGB(113, 254, 84).CGColor;
    button.selected = YES;
    _scrollViewSelectedItem = button;
    //请求网络数据
    NSDate *yesterdayDate=[NSDate dateWithTimeIntervalSinceNow:-24*60*60*(button.tag+1)];
    NSString *time = [[NSString alloc] initWithDate:yesterdayDate format:@"yyyy-MM-dd"];
    [self initDataDate:time];
    
}

#pragma mark 选择日期
- (void)pickerDate:(STPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSString *text = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)year, (long)month, (long)day];
    //    NSLog(@"日期:%@",text);
    
    [self initDataDate:text];
    
}

#pragma mark 更改个人信息
- (void)ProfileChange {
    _listDidArr = [NSMutableArray array];
    NSMutableArray *listAllArray = [[[DeviceListTool alloc]init]queryAllDeviceListShowModels];
    for (int i=0; i<listAllArray.count; i++) {
        DeviceModel *model = [listAllArray objectAtIndex:i];
         if ([model.rule isEqualToString:@"admin"] && [model.isServer isEqualToString:@"0"]) {
             HttpBaseRequestUtil *req = [[HttpBaseRequestUtil alloc] init];
             req.myDelegate = self;
             NSMutableDictionary *reqDic = [NSMutableDictionary dictionary];
             [reqDic setValue:model.did forKey:@"api"];
             [reqDic setValue:[de valueForKey:@"username"] forKey:@"username"];
             [reqDic setValue:[de valueForKey:@"token"] forKey:@"token"];
             [reqDic setValue:model.did forKey:@"deviceID"];
             NSMutableDictionary *userInfoDic = [NSMutableDictionary dictionary];
             [userInfoDic setValue:model.didInfo forKey:@"didInfo"];
             [userInfoDic setValue:model.userInfo forKey:@"userInfo"];
             [userInfoDic setValue:model.snore forKey:@"snore"];
             [userInfoDic setValue:model.clock forKey:@"alarm"];
             NSString *userInfoStr = [GWNSStringUtil convertToJSONString:userInfoDic];
                 NSLog(@"userInfoStr= %@",userInfoStr);
             [reqDic setValue:userInfoStr forKey:@"configData"];
             [req reqDataWithUrl:Update_Config reqDic:reqDic reqHeadDic:nil];
             [_listDidArr addObject:model.did];
         }
    }
}


#pragma mark 开始蓝牙同步止鼾相关配置
- (void)setBluetoothAntiSnore {
    
    //设备配置数据
    deviceModel = [[UpdateDeviceData sharedManager] getReadData];
    if ([[UpdateDeviceData sharedManager]isSetBluetoothSensorDevice:deviceModel]) {
        clock = [Clock objectWithKeyValues:[GWNSStringUtil dictionaryToJsonString:deviceModel.clock]];
        ConfigModel *clockMode = [ConfigModel objectWithKeyValues:clock.clockMode];
        ConfigModel *snore= [ConfigModel objectWithKeyValues:[GWNSStringUtil dictionaryToJsonString:deviceModel.snore]];
//        NSLog(@"%@,%@,%@",snore.isValid,clockMode.isValid,clock.isValid);
        if ([snore.isValid intValue] == 0) {
            if (_isConnectedDevices) {
                [self setType:1 andAntiSnoreModel:[snore.select intValue] andAlarmClockModel:0];
            }else {
                [self getDataIsBluetooth:NO andType:1 andSelect:[snore.select intValue]];
            }
            return;
        }else if ([clockMode.isValid intValue] == 0) {
            if (_isConnectedDevices) {
                [self setType:2 andAntiSnoreModel:0 andAlarmClockModel:[clockMode.select intValue]];
            }else {
                [self getDataIsBluetooth:NO andType:2 andSelect:[clockMode.select intValue]];
            }
            return;
        }else if ([clock.isValid intValue] == 0) {
            if (_isConnectedDevices) {
                [self setType:3 andAntiSnoreModel:0 andAlarmClockModel:0];
            }else {
                [self getDataIsBluetooth:NO andType:3 andSelect:0];
            }
            return;
        }
    }else {
        if (isChangeHome) {
            //开始蓝牙同步
            if (_isConnectedDevices) {
                //同步数据
                [self getData1];
            }else{
                //1, 连接蓝牙
                [self getDataIsBluetooth:YES andType:0 andSelect:0];
            }
            isChangeHome = NO;
        }
        
    }
    
    
}


#pragma mark 页面即将出现
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [GWStatisticalUtil onPageViewBegin:self withName:@"首页"];
    
    //设置导航栏的背景色
    [self setNacColorMainColor];
    
    if (isHome) {
        //同步个人信息到后台
        [self ProfileChange];
        if (deviceModel.did.length ==12) {
            if ([deviceModel.rule isEqualToString:@"admin"] && stateWork != 1) {
                stateWork = 1;
                //开始同步下位机
                [self setBluetoothAntiSnore];
            }
        }
        
    }
    
}

#pragma mark 将要消失页面
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [GWStatisticalUtil onPageViewEnd:self withName:@"首页"];
}

#pragma mark 已经消失页面
- (void)viewDidDisappear:(BOOL)animated {
    
    [_tableView headerEndRefreshing];
    [self getData4];
    stateWork = 0;
    
}

#pragma mark 页面已经出现
- (void)viewDidAppear:(BOOL)animated {
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MainColorWhite;
    
    [self navSet:NSLocalizedString(@"app_name",nil)];
  
    
    
    
    //设备配置数据
    deviceModel = [[UpdateDeviceData sharedManager] getReadData];
    
    if (deviceModel != nil) {
        //确保只要一个首页
        [[UpdateDeviceData sharedManager] setUpdateDataDevice:deviceModel];
        
        didInfoModel = [DidInfoModel objectWithKeyValues:[GWNSStringUtil dictionaryToJsonString:deviceModel.didInfo]];
        userInfoModel = [UserInfoModel objectWithKeyValues:[GWNSStringUtil dictionaryToJsonString:deviceModel.userInfo]];
    }
    
    
   bluetoothOrder = [[BluetoothOrder alloc]init];
   
    //导航左边按钮
    UIButton *leftBt = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBt.frame = CGRectMake(0, 30, NavSize, NavSize);
    [leftBt setImage:[UIImage imageNamed:@"about"] forState:UIControlStateNormal];
//    leftBt.frame = CGRectMake(0, 30, 80, 30);add
//    [leftBt setTitle:@"切换用户" forState:UIControlStateNormal];
    [leftBt addTarget:self action:@selector(navigationButtons12:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBt];
    
    //导航右边按钮
    UIButton *rightBt = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBt.frame = CGRectMake(0, 30, NavSize, NavSize);
    [rightBt setImage:[UIImage imageNamed:@"list"] forState:UIControlStateNormal];
//    rightBt.frame = CGRectMake(0, 30, 80, 30);
//    [rightBt setTitle:@"同步数据" forState:UIControlStateNormal];
    [rightBt addTarget:self action:@selector(navigationButtons22:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBt];
    
   
    NSDate *yesterdayDate=[NSDate dateWithTimeIntervalSinceNow:-24*60*60];
    NSString *time = [[NSString alloc] initWithDate:yesterdayDate format:@"yyyy-MM-dd"];
    dateStr = time;
    //请求网络数据与同步蓝牙传感器
    [self headReloadData];
    
    //加载头部View
    [self createHeaderView];
    
    //加载数据的TableView
    [self layoutTableView];
    
    [GWNotification addHandler:^(NSDictionary *handleDic) {
        isHome = YES;
    } withName:@"返回首页"];
   
    
    
    [GWNotification addHandler:^(NSDictionary *handleDic) {
        //设备配置数据
        deviceModel = [[UpdateDeviceData sharedManager] getReadData];
        if (deviceModel != nil) {
            didInfoModel = [DidInfoModel objectWithKeyValues:[GWNSStringUtil dictionaryToJsonString:deviceModel.didInfo]];
            userInfoModel = [UserInfoModel objectWithKeyValues:[GWNSStringUtil dictionaryToJsonString:deviceModel.userInfo]];
        }else {
            return ;
        }
        if (didInfoModel.deviceName != nil) {
            nameLb.text = didInfoModel.deviceName;
        } else {
            nameLb.text = NSLocalizedString(@"device_default_name", nil);
        }
        [nameLb sizeToFit];
        nameLb.centerX = photoIv.centerX;
        photoIv.image = [self choosePictureNum:[userInfoModel.portrait intValue]];
        
    } withName:@"更新设备信息"];

    [GWNotification addHandler:^(NSDictionary *handleDic) {
        isChangeHome = YES;
        //设备配置数据
        deviceModel = [[UpdateDeviceData sharedManager] getReadData];
        if (deviceModel != nil) {
            didInfoModel = [DidInfoModel objectWithKeyValues:[GWNSStringUtil dictionaryToJsonString:deviceModel.didInfo]];
            userInfoModel = [UserInfoModel objectWithKeyValues:[GWNSStringUtil dictionaryToJsonString:deviceModel.userInfo]];
        }else {
            return ;
        }
        if (didInfoModel.deviceName != nil) {
            nameLb.text = didInfoModel.deviceName;
        } else {
            nameLb.text = NSLocalizedString(@"device_default_name", nil);
        }
        [nameLb sizeToFit];
        nameLb.centerX = photoIv.centerX;
        photoIv.image = [self choosePictureNum:[userInfoModel.portrait intValue]];
        //请求网络数据/或者去缓存拿 刷新全部UI元素
        //        NSDate *yesterdayDate=[NSDate dateWithTimeIntervalSinceNow:-24*60*60];
        //        NSString *time = [[NSString alloc] initWithDate:yesterdayDate format:@"yyyy-MM-dd"];
        //        [self initDataDate:time];
        
    } withName:@"更换首页"];
    
    [GWNotification addHandler:^(NSDictionary *handleDic) {
        
        NSInteger code = [[handleDic valueForKey:@"code"] integerValue];
        if (code == 200) {
            
            [self POSTExampleSucceed];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(delayMethod) userInfo:nil repeats:NO];
            });
            
            [SVProgressHUD showErrorWithStatus:@"上传成功"];
        }else {
            //上传失败
            [self POSTExampleError];
            
            dispatch_async(dispatch_get_main_queue(), ^{
               
                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@,%@",[handleDic valueForKey:@"code"],[handleDic valueForKey:@"msg"]]];
            });
        }
    } withName:@"上传服务器_实时页面"];
    
   [GWNotification addHandler:^(NSDictionary *handleDic) {
        
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_time_out",nil)];
        //上传失败
        [self POSTExampleError];
     
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@,%@",[handleDic valueForKey:@"code"],[handleDic valueForKey:@"msg"]]];
    } withName:@"上传失败"];

    
   
    

}

#pragma -mark ScrollView的布局和相关属性
-(void)layoutTableView
{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = headerView;
    _tableView.tableFooterView = [[UIView alloc]init];
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone; //分割线不显示
    [self.view addSubview:_tableView];
    
    //下拉刷新
    [_tableView addHeaderWithTarget:self action:@selector(headReloadData)];
    
    
    
}
#pragma mark 下拉刷新
-(void)headReloadData
{
    //请求网络数据
    [self initDataDate:dateStr];
    
    //同步个人信息到后台
    [self ProfileChange];
    if (deviceModel.did.length ==12) {
        if ([deviceModel.rule isEqualToString:@"admin"] && stateWork != 1) {
            stateWork = 1;
            isChangeHome = YES;
            //开始同步下位机
            [self setBluetoothAntiSnore];
        }
    }
    

}

#pragma mark 延时执行网络刷新
- (void)delayMethod {

    //请求网络数据
    NSDate *yesterdayDate=[NSDate dateWithTimeIntervalSinceNow:-24*60*60];
    NSString *time = [[NSString alloc] initWithDate:yesterdayDate format:@"yyyy-MM-dd"];
    [self initDataDate:time];

    
}


#pragma mark 蓝牙提示窗口消失
- (void)lyDisappear {

}

#pragma mark 设备列表
- (void)navigationButtons22:(UIButton *)button{

    self.navigationController.navigationBar.tintColor =[UIColor whiteColor];
    [self.navigationController pushViewController:[SwitchingDeviceController alloc] animated:YES];
}

#pragma mark 关于
- (void)navigationButtons12:(UIButton *)button
{
    self.navigationController.navigationBar.tintColor =[UIColor whiteColor];
    [self.navigationController pushViewController:[[AboutViewController alloc] init] animated:YES];
}

#pragma mark *****************************************************************************

#pragma -mark每个分区里面有多少个cell
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

#pragma -mark创建每个cell的方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusepool = @"cell";
    DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusepool];
    if (cell == nil) {
        cell = [[DetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusepool];
    }

    if (indexPath.row == 0) {
        cell.sleepStatisticsLb.text = @"睡眠统计";
    }else if (indexPath.row == 1) {
        cell.sleepStatisticsLb.text = @"体征统计";
    }else if (indexPath.row == 2) {
        cell.sleepStatisticsLb.text = @"恢复分析";
    }else if (indexPath.row == 3) {
        cell.sleepStatisticsLb.text = @"健康预测";
    }else if (indexPath.row == 4) {
        cell.sleepStatisticsLb.text = @"睡眠建议";
    }
    
    //点击cell的颜色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}



#pragma -mark设置cell的高度的方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
    
}


#pragma mark -- 点击cell方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row==0) {
        SleepStatus *sleepSVC = [[SleepStatus alloc] init];
        sleepSVC.detailModrel = detailModrel;
        [self.navigationController pushViewController:sleepSVC animated:YES];
        

    }else if (indexPath.row==1){
        SignsStatisViewController *signsStatisVC = [[SignsStatisViewController alloc]init];
        signsStatisVC.detailModrel = detailModrel;
        [self.navigationController pushViewController:signsStatisVC animated:YES];
    }else if (indexPath.row==2){
        SignsStatisViewController *signsStatisVC = [[SignsStatisViewController alloc]init];
        signsStatisVC.detailModrel = detailModrel;
        [self.navigationController pushViewController:signsStatisVC animated:YES];
        
    }else if (indexPath.row==3){
        SignsStatisViewController *signsStatisVC = [[SignsStatisViewController alloc]init];
        signsStatisVC.detailModrel = detailModrel;
        [self.navigationController pushViewController:signsStatisVC animated:YES];
        
    }else if (indexPath.row==4){
        SignsStatisViewController *signsStatisVC = [[SignsStatisViewController alloc]init];
        signsStatisVC.detailModrel = detailModrel;
        [self.navigationController pushViewController:signsStatisVC animated:YES];
        
    }
  
}

#pragma mark ***************************************蓝牙操作***************************
#pragma mark 蓝牙传感器同步成功
- (void)setSnoringBluetoothNumber:(NSInteger)number {

    switch (number) {
        case 1:{
            ConfigModel *snore= [ConfigModel objectWithKeyValues:[GWNSStringUtil dictionaryToJsonString:deviceModel.snore]];
            snore.isValid = @"1";
            [[UpdateDeviceData sharedManager]setUpdateDataDeviceModel:deviceModel andtype:Snore_Set andChangeName:@"snore" andChangeDetail:[GWNSStringUtil convertToJSONString:[snore keyValues]]];
        }
            break;
        case 2:{
            ConfigModel *clockMode = [ConfigModel objectWithKeyValues:clock.clockMode];
            clockMode.isValid = @"1";
            NSDictionary *clockModeDic = [clockMode keyValues];
            [[UpdateDeviceData sharedManager]setUpdateDataDeviceModel:deviceModel andtype:Clock_Set andChangeName:@"clockMode" andChangeDetail:[GWNSStringUtil convertToJSONString:clockModeDic]];
        }
            break;
        case 3:{
            clock.isValid = @"1";
            NSDictionary *clockDic = [clock keyValues];
            [[UpdateDeviceData sharedManager]setUpdateDataDeviceModel:deviceModel andtype:Clock_Set andChangeName:@"clock" andChangeDetail:[GWNSStringUtil convertToJSONString:clockDic]];
        }
            break;
        default:
            break;
    }
    
    
    
}

#pragma mark 闹钟数据转化成要闹的时间基点
- (int)pointShiftTimeWeek:(int)week andHour:(int)hour andMin:(int)min {
    
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //当前的星期,时,分获得
    NSDateComponents *comps =[calendar components:(NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute)fromDate:date];
     NSInteger nowWeek = [comps weekday]-1; // 星期几（注意，周日是“1”，周一是“2”。。。。）星期 -1
    NSInteger nowHour = [comps hour];
    NSInteger nowMin = [comps minute];
//  NSLog(@"hour:%ld minute: %ld nowWeek: %ld", (long)nowHour, (long)nowMin, (long)nowWeek);
    
//    int week; //星期 -1
//    int hour; //小时
//    int min; //分钟
//    把一个星期等分成30S一个点,共20160个点
    NSInteger nowBaseTime=((nowWeek*24+nowHour)*60+nowMin)*2;
    NSInteger orderBaseTime=((week*24+hour)*60+min)*2;
    NSInteger orderDiffTime;
    //取绝对值
    if(orderBaseTime>=nowBaseTime){
        orderDiffTime=orderBaseTime-nowBaseTime;
    }else{
        orderDiffTime=20160-(nowBaseTime-orderBaseTime);
    }
    return (int)orderDiffTime;
}

#pragma mark 解析闹钟
- (void)clockParsing {
    //需要设置下位机的数组
    _clockTimeAllArray = [NSMutableArray array];
    
    //原闹钟数组
    NSMutableArray *clockTimeArr = [NSMutableArray array];
    clockTimeArr = [clock.clockTime mutableCopy];
    
    //分解闹钟数组
    for (int i = 0; i<clockTimeArr.count; i++) {
        ClockTimeModel *clockTimeModel =[ClockTimeModel objectWithKeyValues:clockTimeArr[i]];
        if ([clockTimeModel.run isEqualToString:@"1"]) {
            if ([clockTimeModel.times isEqualToString:@"1"]) {
                if ([clockTimeModel.ringTime longLongValue] > [[NSDate date] timeIntervalSince1970]) {
                    ClockTimeBluetoothModel *clockTimeBluetoothModelTemp = [[ClockTimeBluetoothModel alloc]init];
                    clockTimeBluetoothModelTemp.times = 1;
                    int points = ([clockTimeModel.ringTime longLongValue] - [[NSDate date] timeIntervalSince1970])/30;
                    clockTimeBluetoothModelTemp.points = points;
                    [_clockTimeAllArray addObject:clockTimeBluetoothModelTemp];
                }else {
                    clockTimeModel.run = @"0";
                    clockTimeArr[i] = [clockTimeModel keyValues];
                    clock.clockTime = clockTimeArr;
                    NSDictionary *clockDic = [clock keyValues];
                    [[UpdateDeviceData sharedManager]setUpdateDataDeviceModel:deviceModel andtype:Clock_Set andChangeName:@"clock" andChangeDetail:[GWNSStringUtil convertToJSONString:clockDic]];
                }
            }else {
                for (int j = 0; j<clockTimeModel.week.count; j++) {
                    ClockTimeBluetoothModel *clockTimeBluetoothModelTemp = [[ClockTimeBluetoothModel alloc]init];
                    clockTimeBluetoothModelTemp.times = [clockTimeModel.times intValue];
                    clockTimeBluetoothModelTemp.points = [self pointShiftTimeWeek:[clockTimeModel.week[j] intValue] andHour:[clockTimeModel.hour intValue] andMin:[clockTimeModel.min intValue]];
                    [_clockTimeAllArray addObject:clockTimeBluetoothModelTemp];
                }
            }
        }
    }
    
    //删除重复闹钟
    for (int i=0; i<_clockTimeAllArray.count; i++) {
        ClockTimeBluetoothModel *clockTimeBluetoothModel2 = _clockTimeAllArray[i];
        for (int j=i+1;j<_clockTimeAllArray.count;) {
            ClockTimeBluetoothModel *clockTimeBluetoothModel3 = _clockTimeAllArray[j];
            if (clockTimeBluetoothModel2.points==clockTimeBluetoothModel3.points) {
                if (clockTimeBluetoothModel2.times == 1) {
                    //优先删除只响一次的
                    [_clockTimeAllArray removeObjectAtIndex:i];
                    i--;
                    break;
                }else {
                    [_clockTimeAllArray removeObjectAtIndex:j];
                }
                
            }else {
                j++;
            }
        }
    }
    
}

#pragma mark 选择模式
-(void)setType:(int)type andAntiSnoreModel:(int)sonreModel andAlarmClockModel:(int)clockModel{
    /**
     *  type 1 打鼾 2闹钟 设置震动
     */
    if (type==1) {
        switch (sonreModel) {
            case 0:
                [self getDataNunber:0 andTime:1 andInterval:1];
                break;
            case 1:
                [self getDataNunber:5 andTime:100 andInterval:500];
                break;
            case 2:
                [self getDataNunber:5 andTime:160 andInterval:500];
                break;
            case 3:
                [self getDataNunber:5 andTime:250 andInterval:500];
                break;
            case 4:
                [self getDataNunber:5 andTime:400 andInterval:500];
                break;
            default:
                break;
        }
    }else if (type==2) {
        if (clockModel == 0) {
            clockModel = 1;
        }
        switch (clockModel) {
            case 1:
                [self getClockNum:300 andActivityTime:20 andInterval:20];
                break;
            case 2:
                [self getClockNum:300 andActivityTime:40 andInterval:40];
                break;
            case 3:
                [self getClockNum:300 andActivityTime:60 andInterval:60];
                break;
            case 4:
                [self getClockNum:300 andActivityTime:80 andInterval:80];
                break;
            default:
                break;
        }
    }else if (type==3) {
        
        //解析闹钟
        [self clockParsing];
        _clockNumber = 0;
        [self getDataClockTimeNum:33 andClockTime:10 andTimes:0];
    }
}

#pragma mark 断开蓝牙
-(void)getData4{
    
    [bluetoothOrder DisconnectBluetooth:^(int result, NSDictionary *dic, NSError *error) {
        
        if ([self isResultEffective:result dic:dic error:error]) {
            if (result == bluetooth_result_staticupdate) {
                if ([dic[@"staticUpdate"] isEqualToString:[NSString stringWithFormat:@"%ld",(long)bluetooth_static_nil]]) {
                    //蓝牙断开状态
                    _isConnectedDevices = NO;
                    
                    [[[BluetoothLogSqlTool alloc]init] insertBluetoothLogTitle:[NSString stringWithFormat:@"蓝牙断开"] andId:deviceModel.did];
                }
            }
        }
        
    }];
}


#pragma mark 获取数据压缩的方式
-(void)getData1{
    
    //连接蓝牙,传入设备ID
    [bluetoothOrder getBlueMessageWithTimeInterval:3 block:^(int result, NSDictionary *dic, NSError *error) {
        
        if ([self isResultEffective:result dic:dic error:error]) {
            if(result == bluetooth_result_success){//成功获取数据
                if ([dic[@"type"] isEqualToString:@"0"]) {
                    NSLog(@"数据量为0,无数据信息");
                    [[[BluetoothLogSqlTool alloc]init] insertBluetoothLogTitle:[NSString stringWithFormat:@"数据量为0,无数据信息"] andId:deviceModel.did];
                    stateWork = 3;
                }else{
                    //数据正常
                    stateWork = 2;

                    NSMutableArray *dataBuleArr = [NSMutableArray array];
                    dataBuleArr = [dic objectForKey:@"dataArr"];
//                    NSLog(@"tempArr的个数是%lu",(unsigned long)dataBuleArr.count);

                    //在SDk已存数据库
                    [[[BluetoothDataSqlTool alloc] init] insertBluetoothDataShowModel:dataBuleArr];
                    [[[BluetoothLogSqlTool alloc]init] insertBluetoothLogTitle:[NSString stringWithFormat:@"收到蓝牙数据,数量是%lu,已存储到本地",(unsigned long)dataBuleArr.count] andId:deviceModel.did];
                    //上传数据
                    [self createFile];
               
                }
            }else if(result == bluetooth_result_log){//日志信息输出
                
            }else if(result == bluetooth_result_fail){//蓝牙失败返回
                
            }
        }
        
    }];
}
#pragma mark 连接蓝牙
-(void)getDataIsBluetooth:(BOOL)bluetooth andType:(int)Type andSelect:(int)select{
    
    //连接蓝牙,传入设备ID
    [bluetoothOrder ConnectionBluetoothDeviceMacAddress:deviceModel.did block:^(int result, NSDictionary *dic, NSError *error) {
        [[[BluetoothLogSqlTool alloc]init] insertBluetoothLogTitle:[GWNSStringUtil getStringFromObj:dic] andId:deviceModel.did];
        if ([self isResultEffective:result dic:dic error:error]) {
            if (result == bluetooth_result_electricCharge) {//电量获取
                NSLog(@"电量获取,电量是: %@",[dic objectForKey:@"electric"]);
                NSString *powerStr = [dic objectForKey:@"electric"];
                _power = [powerStr integerValue];
                
            }else if(result == bluetooth_result_ready){//蓝牙已经准备好接受命令
                NSLog(@"蓝牙已经准备好接受命令");
                [[[BluetoothLogSqlTool alloc]init] insertBluetoothLogTitle:@"蓝牙已经准备好接受命令" andId:deviceModel.did];
                _isConnectedDevices = YES;
                if (bluetooth) {
                    [self getData1];
                }else {
                    [self setType:Type andAntiSnoreModel:select andAlarmClockModel:select];
                    
                }
                
                
            }else if(result == bluetooth_result_log){//日志信息输出
                
                NSLog(@"日志信息输出");
            }
        }
    }];
    
}

//设置打鼾模式
-(void)getDataNunber:(int)number andTime:(int)time andInterval:(int)interval{
    /**
     *  设置打鼾模式传入相关参数
     *
     *  @param num 震动次数
     *  @param ActivityTime  震动持续时间
     *  @param interval 震动时间间隔
     *
     *  @return 所有参数不能设负数
     */
    time = time/2;
    interval = interval/2;
    
    //设置打鼾模式传入相关参数
    [bluetoothOrder getSnoreNum:number andActivityTime:time andInterval:interval block:^(int result, NSDictionary *dic, NSError *error) {
        
        if ([self isResultEffective:result dic:dic error:error]) {
            if(result == bluetooth_result_snore){
                if ([[dic objectForKey:@"setSnore"] isEqualToString:@"successed"]) {
                    NSLog(@"设置打鼾模式成功");
                    [[[BluetoothLogSqlTool alloc]init] insertBluetoothLogTitle:[NSString stringWithFormat:@"设置打鼾模式成功"] andId:deviceModel.did];
                    [self setSnoringBluetoothNumber:1];
                    [SVProgressHUD showErrorWithStatus:@"设置打鼾模式成功"];
                    stateWork = 2;
                    //继续同步闹钟震动
                    [self setBluetoothAntiSnore];
                }
            }
        }
    }];
}
//设置闹钟模式
-(void)getClockNum:(int)num andActivityTime:(int)time andInterval:(int)interval{
    /**
     *  设置打鼾模式传入相关参数
     *
     *  @param num 震动次数
     *  @param ActivityTime  震动持续时间
     *  @param interval 震动时间间隔
     *
     *  @return 所有参数不能设负数
     */
    time = time/2;
    interval = interval/2;
    //设置打鼾模式传入相关参数
    [bluetoothOrder getClockNum:num andActivityTime:time andInterval:interval block:^(int result, NSDictionary *dic, NSError *error) {
        
        if ([self isResultEffective:result dic:dic error:error]) {
            if(result == bluetooth_result_snore){
                if ([[dic objectForKey:@"setClock"] isEqualToString:@"successed"]) {
                    NSLog(@"设置闹钟模式成功");
                    [[[BluetoothLogSqlTool alloc]init] insertBluetoothLogTitle:[NSString stringWithFormat:@"设置闹钟模式成功"] andId:deviceModel.did];
                    [self setSnoringBluetoothNumber:2];
                    [SVProgressHUD showErrorWithStatus:@"设置闹钟模式成功"];
                    stateWork = 2;
                    //继续同步闹钟
                    [self setBluetoothAntiSnore];
                }
            }
        }
    }];
}


//设置闹钟
-(void)getDataClockTimeNum:(int)num andClockTime:(int)clockPoint  andTimes:(int)times{
    /**
     *  设置闹钟传入相关参数
     *
     *  @param ClockTimeNum 编号0~32 大于32清除所有闹钟
     *  @param ClockTime    闹钟基点 闹钟要响的位置
     *  @param andClockNum  闹钟循环次数 30000 永久循环 0取消 1就一次
     *
     *  @return 所有参数不能设负数
     */
//    __weak DetailViewController *self = self;
    [bluetoothOrder getClockTimeNum:num andClockTime:clockPoint andClockNum:times block:^(int result, NSDictionary *dic, NSError *error) {
        
        if ([self isResultEffective:result dic:dic error:error]) {
            if(result == bluetooth_result_snore){
                if ([[dic objectForKey:@"setClockTime"] isEqualToString:@"successed"]) {
                    NSLog(@"设置闹钟成功");
                    
                    if (self.clockNumber<_clockTimeAllArray.count) {
                        self.clockNumber = self.clockNumber+1;
                        ClockTimeBluetoothModel *clockTimeBluetoothModel =_clockTimeAllArray[self.clockNumber-1];
                        NSLog(@"闹钟编号是:%d",self.clockNumber-1);
                        [self getDataClockTimeNum:self.clockNumber-1 andClockTime:clockTimeBluetoothModel.points andTimes:clockTimeBluetoothModel.times];
                    }else {
                        
                        [[[BluetoothLogSqlTool alloc]init] insertBluetoothLogTitle:[NSString stringWithFormat:@"设置闹钟成功"] andId:deviceModel.did];
                        [SVProgressHUD showErrorWithStatus:@"设置闹钟成功"];
                        stateWork = 2;
                        [self setSnoringBluetoothNumber:3];
                        //继续同步闹钟
                        [self setBluetoothAntiSnore];
                    }
                    
                    
                }
            }
        }
    }];
}


#pragma mark 公共的处理结果的地方 - 结果是否有效
-(Boolean)isResultEffective:(int)result dic:(NSDictionary *)dic error:(NSError *)error{
    
    NSLog(@"操作码:%d\n结果:%@",result,[GWNSStringUtil getStringFromObj:dic]);
    if (result == bluetooth_result_fail) {//蓝牙异常
        stateWork = 3;
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"wifi_device_ap_setup_fragment_warm", nil)];
        return NO;
    }else if (result == bluetooth_result_log){
        if ([dic[@"errorType"] isEqualToString:@"0"]) {//异常信息中断了操作
            stateWork = 3;
//            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"wifi_device_ap_setup_fragment_warm_2", nil)];
            return NO;
        }
    }else if(result == bluetooth_result_busy){//蓝牙正忙,目前是蓝牙处于正在连接中...
        return NO;
    }else if(result == bluetooth_result_anknow){//未知异常,目前没有用到
        stateWork = 3;
        return NO;
    }
    return YES;
}

#pragma mark ***************************************文件操作***************************
#pragma mark 删除沙盒里的文件
-(void)deleteFileTextName:(NSString *)name
{
    NSLog(@"将要删除的名字name2:%@",name);
    
    if (name == nil || name.length < 4) {
        return;
    }
    
    NSFileManager* fileManager=[NSFileManager defaultManager];
//    NSString *tempStr = NSTemporaryDirectory();
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    //文件名
    NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:name];
//    NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:name];

    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
    if (!blHave) {
        NSLog(@"no  have");
        return ;
    }else {
        NSLog(@" have");
        BOOL blDele= [fileManager removeItemAtPath:uniquePath error:nil];
        if (blDele) {
            NSLog(@"dele success2");
        }else {
            NSLog(@"dele fail2");
        }
        
    }
    
    NSString *documentsDirectory1= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSError *error1;
    //显示文件目录的内容
    NSLog(@"Documentsdirectory: %@",
          [fileManager contentsOfDirectoryAtPath:documentsDirectory1 error:&error1]);
    
    [[[BluetoothDataSqlTool alloc] init] deleteData:0 andDeviceid:deviceModel.did];
}

#pragma mark POST 上传失败
- (void)POSTExampleError
{
    [[[BluetoothLogSqlTool alloc]init] insertBluetoothLogTitle:@"设备上传失败" andId:deviceModel.did];
    
}

#pragma mark POST 上传成功
- (void)POSTExampleSucceed
{
    [[[BluetoothLogSqlTool alloc]init] insertBluetoothLogTitle:[NSString stringWithFormat:@"设备上传成功,数据数量是:%lu",(unsigned long)_dataArr.count] andId:deviceModel.did];
    
    //删除文件
    [self deleteFileTextName:_textName];
    
    [[[BluetoothDataSqlTool alloc] init] deleteAllData];
    [[[BluetoothLogSqlTool alloc]init] insertBluetoothLogTitle:@"设备删除了所有本地数据" andId:deviceModel.did];
    
    
    
}

#pragma mark POST 上传
- (void)POSTExample
{
    UploadFile1 *upload = [[UploadFile1 alloc] init];
    
    // 这里如果是在同一部电脑上开启的web服务的话,要用localhost,如果用ip的话有时候会出错 //新地址test.freetis.net:9090
    //    NSString *urlString = @"http://127.0.0.1:9090/api/uploadfile";
    //    NSString *urlString = @"http://ec2-52-196-131-65.ap-northeast-1.compute.amazonaws.com:9090/api/uploadfile";
    NSString *urlString = @"http://test.freetis.net:9090/api/uploadfile";
    //    NSString *urlString = @"http://192.168.0.100:9090/api/uploadfile";
    //获取document路径,括号中属性为当前应用程序独享
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentDirectory = [directoryPaths objectAtIndex:0];
    //定义记录文件全名以及路径的字符串filePath,后缀可加可不加
    NSString *result_filePath = [documentDirectory stringByAppendingPathComponent:_textName];
    //用NSData读取
    NSData* fileData = [NSData dataWithContentsOfFile:result_filePath];
    
    //    NSData *data1 = [NSData dataWithContentsOfFile:@"abc"];
    NSMutableDictionary *imageDic = [NSMutableDictionary dictionary];
    
    //打印要加,不打印就不加
    //    data = [data base64EncodedDataWithOptions:NSUTF8StringEncoding];
    [imageDic setValue:fileData forKey:_textName];
    
    //    NSLog(@"上传的Data%@",[imageDic objectForKey:_textName]);
    
    NSMutableDictionary *pramDic = [NSMutableDictionary dictionary];
    [pramDic setValue:@"someid" forKey:@"accessid"];
    [pramDic setValue:@"somekey" forKey:@"accesskey"];
    [upload uploadFileWithURL:[NSURL URLWithString:urlString] imageDic:imageDic pramDic:pramDic];
    
    [[[BluetoothLogSqlTool alloc]init] insertBluetoothLogTitle:[NSString stringWithFormat:@"设备开始上传数据,数据数量是:%lu",(unsigned long)_dataArr.count] andId:deviceModel.did];
}



#pragma mark 创建文件
- (void)createFile
{
    //设备的UDID
    //    NSString *udid = @"6ef0ed9ba339178ae3ee7322bbde57a20bb238aa";
    NSString *SERVICE_NAME = @"com.freetis.GOSPEL";//最好用程序的bundle id
    NSString * str =  [SFHFKeychainUtils getPasswordForUsername:@"UUID" andServiceName:SERVICE_NAME error:nil];  // 从keychain获取数据
    if ([str length]<=0){
        str  = [[[UIDevice currentDevice] identifierForVendor] UUIDString];  // 保存UUID作为手机唯一标识符
        [SFHFKeychainUtils storeUsername:@"UUID"
                             andPassword:str
                          forServiceName:SERVICE_NAME
                          updateExisting:1
                                   error:nil];  // 往keychain添加数据
    }
    NSString *udid = str;
    //当前时间
    NSTimeInterval curveTimeStamp= [[NSDate date] timeIntervalSince1970];
    long curveTime = (long)curveTimeStamp;
    NSString *nowTime =[NSString stringWithFormat:@"%ld",curveTime];
    //文件名,不加后缀
    NSString *textName = [NSString stringWithFormat:@"%@_%@",nowTime,udid];
    _textNameTail = textName;
    //文件名,加后缀
    NSString *textNameUpload = [NSString stringWithFormat:@"%@_%@_iOS.gz",nowTime,udid];
    _textName = textNameUpload;
    //创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //获取document路径,括号中属性为当前应用程序独享
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentDirectory = [directoryPaths objectAtIndex:0];
    //定义记录文件全名以及路径的字符串filePath,后缀可加可不加
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:textName];
    NSString *result_filePath = [documentDirectory stringByAppendingPathComponent:textNameUpload];
    //查找文件，如果不存在，就创建一个文件
    if (![fileManager fileExistsAtPath:filePath]) {
        [fileManager createFileAtPath:filePath contents:nil attributes:nil];
    }
    //如果想检视文件有没有生成，可以在视图上添加一个Label，加一行代码显示地址。 filePath
    //    outLb.text = documentDirectory;
    //    NSLog(@"%@",outLb.text);
    //    NSLog(@"%@",filePath);
    
    //读写文件
    //读取文件数据：
    //分别用NSData 和NSString,NSMutableDictionary来读取文件内容
    NSFileHandle *outFile;
    NSData *buffer;
    
    _dataArr = [[[BluetoothDataSqlTool alloc] init] queryAllBluetoothDataShowModels];
    
    
    //上传的时间
    //    if (_dataCode == 200) {
    //        NSDate *date=[NSDate date];
    //        NSTimeInterval timeStamp= [date timeIntervalSince1970];
    //        long time = (long)timeStamp;
    //        [de setValue:[NSString stringWithFormat:@"%ld",time] forKey:@"upSucceedTime"];
    //        [de setValue:@"1" forKey:@"isupSucceed"];
    //
    //    }
    
    //    1463246011
    
    
    for (int i = 0; i<_dataArr.count; i++) {
        
        //把数据写入文件
        //        NSString* fileName = [[directoryPaths objectAtIndex:0]stringByAppendingPathComponent:textName];
        outFile = [NSFileHandle fileHandleForWritingAtPath:filePath];
        if(outFile == nil)
        {
            NSLog(@"打开的文件编写失败了");
        }
        //找到并定位到outFile的末尾位置(在此后追加文件)
        [outFile seekToEndOfFile];
        //读取inFile并且将其内容写到outFile中
        
        BluetoothDataModel *dataModel = _dataArr[i];
        
//        NSLog(@"model.time = %ld,model.type = %@,model.A = %@,model.B = %@,model.deviceid = %@",dataModel.time,dataModel.type,dataModel.A,dataModel.B,dataModel.deviceid);
        
        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:dataModel.time];
        //        NSString *time = [[NSString alloc] initWithDate:confromTimesp format:@"yyyy-MM-dd hh:mm:ss"];
        
        NSString *str = [NSString stringWithFormat:@"%@,%@,%@,%@,%@,\n",dataModel.deviceid,confromTimesp,dataModel.type,dataModel.A,dataModel.B];
        if (i == _dataArr.count -1) {
            str = [NSString stringWithFormat:@"%@,%@,%@,%@,%@",dataModel.deviceid,confromTimesp,dataModel.type,dataModel.A,dataModel.B];
        }
        
        buffer = [str dataUsingEncoding:NSUTF8StringEncoding];
        [outFile writeData:buffer];
        //        buffer = [@"\n" dataUsingEncoding:NSUTF8StringEncoding];
        //        [outFile writeData:buffer];
        
    }
    //    NSLog(@"%@",filePath);
    /*
     //用NSString读取
     NSString* myString = [NSString stringWithContentsOfFile:filePath usedEncoding:NULL error:NULL];
     NSLog(@"读取文件 = %@",myString);
     //把数据写入文件
     NSString* fileName = [[directoryPaths objectAtIndex:0]stringByAppendingPathComponent:@"testText"];
     NSString *tempStr = @"123";
     //对于错误信息
     NSError *error;
     [tempStr writeToFile:fileName atomically:YES encoding:NSUTF8StringEncoding error:&error];
     */
    //用NSData读取
    NSData* fileData = [NSData dataWithContentsOfFile:filePath];
    //    NSLog(@"未压缩的文件%@",fileData);
    //压缩
    NSData *ysData = [LFCGzipUtility gzipData:fileData];
    [ysData writeToFile:result_filePath atomically:YES];
    NSLog(@"压缩地址%@",result_filePath);
    
    //删除文件
    [self deleteFileTextName:_textNameTail];
    
    //关闭读写文件
    [outFile closeFile];
    
    //上传文件
    [self POSTExample];
    //用NSMutableDictionary读取
    //    NSMutableDictionary* dict = [[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
    //删除文件
    NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSError *error;
    //在filePath2中判断是否删除这个文件
    if ([fileManager removeItemAtPath:result_filePath error:&error] != YES)
        NSLog(@"无法删除文件: %@", [error localizedDescription]);
    //显示文件目录的内容
    NSLog(@"Documentsdirectory: %@",
          [fileManager contentsOfDirectoryAtPath:documentsDirectory error:&error]);
}

#pragma mark 日期转星期
-(NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], NSLocalizedString(@"dateutil_week_7", nil), NSLocalizedString(@"dateutil_week_1", nil), NSLocalizedString(@"dateutil_week_2", nil), NSLocalizedString(@"dateutil_week_3", nil), NSLocalizedString(@"dateutil_week_4", nil), NSLocalizedString(@"dateutil_week_5", nil), NSLocalizedString(@"dateutil_week_6", nil), nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
