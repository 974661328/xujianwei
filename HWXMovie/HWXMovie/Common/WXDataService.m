//
//  WXDataService.m
//  HWXMovie
//
//  Created by 周小立 on 16/6/25.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import "WXDataService.h"

@implementation WXDataService
+(instancetype)requestData:(NSString *)fileName
{
    NSString *filePath = [[NSBundle mainBundle]pathForResource:fileName ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    id jason = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
    return jason;
}
@end
