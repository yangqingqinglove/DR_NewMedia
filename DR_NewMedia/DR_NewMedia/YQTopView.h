//
//  YQTopView.h
//  DR_NewMedia
//
//  Created by 杨庆 on 2017/4/20.
//  Copyright © 2017年 YQ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YQTopView;

@protocol YQTopViewClickDeleate <NSObject>
//实现的代理的方法
-(void)topView:(YQTopView *)TopV buttonDidSelectTag:(NSInteger)tag;

@end

@interface YQTopView : UIView

// 提供的是 类方法,加载xib
+(instancetype)buttonMenu;

@property(nonatomic,strong)id<YQTopViewClickDeleate>  deleage;



@end
