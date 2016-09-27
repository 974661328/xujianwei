//
//  TopDetailCell.h
//  HWXMovie
//
//  Created by 周小立 on 16/7/11.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopDetail.h"
@interface TopDetailCell : UITableViewCell

@property(nonatomic,strong)TopDetail *topDetail;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@end
