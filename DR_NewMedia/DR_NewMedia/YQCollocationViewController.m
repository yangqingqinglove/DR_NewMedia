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
#import "YQWardrobeCollectionView.h"
#import "YQWardrobeCell.h"

@interface YQCollocationViewController ()<YQBottomViewClickDeleage,YQTopViewClickDeleate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *navBarView;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property(nonatomic,strong)YQWardrobeCollectionView * wardrobeView;




/// 定义的记录属性 view
@property(nonatomic,strong)UIView * bottomV;
@property(nonatomic,strong)UIView * topView;

/// 伸缩属性
@property(nonatomic,assign)BOOL isShow;


@end

static NSString * ID = @"imageCell";

@implementation YQCollocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //1.加载topView
    YQTopView * topView = [YQTopView buttonMenu];
    topView.deleage = self;
    [self.view addSubview:topView];
    self.topView = topView;
    self.topView.frame = CGRectMake(widthSize - 105, 60, 105, 45);
    
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
    
    //3.2 创建rect
    CGRect rect = CGRectMake(widthSize, 60 + 45, 60, heightSize - 48 -60 -45);
    YQWardrobeCollectionView * wardrobe = [[YQWardrobeCollectionView alloc]initWithFrame:rect collectionViewLayout:layout];
    wardrobe.backgroundColor = [UIColor grayColor];
    
    wardrobe.dataSource = self;
    wardrobe.delegate =   self;
    //3.3 注册原型cell
    UINib * cellNib = [UINib nibWithNibName:@"YQWardrobeCell" bundle:nil];
    [wardrobe registerNib:cellNib forCellWithReuseIdentifier:ID];
    self.wardrobeView = wardrobe;
    [self.view addSubview:wardrobe];
    
    
}


#pragma mark --------YQBottomViewClickDeleage代理的执行的方法------
-(void)bottomView:(YQBottomView *)bottomV didSelectedButtonFrom:(NSUInteger)from to:(int)To{
    
    if(self.imageView.animating){
        return;
    }
    

}

-(void)topView:(YQTopView *)TopV buttonDidSelectTag:(NSInteger)tag{
    
    switch (tag) {
        case 2:{//移动 transform
            
            CGFloat x = 0;
            
            CGAffineTransform transform = CGAffineTransformMake(1, 0,0,1, 0, 0);
            if (!_isShow) {
                x = -60;
                
            }else{
                
                x = 60;
            }
            
            [UIView animateWithDuration:0.5 animations:^{
                
                self.wardrobeView.transform = CGAffineTransformTranslate(transform, x, 0);
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
    
    return 20;
}


-(UICollectionViewCell * )collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YQWardrobeCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    //cell.imagename  = self.imagesArray[indexPath.row];
    
    return cell;
    
}

#pragma mark - AllButtonClick的方法
- (IBAction)rulerBtnClick:(id)sender {
    //整体的 motai 出来一个控制器
    
    
    
}

- (IBAction)backgroundBtnClick:(id)sender {
    
    
}

- (IBAction)detailBtnClick:(id)sender {
    
    
}

- (IBAction)taggingBtnClick:(id)sender {
    
    
}

- (IBAction)graphicBtnClick:(id)sender {
    
    
}

- (IBAction)saveBtnClick:(id)sender {
    
    
}

@end
