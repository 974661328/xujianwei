//
//  MovieDetailView.m
//  HWXMovie
//
//  Created by 周小立 on 16/7/10.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import "MovieDetailView.h"
#import "Movie.h"
#import "StarView.h"
@implementation MovieDetailView
-(void)setMovie:(Movie *)movie
{
    if (_movie != movie) {
        _movie = movie;
        
        //1.电影的图片
        NSString *mediumUrl = [self.movie.images objectForKey:@"medium"];
        [_imgView sd_setImageWithURL:[NSURL URLWithString:mediumUrl]placeholderImage:[UIImage imageNamed:@"pig"]];
        
        //2.电影的标题
        _titleLabel.text = [NSString stringWithFormat:@"中文:%@",        _movie.title];
        
        //3.原标题
        _sourceTitleLabel.text = [NSString stringWithFormat:@"英文:%@",_movie.original_title];
        
        //4.年份
        _yearLabel.text = [NSString stringWithFormat:@"年份:%@",_movie.year];
        //5.评分
        _starView.rating = [self.movie.average floatValue];
        
        _ratingLabel.text = [NSString stringWithFormat:@"%.1f",[self.movie.average floatValue]];
        
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
