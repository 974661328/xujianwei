//
//  MainTabBarController.m
//  HWXMovie
//
//  Created by 周小立 on 16/6/24.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import "MainTabBarController.h"
#import "HWXTabBarItem.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tab_bg_all"]];
    
    // Do any additional setup after loading the view.
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
//用故事版创建的话会在移除之后重新添加上去
-(void)viewWillAppear:(BOOL)animated
{
    //先调用父类的viewWillAppear方法
    [super viewWillAppear:YES];
    [self _creatTabbar];
}
-(void)_creatTabbar
{
    //1.移除所有的标签项
    for (UIView
         *view in self.tabBar.subviews) {
//        NSLog(@"%@",self.tabBar.subviews);
       // Class 是个抽象的类，把所有的类归为一类
        
        //取得UITabBarButton的类对象
        Class cls = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:cls]) {
            NSLog(@"%@",view);
            //移除tabbar上的按钮对象
            [view removeFromSuperview];
        }
    }
    NSArray *imgArr = @[@"movie_home",@"msg_new",@"start_top250",@"icon_cinema",@"more_setting"];
    NSArray *titleArr = @[@"电影",@"新闻",@"top",@"影院",@"更多"];
    CGFloat width = KScreenWidth / imgArr.count;
    
    CGFloat height = CGRectGetHeight(self.tabBar.frame);
    
    if (_selectImg == nil) {
        //1.创建阴影遮罩视图
        _selectImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 55, 45)];
        //2.添加图片
        _selectImg.image = [UIImage imageNamed:@"selectTabbar_bg_all"];
        //3.添加到tabbar
        [self.tabBar addSubview:_selectImg];
    }
    
    for (int i = 0; i < imgArr.count; i++) {
        NSString *imgName = imgArr[i];
        NSString *titile = titleArr[i];
        
        /*
         UIButton :子视图
         UIImageView 
         UILabel :标题
         UIImageView:背景图片
         */
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.frame = CGRectMake(i * width, 0, width, height);
//        
//        //创建标题
//        [button setTitle:titile forState:UIControlStateNormal];
//        //创建图片
//        [button setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
//        
//        //设置标题字体
//        button.titleLabel.font = [UIFont systemFontOfSize:12];
//        
//        //设置标题和图片便宜，成为上下的格式，四个属性分别为顶左底右，数值为距离原位置的一个偏差（－为靠近，＋为远离）
//        button.titleEdgeInsets = UIEdgeInsetsMake(30, -20, 0, 0);
//        button.imageEdgeInsets = UIEdgeInsetsMake(-15,20, 0, 0);
//        [self.tabBar addSubview:button];
        //使用子类化的item创建标签
        
        CGRect frame = CGRectMake(i*width, 0, width, height);
        
        HWXTabBarItem *item = [[HWXTabBarItem alloc]initWithFrame:frame imageName:imgName title:titile];
        [self.tabBar addSubview:item];
        item.tag = i;
        //添加点击事件
        [item addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            _selectImg.center = item.center;
        }
    }
}
-(void)clickItem:(HWXTabBarItem *)item
{
    self.selectedIndex = item.tag;
    
    //添加一个动画效果
    [UIView animateWithDuration:.2 animations:^{
        _selectImg.center = item.center;
    }];
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
