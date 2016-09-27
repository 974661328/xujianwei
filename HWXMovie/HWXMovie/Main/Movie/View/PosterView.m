//
//  PosterView.m
//  HWXMovie
//
//  Created by 周小立 on 16/7/9.
//  Copyright © 2016年 周小立. All rights reserved.
//

#import "PosterView.h"
#import "PosterCollectionView.h"
#import "IndexCollectionView.h"
#import "Movie.h"
#define KHeaderViewHeight 100//头部视图的高度
#define kFooterViewHeight 35 //尾部视图的高度
@implementation PosterView
{
    //半透明遮罩视图，这里它是要能够接受用户点击事件的
    UIControl *_maskView;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //1.创建头部视图
        [self _createHeaderView];
        //2.创建中间海报视图
        [self _createPosterCollectionView];
        //3.创建索引海报视图
        [self _createIndexCollectionView];
        //4.创建尾部视图
        [self _createFooterView];
        
        
        //posterView使用KVO观察_PosterCollectionView、_IndexCollectionView 大图，小图 两个对象currentItem 属性值的变化
        //[被观察者 addObserve:观察对象 参数2:属性名]//第三个参数表示要新值 第四个参数传递
        [_posterCollectionView addObserver:self forKeyPath:@"currentItem" options:NSKeyValueObservingOptionNew context:NULL];
        
        [_indexCollectionView addObserver:self forKeyPath:@"currentItem" options:NSKeyValueObservingOptionNew context:NULL];
    }
    return self;
}
-(void)_createFooterView
{
    _footerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,self.height - kFooterViewHeight - 49, KScreenWidth, kFooterViewHeight)];
    _footerLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"poster_title_home.png"]];
    _footerLabel.font = [UIFont systemFontOfSize:16.0f];
    _footerLabel.textColor = [UIColor whiteColor];
    _footerLabel.textAlignment = NSTextAlignmentCenter;
    _footerLabel.text = @"超超电影";
    [self addSubview:_footerLabel];
    
}
#pragma mark - KVO 观察者方法
-(void)observeValueForKeyPath:(NSString *)keyPath //currentItem
                     ofObject:(id)object //被观察对象
                       change:(NSDictionary<NSString *,id> *)change //属性值
                      context:(void *)context
{
//    NSLog(@"-------------change = %@",change);
    if ([keyPath isEqualToString:@"currentItem"]) {
        //从change字典中去取
        //取出的值的包装过的，要先改成NSInteger类型
        NSNumber *newValue = [change objectForKey:@"new"];
        NSInteger item = [newValue integerValue];
        
        if (object == _posterCollectionView && _indexCollectionView.currentItem != item) {
            //1.被观察的对象是大图
            
            //将值付给小图的currentitem
            _indexCollectionView.currentItem = item;
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:0];
            [_indexCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        }else if (object == _indexCollectionView && _posterCollectionView.currentItem != item){
            //2.被贯彻的对象是小图
            _posterCollectionView.currentItem = item;
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:0];

            [_posterCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        }
        
        //3.修改电影标题
        Movie *moview = self.data[item];
        _footerLabel.text = moview.title;
    }
}
#pragma mark - 界面的搭建
//1.创建总的头视图
-(void)_createHeaderView
{
    //1.创建头部视图
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64-KHeaderViewHeight, KScreenWidth, 130)];
    _headerView.backgroundColor = [UIColor clearColor];
    [self addSubview:_headerView];
    //2.设置背景图片
    UIImage *img = [UIImage imageNamed:@"indexBG_home"];
    //设置拉伸点
    img = [img stretchableImageWithLeftCapWidth:0 topCapHeight:2];//纵向拉伸
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, KScreenWidth, 130)];
    imgView.image = img;
    [_headerView addSubview:imgView];
    //3.创建箭头按钮
    UIButton *arrowsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    arrowsButton.tag = 101;
    [arrowsButton setImage:[UIImage imageNamed:@"down_home.png"] forState:UIControlStateNormal];
    [arrowsButton setImage:[UIImage imageNamed:@"up_home.png"] forState:UIControlStateSelected];
    arrowsButton.frame = CGRectMake((KScreenWidth - 10)/2, 130 - 20, 15, 15);
    [_headerView addSubview:arrowsButton];
    [arrowsButton addTarget:self action:@selector(arrowsAction:) forControlEvents:UIControlEventTouchUpInside];
    //4.创建向下轻扫的手势
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    swipe.direction = UISwipeGestureRecognizerDirectionDown;
    [self addGestureRecognizer:swipe];
    
    //5.创建向上轻扫的手势
    UISwipeGestureRecognizer *swipe2 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe2:)];
    swipe2.direction = UISwipeGestureRecognizerDirectionUp;
    [self addGestureRecognizer:swipe2];
}
//2.创建海报视图
-(void)_createPosterCollectionView
{
    /*
     中间海报视图的实现难点：1.分页的逻辑：不能够直接使用系统自带的分页逻辑，因为自带的分页逻辑一页就是一整个view的宽度，而我们这里只需要一个图片的宽度（一个咱们定义的单元格的宽度）
     2.此单元格的起始位置并不是从原点开始（最左侧），而是从中间的位置，并且翻页的时候，中间点一直对应着上面头视图的中间位置
     3.单页翻转的逻辑
     4.点击两侧单元格，被点击单元格移动到正中间位置
     综上，我们按照功能模块化的思维应当将此collection子类化，将其封装，为了以后的复用以及解耦合。
     */
    _posterCollectionView = [[PosterCollectionView alloc]initWithFrame:CGRectMake(0, 30 + 64, KScreenWidth, self.height - 30-kFooterViewHeight-64-49)];
    //指定宽度
    _posterCollectionView.pageWidth = 220;
    _posterCollectionView.backgroundColor = [UIColor clearColor];
    [self insertSubview:_posterCollectionView belowSubview:_headerView];
}
//3.创建索引海报视图
-(void)_createIndexCollectionView
{
    _indexCollectionView = [[IndexCollectionView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KHeaderViewHeight)];
    //跟大海报视图最主要的区别为单页的宽度小
    _indexCollectionView.pageWidth = 75;
    [_headerView addSubview:_indexCollectionView];
}


//传递数据到collectionview
-(void)setData:(NSMutableArray *)data
{
    if (_data != data) {
        _data = data;
        [_posterCollectionView setData:data];
        [_indexCollectionView setData:data];
        
        //显示第一个电影标题
        if (data.count > 0) {
            Movie *movie = [data objectAtIndex:0];
            _footerLabel.text = movie.title;
        }
#pragma mark- 别忘了索引海报视图也需要数据
    }
//    NSLog(@"----------pData:%@",self.data);
}
#pragma mark - 事件方法
-(void)swipe2:(UISwipeGestureRecognizer *)swipe2
{
    //收起
    [self _hideHeaderView];
}
-(void)swipe:(UISwipeGestureRecognizer *)swipe
{
    //展开
    [self _showHeaderView];
}
-(void)arrowsAction:(UIButton *)button
{
    if (button.selected == NO)
    {//展开显示
        [self _showHeaderView];
    }else{//收起／隐藏
        [self _hideHeaderView];
   }
}
//收起头部视图
-(void)_hideHeaderView
{
    [UIView animateWithDuration:0.4 animations:^{
        _headerView.transform = CGAffineTransformIdentity;
    }];
    _maskView.hidden = YES;
    //修改按钮的状态
    UIButton *arrowsButton = (UIButton *)[_headerView viewWithTag:101];
    arrowsButton.selected = NO;
}
//显示展开头部视图
-(void)_showHeaderView
{
    //添加动画效果
    [UIView animateWithDuration:0.4 animations:^{
        _headerView.transform = CGAffineTransformMakeTranslation(0, KHeaderViewHeight);//这里的100的移动的距离
    }];
    //创建半透明的遮罩视图
    if (_maskView == nil) {
        _maskView = [[UIControl alloc]initWithFrame:self.bounds];
        _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [_maskView addTarget:self action:@selector(maskAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self insertSubview:_maskView belowSubview:_headerView];
    }
    _maskView.hidden = NO;
    
    //修改按钮的状态
    UIButton *arrowsButton = (UIButton *)[_headerView viewWithTag:101];
    arrowsButton.selected = YES;
}
-(void)maskAction:(UIControl *)control
{
    [self _hideHeaderView];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
