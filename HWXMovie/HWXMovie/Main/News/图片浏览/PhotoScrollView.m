//
//  PhotoScrollView.m
//  HWXMovie
//
//  Created by 周小立 on 16/7/4.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import "PhotoScrollView.h"

@implementation PhotoScrollView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imgView = [[UIImageView alloc]initWithFrame:self.bounds];
        [self addSubview:_imgView];
        
        //1.设置缩放的最大、最小倍数
        self.maximumZoomScale = 3.0;
        self.minimumZoomScale = 1.0;
        
        //2.隐藏滚动条
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        //3.设置代理
        self.delegate = self;
        
        //设置图片的填充方式
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        
        //4.创建单击手势对象
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap2:)];
        
        //设置点击次数
        tap2.numberOfTapsRequired = 2;
        //设置触摸手指的数量
//        tap.numberOfTouchesRequired = 2;
        /*
         UIPanGestureRecognizer  轻扫
         UIPinchGestureRecognizer 捏合
         UILongPressGestureRecognizer 长按
         */
        [self addGestureRecognizer:tap2];
        
        
        
        
        //5.创建单击手势，用于隐藏，显示导航栏
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap1:)];
        tap1.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tap1];
        
        //当tap2手势触发时让tap1失效
        [tap1 requireGestureRecognizerToFail:tap2];

    }
    return self;
}
-(void)tap1:(UITapGestureRecognizer *)tap1
{
    //发送通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"tap1Notification" object:self];
}
-(void)tap2:(UITapGestureRecognizer *)tap
{
    NSLog(@"成功双击一次");
    
//    NSLog(@"tap.view = %@",tap.view);
    //zoomScale 他是scrollview对于子视图缩放的倍数
    if (self.zoomScale > 1) {
        [self setZoomScale:1 animated:YES];
    }else{
        [self setZoomScale:3 animated:YES];
    }
}
-(void)setUrl:(NSURL *)url
{
    if (_url != url) {
        _url = url;
        
        //加载网络图片
        [_imgView sd_setImageWithURL:url];
    }
}
#pragma mark - UIScrollViewDelegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imgView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
