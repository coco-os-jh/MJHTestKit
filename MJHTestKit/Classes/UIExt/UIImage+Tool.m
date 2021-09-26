//
//  UIImage+Tool.m
//  GyennoMedical
//
//  Created by HeJida on 2018/9/29.
//  Copyright © 2018年 Gyenno. All rights reserved.
//

#import "UIImage+Tool.h"

@implementation UIImage (Tool)

//压缩图片（maxLength：目标大小，单位KB，如果压缩太多的话也可以达不到该值）
- (NSData *)compressQualityWithMaxLength:(NSInteger)maxLength
{
    maxLength *= 1000;
    
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    if (data.length < maxLength) return data;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        }
        else if (data.length > maxLength) {
            max = compression;
        }
        else {
            break;
        }
    }
    return data;
}


@end
