//
//  ClockVibrationSettingViewController.m
//  ThePillow
//
//  Created by 陈镇池 on 2017/1/22.
//  Copyright © 2017年 chen_zhenchi_lehu. All rights reserved.
//

#import "ClockVibrationSettingViewController.h"
#import "SnoreAuxiliaryCell.h"

@interface ClockVibrationSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    Clock *clock;
    BOOL isClick; //是否点击选择
}

@property (nonatomic,strong)NSMutableArray *titleArray;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)ConfigModel *clockMode; //闹钟强度模式

@end

@implementation ClockVibrationSettingViewController

#pragma mark 返回上一个页面
- (void)navigationLeftButton:(UIButton *)button {
    if (isClick) {
        [[UpdateDeviceData sharedManager]setUpdateDataDeviceModel:deviceModel andtype:Clock_Set andChangeName:@"clockMode" andChangeDetail:[GWNSStringUtil convertToJSONString:[_clockMode keyValues]]];
    }
    //返回到上一个页面
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self navSet:@"闹钟震动强度设置"];
   
    deviceModel = [[[DeviceListTool alloc]init] queryDeviceListShowModelDevice:_deviceDid];
    clock = [Clock objectWithKeyValues:[GWNSStringUtil dictionaryToJsonString:deviceModel.clock]];
     _clockMode = [ConfigModel objectWithKeyValues:clock.clockMode];
    if ([_clockMode.select intValue] == 0) {
        _clockMode.select = @"1";
        isClick = YES;
    }
    self.titleArray = [[NSMutableArray alloc]initWithObjects:@"轻度震动",@"正常震动",@"重度震动",@"魔鬼震动", nil];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.bounces = NO;
    [self.view addSubview:_tableView];

}

#pragma -mark每个分区里面有多少个cell
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

#pragma -mark创建每个cell的方法

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusepool = @"cell";
    SnoreAuxiliaryCell *cell = [tableView dequeueReusableCellWithIdentifier:reusepool];
    if (cell == nil) {
        cell = [[SnoreAuxiliaryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusepool];
    }
    
    cell.nameLb.text = [_titleArray objectAtIndex:indexPath.section];
    if (indexPath.section == [_clockMode.select integerValue]-1) {
        cell.photoIV.image = [UIImage imageNamed:@"choose"];
    }else {
        cell.photoIV.image = [UIImage imageNamed:@"无效"];
    }
    
    //点击cell的颜色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    if (indexPath.section == _titleArray.count-1) {
    //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //    }else {
    //        cell.accessoryType = UITableViewCellAccessoryNone;
    //    }
    
    return cell;
}


#pragma -mark设置cell的高度的方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}


#pragma mark -- 点击cell方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    _clockMode.select = [NSString stringWithFormat:@"%ld",(long)indexPath.section+1];
    _clockMode.isValid = @"0";
    [_tableView reloadData];
    
    
    isClick = YES;
  
//    for (int i=0; i<tableView.visibleCells.count; i++) {
//        SnoreAuxiliaryCell *cell = [tableView.visibleCells objectAtIndex:i];
//        if (i==indexPath.section) {
//            cell.photoIV.image = [UIImage imageNamed:@"choose"];
//        }
//        //        else if (indexPath.section == 4) {
//        //            break;
//        //        }
//        else {
//            cell.photoIV.image = [UIImage imageNamed:@"无效"];
//        }
//    }
//    
//    if (indexPath.section == 0) {
//        
//    }else if (indexPath.section == 1) {
//       
//    }else if (indexPath.section == 2) {
//        
//    }else if (indexPath.section == 3) {
//        
//    }else if (indexPath.section == 4) {
//       
//    }
//    
}


//设置分区个数,默认为1个
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _titleArray.count;
}

//分区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
