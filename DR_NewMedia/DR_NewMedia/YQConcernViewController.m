//
//  YQConcernViewController.m
//  DR_NewMedia
//
//  Created by 杨庆 on 2017/5/3.
//  Copyright © 2017年 YQ. All rights reserved.
//

#import "YQConcernViewController.h"
#import "YQConcerFirstTableViewController.h"
#import "YQButton.h"

@interface YQConcernViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;

@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;


@end

@implementation YQConcernViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.添加子控制器
    [self setupChildVces];
    
    // 2.添加顶部的所有标题
    [self setupTitles];
    

        
}

#pragma mark --------添加子控制器------
- (void)setupChildVces
{
    YQConcerFirstTableViewController *vc01 = [[YQConcerFirstTableViewController alloc] init];
    vc01.title = @"热门推荐";
    [self addChildViewController:vc01];
    
    YQConcerFirstTableViewController *vc02 = [[YQConcerFirstTableViewController alloc] init];
    vc02.title = @"关注";
    [self addChildViewController:vc02];
    
    YQConcerFirstTableViewController *vc03 = [[YQConcerFirstTableViewController alloc] init];
    vc03.title = @"问答";
    [self addChildViewController:vc03];
    
    YQConcerFirstTableViewController *vc04 = [[YQConcerFirstTableViewController alloc] init];
    vc04.title = @"我的消息";
    [self addChildViewController:vc04];
    
}

#pragma mark --------添加顶部所有的标题------
- (void)setupTitles
{
    // 创建button
    NSUInteger count = self.childViewControllers.count;
    
    CGFloat labelW = self.view.bounds.size.width / count;
    CGFloat labelH = self.titleScrollView.bounds.size.height -2;
    CGFloat labelY = 0;
    
    for (NSUInteger i = 0; i < count; i++) {
        // 创建labe
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


@end
