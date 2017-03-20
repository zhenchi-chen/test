//
//  NewsViewController.m
//  GOSPEL
//
//  Created by 陈镇池 on 16/6/22.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsModel.h"
#import "MessageTableViewCell.h"

@interface NewsViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong)NSMutableArray *msgArr;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,assign)CGFloat myCellHeight;

@end

@implementation NewsViewController

#pragma 网络数据返回
-(void)httpBaseRequestUtilDelegate:(NSData *)data api:(NSString *)api reqDic:(NSMutableDictionary *)reqDic reqHeadDic:(NSMutableDictionary *)reqHeadDic rspHeadDic:(NSMutableDictionary *)rspHeadDic{
    if ([api isEqualToString:@"消息"]) {
        if (data != nil) {
            
            _msgArr = [NSMutableArray array];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"dic = %@",dic);
            BaseDataModel *baseModel = [BaseDataModel objectWithKeyValues:dic];
            if (baseModel.code == 200) {
                if (baseModel.data != nil) {
                    NSArray *dataArr = (NSArray *)baseModel.data;
                    for (NSDictionary *dicTemp in dataArr) {
                        NewsModel *newsModel = [[NewsModel alloc]init];
                        newsModel.content = [[dicTemp objectForKey:@"content"] objectForKey:@"S"];
                        newsModel.title = [[dicTemp objectForKey:@"title"] objectForKey:@"S"];
                        newsModel.type = [[dicTemp objectForKey:@"type"] objectForKey:@"S"];
                        newsModel.create_at = [[dicTemp objectForKey:@"create_at"] objectForKey:@"S"];
                        newsModel.monitor = [[dicTemp objectForKey:@"monitor"] objectForKey:@"S"];
                        [_msgArr addObject:newsModel];
                        //                        NSLog(@"%@,->%@",newsModel.title,newsModel.content);
                    }
                    [_tableView reloadData];
                    [_tableView headerEndRefreshing]; //让下拉刷新控件消失
                    
                } else {
                    [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"detail_fragment_chart_no_data", nil)];
                }
 
            }else {
                [_tableView headerEndRefreshing]; //让下拉刷新控件消失
            }
        } else {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_wrong_prompt", nil)];
        }
    }else if([api isEqualToString:@"删除消息"]) {
        if (data != nil) {
            
           
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"dic = %@",dic);
            BaseDataModel *baseModel = [BaseDataModel objectWithKeyValues:dic];
            if (baseModel.code == 200) {
                [self initData];
                
            }
        } else {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_wrong_prompt", nil)];
        }
    } else {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_wrong_prompt", nil)];
    }
    
    
    
    
}



#pragma mark 请求网络
- (void)initData {
    HttpBaseRequestUtil *req1 = [[HttpBaseRequestUtil alloc] init];
    req1.myDelegate = self;
    NSMutableDictionary *reqDic1 = [NSMutableDictionary dictionary];
    [reqDic1 setValue:@"消息" forKey:@"api"];
    [reqDic1 setValue:[de valueForKey:@"username"] forKey:@"username"];
    [reqDic1 setValue:[de valueForKey:@"token"] forKey:@"token"];
    [reqDic1 setValue:@"10" forKey:@"limit"];
    [req1 reqDataWithUrl:QUERY_MONITO_MSG reqDic:reqDic1 reqHeadDic:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self navSet:@"我的消息"];
    self.view.backgroundColor = RGB(243, 244, 246);
    
 

    //请求数据
    [self initData];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    //下拉刷新
    [_tableView addHeaderWithTarget:self action:@selector(headReloadData)];
    
}

#pragma mark 下拉刷新
-(void)headReloadData
{
    [self initData];
}


#pragma -mark每个分区里面有多少个cell
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _msgArr.count;
}

#pragma -mark创建每个cell的方法

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusepool = @"cell";
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusepool];
    if (cell == nil) {
        cell = [[MessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusepool];
    }
    
    
   
    NewsModel *newsModel = [_msgArr objectAtIndex:indexPath.row];
    cell.model = newsModel;
    
    _myCellHeight = cell.cellHeight;
    
    //点击cell的颜色
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma -mark设置cell的高度的方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.myCellHeight;
    
    
    
}


#pragma mark -- 点击cell方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}


/**
 * 删除设备
 */
#pragma -mark点击编辑按钮执行的方法（第一步）
-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    //必须要让父类也调用该方法，不用只能进入到编辑状态，不能返回原始状态
    [super setEditing:editing animated:animated];
    
    //点击编辑按钮的时候，让表视图处于可编辑状态
    [self.tableView setEditing:editing animated:animated];
}

#pragma -mark设置单元格是否可以编辑(第二步)
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    //默认是都可编辑的，如果，你的需要是都可以编辑，该方法可以不写
    //    if (indexPath.row==4)
    //    {
    //        return NO;
    //    }
    return YES;
}
#pragma -mark设置单元格是删除样式还是添加的样式(第三步)
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCellEditingStyle style = UITableViewCellEditingStyleDelete;
    return style;
}
#pragma -mark真正的根据编辑的样式去删除和添加(第四步)
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsModel *newsModel = _msgArr[indexPath.row];
    
    HttpBaseRequestUtil *req = [[HttpBaseRequestUtil alloc] init];
    req.myDelegate = self;
    NSMutableDictionary *reqDic = [NSMutableDictionary dictionary];
    [reqDic setValue:@"删除消息" forKey:@"api"];
    [reqDic setValue:[de valueForKey:@"username"] forKey:@"username"];
    [reqDic setValue:[de valueForKey:@"token"] forKey:@"token"];
//    [reqDic setValue:[de valueForKey:@"devcieIDD"] forKey:@"deviceID"];
    [reqDic setValue:newsModel.monitor forKey:@"from"];
    [reqDic setValue:newsModel.create_at forKey:@"create_at"];
    [req reqDataWithUrl:DELETE_MONITOR_MSG reqDic:reqDic reqHeadDic:nil];
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
