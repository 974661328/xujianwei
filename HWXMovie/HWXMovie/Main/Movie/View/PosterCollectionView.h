//
//  PosterCollectionView.h
//  HWXMovie
//
//  Created by 周小立 on 16/7/9.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCollectionView.h"
/*
 在这里我们需要实现布局对象的子协议，因为我们这里要对collection进行布局（比如单元格的size）
 */
@interface PosterCollectionView : ImageCollectionView/*在这里我们需要设置这个单元格的大小，而且大小最好不要定死(为了代码的一个可扩展性)，其宽度最好从外面能够传入*/
@end
