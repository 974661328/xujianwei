//
//  PhotoScrollView.h
//  HWXMovie
//
//  Created by 周小立 on 16/7/4.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoScrollView : UIScrollView<UIScrollViewDelegate>
{
    UIImageView *_imgView;//放大的图片
}
@property(nonatomic,strong)NSURL *url;
@end
