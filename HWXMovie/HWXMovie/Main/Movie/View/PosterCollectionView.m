//
//  PosterCollectionView.m
//  HWXMovie
//
//  Created by 周小立 on 16/7/9.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import "PosterCollectionView.h"
#import "PosterCell.h"

@implementation PosterCollectionView
{
    NSString *identify;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self= [super initWithFrame:frame];
    if (self) {
        //注册单元格
        identify = @"PosterCell";
        [self registerClass:[PosterCell class] forCellWithReuseIdentifier:identify];
        
        //[被观察者 addObserve:观察对象 参数2:属性名]
    }
//    self.contentInset = UIEdgeInsetsMake(0, 100, 0, 100);
    return self;
}
//设置单元格的左右偏移
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGFloat offsetX = (CGRectGetWidth(self.frame) - self.pageWidth) / 2;
    return UIEdgeInsetsMake(-10, offsetX, 10, offsetX);
}
#pragma mark - UICollectionViewDataSource
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PosterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    //传递数据用于单元格的显示
    cell.movie = self.data[indexPath.item];
    return cell;
}
#pragma mark - UICollectionViewDelegateFlowLayout
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //先判断当前单元格是否是当前选中的单元格
    if (self.currentItem == indexPath.item) {
        //[单元格对象 翻转]
        PosterCell *pCell = (PosterCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [pCell flipCell];
    }else{
        //让选中的单元格居中
        [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];//让你选中的单元格称为当前单元格
        self.currentItem = indexPath.item;
    }
    NSLog(@"self.subviews = %@",self.subviews);
}
//滑动到下一页单元格的时候，前面翻转的单元格翻转回来
-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([(PosterCell *)cell isFilp] == 1) {
            [(PosterCell *)cell flipCell];
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
