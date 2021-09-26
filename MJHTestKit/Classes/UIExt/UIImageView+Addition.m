//
//  UIImageView+Addition.m
//  OneTutor
//
//  Created by MacBook Pro on 15-6-10.
//  Copyright (c) 2015年 JunHaoBsBs. All rights reserved.
//

#import "UIImageView+Addition.h"

@implementation UIImageView (Addition)

+(UIImageView*)shapeImageWithFrame:(CGRect)frame image:(UIImage *)image{
    
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:frame];
    [imageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = imageView.frame.size.width / 2;
    return imageView;
}

+(UIImageView*)cutImageWithFrame:(CGRect)frame image:(UIImage *)image{
    
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:frame];
    [imageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    return imageView;
}

@end
