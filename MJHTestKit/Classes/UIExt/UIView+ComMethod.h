//
//  UIView+ComMethod.h
//  GyennoMedical
//
//  Created by lmzqm on 2019/1/17.
//  Copyright © 2019 Gyenno. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ComMethod)

- (UILabel *)addLabelWithTextColor:(UIColor *)textColor andFont:(UIFont *)font andTextAlignment:(NSTextAlignment)alignment;

- (UIImageView *)addIcon;

@end

NS_ASSUME_NONNULL_END
