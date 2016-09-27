//
//  MovieViewController.h
//  HWXMovie
//
//  Created by 周小立 on 16/6/24.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import "BaseViewController.h"
@class PosterView;
@interface MovieViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    //列表视图
    UITableView *_tableView;
    //海报视图
    PosterView *_posterView;
    //可变数组，存储数据
    NSMutableArray *_data;
}
@end
