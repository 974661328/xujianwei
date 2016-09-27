//
//  TopViewController.m
//  HWXMovie
//
//  Created by 周小立 on 16/6/24.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import "TopViewController.h"
#import "Movie.h"
#import "TopCell.h"
#import "TopDetailViewController.h"
@interface TopViewController ()

@end

@implementation TopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
    [self _requestData];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    // Do any additional setup after loading the view.
}
-(void)_requestData
{
    //解析json数据
    NSDictionary *jsonDic = (NSDictionary*)[WXDataService requestData:top_250];
//    NSLog(@"%@",jsonDic);
    _data = [[NSMutableArray alloc]init];
    NSArray *array = [jsonDic objectForKey:@"subjects"];
    for (NSDictionary *dic in array) {
        Movie *movie = [[Movie alloc]init];
        movie.average = [[dic objectForKey:@"rating"]objectForKey:@"average"];
        movie.collect_count = [dic objectForKey:@"collect_count"];
        movie.images = [dic objectForKey:@"images"];
        movie.movieID = [dic objectForKey:@"id"];
        movie.title = [dic objectForKey:@"title"];
        movie.subtype = [dic objectForKey:@"subtype"];
        movie.year = [dic objectForKey:@"year"];
        movie.original_title = [dic objectForKey:@"original_title"];
        
        [_data addObject:movie];
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
    TopCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"TopCell" forIndexPath:indexPath];
    cell.movie = self.data[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TopDetailViewController *topDetail = [self.storyboard instantiateViewControllerWithIdentifier:@"TopDetailViewController"];
    [self.navigationController pushViewController:topDetail animated:YES];
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
