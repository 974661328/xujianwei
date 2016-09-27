//
//  NewsDetailViewController.m
//  HWXMovie
//
//  Created by 周小立 on 16/6/24.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import "NewsDetailViewController.h"

@interface NewsDetailViewController ()

@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64)];
//    //1.加载网络url
//    NSURL *url = [NSURL URLWithString:@"http://news.mtime.com/2013/08/31/1517208.html"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [_webView loadRequest:request];
//    [self.view addSubview:_webView];
    
    
//    //2.加载本地的html代码
//    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"百度一下，你就知道" ofType:@"htm"];
//    NSString *s = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
////    NSLog(@"------------s:%@",s);
//    [_webView loadHTMLString:s baseURL:nil];
    [self.view addSubview:_webView];
    [self _loadData];
}
-(void)_loadData
{
    //读取json数据
    NSDictionary *jsonData = (NSDictionary *)[WXDataService requestData:news_detail];
    NSString *content = [jsonData objectForKey:@"content"]; //新闻内容
    NSString *source = [jsonData objectForKey:@"source"]; //新闻来源
    NSString *time = [jsonData objectForKey:@"time"]; //新闻时间
    NSString *author = [jsonData objectForKey:@"author"]; //新闻作者
    NSString *title = [jsonData objectForKey:@"title"]; //新闻标题
    
    //读取news.html的数据
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"news" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@", html);
    
    //子标题  来源 时间
    NSString *subTitle = [NSString stringWithFormat:@"%@ %@", source, time];
    //编辑（作者）
    NSString *at = [NSString stringWithFormat:@"(编辑:%@)", author];
    //拼接html文件
    NSString *htmlString = [NSString stringWithFormat:html, title, subTitle, content, at];
    
    [_webView loadHTMLString:htmlString baseURL:nil];
    //自适应
    _webView.scalesPageToFit = YES;
    
    _webView.delegate = self;
    
    //创建加载视图
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//    [_activityView stopAnimating];
    //    [_activityView startAnimating];
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:_activityView];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
#pragma mark - UIWebView delegate
//1、webView开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [_activityView startAnimating];
    
    
}
//2、webView结束加载
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_activityView stopAnimating];
    
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
