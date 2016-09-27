//
//  NewsViewController.m
//  HWXMovie
//
//  Created by 周小立 on 16/6/24.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import "NewsViewController.h"
#import "StarView.h"
#import "NewsModel.h"
#import "NewsCell.h"
#import "NewsDetailViewController.h"
#import "ImageListViewController.h"
CGFloat imageHeight = 150;
@interface NewsViewController ()
{
    //头条图片
    UIImageView *_imgView;
    //头条标题
    UILabel *_titleLabel;
}

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
    //设置导航栏占位置
    self.navigationController.navigationBar.translucent = NO;
        
    //读取数据
    [self requestData];
    
    //创建头条新闻图片
    [self _creatHeaderView];
    
    // Do any additional setup after loading the view.
}
-(void)_creatHeaderView
{
    //1.图片
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, imageHeight)];
    _imgView.backgroundColor = [UIColor purpleColor];
    [self.view insertSubview:_imgView belowSubview:_tableView];
    
    //2.图片label
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, imageHeight - 30 , KScreenWidth,30 )];
    _titleLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:.3];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textColor = [UIColor whiteColor];
    [self.view insertSubview:_titleLabel belowSubview:_tableView];
    
    //填充数据
    [self _loadHeaderViewData];
}
-(void)_loadHeaderViewData
{
    if (_data.count > 0) {
        NewsModel *news = self.data[0];
        [_imgView sd_setImageWithURL:[NSURL URLWithString:news.image]];
        _titleLabel.text = news.title;
    }
}
-(void)requestData
{
    _data = [[NSMutableArray alloc]init];
    NSArray *jsonArr = (NSArray *)[WXDataService requestData:@"news_list.json"];
    for (NSDictionary *dic in jsonArr) {
        NewsModel *news = [[NewsModel alloc]init];
        
        news.newsId = [dic objectForKey:@"newsid"];
        news.type = [dic objectForKey:@"type"];
        news.title = [dic objectForKey:@"title"];
        news.summary = [dic objectForKey:@"summary"];
        news.image = [dic objectForKey:@"image"];
        
        [_data addObject:news];
    }
    NSLog(@"data = %@",_data);
    //刷新表视图
    [_tableView reloadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 ) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifyHeaderNewsCell" forIndexPath:indexPath];
//        UIImageView *imgView = [cell.contentView viewWithTag:100];
//        NewsModel *news = self.data[indexPath.row];
//        NSLog(@"------%@",news.image);
//        NSLog(@"url~~~~~~%@",[NSURL URLWithString:news.image]);
//        [imgView sd_setImageWithURL:[NSURL URLWithString:news.image]];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifyNewsCell" forIndexPath:indexPath];
    cell.news = self.data[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
//判断单元格来设置高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 150;
    }
    return 60;
}
#pragma mark - UIScrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //1.获取y轴的位移
    CGFloat offsetY = scrollView.contentOffset.y;
//    NSLog(@"%lf",offsetY);
    //先判断是向上滑动还是向下滑动
    if (offsetY > 0) {//向上滑动
        _imgView.top = -offsetY;
    }else{
        //1.计算图片增大之后的一个高度
        //ABS是取绝对值
        CGFloat height = ABS(offsetY) + imageHeight;
        
        //原宽度/原高度 ＝ 放大宽度/放大高度
        CGFloat width = KScreenWidth / imageHeight * height;
        CGRect frame = CGRectMake(-(width - KScreenWidth)/2, 0, width, height);
        _imgView.frame = frame;
        
    }
    _titleLabel.bottom = _imgView.bottom;
}
//单元格点击跳转方法,看清楚方法名字
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSInteger dataCount = indexPath.row;
    NewsModel *news = self.data[indexPath.row];
    NSInteger type = [news.type integerValue];
//    NSLog(@"%ld",type);
    NSLog(@"indexpath:%ld",indexPath.row);
    
    if (type == 0) {//普通新闻
        //根据storyboard id 去取故事版中的控制器
        NewsDetailViewController *newsDetail = [self.storyboard instantiateViewControllerWithIdentifier:@"NewsDetailViewController"];
        //push
        [self.navigationController pushViewController:newsDetail animated:YES];
    }else if (type == 1){//图片新闻
        ImageListViewController *imageList = [self.storyboard instantiateViewControllerWithIdentifier:@"ImageListViewController"];
        //PUSH
        [self.navigationController pushViewController:imageList animated:YES];
        
        
    }
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
