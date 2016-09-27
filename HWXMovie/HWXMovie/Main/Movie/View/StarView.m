//
//  StarView.m
//  HWXMovie
//
//  Created by 周小立 on 16/6/25.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import "StarView.h"
#import "UIViewExt.h"
@implementation StarView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _creatView];
    }
    return self;
}
//有xib文件存在的情况下会自动跳用，这里写着是因为我们需要考虑的周全一点
-(void)awakeFromNib
{
    [self _creatView];
}
-(void)_creatView
{
    UIImage *yellowImg = [UIImage imageNamed:@"yellow"];
    UIImage *grayImg = [UIImage imageNamed:@"gray"];
    
    //1.创建灰色星星
    _grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, grayImg.size.width *5, grayImg.size.height)];
    _grayView.backgroundColor = [UIColor colorWithPatternImage:grayImg];
    [self addSubview:_grayView];
    //2.创建金色星星
    _yellowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, yellowImg.size.width*5, yellowImg.size.height)];
    _yellowView.backgroundColor = [UIColor colorWithPatternImage:yellowImg];
    [self addSubview:_yellowView];
    
    //3.设置当前视图的宽度为5个星星的高度
    CGFloat start5Width = self.frame.size.height *5;
//    CGRect frame = self.frame;
//    frame.size.width  = start5Width;
//    self.frame = frame;
    //等价于
    self.width = start5Width;
    
    CGFloat scale = self.frame.size.height / yellowImg.size.height;
    
    //放大星星
    CGAffineTransform t = CGAffineTransformMakeScale(scale, scale);
    _grayView.transform = t;
    _yellowView.transform = t;
    
    
    
    //重新修改起始点
//    CGRect f1 = _grayView.frame;
//    CGRect f2 = _yellowView.frame;
//    f1.origin = CGPointZero;
//    f2.origin = CGPointZero;
//    _grayView.frame = f1;
//    _yellowView.frame = f2;
    //等价于
    _grayView.origin = CGPointZero;
    _yellowView.origin = CGPointZero;
    
    //给当前视图一个背景，便于观察
    self.backgroundColor = [UIColor clearColor];
}
-(void)setRating:(CGFloat)rating
{
    _rating = rating;
    
    //1.计算分数的百分比
    CGFloat s = rating / 10.0;
    //2.黄色星星宽度进行相应变化：1.先设定黄色星星宽度
//    3.修改黄色星星视图的宽度
//    CGRect frame = _yellowView.frame;
//    frame.size.width = self.frame.size.width * s;
//    _yellowView.frame = frame;
    CGFloat width = self.frame.size.height / [UIImage imageNamed:@"yellow"].size.height *[UIImage imageNamed:@"yellow"].size.width *5*s;
    NSLog(@"%.1f",width);
    CGFloat width2 = self.frame.size.width *s;
    NSLog(@"------%.1f",width2);
    _yellowView.width = width;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
