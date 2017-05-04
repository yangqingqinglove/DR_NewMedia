//
//  YQConcernViewController.m
//  DR_NewMedia
//
//  Created by 杨庆 on 2017/5/3.
//  Copyright © 2017年 YQ. All rights reserved.
//

#import "YQConcernViewController.h"
#import "YQHeadTitleView.h"


@interface YQConcernViewController ()

/// childView
@property(nonatomic,strong)YQHeadTitleView * headTitleView;
@property (weak, nonatomic) IBOutlet UIView *HeadView;
@property (weak, nonatomic) IBOutlet UIScrollView *ContentScrollView;



@end

@implementation YQConcernViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 1.headtitle的初始化
    [self initWithHeadTitleView];
    

}


#pragma mark - init_childView方法
-(void)initWithHeadTitleView{
    
    self.headTitleView = [YQHeadTitleView headTitleInit];
    [self.HeadView addSubview:self.headTitleView];
    
    [self.headTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.HeadView.mas_left).offset(10);
        make.right.mas_equalTo(self.HeadView.mas_right).offset(-10);
        make.bottom.mas_equalTo(self.HeadView.mas_bottom).offset(-10);
        make.height.mas_equalTo(60);
        
    }];

}


@end
