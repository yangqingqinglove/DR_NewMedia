//
//  YQCollocationViewController.m
//  DR_NewMedia
//
//  Created by 杨庆 on 2017/4/20.
//  Copyright © 2017年 YQ. All rights reserved.
//

#define pictureFrames 36
#define widthSize [UIScreen mainScreen].bounds.size.width
#define heightSize [UIScreen mainScreen].bounds.size.height
#define buttonSize 45
#define ADuration 0.01
#define downTime 4.5

#import "YQCollocationViewController.h"
#import "YQBottomView.h"
#import "YQTopView.h"
#import "YQWardrobeCollectionView.h"
#import "YQWardrobeCell.h"
#import "YQDetailViewController.h"
#import "YQRulerVC.h"
#import "YQBackGroundViewController.h"
#import "YQImageGroupView.h"
#import <MBProgressHUD.h>


@interface YQCollocationViewController ()<YQBottomViewClickDeleage,YQTopViewClickDeleate,UICollectionViewDelegate,UICollectionViewDataSource,YQImageGroupViewDelegate>

//@property (weak, nonatomic) IBOutlet UIView *navBarView;

@property (weak, nonatomic) IBOutlet YQImageGroupView *imageView;

@property(nonatomic,strong)YQWardrobeCollectionView * wardrobeView;

/// 各种的展示控制器
@property(nonatomic,strong)YQDetailViewController * detailVC;
@property(nonatomic,strong)YQRulerVC * rulerVC;
@property(nonatomic,strong)YQBackGroundViewController * BGVC;

/// 定义的记录属性 view
@property(nonatomic,strong)UIView * bottomV;
@property(nonatomic,strong)UIView * topView;
@property(nonatomic,strong)UIView * baffleView;

/// 伸缩属性
@property(nonatomic,assign)BOOL isShow;

/// 定义的是衣柜模型数组
@property(nonatomic,strong)NSMutableArray * collocationArray;

@end

static NSString * ID = @"imageCell";

@implementation YQCollocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //0.添加菊花加载
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.mode = MBProgressHUDModeIndeterminate;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(downTime* NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
        
        // Do something... downsometing....
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    });

    //1.加载topView
    YQTopView * topView = [YQTopView buttonMenu];
    topView.deleage = self;
    [self.view addSubview:topView];
    self.topView = topView;
    self.topView.frame = CGRectMake(widthSize - 60, 64, 60, 45);
    
    //2.创建buttonView的展示的效果
    YQBottomView * bottomView = [YQBottomView buttonMenu];
    bottomView.deleage = self;
    [self.view addSubview:bottomView];
    self.bottomV = bottomView;
    CGFloat childs = self.bottomV.subviews.count;
    self.bottomV.frame = CGRectMake(0, heightSize - buttonSize - 48,childs *(buttonSize+ 5),  buttonSize);
    
    //3.创建share的衣柜,创建的流水布局
    //3.1 创建布局
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 5;
    layout.headerReferenceSize = CGSizeMake(60, 5);
    
    //3.2 创建rect
    CGRect rect = CGRectMake(widthSize, 64 + 45, 60, heightSize - 48 -64 -45);
    YQWardrobeCollectionView * wardrobe = [[YQWardrobeCollectionView alloc]initWithFrame:rect collectionViewLayout:layout];
    wardrobe.backgroundColor = [UIColor colorWithRed:187/255.0 green:190/255.0 blue:194/255.0 alpha:1.0];
    
    wardrobe.dataSource = self;
    wardrobe.delegate =   self;
    //3.3 注册原型cell
    UINib * cellNib = [UINib nibWithNibName:@"YQWardrobeCell" bundle:nil];
    [wardrobe registerNib:cellNib forCellWithReuseIdentifier:ID];
    self.wardrobeView = wardrobe;
    [self.view addSubview:wardrobe];
    
    //4.设置代理
    self.imageView.delegate = self;
    
    //5.设置自定义的titleView
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    imageView.image = [UIImage imageNamed:@""];
    imageView.backgroundColor = [UIColor redColor];
    
    self.navigationItem.titleView = imageView;
    
    //6.设置rightBar
    UIButton * rightBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBnt.bounds = CGRectMake(0, 0, 40, 40);
    rightBnt.backgroundColor = [UIColor clearColor];//设置透明
    [rightBnt addTarget:self action:@selector(rightBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [rightBnt setTitle:@"设置" forState:UIControlStateNormal];
    
    UIBarButtonItem * bntItem = [[UIBarButtonItem alloc]initWithCustomView:rightBnt];
    self.navigationItem.rightBarButtonItem = bntItem;
    
}


#pragma mark - 懒加载
-(NSMutableArray *)collocationArray{
    
    if(!_collocationArray){
        //添加下载收藏的图片柜
        NSArray * images = @[@"duowei_00",@"philips_hq6070_00",@"quen170427_40000036_00",@"yi170427_40000036_00",@"ku170427_30000036_00"];
        _collocationArray = [NSMutableArray array];
        
        for(int i =0;i<images.count ;i++){
            
            NSString * string1 = [NSString stringWithFormat:@"%@.png",images[i]];
            
            //  将图片加入数组
            [_collocationArray addObject:string1];
        }
    }
    
    return _collocationArray;
}


#pragma mark YQBottomViewClickDeleage代理执行的方法
-(void)bottomView:(YQBottomView *)bottomV didSelectedButtonFrom:(NSUInteger)from to:(int)To{
    
    if(self.imageView.animating){
        return;
    }
    
    [self bottomViewDetegateToOriginalPicture];
    [self bottomViewDetegateToPlayPictureFrom:To];

}

-(void)topView:(YQTopView *)TopV buttonDidSelectTag:(NSInteger)tag{
    
    switch (tag) {
            
        case 2:{//移动 transform
            
            //禁止用户交互其他的选项
            self.imageView.userInteractionEnabled = NO;
            
            CGFloat x = 0;
            
            CGAffineTransform transform = CGAffineTransformMake(1, 0,0,1, 0, 0);
            if (!_isShow) {
                
                x = -60;
                
                TopV.backgroundColor = [UIColor colorWithRed:187/255.0 green:190/255.0 blue:194/255.0 alpha:1.0];
                
            }else{
                
                TopV.backgroundColor = [UIColor clearColor];
                x = 60;
            }
            
            [UIView animateWithDuration:0.5 animations:^{
                
                self.wardrobeView.transform = CGAffineTransformTranslate(transform, x, 0);
                
            }completion:^(BOOL finished) {
                
                self.imageView.userInteractionEnabled = YES;
            }];
            
            self.isShow = !self.isShow;
            
            break;
        }
            
        case 1:{// 友盟分享
            
            break;
        }
        default:
            break;
    }

}


#pragma mark - collectionView的数据源方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.collocationArray.count;
}


-(UICollectionViewCell * )collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YQWardrobeCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    //cell.imagename  = self.imagesArray[indexPath.row];
    //if(indexPath.row < self.collocationArray.count){
    
    //NSString * path1 = [[NSBundle mainBundle] pathForResource:self.collocationArray[indexPath.item] ofType:nil];
    cell.imageview.image = [UIImage imageNamed:self.collocationArray[indexPath.item]];
    
    //}
    
    return cell;
}


#pragma mark - collectionView的代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //点击的item的选中的情况! 取出来进行检验图片名是否相同!
    //1.首先判断的是这个图片是单张or 组合
    NSString * str = [self.collocationArray[indexPath.item] substringToIndex:2];
    
    if(![str isEqualToString:@"yi"] && ![str isEqualToString:@"ku"]){//单张图片
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            
            //图片是从记录的 位置,开始显示!
            // 注意的是,这里还要有判断上衣和 下衣的逻辑 合成图片
            NSString * string1 = self.collocationArray[indexPath.item];
            NSString * string2 = [string1 substringToIndex:string1.length - 7];
            
//            NSString * string2 = self.imageView.currentDownImageName;
//            NSString * string3 = [string2 substringToIndex:string2.length - 7];
            if([str isEqualToString:@"qu"]){
                
                for(int i=0;i < pictureFrames ;i++){
                    
                    NSString * string3 = [NSString stringWithFormat:@"%@_%02d.png",string2,i*10];
                    NSString * path1 = [[NSBundle mainBundle] pathForResource:string3 ofType:nil];
                    
                    //                NSString * string2 = [NSString stringWithFormat:@"%@_%02d.png",string3,i*10];
                    //                NSString * path2 = [[NSBundle mainBundle] pathForResource:string2 ofType:nil];
                    
                    //  生成图片
                    UIImage *image = [UIImage imageWithContentsOfFile:path1];
                    
                    //  将图片加入数组
                    [self.imageView.cacheArray replaceObjectAtIndex:i withObject:image];
                };
                
            }else{
                
                for(int i=0;i < pictureFrames ;i++){
                    
                    NSString * string1 = [NSString stringWithFormat:@"%@_%02d.jpg",string2,i*10];
                    NSString * path1 = [[NSBundle mainBundle] pathForResource:string1 ofType:nil];
                    
                    //                NSString * string2 = [NSString stringWithFormat:@"%@_%02d.png",string3,i*10];
                    //                NSString * path2 = [[NSBundle mainBundle] pathForResource:string2 ofType:nil];
                    
                    //  生成图片
                    UIImage *image = [UIImage imageWithContentsOfFile:path1];
                    
                    //  将图片加入数组
                    [self.imageView.cacheArray replaceObjectAtIndex:i withObject:image];
                };
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //最后的显示的是: 当前停止的状态
                self.imageView.image = self.imageView.cacheArray[self.imageView.lastIndex];
                self.imageView.currentUpImageName = string1;
                self.imageView.currentDownImageName = nil;
            });
            
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
            // Do something...
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        });
        
    }else{
        
        
        BOOL equal1 =[self.collocationArray[indexPath.item] isEqualToString: self.imageView.currentDownImageName];
        
        BOOL equal2 =[self.collocationArray[indexPath.item] isEqualToString: self.imageView.currentUpImageName];
        
        if(equal1 || equal2){//相等,证明的是,图片存在
            
            //alert 提示当前 衣服就是!
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"已经在展示了哟!" preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
            
            [self presentViewController:alert animated:YES completion:nil ];
            
            return;
            
        }else{//不相等的情况下,需要的是合成 //还有的 逻辑的判断是 现存的是 如果是同类 和 不是同一类的情况
            
            
            BOOL equal1 =[[self.imageView.currentDownImageName substringToIndex:2] isEqualToString: @"ku"];
            
            BOOL equal2 =[[self.imageView.currentUpImageName substringToIndex:2] isEqualToString: @"yi"];
            
            //BOOL equal3 =[self.collocationArray[indexPath.item] isEqualToString: @"ku"];
            
            BOOL equal4 =[str isEqualToString: @"yi"];

            if(equal1 || equal2){
            
                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                    
                    //图片是从记录的 位置,开始显示!
                    // 注意的是,这里还要有判断上衣和 下衣的逻辑 合成图片
                    NSString * string1 = self.collocationArray[indexPath.item];
                    NSString * string = [string1 substringToIndex:string1.length - 7];
                    
                    NSString * string2 = nil;
                    if(equal1){//当前是裤子
                        
                        string2 = self.imageView.currentDownImageName;
                        NSString * string3 = [string2 substringToIndex:string2.length - 7];
                        
                        for(int i=0;i < pictureFrames ;i++){
                            
                            NSString * string1 = [NSString stringWithFormat:@"%@_%02d.png",string,i*10];
                            NSString * path1 = [[NSBundle mainBundle] pathForResource:string1 ofType:nil];
                            
                            NSString * string2 = [NSString stringWithFormat:@"%@_%02d.png",string3,i*10];
                            NSString * path2 = [[NSBundle mainBundle] pathForResource:string2 ofType:nil];
                            
                            //  生成图片
                            UIImage *image = [self.imageView addImagePath:path2 withImage:path1];
                            
                            //  将图片加入数组
                            [self.imageView.cacheArray replaceObjectAtIndex:i withObject:image];
                        };

                    }else{
                        
                        string2 = self.imageView.currentUpImageName;
                        NSString * string3 = [string2 substringToIndex:string2.length - 7];
                        
                        for(int i=0;i < pictureFrames ;i++){
                            
                            NSString * string1 = [NSString stringWithFormat:@"%@_%02d.png",string,i*10];
                            NSString * path1 = [[NSBundle mainBundle] pathForResource:string1 ofType:nil];
                            
                            NSString * string2 = [NSString stringWithFormat:@"%@_%02d.png",string3,i*10];
                            NSString * path2 = [[NSBundle mainBundle] pathForResource:string2 ofType:nil];
                            
                            //  生成图片
                            UIImage *image = [self.imageView addImagePath:path1 withImage:path2];
                            
                            //  将图片加入数组
                            [self.imageView.cacheArray replaceObjectAtIndex:i withObject:image];
                        };
                    }

                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        //最后的显示的是: 当前停止的状态
                        self.imageView.image = self.imageView.cacheArray[self.imageView.lastIndex];
                        if(equal1){//当前是裤子
                        
                            self.imageView.currentUpImageName = string1;
                        }else{
                            
                            self.imageView.currentDownImageName = string1;
                        }
                    });
                    
                });
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(downTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
                    
                    // Do something...
                    
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    
                });
                
            }else{
                
                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                    
                    //图片是从记录的 位置,开始显示!
                    // 注意的是,这里还要有判断上衣和 下衣的逻辑 合成图片
                    NSString * string1 = self.collocationArray[indexPath.item];
                    NSString * string = [string1 substringToIndex:string1.length - 7];
                    
                    //            NSString * string2 = self.imageView.currentDownImageName;
                    //            NSString * string3 = [string2 substringToIndex:string2.length - 7];
                    
                    for(int i=0;i < pictureFrames ;i++){
                        
                        NSString * string1 = [NSString stringWithFormat:@"%@_%02d.png",string,i*10];
                        NSString * path1 = [[NSBundle mainBundle] pathForResource:string1 ofType:nil];
                        
                        //                NSString * string2 = [NSString stringWithFormat:@"%@_%02d.png",string3,i*10];
                        //                NSString * path2 = [[NSBundle mainBundle] pathForResource:string2 ofType:nil];
                        
                        //  生成图片
                        UIImage *image = [UIImage imageWithContentsOfFile:path1];
                        
                        //  将图片加入数组
                        [self.imageView.cacheArray replaceObjectAtIndex:i withObject:image];
                    };
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        //最后的显示的是: 当前停止的状态
                        self.imageView.image = self.imageView.cacheArray[self.imageView.lastIndex];
                        
                        if(equal4){
                        
                            self.imageView.currentUpImageName = string1;
                            self.imageView.currentDownImageName = nil;
                            
                        }else{
                            
                            self.imageView.currentUpImageName = nil;
                            self.imageView.currentDownImageName = string1;

                        }
                    });
                    
                });
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
                    // Do something...
                    
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    
                });
            }
        }
    }
}

#pragma mark - AllButtonClick的方法
- (IBAction)rulerBtnClick:(id)sender {
    
    //整体的 modal 出来一个控制器
    //添加蒙版,设置成为第一响应者
    UIView * baffleV = [[UIView alloc]initWithFrame:self.view.bounds];
    baffleV.backgroundColor = [UIColor grayColor];
    baffleV.alpha = 0.5;
    //BOOL ISTR = [baffleV isFirstResponder];//是否是 第一响应者的情况!
    //[baffleV becomeFirstResponder];//成为第一响应者
    //[baffleV resignFirstResponder];//取消第一响应者
    [self.view addSubview:baffleV];
    self.baffleView = baffleV;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(baffleViewDidClilck)];
    [self.baffleView addGestureRecognizer:tap];
    
    YQRulerVC * ruler = [[YQRulerVC alloc]init];
    self.rulerVC = ruler;
    [self.view addSubview:ruler.view];
    self.rulerVC.view.alpha = 0;
    self.rulerVC.view.hidden = YES;
    self.rulerVC.view.frame = CGRectMake(0, heightSize/4, widthSize, 300);
    
    //添加动画
    [UIView animateWithDuration:0.25 animations:^{
        
        //        [self.detailVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.top.equalTo(baffleV.mas_top).offset(200);
        //            make.width.equalTo(baffleV.mas_bottom).offset(200);
        //        }];
        // self.rulerVC.view.frame = CGRectMake(0, heightSize/4, widthSize, 300);
        self.rulerVC.view.alpha = 1;
        self.rulerVC.view.hidden = NO;
        
    }];
    
    
    // modal 弹框的效果的图形
//    YQRulerVC * ruler = [[YQRulerVC alloc]init];
//    ruler.modalPresentationStyle = UIModalPresentationFormSheet;// 只针对于 ipad的view,对于iphone的项目不适用!
//    [self presentViewController:ruler animated:YES completion:nil];
//    
}




- (IBAction)backgroundBtnClick:(id)sender {
    //实现的思路是:添加模板, 然后的是:自定义的弹窗modal的效果
    /*
     //通过的是调用的popview的窗口来实现的
     //1.创建内容的控制器
     UIStoryboard * revise = [UIStoryboard storyboardWithName:@"YQReviseCase" bundle:nil];
     YQReviseCaseTableViewController * reviseCaseVC = [revise instantiateInitialViewController];
     
     //2.创建popover的控制器
     #pragma clang diagnostic push
     #pragma clang diagnostic ignored "-Wdeprecated-declarations"
     
     self.casePopover = [[UIPopoverController alloc]initWithContentViewController:reviseCaseVC];
     #pragma clang diagnostic pop
     
     CGFloat x = self.superview.superview.bounds.origin.x;
     CGFloat y = self.superview.superview.bounds.origin.y;
     CGRect rect = CGRectMake(x-350, y+230, 900, 600);
     
     //3.弹出present出来一个控制器
     [self.casePopover presentPopoverFromRect:rect inView:self.superview.superview permittedArrowDirections:UIPopoverArrowDirectionUnknown animated:YES];
     */
    //整体的 modal 出来一个控制器
    //添加蒙版,设置成为第一响应者
    UIView * baffleV = [[UIView alloc]initWithFrame:self.view.bounds];
    baffleV.backgroundColor = [UIColor grayColor];
    baffleV.alpha = 0.5;
    //BOOL ISTR = [baffleV isFirstResponder];//是否是 第一响应者的情况!
    //[baffleV becomeFirstResponder];//成为第一响应者
    //[baffleV resignFirstResponder];//取消第一响应者
    [self.view addSubview:baffleV];
    self.baffleView = baffleV;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(baffleViewDidClilck)];
    [self.baffleView addGestureRecognizer:tap];
    
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"YQBackGround" bundle:nil];
    self.BGVC = [sb instantiateInitialViewController];
    [self.view addSubview:self.BGVC.view];
    
    self.BGVC.view.alpha = 0;
    self.BGVC.view.hidden = YES;
    self.BGVC.view.frame = CGRectMake(0, heightSize/4, widthSize, 300);
    
    //添加动画
    [UIView animateWithDuration:0.25 animations:^{
        
        //        [self.detailVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.top.equalTo(baffleV.mas_top).offset(200);
        //            make.width.equalTo(baffleV.mas_bottom).offset(200);
        //        }];
        // self.rulerVC.view.frame = CGRectMake(0, heightSize/4, widthSize, 300);
        self.BGVC.view.alpha = 1;
        self.BGVC.view.hidden = NO;
        
    }];
    
}

- (IBAction)detailBtnClick:(id)sender {
    //停止用户的交互
    //self.view.userInteractionEnabled = NO;
    //添加蒙版,设置成为第一响应者
    UIView * baffleV = [[UIView alloc]initWithFrame:self.view.bounds];
    baffleV.backgroundColor = [UIColor grayColor];
    baffleV.alpha = 0.5;
    //BOOL ISTR = [baffleV isFirstResponder];//是否是 第一响应者的情况!
    //[baffleV becomeFirstResponder];//成为第一响应者
    //[baffleV resignFirstResponder];//取消第一响应者
    [self.view addSubview:baffleV];
    self.baffleView = baffleV;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(baffleViewDidClilck)];
    [self.baffleView addGestureRecognizer:tap];
    
    
    //然后再添加控制器来成为 baffleV的子视图!
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"YQDetail" bundle:nil];
    self.detailVC = [sb instantiateInitialViewController];
    [self.view addSubview:self.detailVC.view];
    
//    [self.detailVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(baffleV.mas_bottom);
//        make.left.equalTo(baffleV.mas_left).offset(30);
//        make.right.equalTo(baffleV.mas_right).offset(30);
//        make.width.equalTo(@400);
//    }];
    
    self.detailVC.view.alpha = 0;
    self.detailVC.view.hidden = YES;
    self.detailVC.view.frame = CGRectMake(0, heightSize/4, widthSize, 300);
    
    //添加动画
    [UIView animateWithDuration:0.25 animations:^{
        
//        [self.detailVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(baffleV.mas_top).offset(200);
//            make.width.equalTo(baffleV.mas_bottom).offset(200);
//        }];
//       self.detailVC.view.frame = CGRectMake(0, heightSize/4, widthSize, 300);
        self.detailVC.view.alpha = 1;
        self.detailVC.view.hidden = NO;

    }];
    
}

- (IBAction)taggingBtnClick:(id)sender {
    //整体的 modal 出来一个控制器
    //添加蒙版,设置成为第一响应者
    UIView * baffleV = [[UIView alloc]initWithFrame:self.view.bounds];
    baffleV.backgroundColor = [UIColor grayColor];
    baffleV.alpha = 0.5;
    //BOOL ISTR = [baffleV isFirstResponder];//是否是 第一响应者的情况!
    //[baffleV becomeFirstResponder];//成为第一响应者
    //[baffleV resignFirstResponder];//取消第一响应者
    [self.view addSubview:baffleV];
    self.baffleView = baffleV;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(baffleViewDidClilck)];
    [self.baffleView addGestureRecognizer:tap];
    
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"YQBackGround" bundle:nil];
    self.BGVC = [sb instantiateInitialViewController];
    [self.view addSubview:self.BGVC.view];
    
    self.BGVC.view.alpha = 0;
    self.BGVC.view.hidden = YES;
    self.BGVC.view.frame = CGRectMake(0, heightSize/4, widthSize, 300);
    
    //添加动画
    [UIView animateWithDuration:0.25 animations:^{
        
        //        [self.detailVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.top.equalTo(baffleV.mas_top).offset(200);
        //            make.width.equalTo(baffleV.mas_bottom).offset(200);
        //        }];
        // self.rulerVC.view.frame = CGRectMake(0, heightSize/4, widthSize, 300);
        self.BGVC.view.alpha = 1;
        self.BGVC.view.hidden = NO;
        
    }];

}

- (IBAction)graphicBtnClick:(id)sender {
    //整体的 modal 出来一个控制器
    //添加蒙版,设置成为第一响应者
    UIView * baffleV = [[UIView alloc]initWithFrame:self.view.bounds];
    baffleV.backgroundColor = [UIColor grayColor];
    baffleV.alpha = 0.5;
    //BOOL ISTR = [baffleV isFirstResponder];//是否是 第一响应者的情况!
    //[baffleV becomeFirstResponder];//成为第一响应者
    //[baffleV resignFirstResponder];//取消第一响应者
    [self.view addSubview:baffleV];
    self.baffleView = baffleV;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(baffleViewDidClilck)];
    [self.baffleView addGestureRecognizer:tap];
    
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"YQBackGround" bundle:nil];
    self.BGVC = [sb instantiateInitialViewController];
    [self.view addSubview:self.BGVC.view];
    
    self.BGVC.view.alpha = 0;
    self.BGVC.view.hidden = YES;
    self.BGVC.view.frame = CGRectMake(0, heightSize/4, widthSize, 300);
    
    //添加动画
    [UIView animateWithDuration:0.25 animations:^{
        
        //        [self.detailVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.top.equalTo(baffleV.mas_top).offset(200);
        //            make.width.equalTo(baffleV.mas_bottom).offset(200);
        //        }];
        // self.rulerVC.view.frame = CGRectMake(0, heightSize/4, widthSize, 300);
        self.BGVC.view.alpha = 1;
        self.BGVC.view.hidden = NO;
        
    }];

}

- (IBAction)saveBtnClick:(id)sender {
    
    //通过alert的方式来进行的实现
    UIAlertController * save = [UIAlertController alertControllerWithTitle:@"保存" message:@"是否要保存" preferredStyle:UIAlertControllerStyleAlert];
    
    [save addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击取消");
        
    }]];
    
    
    
    [save addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击确认");
        
    }]];
    
//    [alertController addAction:[UIAlertAction actionWithTitle:@"警告" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//        
//        NSLog(@"点击警告");
//        
//    }]];
    
    
//    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//        
//        NSLog(@"添加一个textField就会调用 这个block");
//        
//    }];
    

    // 由于它是一个控制器 直接modal出来就好了
    
    [self presentViewController:save animated:YES completion:nil];
    

    
}

#pragma mark - touchesBegin的解锁方法
-(void)baffleViewDidClilck{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        //        [self.detailVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.top.equalTo(baffleV.mas_top).offset(200);
        //            make.width.equalTo(baffleV.mas_bottom).offset(200);
        //        }];
        
        self.detailVC.view.alpha = 0;
        self.detailVC.view.hidden = YES;
        self.rulerVC.view.alpha = 0;
        self.rulerVC.view.hidden = YES;
        self.BGVC.view.alpha = 0;
        self.BGVC.view.hidden = YES;
        
    }];
    
    [self.baffleView removeFromSuperview];

}


#pragma mark --------封装代理方法中的复原------
-(void)bottomViewDetegateToOriginalPicture{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.imageView.transform = self.imageView.originalTransform;
    }];
    
}


#pragma mark --------封装代理方法中的回播------
-(void)bottomViewDetegateToPlayPictureFrom:(int)num{
    
    if (self.imageView.lastIndex == num) {
        return;
    }
    
    if (self.imageView.lastIndex < 0) {
        // 如果是 负数的话就要求的是 回转一圈
        self.imageView.lastIndex = self.imageView.lastIndex + pictureFrames;
    }
    
    NSMutableArray * array = [NSMutableArray array];
    //回到主视图的操作
    //停留的帧数 倒序 回放到 原始地方的逻辑的处理
    if( self.imageView.lastIndex < num){
        
        for (int i = self.imageView.lastIndex; i < num; i++) {
            
            [array addObject:self.imageView.cacheArray[i]];
        }
        
    }else{
        for (int i = self.imageView.lastIndex; i > num; i--) {
            
            [array addObject:self.imageView.cacheArray[i]];
        }
    }
    
    //  1.3把数组存入UIImageView中
    self.imageView.animationImages = array;
    
    //  fps  12
    self.imageView.animationDuration = ADuration * array.count * 10;
    
    //  1.5播放动画
    [self.imageView startAnimating];
    
    [self.imageView performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:self.imageView.animationDuration + 0.005 ];
    
    self.imageView.image = (UIImage *)self.imageView.cacheArray[num];
    
    //给组动画最后最后一张来赋值
    //内存优化!
    self.imageView.lastIndex = num;
    self.imageView.scaleStall = 1;
    
}


#pragma mark - YQGroupViewDelegate_alert的代理方法
-(void)imageGroupView:(YQImageGroupView *)groupView ViewWithWidthSize:(CGFloat)width{
    
    if (width > 1000) {
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"最大了,已经最大了哟!" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        
        [self presentViewController:alert animated:YES completion:nil ];

        
    }else{
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"最小了,已经最小了哟!" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        
        [self presentViewController:alert animated:YES completion:nil ];

    }
    
}

#pragma mark - rightBarButtonClick的方法
-(void)rightBarButtonClicked:(UIButton *)bnt{



}




@end
