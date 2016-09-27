//
//  MovieViewController.m
//  HWXMovie
//
//  Created by 周小立 on 16/6/24.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import "MovieViewController.h"
#import "Movie.h"
#import "USMovieCell.h"
#import "WXDataService.h"
#import "PosterView.h"
@interface MovieViewController ()
//@property (weak, nonatomic) IBOutlet UIView *myView;
//@property (weak, nonatomic) IBOutlet UIView *otherView;
//@property (weak, nonatomic) IBOutlet UIView *otherView2;

@end

@implementation MovieViewController
//- (IBAction)trasitionAction:(UIButton *)sender {
//    [UIView transitionWithView:self.myView   //切换的页面
//                      duration:.5            //动画的时长
//                       options:UIViewAnimationOptionTransitionFlipFromLeft //切换的动画
//                    animations:^{
//                        [self.myView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];//切换的动作
//                    }
//                    completion:^(BOOL finished) {
//                        NSLog(@"动作完成");
//                    }];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _loadNavigationItem];
    [self _loadTableView];
    [self _loadPosterView];
    [self _requestData];
//    //当，当前控制器中有着scrollview对象的时候，自动将此对象偏移-64
//    self.automaticallyAdjustsScrollViewInsets = YES;
//    //edgesForExtendedLayout此属性是设置scrollview对象他的一个延伸方向
//    self.edgesForExtendedLayout = UIRectEdgeTop | UIRectEdgeBottom;
    
    
    // Do any additional setup after loading the view.
}
//解析数据
-(void)_requestData
{
        //1.获取文件路径
//    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"us_box.json" ofType:nil];
//        //2.根据路径获取数据
//        NSData *data = [NSData dataWithContentsOfFile:filePath];
//        //3.解析json数据
//        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
    
    NSDictionary *jsonDic = (NSDictionary *)[WXDataService requestData:us_box];
    _data = [[NSMutableArray alloc]init];
    
    NSArray *array = [jsonDic objectForKey:@"subjects"];
    for (NSDictionary *dic in array) {
        NSDictionary *subject = [dic objectForKey:@"subject"];
        
        Movie *movie = [[Movie alloc]init];
        movie.average = [[subject objectForKey:@"rating"]objectForKey:@"average"];
        movie.collect_count = [subject objectForKey:@"collect_count"];
        movie.images = [subject objectForKey:@"images"];
        movie.movieID = [subject objectForKey:@"id"];
        movie.title = [subject objectForKey:@"title"];
        movie.subtype = [subject objectForKey:@"subtype"];
        movie.year = [subject objectForKey:@"year"];
        movie.original_title = [subject objectForKey:@"original_title"];
        [_data addObject:movie];
    }
    //刷新tableview，重新读取数据
    [_tableView reloadData];
    
    //将数据传递给posterview
//    NSLog(@"----------------%@",_posterView);
    [_posterView setData:_data];
    
}
-(void)_loadNavigationItem
{
    //1.创建翻转所用的父视图
    UIView *buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    
    //2.创建右侧两个翻转按钮
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.tag = 200;
    [button1 setImage:[UIImage imageNamed:@"poster_home"] forState:UIControlStateNormal];
    [button1 setBackgroundImage:[UIImage imageNamed:@"exchange_bg_home@2x"] forState:UIControlStateNormal];
    button1.frame = buttonView.bounds;
    button1.hidden = NO;
    [buttonView addSubview:button1];
    [button1 addTarget:self action:@selector(rightBarClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.tag = 201;
    [button2 setImage:[UIImage imageNamed:@"list_home"] forState:UIControlStateNormal];
    [button2 setBackgroundImage:[UIImage imageNamed:@"exchange_bg_home@2x"] forState:UIControlStateNormal];
    button2.frame = buttonView.bounds;
    button2.hidden = YES;
    
    [buttonView addSubview:button2];
    [button2 addTarget:self action:@selector(rightBarClickAction:) forControlEvents:UIControlEventTouchUpInside];
    //把父视图给页面右边按钮
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:buttonView];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
}

-(void)rightBarClickAction:(UIButton *)button
{
    //1.通过button.superview
    //2.通过拿rightBarBuutonItem
    UIView *buttonView = self.navigationItem.rightBarButtonItem.customView;
    //3.切换两个按钮的显示
    UIButton *buuton1 = (UIButton *)[buttonView viewWithTag:200];
    UIButton *button2 = (UIButton *)[buttonView viewWithTag:201];
    buuton1.hidden = !buuton1.hidden;
    button2.hidden = !button2.hidden;
    [self flipView:buttonView left:buuton1.hidden];
    
    //4.切换列表视图和海报视图
    _tableView.hidden = !_tableView.hidden;
    _posterView.hidden = !_posterView.hidden;
    [self flipView:self.view left:buuton1.hidden];
    
}
//初始化列表视图
-(void)_loadTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main@2x"]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 120;
    _tableView.hidden = YES;
    _tableView.separatorColor = [UIColor darkGrayColor];
    
    //注册单元格
    [_tableView registerNib:[UINib nibWithNibName:@"USMovieCell" bundle:nil] forCellReuseIdentifier:@"movieCell"];
    
    [self.view addSubview:_tableView];
}
//创建海报视图
-(void)_loadPosterView
{
    _posterView = [[PosterView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    _posterView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
    _posterView.hidden = NO;
//    [self.view insertSubview:_posterView atIndex:0];
    [self.view addSubview:_posterView];
    
}
-(void)flipView:(UIView *)forView left:(BOOL)flag
{
    //三目运算符
    UIViewAnimationOptions flip = flag ? UIViewAnimationOptionTransitionFlipFromLeft :
    UIViewAnimationOptionTransitionFlipFromRight;
    [UIView transitionWithView:forView
                      duration:.5
                       options:flip
                    animations:^{
                        [forView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
                    }
                    completion:NULL];
    
    
}
#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"movieCell";
    USMovieCell*cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
//        if (cell == nil) {
////        创建cell
//        cell = [[[NSBundle mainBundle]loadNibNamed:@"USMovieCell" owner:self options:nil]lastObject];
//    
//        
//    }
    //数据传输
    cell.movie = _data[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //去掉背景颜色
    cell.backgroundColor = [UIColor clearColor];
    //去掉选中风格
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
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
