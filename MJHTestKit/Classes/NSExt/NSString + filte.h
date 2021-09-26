//
//  NSString + filte.h
//  GyennoMedical
//
//  Created by fengwu on 5/13/16.
//  Copyright © 2016 Gyenno. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (filte)

+ (NSString *)flattenHTML:(NSString *)htmlString;

-(NSAttributedString*)getAttributeStringWithView:(UIView *)view;

-(NSAttributedString*)getAttributeStringWithLabel:(UILabel *)label;

- (NSMutableAttributedString *)attrStrFromStringWithColor:(UIColor *)color;

-(NSAttributedString*)getAttributeStringWithLabel:(UILabel *)label lineSpace:(CGFloat)lineSpace;

///是否包含有效的字符串（如果只包含空格字符，返回NO）
- (BOOL)isEffectCharacters;

-(NSString *)cleanSpace;

-(BOOL)isEmptyString;

/// 获取手机号隐藏内容
+ (NSString *)getTextWithPhone:(NSString *)phone;

/// 获取身份证号隐藏内容
+ (NSString *)getTextWithCard:(NSString *)card;

/// 判断手机号是否正确
- (BOOL)confirePhone;

@end
