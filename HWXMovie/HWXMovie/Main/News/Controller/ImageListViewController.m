//
//  ImageListViewController.m
//  HWXMovie
//
//  Created by 周小立 on 16/6/29.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import "ImageListViewController.h"
#import "NewsModel.h"
#import "PhotoViewController.h"
#import "HWXNavigationController.h"
@interface ImageListViewController ()

@end

@implementation ImageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图片新闻";
    _collectionView.delegate = self;
    _collectionView.dataSource =self;
    [self _requestData];
    // Do any additional setup after loading the view.
}
-(void)_requestData
{
    //加载数据
    NSArray *array = (NSArray *)[WXDataService requestData:image_list];
    self.data = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *imageModel in array) {
        //BaseModel的作用就是简化这里加载json文件
        NewsModel *nesModel = [[NewsModel alloc]initContentWithDic:imageModel];
        [_data addObject:nesModel];
        
    }
    //刷新collectionview
    [_collectionView reloadData];
}
#pragma mark - UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _data.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    UIImageView *imgView = (UIImageView *)[cell.contentView viewWithTag:200];
    NewsModel *news = self.data[indexPath.row];
    [imgView sd_setImageWithURL:[NSURL URLWithString:news.image]];
    return cell;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //取出所有的model中的图片url
    NSMutableArray *urls = [NSMutableArray array];
    for (NewsModel *model in self.data) {
        NSString *urlString = model.image;
        [urls addObject:urlString];
    }
    PhotoViewController *photoCtrl = [[PhotoViewController alloc]init];
    //图片url的传递
    photoCtrl.urls = urls;
    photoCtrl.indexpath = indexPath;
    HWXNavigationController *navigation = [[HWXNavigationController alloc]initWithRootViewController:photoCtrl];
    /*通过模态视图效果弹出的控制器，此控制器视图是直接添加到window上去的，是没有父控制器的，就是说，模态弹出的效果并不会添加在导航控制器上去显示*/
    [self presentViewController:navigation animated:YES completion:NULL];
    
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
