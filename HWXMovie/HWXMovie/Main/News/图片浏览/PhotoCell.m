//
//  PhotoCell.m
//  HWXMovie
//
//  Created by 周小立 on 16/7/4.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import "PhotoCell.h"
#import "PhotoScrollView.h"
@implementation PhotoCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [[PhotoScrollView alloc]initWithFrame:self.bounds];
        [self.contentView addSubview:_scrollView];
    }
    return self;
}
-(void)setUrl:(NSString *)url
{
    if (_url != url) {
        _url = url;
        
        _scrollView.url = [NSURL URLWithString:url];
    }
}
@end
