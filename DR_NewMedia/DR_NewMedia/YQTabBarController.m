//
//  YQTabBarController.m
//  DR_NewMedia
//
//  Created by 杨庆 on 2017/4/17.
//  Copyright © 2017年 YQ. All rights reserved.
//

#import "YQTabBarController.h"
#import "YQCollocationViewController.h"

@interface YQTabBarController ()<UITabBarDelegate>

@property(nonatomic,assign)int lock;


@end

@implementation YQTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //[MBProgressHUD showMessage:@"正在登录中..." toView:self.view];
    // dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC);
    hud.mode = MBProgressHUDModeIndeterminate;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
        // Do something...
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    });
    
   
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    //目标控制器
    id destVC = segue.destinationViewController;
    
    if([destVC isKindOfClass:[YQCollocationViewController class]]){
        
        
        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //[MBProgressHUD showMessage:@"正在登录中..." toView:self.view];
        // dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC);
        hud.mode = MBProgressHUDModeIndeterminate;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
            // Do something...
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        });
    }
}




- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    
    if(item.tag == 1 && !self.lock){
        
        // [UIApplication sharedApplication].keyWindow.rootViewController.view animated:YES]
        
//        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        
//        //[MBProgressHUD showMessage:@"正在登录中..." toView:self.view];
//        // dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC);
//        hud.mode = MBProgressHUDModeIndeterminate;
//        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1* NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
//            
//            // Do something...
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//            
//        });
        
        self.lock = 1;
    }



}
@end
