//
//  YQMineViewController.m
//  DR_NewMedia
//
//  Created by 杨庆 on 2017/5/8.
//  Copyright © 2017年 YQ. All rights reserved.
//

#import "YQMineViewController.h"
#import "YQMineHeadView.h"
#import "YQStaticTableViewController.h"

@interface YQMineViewController ()

@property(nonatomic,strong)YQMineHeadView * mineHeadView;

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@property (weak, nonatomic) IBOutlet UIView *contentView;

// 属性记录保存
@property(nonatomic,strong)YQStaticTableViewController * staticTableView;


@end

@implementation YQMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.nav控制器要求实现的是透明
    UIImage * image = [[UIImage alloc]init];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    //去横线去阴影的方法
    if ([self.navigationController.navigationBar respondsToSelector:@selector(shadowImage)])
    {
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 2.加载视图的xib
    [self initMineHeadView];
    
    // 3.加载静态单元cell
    [self initStaticTableView];

}

-(void)initMineHeadView{

    self.mineHeadView = [YQMineHeadView initMineHeadView];
    
    [self.backImageView addSubview:self.mineHeadView];
    
    [self.mineHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.backImageView).offset(10);
        make.bottom.right.equalTo(self.backImageView).offset(-10);
        make.height.mas_equalTo(60);
        
    }];
}

-(void)initStaticTableView{
    
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"YQStaticTV" bundle:nil];
    self.staticTableView = [sb instantiateInitialViewController];
    [self.contentView addSubview:self.staticTableView.view];
    

    [self.staticTableView.view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.left.bottom.top.equalTo(self.contentView);
    }];
    
    
}


@end
