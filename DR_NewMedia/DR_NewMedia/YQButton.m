//
//  YQButton.m
//  DR_NewMedia
//
//  Created by 杨庆 on 2017/4/18.
//  Copyright © 2017年 YQ. All rights reserved.
//

#import "YQButton.h"

@implementation YQButton

-(instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.titleLabel.textAlignment = NSTextAlignmentNatural;
        self.titleLabel.font = [UIFont systemFontOfSize:20];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor grayColor];
        self.userInteractionEnabled = YES;
    
    }
    
    return self;
}

-(void)buttonWithScaleToHighlightedAnimation:(CGFloat)scale{
    
    //思路怎么来实现 渐变的效果:
    self.imageView.alpha = scale;
    
}

-(void)setScale:(CGFloat)scale{
    _scale = scale;
    
    //思路怎么来实现 渐变的效果:
    self.imageView.alpha = scale;
    //设置select的高亮的选择
    
}


@end
