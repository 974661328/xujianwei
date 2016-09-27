//
//  PosterView.h
//  HWXMovie
//
//  Created by 周小立 on 16/7/9.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PosterCollectionView;
@class IndexCollectionView;
@interface PosterView : UIView
{
    //子视图：
    //1.头部视图
    UIView *_headerView;
    IndexCollectionView *_indexCollectionView;
    //2.中间海报视图
    PosterCollectionView *_posterCollectionView;
    //3.尾部视图
    UILabel *_footerLabel;
    
}
@property(nonatomic,strong)NSMutableArray *data;
@end
