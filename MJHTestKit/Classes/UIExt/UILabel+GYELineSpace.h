//
//  UILabel+GYELineSpace.h
//  GyennoMedical
//
//  Created by gyenno on 2020/12/4.
//  Copyright © 2020 Gyenno. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (GYELineSpace)
- (void)changeLineSpaceWithSpace:(float)space;

- (CGSize)getStrHeightWithAttributeStr:(NSAttributedString *)string
                             viewWidth:(CGFloat)viewWidth;
@end

NS_ASSUME_NONNULL_END
