//
//  PhotoViewController.h
//  HWXMovie
//
//  Created by 周小立 on 16/7/4.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController
{
    BOOL _isHide;
}
@property(nonatomic,strong)NSArray *urls;
@property(nonatomic,strong)NSIndexPath *indexpath;
@end
