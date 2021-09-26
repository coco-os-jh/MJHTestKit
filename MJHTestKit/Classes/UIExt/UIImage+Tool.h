//
//  UIImage+Tool.h
//  GyennoMedical
//
//  Created by HeJida on 2018/9/29.
//  Copyright © 2018年 Gyenno. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tool)

///压缩图片（maxLength：目标大小，单位KB，如果压缩太多的话也可以达不到该值）
- (NSData *)compressQualityWithMaxLength:(NSInteger)maxLength;

@end
