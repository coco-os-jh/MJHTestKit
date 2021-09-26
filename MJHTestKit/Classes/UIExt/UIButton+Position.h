//
//  UIButton+Position.h
//  GyennoMedical
//
//  Created by flora on 16/8/1.
//  Copyright © 2016年 Gyenno. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM (NSInteger, ImagePosition)
{
    ImagePositionLeft = 1,
    ImagePositionRight,
    ImagePositionTop,
    ImagePositionBottom
};

@interface UIButton (Position)

- (void) centerButtonAndImageWithSpacing:(CGFloat)spacing;
- (void) positionButtonImageAtPosition:(ImagePosition)imagePosition withSpacing:(CGFloat)spacing;

- (void) verterButtonAndImageWithSpacing:(CGFloat)spacing;

//用于需要换行的button
- (void) positionButtonImageAtPosition:(ImagePosition)imagePosition byBtnSize:(CGSize)size withSpacing:(CGFloat)spacing;
@end
 
