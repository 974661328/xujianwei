//
//  NewsCell.m
//  HWXMovie
//
//  Created by 周小立 on 16/6/25.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import "NewsCell.h"
#import "NewsModel.h"
@implementation NewsCell
-(void)setNews:(NewsModel *)news
{
    if(news != nil) {
        _news = news;
        NSString *urlString = self.news.image;
        [_imgView sd_setImageWithURL:[NSURL URLWithString:urlString]];
        
        _titleLabel.text = self.news.title;
        _summaryLabel.text = self.news.summary;
        
        NSInteger type = [self.news.type integerValue];
        
        if (type == 0) {//普通新闻
            _iconImg.hidden = NO;
//            _summaryLabel.left = _iconImg.right + 20;//作用暂时未知
            _iconImg.backgroundColor = [UIColor blueColor];
        }else if(type == 1){//图片新闻
            _iconImg.image = [UIImage imageNamed:@"sctpxw.png"];
            _iconImg.hidden = NO;
//            _summaryLabel.left = _iconImg.right + 20;
        }else if (type == 2){//视频新闻
            _iconImg.image = [UIImage imageNamed:@"scspxw.png"];
            _iconImg.hidden = NO;
            
        }
        
        
    }
}
@end
