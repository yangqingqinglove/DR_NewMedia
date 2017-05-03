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

@property(nonatomic,strong)YQHeadTitleView * headTitleView;



@end

@implementation YQConcernViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 1.headtitle的初始化
       self.headTitleView = [YQHeadTitleView headTitleInit];

}


@end
