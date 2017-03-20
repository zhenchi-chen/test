//
//  AppDelegate.m
//  GOSPEL
//
//  Created by 陈镇池 on 16/4/21.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import "AppDelegate.h"

#import "SqlVersionTool.h"
#import "StartViewController.h"

#import "DetailViewController.h"
#import "AddViewController.h"
#import "LoginController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //  友盟的方法本身是异步执行，所以不需要再异步调用
    [self umengTrack];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //数据库操作
    [SqlVersionTool updateVersion];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES]; //不锁屏
    
    
    //设置statusBar,电量,信号 颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self createMyAppView];
    
    
   
    
    //网络连接状态
    [GWNotification addHandler:^(NSDictionary *handleDic) {
        NSInteger code = [[handleDic valueForKey:@"code"] integerValue];
        NSString *msg = [handleDic valueForKey:@"msg"];
        dispatch_async(dispatch_get_main_queue(), ^{
            //主线程内容
            [self accessCode:code andMsg:msg];
        });
        
    } withName:@"后台返回状态"];
   
    

    return YES;
}

#pragma mark -- 友盟统计
-(void)umengTrack {
    
    [GWStatisticalUtil openTheStatistics];
    [GWStatisticalUtil setAppVersionNumber:XcodeAppVersion];
    [GWStatisticalUtil setCrashReportCollection:YES];

}

#pragma mark -- 推送
-(void)pushApp {
    //推送
    
    //该方法一定要写在appdelegate
    if ([[UIDevice currentDevice].systemVersion floatValue]<=8.0)
    {
        //iOS8.0以前使用的方法
        //注册远程推送的类型
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
        
    }
    else
    {
        //iOS8以后的使用方法
        //1.创建一个推送的设置对象
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
        
        //2.将创建好的setting赋值给application
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
        //3.注册一个远程推送
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
    }
    
}

#pragma mark -- 建立我自己的view
-(void)createMyAppView
{
    

    //详情页
    DetailViewController *detailVC = [[DetailViewController alloc]init];
    //添加导航控制器
    _nc1 = [[UINavigationController alloc] initWithRootViewController:detailVC];
    //导航控制器分两个部分  外观(背景色,背景图片,是否半透明) 和内容(标题,左侧内容,右侧内容);
    //取消半透明
    _nc1.navigationBar.translucent = NO;
    //导航栏的颜色
    _nc1.navigationBar.barTintColor = [UIColor whiteColor];
    //导航栏字体颜色,大小
    [_nc1 .navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont systemFontOfSize:18 weight:1],NSFontAttributeName, nil]];
    [_nc1 setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    
    AddViewController *addVC = [[AddViewController alloc] init];
    //添加导航控制器
    _nc2 = [[UINavigationController alloc] initWithRootViewController:addVC];
    //导航控制器分两个部分  外观(背景色,背景图片,是否半透明) 和内容(标题,左侧内容,右侧内容);
    //取消半透明
    _nc2.navigationBar.translucent = NO;
    //导航栏的颜色
    _nc2.navigationBar.barTintColor = [UIColor whiteColor];
    //导航栏字体颜色,大小
    [_nc2.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont systemFontOfSize:18 weight:1],NSFontAttributeName, nil]];
    [_nc2 setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    
    //去掉 NavigationBar 底部的那条黑线
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
   
    

    //启动页
    StartViewController *startVC = [[StartViewController alloc]init];
    //无登陆页面进入
    self.window.rootViewController = startVC;


    

}

//访问
- (void)accessCode:(NSInteger)code andMsg:(NSString *)msg{
    
    switch (code) {
        case 12001:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12001", nil)];
            [self join];
        }
            break;
        case 12002:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12002", nil)];
            [self join];
        }
            break;
        case 12003:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12003", nil)];
            [self join];
        }
            break;
        case 12004:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12004", nil)];
            
        }
            break;
        case 12005:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12005", nil)];
            
        }
            break;
        case 12006:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12006", nil)];
            
        }
            break;
        case 12007:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12007", nil)];
            
        }
            break;
        case 12008:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12008", nil)];
            
        }
        case 12009:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12009", nil)];
            
        }
            break;
        case 12010:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12010", nil)];
            
        }
            break;
        case 12011:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12011", nil)];
            
        }
            break;
        case 12012:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12012", nil)];
            
        }
            break;
        case 12013:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12013", nil)];
            
        }
            break;
        case 12014:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12014", nil)];
            
        }
            break;
        case 12015:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12015", nil)];
            
        }
            break;
        case 12016:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12016", nil)];
            
        }
            break;
        case 12020:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12020", nil)];
            
        }
            break;
        case 12021:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12021", nil)];
            
        }
            break;
        case 12022:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12022", nil)];
            
        }
            break;
        case 12023:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12023", nil)];
            
        }
            break;
        case 12024:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12024", nil)];
            
        }
            break;
        case 12025:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12025", nil)];
            
        }
            break;
        case 12030:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12030", nil)];
            
        }
            break;
        case 12031:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12031", nil)];
            
        }
            break;
        case 12032:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12032", nil)];
            
        }
            break;
        case 12033:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12033", nil)];
            
        }
            break;
        case 12034:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12034", nil)];
            
        }
            break;
        case 12036:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12036", nil)];
            
        }
            break;
        case 12037:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12037", nil)];
            
        }
            break;
        case 12038:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12038", nil)];
            
        }
            break;
        case 12040:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12040", nil)];
            
        }
            break;
        case 12041:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12041", nil)];
            
        }
            break;
        case 12042:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12042", nil)];
            
        }
            break;
        case 12043:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12043", nil)];
            
        }
            break;
        case 12044:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12044", nil)];
            
        }
            break;
        case 12045:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12045", nil)];
            
        }
            break;
        case 12046:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12046", nil)];
            
        }
            break;
        case 12047:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12047", nil)];
            
        }
            break;
        case 12048:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12048", nil)];
            
        }
            break;
        case 12049:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12049", nil)];
            
        }
            break;
        case 12050:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12050", nil)];
            
        }
            break;
        case 12060:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12060", nil)];
            
        }
            break;
        case 12070:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12070", nil)];
            
        }
            break;
            
        case 12071:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12071", nil)];
            
        }
            break;
        case 12080:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12080", nil)];
            
        }
            break;
        case 12081:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12081", nil)];
            
        }
            break;
            
        case 12082:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12082", nil)];
            
        }
            break;
        case 12090:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12090", nil)];
            
        }
            break;
        case 12091:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12091", nil)];
            
        }
            break;
        case 12092:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12092", nil)];
            
        }
            break;
            
        case 12093:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12093", nil)];
            
        }
            break;
        case 12100:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12100", nil)];
            
        }
            break;
        case 12101:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12101", nil)];
            
        }
            break;
        case 12110:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_12110", nil)];
            
        }
            break;
            
        default:
        {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%ld,%@",(long)code,msg]];
        }
            break;
    }
    
}

//跳到登陆页
- (void)join{
    
//    if (self.window.rootViewController!=nil) {
//        [self.window.rootViewController removeFromParentViewController];
//        self.window.rootViewController = nil;
//    }
    //移除所有通知方法
//    [GWNotification removeAllHandle];
    
    LoginController *lodinVC = [[LoginController alloc]init];
    self.window.rootViewController = lodinVC;
    [self.nc1 popToRootViewControllerAnimated:YES];
    [self.nc2 popToRootViewControllerAnimated:YES];
    
}

#pragma -mark获取deviceToken的方法
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
//    NSLog(@"deviceToken = %@",deviceToken);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

#pragma mark 进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    //关闭线程
//    [[BluetoothDataManagement shareInstranse] closeGCDAction];
//    NSUserDefaults *de = [NSUserDefaults standardUserDefaults];
//    [de setValue:@"0" forKey:@"readData"];
//    [de setValue:@"0" forKey:@"bluetoothOFF"];
//    [de setValue:@"0" forKey:@"deviceOFF"];
    
    [[UIApplication sharedApplication]beginBackgroundTaskWithExpirationHandler:^(){
        //程序在10分钟内未被系统关闭或者强制关闭，则程序会调用此代码块，可以在这里做一些保存或者清理工作
        NSLog(@"程序关闭");
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

#pragma mark 进入前台
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    //开始线程
//    [[BluetoothDataManagement shareInstranse] openGCDAction];
    
}

#pragma mark 退出程序走的最后一个方法
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    NSLog(@"程序即将销毁");
}



@end
