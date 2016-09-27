//
//  HWXNavigationController.m
//  HWXMovie
//
//  Created by 周小立 on 16/6/24.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import "HWXNavigationController.h"

@interface HWXNavigationController ()

@end

@implementation HWXNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //修改导航栏背景颜色
    [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"nav_bg_all-64"] forBarMetrics:UIBarMetricsDefault];
    
    //修改导航栏上面的标题颜色
    NSDictionary *textAtt = @{
                              NSForegroundColorAttributeName : [UIColor whiteColor],
                              NSFontAttributeName : [UIFont systemFontOfSize:20]
                              
                              };
    self.navigationBar.titleTextAttributes = textAtt;
//    self.navigationBarHidden = NO;
    //修改返回按钮的字体颜色
    self.navigationBar.tintColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}
//返回的状态栏样式由子控制器返回的样式为准
- (UIStatusBarStyle)preferredStatusBarStyle
{
    UIStatusBarStyle style = [self.topViewController preferredStatusBarStyle];
    return style;
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
