//
//  YQRegisterViewController.m
//  DR_NewMedia
//
//  Created by 杨庆 on 2017/5/17.
//  Copyright © 2017年 YQ. All rights reserved.
//

#import "YQRegisterViewController.h"
<<<<<<< HEAD
#import "YQSettingContentViewController.h"


@interface YQRegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;

@property (weak, nonatomic) IBOutlet UITextField *Verification;

=======

@interface YQRegisterViewController ()

>>>>>>> origin/test1
@end

@implementation YQRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

<<<<<<< HEAD
- (IBAction)sendVerification:(id)sender {
    
    
    
}

- (IBAction)LoginButtonClick:(id)sender {
    
    //发送请求
    
    //跳转界面(完善用户信息)
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"YQSettingContent" bundle:nil];
    UIViewController * vc = [sb instantiateInitialViewController];
    [self presentViewController:vc animated:YES completion:nil];
    
    
}

- (IBAction)closeVC:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
=======
>>>>>>> origin/test1

@end
