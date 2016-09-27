//
//  IndexCell.m
//  HWXMovie
//
//  Created by 周小立 on 16/7/9.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import "IndexCell.h"

@implementation IndexCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //创建图片
        [self _createView];
    }
    return self;
}
-(void)_createView
{
    _imgView = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
    _imgView.transform = CGAffineTransformMakeScale(0.95, 0.95);
    [self.contentView addSubview:_imgView];
    
}
-(void)setUrl:(NSString *)url
{
    if (_url != url) {
        _url = url;
    }
    //填充数据
    [_imgView sd_setImageWithURL:[NSURL URLWithString:url]placeholderImage:[UIImage imageNamed:@"hzc.JPG"]];
}
@end
