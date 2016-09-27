//
//  MoreViewController.m
//  HWXMovie
//
//  Created by 周小立 on 16/6/24.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
    self.tableView.separatorColor = [UIColor darkGrayColor];
    // Do any additional setup after loading the view.
}
-(void)countCacheSize
{
    //计算出来的是b * 1024 = kb * 1024 = MB
    NSUInteger flieSize = [[SDImageCache sharedImageCache]getSize];
    
    
    _countLabel.text = [NSString stringWithFormat:@"%.1f M",flieSize / 1024 / 1024.0];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self countCacheSize];
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"清空缓存" message:@"确定要清理缓存嘛？召唤师" delegate:self cancelButtonTitle:@"宝宝不要" otherButtonTitles:@"朕准了", nil];
        [alertView show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[SDImageCache sharedImageCache]clearDisk];
        [self countCacheSize];
    }
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
