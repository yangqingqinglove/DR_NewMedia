//
//  YQCollocationViewController.m
//  DR_NewMedia
//
//  Created by 杨庆 on 2017/4/20.
//  Copyright © 2017年 YQ. All rights reserved.
//

#define widthSize [UIScreen mainScreen].bounds.size.width
#define heightSize [UIScreen mainScreen].bounds.size.height
#define buttonSize 45

#import "YQCollocationViewController.h"
#import "YQBottomView.h"
#import "YQTopView.h"
#import "YQTopView.h"


@interface YQCollocationViewController ()<YQBottomViewClickDeleage,YQTopViewClickDeleate>

@property (weak, nonatomic) IBOutlet UIView *navBarView;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

/// 定义的记录属性 view
@property(nonatomic,strong)UIView * bottomV;
@property(nonatomic,strong)UIView * topView;


@end

@implementation YQCollocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //1.加载topView
    YQTopView * topView = [YQTopView buttonMenu];
    topView.deleage = self;
    [self.view addSubview:topView];
    self.topView = topView;
    self.topView.frame = CGRectMake(widthSize - 90, 60, 90, 45);
    
    //2.创建buttonView的展示的效果
    YQBottomView * bottomView = [YQBottomView buttonMenu];
    bottomView.deleage = self;
    [self.view addSubview:bottomView];
    self.bottomV = bottomView;
    CGFloat childs = self.bottomV.subviews.count;
    self.bottomV.frame = CGRectMake(0, heightSize - buttonSize - 48,childs *(buttonSize+ 5),  buttonSize);
    
    //3.创建share的衣柜,创建的流水布局
    
    
}


#pragma mark --------YQBottomViewClickDeleage代理的执行的方法------
-(void)bottomView:(YQBottomView *)bottomV didSelectedButtonFrom:(NSUInteger)from to:(int)To{
    
    if(self.imageView.animating){
        return;
    }

}

-(void)topView:(YQTopView *)TopV buttonDidSelectTag:(NSInteger)tag{
    
    switch (tag) {
        case 1:{//移动 transform
            
            break;
        }
            
        case 2:{// 友盟分享
            
            break;
        }
        default:
            break;
    }

}


@end
