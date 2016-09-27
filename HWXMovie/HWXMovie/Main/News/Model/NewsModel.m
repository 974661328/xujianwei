//
//  NewsModel.m
//  HWXMovie
//
//  Created by 周小立 on 16/6/25.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel
-(void)setAttributes:(NSDictionary *)jsonDic
{
    [super setAttributes:jsonDic];
    self.image = [jsonDic objectForKey:@"image"];
}
@end
