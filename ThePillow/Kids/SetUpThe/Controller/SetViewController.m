//
//  SetViewController.m
//  PingHuoTuan
//
//  Created by 陈镇池 on 15/12/22.
//  Copyright © 2015年 陈镇池. All rights reserved.
//

#import "SetViewController.h"
#import "LoginController.h"
#import "SwitchingDeviceController.h"
#import "CommonProblemViewController.h"
#import "HowToUseViewController.h"
#import "AddViewController.h"
#import "MyCenterViewController.h"
#import "PersonalInformationViewController.h"
#import "AboutViewController.h"


@interface SetViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *arr;
   
    UIView *footerView;
   
}

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation SetViewController


#pragma 网络数据返回
-(void)httpBaseRequestUtilDelegate:(NSData *)data api:(NSString *)api reqDic:(NSMutableDictionary *)reqDic reqHeadDic:(NSMutableDictionary *)reqHeadDic rspHeadDic:(NSMutableDictionary *)rspHeadDic{
    if ([api isEqualToString:@"第一页"]) {
        if (data != nil) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"dic = %@",dic);
            BaseDataModel *baseModel = [BaseDataModel objectWithKeyValues:dic];
            NSDictionary *dataDic = (NSDictionary *)baseModel.data;
            
            
            if (baseModel.code == 200) {
                if (baseModel.data != nil) {
                    
                    
                } else {
                    [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"detail_fragment_chart_no_data",nil)];
                }
            }
        } else {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_wrong_prompt",nil)];
        }
        
        
    }
    
    
    
}



#pragma mark 加载FooterView
- (void)initFooterView
{
    footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 100)];
    footerView.backgroundColor = RGB(247, 247, 247);
    
    UIButton *exitBt = [UIButton buttonWithType:UIButtonTypeCustom];
    exitBt.frame = CGRectMake(0, 0, 200, 35);
    exitBt.centerX = MainScreenWidth/2;
    exitBt.centerY = footerView.height/2;
//    exitBt.backgroundColor = RGB(77, 207, 199);
    [exitBt setBackgroundImage:RGB(77, 207, 199).image forState:UIControlStateNormal];
    [exitBt setTitle:NSLocalizedString(@"personal_fragment_logout",nil) forState:UIControlStateNormal];
    exitBt.layer.cornerRadius = 3;
    exitBt.clipsToBounds = YES;
    [exitBt addTarget:self action:@selector(exitBtAction:) forControlEvents:UIControlEventTouchUpInside];
//    [footerView addSubview:exitBt];

    
    UILabel *versionLb = [[UILabel alloc]initWithFrame:CGRectMake(0,40, MainScreenWidth, 30)];
    versionLb.textAlignment = NSTextAlignmentCenter;
    versionLb.text = [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"setting_fragment_version",nil),Software_version];
    [footerView addSubview:versionLb];
}

#pragma mark 退出登陆
- (void)exitBtAction:(UIButton *)button
{
    HttpBaseRequestUtil *req = [[HttpBaseRequestUtil alloc] init];
    req.myDelegate = self;
    NSMutableDictionary *reqDic = [NSMutableDictionary dictionary];
    [reqDic setValue:@"第一页" forKey:@"api"];
    [reqDic setValue:[de valueForKey:@"username"] forKey:@"username"];
    [reqDic setValue:[de valueForKey:@"token"] forKey:@"token"];
    [req reqDataWithUrl:LOGOUT reqDic:reqDic reqHeadDic:nil];
    
    LoginController *loginVC = [[LoginController alloc] init];
    loginVC.tagNum = 2;
    [de setValue:nil forKey:@"token"];
    kAppDelegate.window.rootViewController = loginVC;
    [self.navigationController popViewControllerAnimated:YES];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self navSet:NSLocalizedString(@"setting_fragment_title",nil)];
    
    self.view.backgroundColor = RGB(247, 247, 247);
    

    arr = @[NSLocalizedString(@"device_list_fragment_title",nil),NSLocalizedString(@"no_device_fragment_title",nil),NSLocalizedString(@"how_to_use_fragment_title",nil),NSLocalizedString(@"question_fragment_title",nil),NSLocalizedString(@"personal_fragment_title",nil),NSLocalizedString(@"about_fragment_title",nil)];
    
    //加载底部的View
    [self initFooterView];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight)];
    _tableView.backgroundColor = RGB(247, 247, 247);
    //分割线颜色
//    _tableView.separatorColor = RGB(212, 212, 212);
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = footerView;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _tableView.bounces = NO;
    [self.view addSubview:_tableView];

    
}

#pragma -mark每个分区里面有多少个cell
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    if (section == 0||section == 1) {
//        return 1;
//    }
//    else if (section == 2)
//    {
//        return 3;
//    }
//    else
//    {
//        return 2;
//    }
     return 1;
}

#pragma -mark创建每个cell的方法

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusepool = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusepool];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusepool];
    }
    
    cell.textLabel.text = arr[indexPath.section];
    cell.textLabel.textColor = RGB(0, 0, 0);

    // 设置图片大小
    UIImage *icon = [UIImage imageNamed:@"switch"];
    if (indexPath.section == 1) {
        icon = [UIImage imageNamed:@"tzsb"];
    }else if (indexPath.section == 2){
        icon = [UIImage imageNamed:@"使用说明"];
    }else if (indexPath.section == 3){
        icon = [UIImage imageNamed:@"常见问题"];
    }else if (indexPath.section == 4){
        icon = [UIImage imageNamed:@"my"];
    }else if (indexPath.section == 5){
        icon = [UIImage imageNamed:@"关于"];
    }
    
    
    
    CGSize itemSize = CGSizeMake(25, 25);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO,0.0);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [icon drawInRect:imageRect];
    
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if (indexPath.section == 2 && indexPath.row == 1) {
        UIView *badgeView = [[UIView alloc] init];
        badgeView.size = CGSizeMake(10, 10);
        badgeView.center = CGPointMake(iPhone_Plus ? 45 : 40, 12.5);
        badgeView.backgroundColor = [UIColor redColor];
        badgeView.layer.cornerRadius = badgeView.width / 2.0;
        badgeView.clipsToBounds = YES;
        [cell addSubview:badgeView];
        
    }
    
    
    
    //点击cell的颜色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


#pragma -mark设置cell的高度的方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
    
    
}


#pragma mark -- 点击cell方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        SwitchingDeviceController *switchingVC = [[SwitchingDeviceController alloc]init];
        [self.navigationController pushViewController:switchingVC animated:YES];
    }
    else if (indexPath.section == 1){
        AddViewController *plusDeviceVC = [[AddViewController alloc]init];
        self.navigationController.navigationBar.tintColor =[UIColor whiteColor];
        [self.navigationController pushViewController:plusDeviceVC animated:YES];
    }
    else if (indexPath.section == 2){
        
        HowToUseViewController *howTUVC = [[HowToUseViewController alloc]init];
        [self.navigationController pushViewController:howTUVC animated:YES];
    }
    else if (indexPath.section == 3){
        CommonProblemViewController *commonPVC = [[CommonProblemViewController alloc]init];
        [self.navigationController pushViewController:commonPVC animated:YES];
    }
    else if (indexPath.section == 4){
//        MyCenterViewController *myCVC = [[MyCenterViewController alloc]init];
        PersonalInformationViewController *myCVC = [[PersonalInformationViewController alloc]init];
        [self.navigationController pushViewController:myCVC animated:YES];
    }
    else if (indexPath.section == 5){
        AboutViewController *aboutVC = [[AboutViewController alloc]init];
        [self.navigationController pushViewController:aboutVC animated:YES];

    }
    
    
}


//设置分区个数,默认为1个
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arr.count;
}

//分区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 20;
    }else {
        return 5;
    }
    
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
