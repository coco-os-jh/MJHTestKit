//
//  NSString+Emoji.h
//  GyennoDoctor
//
//  Created by 尘浮 on 16/10/26.
//  Copyright © 2016年 Gyenno. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Emoji)
+ (NSString *)filterEmoji:(NSString *)string ;
+ (BOOL)isContainsEmoji:(NSString *)string;
+ (BOOL) isEmpty:(NSString *)string;
+ (BOOL) isEmoji:(NSString *)string;
+(BOOL)idCardNumber:(NSString *)string;
+(BOOL)idCardAuthor:(NSString *)string;
+ (BOOL)ChinCharact:(NSString *)ChinCharact;
/// 验证手机号格式
+ (BOOL)confirePhone:(NSString *)mobilePhone;

/// 检查身份证是否正确
+ (BOOL)checkUserIDCard:(NSString *)value;
@end
