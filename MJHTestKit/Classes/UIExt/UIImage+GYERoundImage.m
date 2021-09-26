//
//  UIImage+GYERoundImage.m
//
//
//  Created by lmzqm on 17/4/5.
//  Copyright © 2017年 lmzqm. All rights reserved.
//

#import "UIImage+GYERoundImage.h"
#import "GlobalHeader.h"

@implementation UIImage (GYERoundImage)

+ (UIImage *)generateRoundedCornersWithImage:(UIImage *)image size:(CGSize)size radius:(CGFloat)radius
{
    if (!image)return nil;
    
    const CGFloat width = size.width;
    const CGFloat height = size.height;
    
    radius = MAX(5.f, radius);
    radius = MIN(10.f, radius);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, 4 * width, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, width, height);
    CGContextBeginPath(context);
    addRoundRectToPath(context, rect, radius, image.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    UIImage * img = [UIImage imageWithCGImage: imageMasked];
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageMasked);
    
    return img;
}



/**
 *  给上下文添加圆角蒙版
 */
void addRoundRectToPath(CGContextRef context, CGRect rect, float radius, CGImageRef image)
{
    float width, height;
    if (radius == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    width = CGRectGetWidth(rect);
    height = CGRectGetHeight(rect);
    
    //裁剪路径
    CGContextMoveToPoint(context, width, height / 2);
    CGContextAddArcToPoint(context, width, height, width / 2, height, radius);
    CGContextAddArcToPoint(context, 0, height, 0, height / 2, radius);
    CGContextAddArcToPoint(context, 0, 0, width / 2, 0, radius);
    CGContextAddArcToPoint(context, width, 0, width, height / 2, radius);
    CGContextClosePath(context);
    CGContextClip(context);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), image);
    CGContextRestoreGState(context);
}

-(UIImage*)gye_drawCornor{
    return [self lm_drawRectWithRoundedCorner:5*WIDTHSCALE size:self.size];
}

- (UIImage *)lm_drawRectWithRoundedCorner:(CGFloat)radius
                                     size:(CGSize)size{
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, false, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    CGContextAddPath(context, path.CGPath);
    
    CGContextClip(context);
    
    [self drawInRect:rect];
    CGContextDrawPath(context, kCGPathFillStroke);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  image;
}


@end
