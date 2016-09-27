//
//  PosterCell.h
//  HWXMovie
//
//  Created by 周小立 on 16/7/9.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Movie;
@class MovieDetailView;
@interface PosterCell : UICollectionViewCell
{
    UIImageView *_imgView;
    MovieDetailView *_datailView;//海报详情页面
    BOOL left;//用于翻转的三目运算符
}
@property(nonatomic,strong)Movie *movie;
@property(nonatomic,assign)BOOL isFilp;
-(void)flipCell;
@end
