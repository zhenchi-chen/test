//
//  StartPageViewController.m
//  Kids
//
//  Created by 陈镇池 on 2016/12/13.
//  Copyright © 2016年 chen_zhenchi_lehu. All rights reserved.
//

#import "StartPageViewController.h"
#import "DetailViewController.h"
#import "AddViewController.h"
#import "LoginController.h"

@interface StartPageViewController ()<UIScrollViewDelegate>
{
    UIButton *promptBt;
}
@property (nonatomic,strong)UIScrollView *scrollViewData; //显示数据的scrollView
@property(nonatomic,retain)UIPageControl *pageControl;
@property(nonatomic,assign)int number; //滚动位置

@end

@implementation StartPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNacColorWhite];
    
    //加载数据的ScrollView
    [self layoutScrollView];
    
    //加载ScrollView的内容
    [self layoutView];
    
    promptBt = [self buildBtn:@"下一步" action:@selector(promptBtAction) frame:CGRectMake((MainScreenWidth-230)/2, MainScreenHeight-120, 200, 50)];
    promptBt.centerX = self.pageControl.centerX;
    [self.view addSubview:promptBt];
    
    
    UIButton *skipBt = [UIButton buttonWithType:UIButtonTypeCustom];
    skipBt.frame = CGRectMake((MainScreenWidth-130)/2, MainScreenHeight-60, 100, 30);
    [skipBt setTitleColor:MainColorDarkGrey forState:UIControlStateNormal];
    [skipBt setTitle:@"跳过" forState:UIControlStateNormal];
    [skipBt.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [skipBt addTarget:self action:@selector(skipBtAction) forControlEvents:UIControlEventTouchUpInside];
    skipBt.centerX = self.pageControl.centerX;
    [self.view addSubview:skipBt];
}
#pragma -mark 下一步
- (void)promptBtAction {
    
    if (_number == 2) {
        [self skipBtAction];
    }else {
      
        _scrollViewData.contentOffset = CGPointMake(MainScreenWidth*(_number+1), 0);
        self.pageControl.currentPage = _number;
    }
   
}
#pragma -mark 跳过
- (void)skipBtAction {
    LoginController *loginVC = [[LoginController alloc]init];
    kAppDelegate.window.rootViewController = loginVC;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma -mark ScrollView的布局和相关属性
-(void)layoutScrollView
{
    
   
    
    _scrollViewData = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,MainScreenWidth, MainScreenHeight)];
    _scrollViewData.pagingEnabled = YES;
    _scrollViewData.userInteractionEnabled = YES;
    _scrollViewData.backgroundColor = [UIColor clearColor];
    _scrollViewData.showsHorizontalScrollIndicator = NO;
    _scrollViewData.showsVerticalScrollIndicator = NO;
    _scrollViewData.contentSize = CGSizeMake(MainScreenWidth*3, 0);
    _scrollViewData.contentOffset = CGPointMake(0, 0);
    _scrollViewData.delegate = self;
    _scrollViewData.bounces = YES;
    [self.view addSubview:_scrollViewData];
    
    //页码控制器
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(20, MainScreenHeight-160, MainScreenWidth-40, 40)];
    [self.view addSubview:self.pageControl];
    //颜色
//    self.pageControl.backgroundColor = [UIColor yellowColor];
    self.pageControl.currentPageIndicatorTintColor = MainColor;
    self.pageControl.pageIndicatorTintColor = MainColorLightGrey;
    //设置可以存放的view数量
    self.pageControl.numberOfPages = 3;

    //指定pagecontrol的代理人
    [self.pageControl addTarget:self action:@selector(clickMe:) forControlEvents:UIControlEventValueChanged];
}
#pragma -mark布局在ScrollView上的要滑动的内容
-(void)layoutView
{
    
    for (int i = 0; i < 3; i++) {
        
        if (i == 0) {
            UIImageView *photoIV = [[UIImageView alloc]initWithFrame:CGRectMake(i*MainScreenWidth, 20*Height+64, MainScreenWidth, MainScreenWidth*7/10)];
            photoIV.image = [UIImage imageNamed:@"qd"];
            [_scrollViewData addSubview:photoIV];
    
            //标题
            UILabel *titleLb = [[UILabel alloc]init];
            titleLb.text = @"智能检测打鼾并辅助干预";
            titleLb.textColor = MainColorDarkGrey;
            titleLb.font = [UIFont systemFontOfSize:16];
            //根据字体得到宽度
            //    CGFloat width = [UILabel getWidthWithTitle:titleLb.text font:titleLb.font];
            // 根据字体得到NSString的尺寸
            CGSize titleLbSize = [titleLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:titleLb.font,NSFontAttributeName, nil]];
            titleLb.size = titleLbSize;
            titleLb.centerX = photoIV.centerX;
            titleLb.y = height_y(photoIV)+20*Height;
            [_scrollViewData  addSubview:titleLb];
            
            UILabel *lbl_text = [[UILabel alloc]initWithFrame:CGRectMake(20*Width, height_y(titleLb)+10*Height, MainScreenWidth-40*Width, 0)];
            lbl_text.font = [UIFont systemFontOfSize:12];
            lbl_text.textAlignment = NSTextAlignmentCenter;
            lbl_text.text = @"智能辅助止鼾枕可以有效减少60%的鼾声，帮助您\n和家人安静睡眠环境";
            lbl_text.numberOfLines = 0;//多行显示，计算高度
            lbl_text.textColor = MainColorDarkGrey;
            CGFloat heightLb = [UILabel getLabelHeight:12 labelWidth:lbl_text.width content:lbl_text.text];
            lbl_text.height = heightLb;
            [_scrollViewData addSubview:lbl_text];

            
        }else if (i == 1){
            UIImageView *photoIV = [[UIImageView alloc]initWithFrame:CGRectMake(i*MainScreenWidth, 20*Height+64, MainScreenWidth, MainScreenWidth*7/10)];
            photoIV.image = [UIImage imageNamed:@"qd"];
            [_scrollViewData addSubview:photoIV];
            
            //标题
            UILabel *titleLb = [[UILabel alloc]init];
            titleLb.text = @"静音闹钟轻松勿扰";
            titleLb.textColor = MainColorDarkGrey;
            titleLb.font = [UIFont systemFontOfSize:16];
            //根据字体得到宽度
            //    CGFloat width = [UILabel getWidthWithTitle:titleLb.text font:titleLb.font];
            // 根据字体得到NSString的尺寸
            CGSize titleLbSize = [titleLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:titleLb.font,NSFontAttributeName, nil]];
            titleLb.size = titleLbSize;
            titleLb.centerX = photoIV.centerX;
            titleLb.y = height_y(photoIV)+20*Height;
            [_scrollViewData  addSubview:titleLb];
            
            UILabel *lbl_text = [[UILabel alloc]initWithFrame:CGRectMake(i*MainScreenWidth+20*Width, height_y(titleLb)+10*Height, MainScreenWidth-40*Width, 0)];
            lbl_text.font = [UIFont systemFontOfSize:12];
            lbl_text.textAlignment = NSTextAlignmentCenter;
            lbl_text.text = @"静音闹钟让您从宁静中醒来，而不会影响他人";
            lbl_text.numberOfLines = 0;//多行显示，计算高度
            lbl_text.textColor = MainColorDarkGrey;
            CGFloat heightLb = [UILabel getLabelHeight:12 labelWidth:lbl_text.width content:lbl_text.text];
            lbl_text.height = heightLb;
            [_scrollViewData addSubview:lbl_text];
        }else if (i== 2){
            
            UIImageView *photoIV = [[UIImageView alloc]initWithFrame:CGRectMake(i*MainScreenWidth, 20*Height+64, MainScreenWidth, MainScreenWidth*7/10)];
            photoIV.image = [UIImage imageNamed:@"qd"];
            [_scrollViewData addSubview:photoIV];
            
            //标题
            UILabel *titleLb = [[UILabel alloc]init];
            titleLb.text = @"睡眠报告详细可靠";
            titleLb.textColor = MainColorDarkGrey;
            titleLb.font = [UIFont systemFontOfSize:16];
            //根据字体得到宽度
            //    CGFloat width = [UILabel getWidthWithTitle:titleLb.text font:titleLb.font];
            // 根据字体得到NSString的尺寸
            CGSize titleLbSize = [titleLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:titleLb.font,NSFontAttributeName, nil]];
            titleLb.size = titleLbSize;
            titleLb.centerX = photoIV.centerX;
            titleLb.y = height_y(photoIV)+20*Height;
            [_scrollViewData  addSubview:titleLb];
            
            UILabel *lbl_text = [[UILabel alloc]initWithFrame:CGRectMake(i*MainScreenWidth+20*Width, height_y(titleLb)+10*Height, MainScreenWidth-40*Width, 0)];
            lbl_text.font = [UIFont systemFontOfSize:12];
            lbl_text.textAlignment = NSTextAlignmentCenter;
            lbl_text.text = @"近20项睡眠指标，让您详细了解整晚睡眠情况，轻\n松改善睡眠";
            lbl_text.numberOfLines = 0;//多行显示，计算高度
            lbl_text.textColor = MainColorDarkGrey;
            CGFloat heightLb = [UILabel getLabelHeight:12 labelWidth:lbl_text.width content:lbl_text.text];
            lbl_text.height = heightLb;
            [_scrollViewData addSubview:lbl_text];
        }
        
        
    }
}

//点击小圆点
-(void)clickMe:(UIPageControl *)pg
{
    //    NSLog(@"%ld", pg.currentPage);
    //动画换页
    [_scrollViewData setContentOffset:CGPointMake(MainScreenWidth * pg.currentPage, 0) animated:YES];
}


#pragma -mark scrollerView代理方法 一旦滚动就会执行
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
//    self.pageControl.currentPage = scrollView.contentOffset.x/MainScreenWidth;//这种方式在后退的时候小圆点会动的比较快
    int i = _scrollViewData.contentOffset.x/MainScreenWidth;
    _number = i;
    if (i== 2){
        [promptBt setTitle:@"完成" forState:UIControlStateNormal];
    }else {
        [promptBt setTitle:@"下一步" forState:UIControlStateNormal];
    }

    
    
}

//减速结束
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    //滚动的时候设置下面的小圆点
    self.pageControl.currentPage = _scrollViewData.contentOffset.x/MainScreenWidth + 1;//这种方式改变如果快速切图,小圆点会忽然跳跃过去
    
    if (_scrollViewData.contentOffset.x == MainScreenWidth * self.number) {
        _scrollViewData.contentOffset = CGPointMake(MainScreenWidth * self.number, 0);
        self.pageControl.currentPage = self.number;
    }else if(_scrollViewData.contentOffset.x == 0){
        _scrollViewData.contentOffset = CGPointMake(MainScreenWidth, 0);
        self.pageControl.currentPage = 0;
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
