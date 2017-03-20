//
//  PersonalInformationViewController.m
//  GOSPEL
//
//  Created by 陈镇池 on 16/6/28.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import "PersonalInformationViewController.h"
#import "ChooseAvatarView.h"
#import "LoginController.h"
#import "PersonalInformationCell.h"
#import "zySheetPickerView.h"
#import "JXAlertview.h"
#import "AbstractActionSheetPicker+Interface.h"//这个是定义取消和确定按钮
#import "ActionSheetPicker.h"
#import "XKPEActionPickersDelegate.h"
#import "XKPEWeightAndHightActionPickerDelegate.h"
#import "ActionSheetDatePicker.h"
#import "AddressChoicePickerView.h"
#import "AreaObject.h"
#import "UIImage+LXDCreateBarcode.h" //二维码生成
#import "UserInfoModel.h"
#import "GWNSStringUtil.h"

@interface PersonalInformationViewController ()<UITableViewDelegate,UITableViewDataSource,ChooseAvatarViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIView *headView;
    UIImageView *faceIv;
    UIView *backgroundView; //弹窗底色
    ChooseAvatarView *chooseAvatarView; //弹窗选择头像
    int chooseAvatarNum; //你点击的图片
    
    UserInfoModel *userInfoModel; //个人资料
    
    UIView *viewHei; //二维码弹窗
    UIView *baiVie;
    UIImageView *ewmIV; //二维码图片
    
  
   

}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *textArray;
@property (nonatomic,strong)NSMutableArray *dataArr;






@end

@implementation PersonalInformationViewController



#pragma mark 头部显示
- (void)headerView {
    
    headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 150*Height)];
    headView.backgroundColor = MainColor;
    
    faceIv = [[UIImageView alloc]initWithFrame:CGRectMake(MainScreenWidth/2-45*Height, 30*Height, 90*Height, 90*Height)];
    faceIv.image = [self choosePictureNum:[userInfoModel.portrait intValue]];
    faceIv.userInteractionEnabled  = YES;
    [headView addSubview:faceIv];
    //轻拍手势 UITapGestureRecognizer
    MyTap *tap = [[MyTap alloc]initWithTarget:self action:@selector(faceIvAction)];
    [faceIv addGestureRecognizer:tap];
    

    
    
}

#pragma mark 头像点击
- (void)faceIvAction {
    
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight)];
    backgroundView.backgroundColor = RGBA(0, 0, 0, 0.7);
    [window addSubview:backgroundView];
    
    MyTap *tapView = [[MyTap alloc]initWithTarget:self action:@selector(backgroundViewAction)];
    [backgroundView addGestureRecognizer:tapView];
    
    
    if (chooseAvatarView == nil) {
        chooseAvatarView = [[ChooseAvatarView alloc]initWithFrame:CGRectMake(10*Width, MainScreenHeight/3, MainScreenWidth-20*Width, MainScreenHeight/3)];
        chooseAvatarView.backgroundColor = [UIColor whiteColor];
        chooseAvatarView.delegate = self;
        [backgroundView addSubview:chooseAvatarView];
        
    }
}

#pragma mark 弹窗消失
- (void)backgroundViewAction{
    
    if (chooseAvatarView != nil) {
        [chooseAvatarView removeFromSuperview];
        chooseAvatarView = nil;
    }
    
    if (backgroundView != nil) {
        [backgroundView removeFromSuperview];
        backgroundView = nil;
    }
}





#pragma mark 更改个人信息
- (void)ProfileChange {
  
    
     NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    if (userInfoModel.gender != nil) {
        [tempDic setValue:userInfoModel.gender forKey:@"gender"];
    }
    if (userInfoModel.age !=nil) {
        [tempDic setValue:userInfoModel.age forKey:@"age"];
    }
    if (userInfoModel.height != nil) {
        [tempDic setValue:userInfoModel.height forKey:@"height"];
    }
    if (userInfoModel.weight != nil) {
        [tempDic setValue:userInfoModel.weight forKey:@"weight"];
    }
    
    if (userInfoModel.portrait != nil) {
        [tempDic setValue:userInfoModel.portrait forKey:@"portrait"];
        faceIv.image = [self choosePictureNum:[userInfoModel.portrait intValue]];
        
        [[UpdateDeviceData sharedManager]setUpdateDataDeviceModel:_device andtype:UserInfo_Set andChangeName:@"userInfo" andChangeDetail:[GWNSStringUtil convertToJSONString:tempDic]];
        [GWNotification pushHandle:nil withName:@"更新设备信息"];
    }else {
        [[UpdateDeviceData sharedManager]setUpdateDataDeviceModel:_device andtype:UserInfo_Set andChangeName:@"userInfo" andChangeDetail:[GWNSStringUtil convertToJSONString:tempDic]];
    }
    
    
    [_tableView reloadData];
}

#pragma mark 你点击的是哪张头像
- (void)didSelectChooseAvatarViewWithNum:(NSInteger)num {
    
    chooseAvatarNum = (int)num;
    userInfoModel.portrait = [NSString stringWithFormat:@"%d",chooseAvatarNum];
    [self ProfileChange];
    [self backgroundViewAction];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self navSet:NSLocalizedString(@"personal_fragment_title",nil)];
    
    //导航右边按钮
    UIButton *rightBt = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBt.frame = CGRectMake(0, 30, NavSize, NavSize);
//    [rightBt setImage:[UIImage imageNamed:@"list"] forState:UIControlStateNormal];
        rightBt.frame = CGRectMake(0, 30, 80, 30);
        [rightBt setTitle:@"设置" forState:UIControlStateNormal];
    [rightBt setTitleColor:MainColor forState:UIControlStateNormal];
    [rightBt addTarget:self action:@selector(navigationSetButtons:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBt];

    userInfoModel = [UserInfoModel objectWithKeyValues:[GWNSStringUtil dictionaryToJsonString:_device.userInfo]];
    
    //测试数组
    self.textArray = [[NSMutableArray alloc]initWithObjects:NSLocalizedString(@"personal_fragment_sex",nil),@"年龄",NSLocalizedString(@"personal_fragment_height",nil),NSLocalizedString(@"personal_fragment_weight",nil), nil];

    //加载个人信息
    [self headerView];
    

    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight)];
    _tableView.backgroundColor = [UIColor whiteColor];
    //分割线颜色
    _tableView.separatorColor = RGB(212, 212, 212);
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.tableHeaderView = headView;
    _tableView.bounces = NO;
    [self.view addSubview:_tableView];
    
}
#pragma mark 设置
- (void)navigationSetButtons:(UIButton *)button {
    
}






#pragma -mark每个分区里面有多少个cell
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 4;
    }
    else
    {
        return 0;
    }

    
}

#pragma -mark创建每个cell的方法

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusepool = @"cell";
    PersonalInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:reusepool];
    if (cell == nil) {
        cell = [[PersonalInformationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusepool];
    }
    
    NSInteger t = 0;
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            if (userInfoModel.gender.length != 0) {
                if ([userInfoModel.gender integerValue] == 1) {
                    cell.contentLb.text = NSLocalizedString(@"personal_fragment_man",nil);
                }else {
                    cell.contentLb.text = NSLocalizedString(@"personal_fragment_woman",nil);
                }
                
                cell.contentLb.textColor = RGB(138, 138, 138);
            }else {
                cell.contentLb.textColor = RGB(77, 207, 199);
                cell.contentLb.text = NSLocalizedString(@"personal_fragment_none",nil);
            }
        }else if (indexPath.row == 1){
            if (userInfoModel.age.length != 0) {
                cell.contentLb.text = userInfoModel.age;
                cell.contentLb.textColor = RGB(138, 138, 138);
            }else {
                cell.contentLb.textColor = RGB(77, 207, 199);
                cell.contentLb.text = NSLocalizedString(@"personal_fragment_none",nil);
            }
        }else if (indexPath.row == 2){
            if (userInfoModel.height.length != 0) {
                cell.contentLb.text = userInfoModel.height;
                cell.contentLb.textColor = RGB(138, 138, 138);
                
            }else {
                cell.contentLb.textColor = RGB(77, 207, 199);
                cell.contentLb.text = NSLocalizedString(@"personal_fragment_none",nil);
                
            }
        }else if (indexPath.row == 3){
            if (userInfoModel.weight.length != 0) {
                cell.contentLb.text = userInfoModel.weight;
                cell.contentLb.textColor = RGB(138, 138, 138);
            }else {
                cell.contentLb.textColor = RGB(77, 207, 199);
                cell.contentLb.text = NSLocalizedString(@"personal_fragment_none",nil);
            }
        }

    }

    cell.titleLb.text = self.textArray[indexPath.row+t];
    
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
        if (indexPath.row == 0) {
            [self sexSelect];
        }else if (indexPath.row == 1) {
            [self ageSelect];
            
        }else if (indexPath.row == 2) {
            [self heightSelect];
            
        }else if (indexPath.row == 3) {
            [self bodyWeightSelect];
        }
    }

}


//设置分区个数,默认为1个
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//分区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}


#pragma mark 我的二维码 
- (void)ewmMy {
    if (viewHei == nil) {
        UIWindow* window = [UIApplication sharedApplication].keyWindow;
        viewHei = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight)];
        viewHei.backgroundColor = RGBA(0, 0, 0, 0.7);
        [window addSubview:viewHei];
        MyTap *tapView = [[MyTap alloc]initWithTarget:self action:@selector(viewHeiAction:)];
        [viewHei addGestureRecognizer:tapView];
        
        
    }
    
    if (ewmIV == nil) {
        UIImage * image = [UIImage imageOfQRFromURL: @"https://itunes.apple.com/cn/app/shui-mian-guan-jia/id930053298?mt=8" codeSize: 300 red: 0 green: 0 blue: 0 insertImage: [UIImage imageNamed: @"logo2"] roundRadius: 15.0f];
        CGSize size = image.size;
        
        baiVie = [[UIView alloc]init];
        baiVie.x = (MainScreenWidth -300)/2;
        baiVie.y = (MainScreenHeight -300)/2;
        baiVie.size = image.size;
        baiVie.backgroundColor = [UIColor whiteColor];
        [viewHei addSubview:baiVie];

        ewmIV = [[UIImageView alloc] initWithFrame:  ((CGRect){(CGPointZero), (size)})];
        ewmIV.image = image;
        [baiVie addSubview: ewmIV];
        
        
      
    }

}
- (void)viewHeiAction:(MyTap *)tap {
    if (viewHei != nil) {
        [viewHei removeFromSuperview];
        viewHei = nil;
    }
    
    if (ewmIV != nil) {
        [ewmIV removeFromSuperview];
        ewmIV = nil;
    }
    
    if (baiVie != nil) {
        [baiVie removeFromSuperview];
        baiVie = nil;
    }
}


#pragma mark 性别选择
- (void)sexSelect {
    
    NSArray * str  = @[NSLocalizedString(@"personal_fragment_man",nil),NSLocalizedString(@"personal_fragment_woman",nil)];
    zySheetPickerView *pickerView = [zySheetPickerView ZYSheetStringPickerWithTitle:str andHeadTitle:@"" Andcall:^(zySheetPickerView *pickerView, NSString *choiceString) {
   
        NSLog(@"选择结果:%@",choiceString);
        if ([choiceString isEqualToString:NSLocalizedString(@"personal_fragment_man",nil)]) {
            userInfoModel.gender = @"1";
        }else if ([choiceString isEqualToString:NSLocalizedString(@"personal_fragment_woman",nil)]) {
            userInfoModel.gender = @"2";
        }
        
        [self ProfileChange];
        [pickerView dismissPicker];
    }];
    [pickerView show];
}

#pragma mark 选择身高
- (void)heightSelect{
    
    NSMutableArray *dataArr = [[NSMutableArray alloc]init];
    for (NSInteger i=0; i<=250; i++) {
        NSString *datastr = [NSString stringWithFormat:@"%ldcm",i];
        [dataArr addObject:datastr];
    }
    ActionSheetStringPicker *actionPicker = [[ActionSheetStringPicker alloc]initWithTitle:@"" rows:dataArr initialSelection:160 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        //*********一组点击确认按钮做处理************
        NSLog(@"选择的身高%@",selectedValue);
        userInfoModel.height = selectedValue;
        [self ProfileChange];
        
    } cancelBlock:^(ActionSheetStringPicker *picker) {
        
    } origin:self.view];
    [actionPicker customizeInterface];
    [actionPicker showActionSheetPicker];

    
}

#pragma mark 选择体重
- (void)bodyWeightSelect{
    
    NSMutableArray *dataArr = [[NSMutableArray alloc]init];
    for (NSInteger i=0; i<=200; i++) {
        NSString *datastr = [NSString stringWithFormat:@"%ldkg",i];
        [dataArr addObject:datastr];
    }
    ActionSheetStringPicker *actionPicker = [[ActionSheetStringPicker alloc]initWithTitle:@"" rows:dataArr initialSelection:40 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        //*********一组点击确认按钮做处理************
        NSLog(@"选择的体重%@",selectedValue);
        userInfoModel.weight = selectedValue;
        [self ProfileChange];
    } cancelBlock:^(ActionSheetStringPicker *picker) {
        
    } origin:self.view];
    [actionPicker customizeInterface];
    [actionPicker showActionSheetPicker];
}



#pragma mark 选择年龄
- (void)ageSelect{
    
    NSMutableArray *dataArr = [[NSMutableArray alloc]init];
    for (NSInteger i=10; i<=100; i++) {
        NSString *datastr = [NSString stringWithFormat:@"%ld",i];
        [dataArr addObject:datastr];
    }
    ActionSheetStringPicker *actionPicker = [[ActionSheetStringPicker alloc]initWithTitle:@"" rows:dataArr initialSelection:10 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        //*********一组点击确认按钮做处理************
        NSLog(@"选择的年龄:%@",selectedValue);
        userInfoModel.age = selectedValue;
        [self ProfileChange];
    } cancelBlock:^(ActionSheetStringPicker *picker) {
        
    } origin:self.view];
    [actionPicker customizeInterface];
    [actionPicker showActionSheetPicker];
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
