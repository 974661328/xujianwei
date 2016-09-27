//
//  NewsCell.h
//  HWXMovie
//
//  Created by 周小立 on 16/6/25.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsModel;
@interface NewsCell : UITableViewCell
{
    
    __weak IBOutlet UIImageView *_iconImg;
    __weak IBOutlet UIImageView *_imgView;
    __weak IBOutlet UILabel *_summaryLabel;
    __weak IBOutlet UILabel *_titleLabel;
}
@property(nonatomic,strong)NewsModel *news;
@end
