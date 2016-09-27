//
//  ImageCollectionView.m
//  HWXMovie
//
//  Created by 周小立 on 16/7/10.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import "ImageCollectionView.h"

@implementation ImageCollectionView
-(instancetype)initWithFrame:(CGRect)frame
{
    //创建布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        //实现代理
        self.delegate = self;
        self.dataSource = self;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        
        
    }
    return self;
}
//返回单元格的尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(_pageWidth, CGRectGetHeight(self.frame));
}
#pragma mark - UICollectionViewDelegateFlowLayout
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.data.count;
}
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    //计算新的index索引范围
    int index = (targetContentOffset->x + _pageWidth /2)/_pageWidth;
    
    if (self.currentItem == index && index < self.data.count - 1) {
        //以加速度作为判断
        if (velocity.x > 0.5) {
            index++;
        }else{
            index--;
        }
        
    }
    //3.设置下一页的偏移量
    targetContentOffset->x = index * _pageWidth;
    //4.记录当前页
    self.currentItem = index;
}
#pragma mark - UIScrollViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.currentItem != indexPath.item) {
        //让选中的单元格居中
        [UIView animateKeyframesWithDuration:0.4 delay:0.0 options:0 animations:^{
            [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        } completion:NULL];
        
        //记录当前页
        self.currentItem = indexPath.item;
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
