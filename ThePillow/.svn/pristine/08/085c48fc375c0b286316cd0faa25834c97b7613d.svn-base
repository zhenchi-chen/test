//
//  SoftwareDiaryViewController.m
//  ThePillow
//
//  Created by 陈镇池 on 2017/1/11.
//  Copyright © 2017年 chen_zhenchi_lehu. All rights reserved.
//

#import "SoftwareDiaryViewController.h"


@interface SoftwareDiaryViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat cellWidth;
    CGFloat cellHeight;
    
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *array;

@end

@implementation SoftwareDiaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self navSet:@"软件日记"];
    
    //导航右边按钮
    UIButton *rightBt = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBt.frame = CGRectMake(0, 30, 50, 30);
    [rightBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBt setTitle:@"清空" forState:UIControlStateNormal];
    [rightBt addTarget:self action:@selector(navigationRightBt:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBt];
    
    _array = [NSMutableArray array];
    _array = [[[[BluetoothLogSqlTool alloc]init]queryAllBluetoothLogShowModels] mutableCopy];;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight-64)];
    _tableView.backgroundColor = [UIColor whiteColor];
    //分割线颜色
    _tableView.separatorColor = RGB(212, 212, 212);
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //_tableView.bounces = NO;
    [self.view addSubview:_tableView];

    
}

//清空列表
- (void)navigationRightBt:(UIButton *)btuton {
    [[[BluetoothLogSqlTool alloc]init]deleteAllData];
    _array = nil;
    [_array removeAllObjects];
    [_tableView reloadData];
}


#pragma -mark每个分区里面有多少个cell
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _array.count;
}

#pragma -mark创建每个cell的方法

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusepool = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusepool];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusepool];
    }
    LogModel *logModel = [[LogModel alloc]init];
    logModel = [_array objectAtIndex:indexPath.row];
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.numberOfLines = 0;//多行显示，计算高度
    cell.textLabel.text = [NSString stringWithFormat:@"%@\n%@\n%@",logModel.time,logModel.deviceID,logModel.title];
    cellWidth = cell.textLabel.width;
//    CGFloat heightLb = [UILabel getLabelHeight:14 labelWidth:cellWidth content:cell.textLabel.text];
    cell.textLabel.height = cellHeight-20;
    //点击cell的颜色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


#pragma -mark设置cell的高度的方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LogModel *logModel = [[LogModel alloc]init];
    logModel = [_array objectAtIndex:indexPath.row];
    NSString *textStr = [NSString stringWithFormat:@"%@\n%@\n%@",logModel.time,logModel.deviceID,logModel.title];
    CGFloat heightLb = [UILabel getLabelHeight:14 labelWidth:cellWidth content:textStr];
    cellHeight = heightLb+20;
    return cellHeight;
    
    
    
}


#pragma mark -- 点击cell方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
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
