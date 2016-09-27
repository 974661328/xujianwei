//
//  PosterCell.m
//  HWXMovie
//
//  Created by 周小立 on 16/7/9.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import "PosterCell.h"
#import "Movie.h"
#import "MovieDetailView.h"
@implementation PosterCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //1.创建大图
        [self _createView];
        
    }
    return self;
}
-(void)_createView
{
    
    //1.创建图片视图
    _imgView = [[UIImageView alloc]initWithFrame:self.contentView.bounds];//使用父视图的尺寸
    _imgView.transform = CGAffineTransformMakeScale(0.95, 0.95);
    [self.contentView addSubview:_imgView];

//    _imgView.tag = 200;
    
    //2.创建海报详情视图
//    _datailView.tag = 201;
//    _datailView.backgroundColor = [UIColor yellowColor];
    
    _datailView = [[[NSBundle mainBundle]loadNibNamed:@"MovieDetailView" owner:self options:nil]lastObject];
    _datailView.backgroundColor = [UIColor redColor];
    _datailView.transform = CGAffineTransformMakeScale(0.95, 0.95);
    
    [self.contentView insertSubview:_datailView belowSubview:_imgView];
    
}
//在这里填充数据能够百分百保证数据已经传入
-(void)setMovie:(Movie *)movie
{
    if (_movie != movie) {
        _movie = movie;
        
        
        //填充数据
        NSString *largeUrl = [movie.images objectForKey:@"large"];
        [_imgView sd_setImageWithURL:[NSURL URLWithString:largeUrl]placeholderImage:[UIImage imageNamed:@"hzc.JPG"]];
        
        [_datailView setMovie:movie];
    }
    
}
-(void)flipCell
{
    //使用三目运算符确保翻转的动作更华丽
    UIViewAnimationOptions transition = left ?
    UIViewAnimationOptionTransitionFlipFromLeft :
    UIViewAnimationOptionTransitionFlipFromRight;
    
    //可能其父视图上不仅仅只有我们添加的子视图，我么要交换的视图的索引不一定是0和1
    NSInteger index1 = [self.contentView.subviews indexOfObject:_imgView];
    NSInteger index2 = [self.contentView.subviews indexOfObject:_datailView];
    [UIView transitionWithView:self.contentView duration:0.5 options:transition animations:^{
        //交换子视图
        [self.contentView exchangeSubviewAtIndex:index1 withSubviewAtIndex:index2];
    } completion:NULL];
    left = !left;
    _isFilp = !_isFilp;
}
@end
