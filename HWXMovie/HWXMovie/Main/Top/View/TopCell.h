//
//  TopCell.h
//  HWXMovie
//
//  Created by 周小立 on 16/6/29.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StarView;
@class Movie;
@interface TopCell : UICollectionViewCell
{
    __weak IBOutlet UIImageView *_imgView;
    
    __weak IBOutlet UILabel *_titleLabel;
    __weak IBOutlet StarView *_starView;
    __weak IBOutlet UILabel *_ratingLabel;
}
@property(nonatomic,strong)Movie *movie;
@end
