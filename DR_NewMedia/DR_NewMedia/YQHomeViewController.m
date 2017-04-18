//
//  YQHomeViewController.m
//  DR_NewMedia
//
//  Created by 杨庆 on 2017/4/17.
//  Copyright © 2017年 YQ. All rights reserved.
//

#import "YQHomeViewController.h"
#import "YQFirstTableViewController.h"
#import "YQButton.h"

@interface YQHomeViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@end

@implementation YQHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.添加子控制器
    [self setupChildVces];
    
    // 2.添加顶部的所有标题
    [self setupTitles];
    
    // 3.添加的是默认的第一个的控制器
    UIViewController *firstVc = [self.childViewControllers firstObject];
    firstVc.view.frame = self.contentScrollView.bounds;
    [self.contentScrollView addSubview:firstVc.view];
    
    // 4.设置contentSize
    CGFloat contentW = self.childViewControllers.count * [UIScreen mainScreen].bounds.size.width;
    self.contentScrollView.contentSize = CGSizeMake(contentW, 0);

    
}

#pragma mark --------添加子控制器------
- (void)setupChildVces
{
    YQFirstTableViewController *vc01 = [[YQFirstTableViewController alloc] init];
    vc01.title = @"3D秀场";
    [self addChildViewController:vc01];
    
    YQFirstTableViewController *vc02 = [[YQFirstTableViewController alloc] init];
    vc02.title = @"媒体看点";
    [self addChildViewController:vc02];
    
    YQFirstTableViewController *vc03 = [[YQFirstTableViewController alloc] init];
    vc03.title = @"问答";
    [self addChildViewController:vc03];
    
    YQFirstTableViewController *vc04 = [[YQFirstTableViewController alloc] init];
    vc04.title = @"视频";
    [self addChildViewController:vc04];
 
}

#pragma mark --------添加顶部所有的标题------
- (void)setupTitles
{
    // 创建button
    NSUInteger count = self.childViewControllers.count;
    
    CGFloat labelW = self.view.bounds.size.width / count;
    CGFloat labelH = self.titleScrollView.bounds.size.height;
    CGFloat labelY = 0;
    
    for (NSUInteger i = 0; i < count; i++) {
        // 创建label
        YQButton *btn = [[YQButton alloc] init];
        btn.tag = i;
        
        
        // 设置frame
        CGFloat btnX = i * labelW;
        btn.frame = CGRectMake(btnX, labelY, labelW, labelH);
        
        // 设置文字和图片
        UIViewController *vc = self.childViewControllers[i];
        [btn setTitle:vc.title forState:UIControlStateNormal];
        
        //[btn setImage:[UIImage imageNamed:vc.title] forState:UIControlStateHighlighted];
        //btn setImage:<#(nullable UIImage *)#> forState:<#(UIControlState)#>
        
        // 监听点击事件
        [btn addTarget:self action:@selector(bottonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.titleScrollView addSubview:btn];
    }
    
    // 设置scrollView的内容大小
    CGFloat titlesContentW = count * labelW;
    self.titleScrollView.contentSize = CGSizeMake(titlesContentW, 0);
}

-(void)bottonDidClicked:(UIButton *)btn{

    //这里的是:切换加载对应的VC
    // 计算x方向上的偏移量
    CGFloat offsetX = btn.tag * self.contentScrollView.frame.size.width;
    
    // 设置偏移量
    [self.contentScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];

}

#pragma mark - 执行的scorllView的代理方法
/**
 *  在scrollview动画结束时调用 (添加子控制器的view到 self.contentScrollview )
 *  用户手动触发的动画结束,不会调用这个方法
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
    // 获得当前需要显示的子控制器索引
    NSUInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    UIViewController *vc = self.childViewControllers[index];
   
    // 如果子控制器的view已经在上面,就直接返回
    if (vc.view.superview) return;
    
    // 添加
    CGFloat vcW = scrollView.frame.size.width;
    CGFloat vcH = scrollView.frame.size.height;
    CGFloat vcY = 0;
    CGFloat vcX = index * vcW;
    vc.view.frame = CGRectMake(vcX, vcY, vcW, vcH);
    
    [scrollView addSubview:vc.view];
}
/**
 *  当scrollview停止滚动时调用这个方法 (用户手动触发的动画结束,会调用这个方法)
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //思路是 将btn的高亮的状态和 offset的效果执行起来实现一个动画的效果!
    // 1. 需要进行控制的文字 (2个标题)
    // 2. 两个标题各自的比例值
    // 偏移量 / 宽度
    CGFloat value = ABS(self.contentScrollView.contentOffset.x / self.contentScrollView.frame.size.width);
    
    
    // 左边bnt的索引
    NSUInteger leftIndex = (NSUInteger)(self.contentScrollView.contentOffset.x / self.contentScrollView.frame.size.width);
    // 右边bnt的索引
    NSUInteger rightIndex = leftIndex + 1;
    
    if (rightIndex > 3) {//就是 避免数组越界
        rightIndex = 3;
    }
    
    // 右边文字的比例
    CGFloat rightScale = value - leftIndex;
    // 左边文字的比例
    CGFloat leftScale = 1 - rightScale;
    
    // 取出label设置高亮状态的apla 的渐变的效果
    YQButton *leftBtn = self.titleScrollView.subviews[leftIndex];
    [leftBtn buttonWithScaleToHighlightedAnimation:leftScale];
    
    YQButton *rightBtn = self.titleScrollView.subviews[rightIndex];
    [rightBtn buttonWithScaleToHighlightedAnimation:rightScale];;

}

@end
