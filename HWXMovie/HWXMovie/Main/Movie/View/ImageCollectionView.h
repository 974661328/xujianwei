//
//  ImageCollectionView.h
//  HWXMovie
//
//  Created by 周小立 on 16/7/10.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,assign)CGFloat pageWidth;//一页的宽度
@property(nonatomic,assign)NSInteger currentItem;//当前选中的单元格
@property(nonatomic,strong)NSArray *data;//数组，接受数据
@end
