//
//  YQImageGroupView.h
//  DR_NewMedia
//
//  Created by 杨庆 on 2017/4/25.
//  Copyright © 2017年 YQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQImageGroupView : UIImageView

//停留的原帧数
@property(nonatomic,assign)int lastIndex;

//记录原始的transform;
@property(nonatomic,assign)CGAffineTransform  originalTransform;

//定义的是图片的缓存池
@property(nonatomic,strong)NSMutableArray * cacheArray;

//定制的缩放的档位
@property(nonatomic,assign)CGFloat scaleStall;

@end
