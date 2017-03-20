//
//  SnoreAuxiliaryViewController.m
//  Kids
//
//  Created by 陈镇池 on 2016/12/14.
//  Copyright © 2016年 chen_zhenchi_lehu. All rights reserved.
//

#import "SnoreAuxiliaryViewController.h"
#import "SnoreSetViewViewController.h"
#import "SnoreAuxiliaryCell.h"

@interface SnoreAuxiliaryViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *footerView;
    UIButton *stateBt;
    ConfigModel *snore; //打鼾震动设置
    BOOL isClick; //是否点击选择
}

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *titleArray;



@end

@implementation SnoreAuxiliaryViewController

#pragma mark 已经消失页面
- (void)viewDidDisappear:(BOOL)animated {

}

#pragma mark 页面已经出现
- (void)viewDidAppear:(BOOL)animated {
   

}

#pragma mark 返回上一个页面
- (void)navigationLeftButton:(UIButton *)button {
    if (isClick) {
        [[UpdateDeviceData sharedManager]setUpdateDataDeviceModel:_device andtype:Snore_Set andChangeName:@"snore" andChangeDetail:[GWNSStringUtil convertToJSONString:[snore keyValues]]];
    }
    //返回到上一个页面
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self navSet:@"欢迎使用止鼾辅助"];
    
    
     snore = [ConfigModel objectWithKeyValues:[GWNSStringUtil dictionaryToJsonString:_device.snore]];

        //测试数组
    self.titleArray = [[NSMutableArray alloc]initWithObjects:@"轻度辅助",@"一般辅助",@"重度辅助",@"魔鬼时间辅助", nil];
    
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
    
    
    stateBt = [self buildBtn:@"止鼾辅助已关闭"action:@selector(stateBtAction) frame:CGRectMake(MainScreenWidth/4, 50, MainScreenWidth/2, 50*Height)];
    if ([snore.select intValue] != 0) {
        stateBt.selected = YES;
        stateBt.backgroundColor = MainColor;
    }else {
        stateBt.selected = NO;
        stateBt.backgroundColor = [UIColor lightGrayColor];
    }
//    [stateBt setTitleColor:MainColorLightGrey forState:UIControlStateNormal];
//    [stateBt setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [stateBt setTitle:@"止鼾辅助开启中" forState:UIControlStateSelected];
    [footerView addSubview:stateBt];
    
}

- (void)stateBtAction {
    if (stateBt.selected) {
        stateBt.selected = NO;
        snore.select = @"0";
        stateBt.backgroundColor = [UIColor lightGrayColor];
        snore.isValid = @"0";
        [_tableView reloadData];
    }else {
        stateBt.selected = YES;
        stateBt.backgroundColor = MainColor;
        snore.select = @"1";
        snore.isValid = @"0";
        [_tableView reloadData];
    }
    
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
    if ([snore.select intValue] == 0) {
        cell.photoIV.image = [UIImage imageNamed:@"无效"];
    }else {
        if (indexPath.section == [snore.select integerValue]-1) {
            cell.photoIV.image = [UIImage imageNamed:@"choose"];
        }else {
            cell.photoIV.image = [UIImage imageNamed:@"无效"];
        }
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
    if (!stateBt.selected) {
        stateBt.selected = YES;
        stateBt.backgroundColor = MainColor;
        
    }
    snore.select = [NSString stringWithFormat:@"%ld",(long)indexPath.section+1];
    snore.isValid = @"0";
    [_tableView reloadData];
    isClick = YES;
//    for (int i=0; i<tableView.visibleCells.count; i++) {
//        SnoreAuxiliaryCell *cell = [tableView.visibleCells objectAtIndex:i];
//        if (i==indexPath.section) {
//            cell.photoIV.image = [UIImage imageNamed:@"choose"];
//        }
////        else if (indexPath.section == 4) {
////            break;
////        }
//        else {
//            cell.photoIV.image = [UIImage imageNamed:@"无效"];
//        }
//    }
//    if (indexPath.section == 0) {
//        [self getDataNunber:2 andTime:100 andInterval:100];
//    }else if (indexPath.section == 1) {
//        [self getDataNunber:3 andTime:100 andInterval:100];
//    }else if (indexPath.section == 2) {
//        [self getDataNunber:4 andTime:100 andInterval:100];
//    }else if (indexPath.section == 3) {
//        [self getDataNunber:5 andTime:100 andInterval:100];
//    }else if (indexPath.section == 4) {
//        SnoreSetViewViewController *snoreSetVC = [[SnoreSetViewViewController alloc]init];
//        [self.navigationController pushViewController:snoreSetVC animated:YES];
//    }
    
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
