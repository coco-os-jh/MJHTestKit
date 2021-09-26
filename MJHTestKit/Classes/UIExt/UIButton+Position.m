//
//  UIButton+Position.m
//  GyennoMedical
//
//  Created by flora on 16/8/1.
//  Copyright © 2016年 Gyenno. All rights reserved.
//

#import "UIButton+Position.h"

@implementation UIButton (Position)
- (void) centerButtonAndImageWithSpacing:(CGFloat)spacing {
    CGFloat insetAmount = spacing / 2.0;
    
    self.imageEdgeInsets = UIEdgeInsetsMake(0, -insetAmount, 0, insetAmount);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, insetAmount, 0, -insetAmount);
    self.contentEdgeInsets = UIEdgeInsetsMake(0, insetAmount, 0, insetAmount);
}
-(void)verterButtonAndImageWithSpacing:(CGFloat)spacing{
    [self positionButtonImageAtPosition:ImagePositionTop withSpacing:spacing];
}
- (void) positionButtonImageAtPosition:(ImagePosition)imagePosition withSpacing:(CGFloat)spacing {
    CGSize titleSize = [self.titleLabel.text sizeWithAttributes:@{ NSFontAttributeName: self.titleLabel.font }];
    CGSize imageSize = self.imageView.image.size;
    CGFloat insetAmount = spacing / 2.0;
    
    if (self) {
        switch (imagePosition)
        {
            case ImagePositionLeft: {
                self.imageEdgeInsets = UIEdgeInsetsMake(0, -insetAmount, 0, insetAmount);
                self.titleEdgeInsets = UIEdgeInsetsMake(0, insetAmount, 0, -insetAmount);
                self.contentEdgeInsets = UIEdgeInsetsMake(0, insetAmount, 0, insetAmount);
            }
                break;
                
            case ImagePositionRight: {
                self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width + insetAmount), 0, imageSize.width + insetAmount);
                self.imageEdgeInsets = UIEdgeInsetsMake(0, titleSize.width + insetAmount, 0, -(titleSize.width + insetAmount));
                self.contentEdgeInsets = UIEdgeInsetsMake(0, insetAmount, 0, insetAmount);
            }
                break;
                
            case ImagePositionTop: {
                self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, -(imageSize.height + spacing), 0.0);
                self.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), 0.0, 0.0, -titleSize.width);
            }
                break;
                
            case ImagePositionBottom: {
                self.titleEdgeInsets = UIEdgeInsetsMake(-(imageSize.height + spacing), -imageSize.width, 0, 0.0);
                self.imageEdgeInsets = UIEdgeInsetsMake(0, 0.0, -(titleSize.height + spacing), -titleSize.width);
            }
                break;
                
            default: {
                self.titleEdgeInsets = UIEdgeInsetsMake(0, 2 * spacing, 0, -2 * spacing);
                self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            }
                break;
        }
    }
}

- (void) positionButtonImageAtPosition:(ImagePosition)imagePosition byBtnSize:(CGSize)size withSpacing:(CGFloat)spacing{
    
    CGSize titleSize1 = [self.titleLabel.text sizeWithAttributes:@{ NSFontAttributeName: self.titleLabel.font }];
    CGSize titleSize = titleSize1.width < size.width ? titleSize1 : size ;
    CGSize imageSize = self.imageView.image.size;
    CGFloat insetAmount = spacing / 2.0;
    
    if (self) {
        switch (imagePosition)
        {
            case ImagePositionLeft: {
                self.imageEdgeInsets = UIEdgeInsetsMake(0, -insetAmount, 0, insetAmount);
                self.titleEdgeInsets = UIEdgeInsetsMake(0, insetAmount, 0, -insetAmount);
                self.contentEdgeInsets = UIEdgeInsetsMake(0, insetAmount, 0, insetAmount);
            }
                break;
                
            case ImagePositionRight: {
                self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width + insetAmount), 0, imageSize.width + spacing);
                self.imageEdgeInsets = UIEdgeInsetsMake(0, titleSize.width + insetAmount, 0, -(titleSize.width + spacing));
                self.contentEdgeInsets = UIEdgeInsetsMake(0, insetAmount, 0, insetAmount);
            }
                break;
                
            default: {
                self.titleEdgeInsets = UIEdgeInsetsMake(0, 2 * spacing, 0, -2 * spacing);
                self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            }
                break;
        } 
    }
    
    
}


@end
