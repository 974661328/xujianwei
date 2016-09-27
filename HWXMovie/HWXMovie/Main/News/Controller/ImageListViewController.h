//
//  ImageListViewController.h
//  HWXMovie
//
//  Created by 周小立 on 16/6/29.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import "BaseViewController.h"

@interface ImageListViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate>
{
    __weak IBOutlet UICollectionView *_collectionView;
    
}
@property(nonatomic,strong)NSMutableArray *data;
@end
