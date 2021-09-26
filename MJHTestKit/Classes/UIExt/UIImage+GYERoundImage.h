//
//  UIImage+GYERoundImage.h
//  
//
//  Created by lmzqm on 17/4/5.
//  Copyright © 2017年 lmzqm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GYERoundImage)

/**
 *  生成圆角图片
 *
 *  @param image  图片
 *  @param size   尺寸
 *  @param radius 角度
 *
 *  @return 图片
 */
+ (UIImage *)generateRoundedCornersWithImage:(UIImage *)image size:(CGSize)size radius:(CGFloat)radius;

-(UIImage*)gye_drawCornor;

@end
