//
//  MyCenterViewController.m
//  GOSPEL
//
//  Created by 陈镇池 on 16/6/27.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import "MyCenterViewController.h"
#import "SwitchingDeviceController.h"
#import "NewsViewController.h"
#import "PersonalInformationViewController.h"
#import "PersonalInformationModel.h"
#import "LoginController.h"

@interface MyCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *headView;
    UIImageView *faceIv;
    UILabel *nameLb;
    UILabel *addressLb;
    UILabel *phoneLb;
  
    PersonalInformationModel *personalIFModel;

}
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *imageArr;
@property (nonatomic,strong)NSMutableArray *textArray;
@property (nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation MyCenterViewController


#pragma 网络数据返回
-(void)httpBaseRequestUtilDelegate:(NSData *)data api:(NSString *)api reqDic:(NSMutableDictionary *)reqDic reqHeadDic:(NSMutableDictionary *)reqHeadDic rspHeadDic:(NSMutableDictionary *)rspHeadDic{
    if ([api isEqualToString:@"第一页"]) {
        if (data != nil) {
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"dic = %@",dic);
            BaseDataModel *baseModel = [BaseDataModel objectWithKeyValues:dic];
            if (baseModel.code == 200) {
                if (baseModel.data != nil) {
                    NSDictionary *tempDic = (NSDictionary *)baseModel.data;
                    personalIFModel = [[PersonalInformationModel alloc]init];
                    personalIFModel.gender = [[tempDic objectForKey:@"gender"] objectForKey:@"S"];
                    personalIFModel.birthday = [[tempDic objectForKey:@"birthday"] objectForKey:@"S"];
                    personalIFModel.height = [[tempDic objectForKey:@"height"] objectForKey:@"S"];
                    personalIFModel.weight = [[tempDic objectForKey:@"weight"] objectForKey:@"S"];
                    personalIFModel.region = [[tempDic objectForKey:@"region"] objectForKey:@"S"];
                    personalIFModel.portrait = [[tempDic objectForKey:@"portrait"] objectForKey:@"S"];
                    personalIFModel.name = [[tempDic objectForKey:@"name"] objectForKey:@"S"];
                }
                if (personalIFModel.portrait != nil) {
                    [self chooseAvatarNum:[personalIFModel.portrait intValue]];
                }else {
                    [self chooseAvatarNum:0];
                }
                
                [_tableView reloadData];
                
            }
            
        }else {
            //            [dropDownSCView headerEndRefreshing];
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_wrong_prompt", nil)];
        }
        
        
    }     
}



#pragma mark 头部显示
- (void)headerView {
    
    headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 180*Height)];
    headView.backgroundColor = RGB(77, 207, 199);
    
    faceIv = [[UIImageView alloc]initWithFrame:CGRectMake(MainScreenWidth/2-45*Height, 30*Height, 90*Height, 90*Height)];
    faceIv.userInteractionEnabled  = YES;
    [headView addSubview:faceIv];
    [self chooseAvatarNum:0];
    //轻拍手势 UITapGestureRecognizer
    MyTap *tap = [[MyTap alloc]initWithTarget:self action:@selector(faceIvAction)];
    [faceIv addGestureRecognizer:tap];
    
    UIView *bj = [[UIView alloc]initWithFrame:CGRectMake(0, 150*Height, MainScreenWidth, 30*Height)];
    bj.backgroundColor = RGB(255, 255, 255);
    [headView addSubview:bj];
    
    nameLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth/3-0.5, 30*Height)];
    nameLb.textColor = RGB(77, 207, 199);
    nameLb.textAlignment = NSTextAlignmentCenter;
    nameLb.text = @"名字";
    nameLb.font = [UIFont systemFontOfSize:12];
    [bj addSubview:nameLb];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(width_x(nameLb), nameLb.y+5*Height, 1, 20*Height)];
    line1.backgroundColor = RGB(238, 238, 238);
    [bj addSubview:line1];
    
    phoneLb = [[UILabel alloc]initWithFrame:CGRectMake(MainScreenWidth/3+0.5, nameLb.y, MainScreenWidth/3-1, 30*Height)];
    phoneLb.textColor = RGB(77, 207, 199);
    phoneLb.textAlignment = NSTextAlignmentCenter;
    phoneLb.text = @"电话";
    phoneLb.font = [UIFont systemFontOfSize:12];
    [bj addSubview:phoneLb];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(width_x(phoneLb), line1.y, 1, 20*Height)];
    line2.backgroundColor = RGB(238, 238, 238);
    [bj addSubview:line2];
    
    addressLb = [[UILabel alloc]initWithFrame:CGRectMake(width_x(line2), nameLb.y, MainScreenWidth/3-0.5, 30*Height)];
    addressLb.textColor = RGB(77, 207, 199);
    addressLb.textAlignment = NSTextAlignmentCenter;
    addressLb.text = @"地址";
    addressLb.font = [UIFont systemFontOfSize:12];
    [bj addSubview:addressLb];


    
}


#pragma mark 头像点击
- (void)faceIvAction {
    
    PersonalInformationViewController *personalIVC = [[PersonalInformationViewController alloc]init];
    [self.navigationController pushViewController:personalIVC animated:YES];
}

#pragma mark 头像显示
- (void)chooseAvatarNum:(NSInteger)num {
    switch (num) {
        case 0:
            faceIv.image = [UIImage imageNamed:@"moren"];
            break;
        case 1:
            faceIv.image = [UIImage imageNamed:@"headPortrait1"];
            break;
        case 2:
            faceIv.image = [UIImage imageNamed:@"headPortrait2"];
            break;
        case 3:
            faceIv.image = [UIImage imageNamed:@"headPortrait3"];
            break;
        case 4:
            faceIv.image = [UIImage imageNamed:@"headPortrait4"];
            break;
        case 5:
            faceIv.image = [UIImage imageNamed:@"headPortrait5"];
            break;
        case 6:
            faceIv.image = [UIImage imageNamed:@"headPortrait6"];
            break;
        default:
            break;
    }
}

#pragma mark 请求网络
- (void)initData {
    HttpBaseRequestUtil *req1 = [[HttpBaseRequestUtil alloc] init];
    req1.myDelegate = self;
    NSMutableDictionary *reqDic1 = [NSMutableDictionary dictionary];
    [reqDic1 setValue:@"第一页" forKey:@"api"];
    [reqDic1 setValue:[de valueForKey:@"username"] forKey:@"username"];
    [reqDic1 setValue:[de valueForKey:@"token"] forKey:@"token"];
    [req1 reqDataWithUrl:Get_Profile reqDic:reqDic1 reqHeadDic:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self navSet:@"个人中心"];
        
    self.view.backgroundColor = RGB(243, 244, 246);
    
 
    
    //测试数组
    self.imageArr = [[NSMutableArray alloc] initWithObjects:@"logo1",@"101",@"102",@"103",@"104",@"105",@"106",@"107",@"108", nil];
    self.textArray = [[NSMutableArray alloc]initWithObjects:@"我的消息",@"亲友请求",@"我的收藏",@"我的设备", nil];
    
    
    [self initData];
    
    //加载个人信息
    [self headerView];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight-49)];
    _tableView.backgroundColor = RGB(238, 238, 238);
    //分割线颜色
    _tableView.separatorColor = RGB(212, 212, 212);
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.tableHeaderView = headView;
    _tableView.bounces = NO;
    [self.view addSubview:_tableView];

    
    
}
#pragma -mark每个分区里面有多少个cell
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 3;
    }
    else
    {
        return 1;
    }
    
}

#pragma -mark创建每个cell的方法

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusepool = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusepool];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusepool];
    }
    
    NSInteger t = 0;
    if (indexPath.section == 1) {
        t = 3;
    }
    
    cell.textLabel.text = self.textArray[indexPath.row+t];
    cell.textLabel.textColor = RGB(138, 138, 138);
    //    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"logo%ld",indexPath.row+1 + t]];
    
    // 设置图片大小
    UIImage *icon = [UIImage imageNamed:self.imageArr[indexPath.row+t]];
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
        switch (indexPath.row) {
            case 0:
            {
                NewsViewController *newsVC = [[NewsViewController alloc]init];
                [self.navigationController pushViewController:newsVC animated:YES];
            }
                break;
            case 1:
            {
                
            }
                break;
                
            case 2:
            {
                
                
            }
                break;
            default:
                break;
        }
        
    }
    else if (indexPath.section == 1)
    {
        SwitchingDeviceController *listVC = [[SwitchingDeviceController alloc]init];
        [self.navigationController pushViewController:listVC animated:YES];
    }
   
}


//设置分区个数,默认为1个
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

//分区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
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
