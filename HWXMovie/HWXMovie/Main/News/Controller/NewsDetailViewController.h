//
//  NewsDetailViewController.h
//  HWXMovie
//
//  Created by 周小立 on 16/6/24.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsDetailViewController : UIViewController<UIWebViewDelegate>
{
    UIWebView *_webView;
    UIActivityIndicatorView *_activityView;
}
@end
