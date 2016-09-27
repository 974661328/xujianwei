//
//  PhotoCell.h
//  HWXMovie
//
//  Created by 周小立 on 16/7/4.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PhotoScrollView;
@interface PhotoCell : UICollectionViewCell

@property(nonatomic,strong)PhotoScrollView *scrollView;
@property(nonatomic,copy)NSString *url;
@end
