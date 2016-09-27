//
//  PhotoViewController.m
//  HWXMovie
//
//  Created by 周小立 on 16/7/4.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import "PhotoViewController.h"
#import "PhotoCollectionView.h"
@interface PhotoViewController ()

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    //样式设置为黑色
    navigationBar.barStyle = UIBarStyleBlack;
    //设置为半透明
    navigationBar.translucent = YES;
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = backItem;
    
    PhotoCollectionView *collectionView = [[PhotoCollectionView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    [self.view addSubview:collectionView];
    
    collectionView.urls = _urls;
    
    //滚动到指定单元格
    [collectionView scrollToItemAtIndexPath:_indexpath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    _isHide = NO;
    
    
    //监听图片被单击之后的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tap:) name:@"tap1Notification" object:nil];
        // Do any additional setup after loading the view.
}
-(void)tap:(UITapGestureRecognizer *)tap
{
    _isHide = !_isHide;
    [self.navigationController setNavigationBarHidden:_isHide animated:YES];
    NSLog(@"成功单击一次");
}
-(void)backAction
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(BOOL)prefersStatusBarHidden
{
    return _isHide;
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
