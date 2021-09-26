//
//  UIView+ComMethod.m
//  GyennoMedical
//
//  Created by lmzqm on 2019/1/17.
//  Copyright © 2019 Gyenno. All rights reserved.
//

#import "UIView+ComMethod.h"

@implementation UIView (ComMethod)

- (UILabel *)addLabelWithTextColor:(UIColor *)textColor andFont:(UIFont *)font andTextAlignment:(NSTextAlignment)alignment {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = textColor;
    label.font = font;
    label.textAlignment = alignment;
    [self addSubview:label];
    return label;
}
- (UIImageView *)addIcon {
    UIImageView *icon = [[UIImageView alloc] init];
    [self addSubview:icon];
    return icon;
}

@end
