//
//  MovieDetailView.h
//  HWXMovie
//
//  Created by 周小立 on 16/7/10.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StarView;
@class Movie;
@interface MovieDetailView : UIView
{
    
    __weak IBOutlet UIImageView *_imgView;
    __weak IBOutlet UILabel *_titleLabel;
    __weak IBOutlet UILabel *_sourceTitleLabel;
    __weak IBOutlet UILabel *_yearLabel;
    __weak IBOutlet StarView *_starView;
    __weak IBOutlet UILabel *_ratingLabel;
}
@property(nonatomic,strong)Movie *movie;
@end
