//
//  IndexCollectionView.m
//  HWXMovie
//
//  Created by 周小立 on 16/7/9.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import "IndexCollectionView.h"
#import "IndexCell.h"
#import "Movie.h"
@implementation IndexCollectionView
{
    NSString *identify;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self= [super initWithFrame:frame];
    if (self) {
        //注册单元格
        identify = @"IndexCell";
        [self registerClass:[IndexCell class] forCellWithReuseIdentifier:identify];
        
    }
    //    self.contentInset = UIEdgeInsetsMake(0, 100, 0, 100);
    return self;
}
//设置单元格的左右偏移
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGFloat offsetX = (CGRectGetWidth(self.frame) - self.pageWidth) / 2;
    return UIEdgeInsetsMake(0, offsetX+5, 0, offsetX);
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IndexCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    //传递数据用于单元格的显示
    Movie *movie = self.data[indexPath.item];
    NSString *url = [movie.images objectForKey:@"medium"];
    cell.url = url;
    return cell;
}
#pragma mark - UICollectionViewDelegateFlowLayout
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.currentItem != indexPath.item) {//让选中的单元格居中显示
        [UIView animateKeyframesWithDuration:0.4 delay:0.0 options:0 animations:^{
            [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        } completion:NULL];
        
    }
        self.currentItem = indexPath.item;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
