//
//  HWXTabBarItem.m
//  HWXMovie
//
//  Created by 周小立 on 16/6/24.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import "HWXTabBarItem.h"

@implementation HWXTabBarItem
-(instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)name title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self != nil) {
        //1.图片子视图
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width - 20)/2, 5, 20, 20)];
        imageView.image = [UIImage imageNamed:name];
        //设置图片内容模式,默认情况下为拉伸填充
        //改为使用原图填充
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
        
        //2.创建标题视图
        CGFloat maxY = CGRectGetMaxY(imageView.frame);
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, maxY, frame.size.width, 20)];
        //设置label内容
        titleLabel.text = title;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:titleLabel];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
