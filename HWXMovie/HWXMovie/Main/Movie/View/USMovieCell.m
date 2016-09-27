//
//  USMovieCell.m
//  HWXMovie
//
//  Created by 周小立 on 16/6/24.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import "USMovieCell.h"
#import "Movie.h"
#import "UIImageView+WebCache.h"
#import "StarView.h"
@implementation USMovieCell
//有xib文件下，加载时会调用，这个方法调用的时候，movie还没有传过来，数据无法填充
- (void)awakeFromNib {
    // Initialization code
    //去掉背景颜色
//    self.backgroundColor = [UIColor clearColor];
//    //去掉选中风格
//    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
//等价于下面的代码
//-(void)layoutSubviews
//{
//    [super layoutSubviews];
//    
//        //单元格数据传递
//        titleLabel.text = self.movie.title;
//    
//        yearLabel.text = [NSString stringWithFormat:@"年份:%@",self.movie.year];
//        ratingLabel.text = [NSString stringWithFormat:@"%.1f",[self.movie.average floatValue]];
//    
//        //图片加载
//        NSString *medium = [self.movie.images objectForKey:@"small"];
//        //将取出的字符串转化为url
//        NSURL *url = [NSURL URLWithString:medium];
//    
//        [imgView sd_setImageWithURL:url];
//
//}

-(void)setMovie:(Movie *)movie
{
    _movie = movie;
    
    //单元格数据传递
    titleLabel.text = self.movie.title;
    
    yearLabel.text = [NSString stringWithFormat:@"年份:%@",self.movie.year];
    ratingLabel.text = [NSString stringWithFormat:@"%.1f",[self.movie.average floatValue]];
    
    //图片加载
    NSString *medium = [self.movie.images objectForKey:@"small"];
    //将取出的字符串转化为url
    NSURL *url = [NSURL URLWithString:medium];
    
    [imgView sd_setImageWithURL:url];
    
    
    //填充星星,这边注意⚠️，xib当中，作为星星视图父视图的高度要尽量贴近20
    starView.rating = [self.movie.average floatValue];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
