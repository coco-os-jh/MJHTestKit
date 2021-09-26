//
//  UIImageView+DoctorAvatar.h
//  GyennoMedical
//
//  Created by Mac on 2020/9/2.
//  Copyright © 2020 Gyenno. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (DoctorAvatar)

- (void)setDoctorAvatarImageWithUrlString:(NSString *)urlStr andSex:(NSInteger)sex;

@end

NS_ASSUME_NONNULL_END
