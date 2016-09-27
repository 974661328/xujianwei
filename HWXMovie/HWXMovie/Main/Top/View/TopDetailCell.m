//
//  TopDetailCell.m
//  HWXMovie
//
//  Created by 周小立 on 16/7/11.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import "TopDetailCell.h"

@implementation TopDetailCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [_imgView sd_setImageWithURL:[NSURL URLWithString:_topDetail.userImage]];
    
    _nickNameLabel.text = _topDetail.nickname;
    _ratingLabel.text = _topDetail.rating;
    _contentLabel.text = _topDetail.content;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
