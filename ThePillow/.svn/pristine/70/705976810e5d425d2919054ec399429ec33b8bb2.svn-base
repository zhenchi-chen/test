//
//  StartViewController.m
//  GOSPEL
//
//  Created by 陈镇池 on 16/5/20.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import "StartViewController.h"
#import "LoginController.h"
#import "AppDelegate.h"
#import "DetailViewController.h"
#import "AddViewController.h"
#import "ListModel.h"
#import "StartPageViewController.h"

@interface StartViewController ()
{
    NSUserDefaults *de;
}

@end

@implementation StartViewController

#pragma 网络数据返回
-(void)httpBaseRequestUtilDelegate:(NSData *)data api:(NSString *)api reqDic:(NSMutableDictionary *)reqDic reqHeadDic:(NSMutableDictionary *)reqHeadDic rspHeadDic:(NSMutableDictionary *)rspHeadDic{
    if ([api isEqualToString:@"第一页"]) {
        if (data != nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"dic = %@",dic);
            BaseDataModel *baseModel = [BaseDataModel objectWithKeyValues:dic];
            NSDictionary *dataDic = (NSDictionary *)baseModel.data;
            if (baseModel.code == 200) {
                if ([[dataDic objectForKey:@"Count"] intValue] == 0) {
                    if (![@"1" isEqualToString:[de valueForKey:@"isStartPageView"]]) {//非首次启动
                        [de setValue:@"1" forKey:@"isStartPageView"];
                        StartPageViewController *startPageVC = [[StartPageViewController alloc]init];
                        [startPageVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
                        [self presentViewController: startPageVC animated:YES completion:nil];
                    }else {
                        kAppDelegate.window.rootViewController = kAppDelegate.nc2;
                        [de setValue:@"1" forKey:@"bind_myTag"];
                    }
                } else {
                    NSArray *devcieArr = [dataDic objectForKey:@"Items"];
                    NSMutableArray *tempArray = [NSMutableArray array];
                    for (int i = 0;i<devcieArr.count; i++) {
                        ListModel *listModel = [[ListModel alloc] init];
                        listModel.devicename = [[devcieArr[i] objectForKey:@"devicename"] objectForKey:@"S"];
                        listModel.did = [[devcieArr[i] objectForKey:@"did"] objectForKey:@"S"];
                        listModel.portrait = [[devcieArr[i] objectForKey:@"portrait"] objectForKey:@"S"];
                        listModel.rule = [[devcieArr[i] objectForKey:@"rule"] objectForKey:@"S"];
                        [tempArray addObject:listModel];
                    }
                    
                    if (![@"1" isEqualToString:[de valueForKey:@"isStartPageView"]]) {//非首次启动
                        [de setValue:@"1" forKey:@"isStartPageView"];
                        StartPageViewController *startPageVC = [[StartPageViewController alloc]init];
                        [startPageVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
                        [self presentViewController: startPageVC animated:YES completion:nil];
                    }else {
                        kAppDelegate.window.rootViewController = kAppDelegate.nc1;
                    }
                }
       
            }
        } else {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_wrong_prompt", nil)];
            if (![@"1" isEqualToString:[de valueForKey:@"isStartPageView"]]) {//非首次启动
            
                [de setValue:@"1" forKey:@"isStartPageView"];
                StartPageViewController *startPageVC = [[StartPageViewController alloc]init];
                [startPageVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
                [self presentViewController: startPageVC animated:YES completion:nil];
                
            }else {
                LoginController *loginVC = [[LoginController alloc]init];
                kAppDelegate.window.rootViewController = loginVC;
                [self.navigationController popViewControllerAnimated:YES];
            }
           
        }
        
        
    }else {
        
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_time_out", nil)];
        
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置导航栏的背景色,如果设置颜色,模糊效果会消失
    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    
    self.navigationItem.leftBarButtonItem = nil;
    
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight)];
//    imageView.image = [UIImage imageNamed:@"960"];
//    [self.view addSubview:imageView];
    
    
    de = [NSUserDefaults standardUserDefaults];
    
   
//    HttpBaseRequestUtil *req = [[HttpBaseRequestUtil alloc] init];
//    req.myDelegate = self;
//    NSMutableDictionary *reqDic = [NSMutableDictionary dictionary];
//    [reqDic setValue:@"第一页" forKey:@"api"];
//    [reqDic setValue:[de valueForKey:@"username"] forKey:@"username"];
//    [reqDic setValue:[de valueForKey:@"token"] forKey:@"token"];
//    [req reqDataWithUrl:DEVICE_LIST reqDic:reqDic reqHeadDic:nil];
    
    self.view.backgroundColor = MainColor;
    
    UILabel *nameLb = [[UILabel alloc]init];
    nameLb.size = CGSizeMake(300, 50);
    nameLb.font = [UIFont systemFontOfSize:50];
    nameLb.center = self.view.center;
    nameLb.text = NSLocalizedString(@"app_name", nil);
    nameLb.textColor = MainColorWhite;
    nameLb.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:nameLb];
    

    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:3.0f];
}

- (void)delayMethod {
    if (![@"1" isEqualToString:[de valueForKey:@"isStartPageView"]]) {//非首次启动
        [de setValue:@"1" forKey:@"isStartPageView"];
        StartPageViewController *startPageVC = [[StartPageViewController alloc]init];
        [startPageVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self presentViewController: startPageVC animated:YES completion:nil];
    }else {
        NSMutableArray *listArray = [[[DeviceListTool alloc]init]queryAllDeviceListShowModels];
        if (listArray.count == 0) {
            kAppDelegate.window.rootViewController = kAppDelegate.nc2;
            [de setValue:@"1" forKey:@"bind_myTag"];
        }else {
            kAppDelegate.window.rootViewController = kAppDelegate.nc1;
        }
        
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
