//
//  YQSaveFileViewController.m
//  DR_NewMedia
//
//  Created by 杨庆 on 2017/5/5.
//  Copyright © 2017年 YQ. All rights reserved.
//

#import "YQSaveFileViewController.h"
#import "YQSaveFileCell.h"

@interface YQSaveFileViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *YQFileCollectionView;

/// data数组
@property(nonatomic,strong)NSMutableArray * saveFileArray;



@end

static NSString * ID = @"fileCell";

@implementation YQSaveFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.自定义布局
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 10;
    layout.headerReferenceSize = CGSizeMake(5, 0);
    
    layout.itemSize = CGSizeMake(self.YQFileCollectionView.width /2, self.YQFileCollectionView.height);
    
    self.YQFileCollectionView.collectionViewLayout = layout;
    
    //2.注册原型cell
    UINib * cellNib = [UINib nibWithNibName:@"YQSaveFileCell" bundle:nil];
    [self.YQFileCollectionView registerNib:cellNib forCellWithReuseIdentifier:ID];

    
    
}

#pragma mark - 懒加载数据方法
-(NSMutableArray *)saveFileArray{
    if(!_saveFileArray){
        
        _saveFileArray = [NSMutableArray array];
        
        for(int i =1;i< 15 ;i++){
            
            NSString * string1 = [NSString stringWithFormat:@"_00%02d.jpg",i ];
            
            //  将图片加入数组
            [_saveFileArray addObject:string1];
        }
    }
    
    return _saveFileArray;
}


#pragma mark - CollectionView数据源方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.saveFileArray.count;
}


-(UICollectionViewCell * )collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YQSaveFileCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:45/255.0 green:45/255.0 blue:60/255.0 alpha:0.4];
    //cell.imagename  = self.imagesArray[indexPath.row];
    //if(indexPath.row < self.collocationArray.count){
    
    //    NSString * path1 = [[NSBundle mainBundle] pathForResource:self.BGArray[indexPath.item] ofType:nil];
    // cell.saveImageView.image = [UIImage imageNamed:self.saveFileArray[indexPath.item]];
    
    //}
    return cell;
}



#pragma mark - CollectionView的代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //点击的是 item,将对应的图片传给控制 通知!
//    [[NSNotificationCenter defaultCenter]postNotificationName:YQbackGroundChange object:nil userInfo:@{YQpictureName:self.BGArray[indexPath.item]}];
    
    
}



@end
