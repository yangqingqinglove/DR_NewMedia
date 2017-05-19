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
#import "YQLoginViewController.h"

@interface YQMineViewController ()

@property(nonatomic,strong)YQMineHeadView * mineHeadView;

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@property (weak, nonatomic) IBOutlet UIView *contentView;

// 属性记录保存
@property(nonatomic,strong)YQStaticTableViewController * staticTableView;

// 登录状态的设置
@property(nonatomic,assign)BOOL isLogin;



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
    
    // 4.接受通知
    [self abserverAllNoties];
    
    // 5.获取用户偏好设置的基本信息来设置
    self.isLogin = [[NSUserDefaults standardUserDefaults] objectForKey:IsFirstLogin];
    

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


#pragma mark - 接受所有通知的方法
-(void)abserverAllNoties{
    
    [YQNoteCenter addObserver:self selector:@selector(pushDetailView:) name:YQPushChildsViewController object:nil];
}

#pragma mark - 通知执行的方法
-(void)pushDetailView:(NSNotification *)notes{// 分为的是 未登录和 已登录的情况
    
    
    NSString * VCName = notes.userInfo[YQPushChlidsVCTitileKey];
    
    if(!self.isLogin){//没有登录的情况下:
    
        
        BOOL isSetting = [VCName isEqualToString:@"YQSystemSetting"];
        
        if(isSetting){
            
            UIStoryboard * sb = [UIStoryboard storyboardWithName:VCName bundle:nil];
            UIViewController * vc = [sb instantiateInitialViewController];
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{//弹出的登录注册的界面
            
            UIStoryboard * sb = [UIStoryboard storyboardWithName:@"YQLogin" bundle:nil];
            UIViewController * vc = [sb instantiateInitialViewController];
            [self presentViewController:vc animated:YES completion:nil];
        
        }
    
    }else{//已经登录的情况下
        UIStoryboard * sb = [UIStoryboard storyboardWithName:VCName bundle:nil];
        UIViewController * vc = [sb instantiateInitialViewController];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


#pragma mark --------dealloc------
-(void)dealloc{
    
    [YQNoteCenter removeObserver:self];
}


@end
