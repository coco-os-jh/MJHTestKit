//
//  UIImageView+DoctorAvatar.m
//  GyennoMedical
//
//  Created by Mac on 2020/9/2.
//  Copyright © 2020 Gyenno. All rights reserved.
//

#import "UIImageView+DoctorAvatar.h"

@implementation UIImageView (DoctorAvatar)

- (void)setDoctorAvatarImageWithUrlString:(NSString *)urlStr andSex:(NSInteger)sex {
    UIImage *placeHolderImage = nil;
    if (sex == 1) { // 男
        placeHolderImage = [UIImage imageNamed:@"man_doctor_placeholder"];
    } else if (sex == 2) { // 女
        placeHolderImage = [UIImage imageNamed:@"women_doctor_placeholder"];
    } else { // 未知
        placeHolderImage = [UIImage imageNamed:@"man_doctor_placeholder"];
    }
//    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:placeHolderImage];
//    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:placeHolderImage options:SDWebImageRetryFailed completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//
//    }];
}

@end
