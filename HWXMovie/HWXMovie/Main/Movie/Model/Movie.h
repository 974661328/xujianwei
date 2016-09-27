//
//  Movie.h
//  HWXMovie
//
//  Created by 周小立 on 16/6/24.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
/*
 电影model，和json数据里面的类型以及变量名匹配
 */
@interface Movie : BaseModel
@property(nonatomic,strong)NSNumber *average;  //评分
@property(nonatomic,copy)NSString *title;      //标题
@property(nonatomic,copy)NSString *original_title;//原标题
@property(nonatomic,copy)NSString *subtype;     //种类
@property(nonatomic,copy)NSString *year;       //年份
@property(nonatomic,copy)NSDictionary *images; //images
@property(nonatomic,copy)NSString *movieID;     //电影id
@property(nonatomic,strong)NSNumber *collect_count;//收藏人数
@end
