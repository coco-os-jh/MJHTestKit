//
//  UILabel+GYELineSpace.m
//  GyennoMedical
//
//  Created by gyenno on 2020/12/4.
//  Copyright © 2020 Gyenno. All rights reserved.
//

#import "UILabel+GYELineSpace.h"

@implementation UILabel (GYELineSpace)

- (void)changeLineSpaceWithSpace:(float)space
{

    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
    [self sizeToFit];

}

- (CGSize)getStrHeightWithAttributeStr:(NSAttributedString *)string
                             viewWidth:(CGFloat)viewWidth
{
    if (string.length == 0) {
        return CGSizeZero;
    }
    CGSize size  = [string boundingRectWithSize:CGSizeMake(viewWidth, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  context:nil].size;
    return size;
}

@end
