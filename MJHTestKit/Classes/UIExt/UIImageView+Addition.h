//
//  UIImageView+Addition.h
//  OneTutor
//
//  Created by MacBook Pro on 15-6-10.
//  Copyright (c) 2015年 JunHaoBsBs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Addition)

+(UIImageView*)shapeImageWithFrame:(CGRect)frame
                             image:(UIImage*)image;

+(UIImageView*)cutImageWithFrame:(CGRect)frame image:(UIImage *)image;

@end
