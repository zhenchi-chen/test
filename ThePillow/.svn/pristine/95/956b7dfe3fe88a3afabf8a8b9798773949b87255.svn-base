//
//  AlarmClockTwoViewController.m
//  Kids
//
//  Created by 陈镇池 on 2016/12/15.
//  Copyright © 2016年 chen_zhenchi_lehu. All rights reserved.
//

#import "AlarmClockTwoViewController.h"
#import "SnoreAuxiliaryCell.h"
#import "AlarmClockThreeViewController.h"
#import "SnoreSetViewViewController.h"

@interface AlarmClockTwoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *footerView;
    UIButton *nextBt;
    NSInteger select; //选择的是哪一个
    ConfigModel *clockMode; //闹钟强度模式
    DeviceModel *deviceModelTemp;
}

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *titleArray;


@end

@implementation AlarmClockTwoViewController

#pragma mark 已经消失页面
- (void)viewDidDisappear:(BOOL)animated {
    
}

#pragma mark 页面已经出现
- (void)viewDidAppear:(BOOL)animated {

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self navSet:@"选择叫醒模式"];
    
    deviceModelTemp = [[[DeviceListTool alloc]init] queryDeviceListShowModelDevice:[de valueForKey:@"bind_deviceId"]];
    Clock *clock = [Clock objectWithKeyValues:[GWNSStringUtil dictionaryToJsonString:deviceModelTemp.clock]];
    clockMode = [ConfigModel objectWithKeyValues:clock.clockMode];
    
    //标题数组
    self.titleArray = [[NSMutableArray alloc]initWithObjects:@"轻度震动",@"正常震动",@"重度震动",@"魔鬼震动", nil];
    
    if (select == 0) {
        select = 1;
    }
    
    
    [self initFooterView];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.tableFooterView =footerView;
    _tableView.bounces = NO;
    [self.view addSubview:_tableView];
    
}

#pragma mark 加载FooterView
- (void)initFooterView
{
    footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 100)];
    //    footerView.backgroundColor = [UIColor lightGrayColor];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 1)];
    line.backgroundColor = RGB(240, 240, 240);
    [footerView addSubview:line];
    
    
    nextBt = [self buildBtn:@"下一步"action:@selector(nextBtAction) frame:CGRectMake(MainScreenWidth/4, 50, MainScreenWidth/2, 50*Height)];
    [footerView addSubview:nextBt];
    
}

- (void)nextBtAction {
    
    clockMode.select = [NSString stringWithFormat:@"%ld",(long)select];
    clockMode.isValid = @"0";
    
    [[UpdateDeviceData sharedManager]setUpdateDataDeviceModel:deviceModelTemp andtype:Clock_Set andChangeName:@"clockMode" andChangeDetail:[GWNSStringUtil convertToJSONString:[clockMode keyValues]]];
    
    
    AlarmClockThreeViewController *alarmClockThreeVC = [[AlarmClockThreeViewController alloc]init];
    [self.navigationController pushViewController:alarmClockThreeVC animated:YES];
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
    if (indexPath.section == select-1) {
        cell.photoIV.image = [UIImage imageNamed:@"choose"];
    }else {
        cell.photoIV.image = [UIImage imageNamed:@"无效"];
    }
    
    //点击cell的颜色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma -mark设置cell的高度的方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}


#pragma mark -- 点击cell方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    select = indexPath.section+1;
    [_tableView reloadData];
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
