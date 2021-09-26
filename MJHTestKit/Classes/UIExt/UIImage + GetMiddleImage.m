//
//  UIImage + GetMiddleImage.m
//  GyennoMedical
//
//  Created by fengwu on 5/17/16.
//  Copyright © 2016 Gyenno. All rights reserved.
//

#import "UIImage + GetMiddleImage.h"
#import "GlobalHeader.h"

@implementation UIImage (GetMiddleImage) 
+ (UIImage *)getMiddleRect:(UIImage*)image
{
    
    float width = image.size.width;
    float height = image.size.height;
    
    float minValue = width>height ?height:width;
    minValue = 360*HEIGHTSCALE>minValue ?minValue:360*HEIGHTSCALE;
    
    UIImageView * iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    iv.image = image;
    
    UIImage * timage = [[self class]getImage:iv];
    CGRect rect = CGRectMake(image.size.width/2 - minValue/2, image.size.height/2 - minValue/2, minValue, minValue);
    CGImageRef imageRef = CGImageCreateWithImageInRect([timage CGImage], rect);
    UIImage * img = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return img;
}

+ (UIImage *)getImage:(UIView *)view
{
    CGSize size = CGSizeMake(view.frame.size.width, view.frame.size.height );
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    [view.layer renderInContext:context];
    UIImage * theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
