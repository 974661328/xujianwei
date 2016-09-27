//
//  TopDetailViewController.h
//  HWXMovie
//
//  Created by 周小立 on 16/7/11.
//  Copyright © 2016年 周小立. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "TopDetail.h"
@interface TopDetailViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)TopDetail *topDetail;
@property(nonatomic,copy)NSMutableArray *commentData;
@property(nonatomic, strong)NSIndexPath *index;
@end
