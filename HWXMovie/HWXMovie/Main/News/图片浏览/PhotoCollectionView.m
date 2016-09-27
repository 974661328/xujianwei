//
//  PhotoCollectionView.m
//  HWXMovie
//
//  Created by 周小立 on 16/7/4.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import "PhotoCollectionView.h"
#import "PhotoCell.h"
#import "PhotoScrollView.h"
static NSString *identify = @"PhotoCell";
@implementation PhotoCollectionView
-(instancetype)initWithFrame:(CGRect)frame
{
    //因为collection必须需要一个布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //设置滑动方向
    //UICollectionViewScrollDirectionHorizontal 水平方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //布局对象的尺寸
    flowLayout.itemSize = CGSizeMake(KScreenWidth, KScreenHeight);
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        //设置当前对象作为代理对象
        self.delegate = self;
        self.dataSource = self;
        self.pagingEnabled = YES;
        
        flowLayout.minimumLineSpacing = NO;
        //注册单元格
        [self registerClass:[PhotoCell class] forCellWithReuseIdentifier:identify];
    }
    return self;
    //
}
#pragma mark - UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.urls.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    cell.url = self.urls[indexPath.row];
//    NSLog(@"cell.url = %@",cell.url);
    return cell;
}
//此方法可以获取到已经结束显示，也就是移除了的单元格
-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCell *pCell = (PhotoCell *)cell;
    [pCell.scrollView setZoomScale:1 animated:YES];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
