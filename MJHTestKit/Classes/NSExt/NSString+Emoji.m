//
//  NSString+Emoji.m
//  GyennoDoctor
//
//  Created by 尘浮 on 16/10/26.
//  Copyright © 2016年 Gyenno. All rights reserved.
//

#import "NSString+Emoji.h"

@implementation NSString (Emoji)

+(BOOL)isContainsEmoji:(NSString *)string{
    
    __block BOOL isEomji = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         
         const unichar hs = [substring characterAtIndex:0];
         
         // surrogate pair
         
         if (0xd800 <= hs && hs <= 0xdbff) {
             
             if (substring.length > 1) {
                 
                 const unichar ls = [substring characterAtIndex:1];
                 
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     
                     isEomji = YES;
                     
                 }
                 
             }
             
         } else if (substring.length > 1) {
             
             const unichar ls = [substring characterAtIndex:1];
             
             if (ls == 0x20e3) {
                 
                 isEomji = YES;
                 
             }
             
             
             
         } else {
             
             // non surrogate
             
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 
                 isEomji = YES;
                 
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 
                 isEomji = YES;
                 
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 
                 isEomji = YES;
                 
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 
                 isEomji = YES;
                 
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                 
                 isEomji = YES;
                 
             }
             
         }
         
     }];
    
    
    
    return isEomji;
    
}


+ (NSString *)filterEmoji:(NSString *)string {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:string
                                                               options:0
                                                                 range:NSMakeRange(0, [string length])
                                                          withTemplate:@""];
    return modifiedString;
}

+(BOOL)isEmoji:(NSString *)string{
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:string
                                                               options:0
                                                                 range:NSMakeRange(0, [string length])
                                                          withTemplate:@"lmzqm"];
    if([modifiedString isEqualToString:@"lmzqm"]){
        // 这里再判断键盘键
        if([self isNineKeyBoard:string]){
            return NO;
        }
        return YES;
    }
    return NO;
}

+(BOOL)idCardNumber:(NSString *)string{
    
    NSString *regex = @"[0-9]|x|X";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([string isEqualToString:@""]) {
        return YES;
    }
    return [pred evaluateWithObject:string] || [NSString idCardAuthor:string];
}

#pragma mark - 身份证格式验证
+(BOOL)idCardAuthor:(NSString *)string{
    
//    NSString *regex = @"(^[0-9]{15}$)|(^[0-9]{17}([0-9]|X|x)$)";
    NSString *regex = @"^(\d{6})(\d{4})(\d{2})(\d{2})(\d{3})([0-9]|X)$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([string isEqualToString:@""]) {
        return YES;
    }
    return [pred evaluateWithObject:string];
}

#pragma mark - 检查身份证是否正确
+ (BOOL)checkUserIDCard:(NSString *)value {
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger length = 0;
    if (!value) {
        return NO;
    } else {
        length = value.length;
        //不满足15位和18位，即身份证错误
        if (length != 18) {
            return NO;
        }
//        if (length != 15 && length != 18) {
//            return NO;
//        }
    }
    // 省份代码
    NSArray *areasArray = @[@"11", @"12", @"13", @"14", @"15", @"21", @"22", @"23", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"41", @"42", @"43", @"44", @"45", @"46", @"50", @"51", @"52", @"53", @"54", @"61", @"62", @"63", @"64", @"65", @"71", @"81", @"82", @"91"];
    // 检测省份身份行政区代码
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag = NO; //标识省份代码是否正确
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag = YES;
            break;
        }
    }

    if (!areaFlag) {
        return NO;
    }
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;

    int year = 0;
    //分为15位、18位身份证进行校验
    switch (length) {
//        case 15:
//            //获取年份对应的数字
//            year = [value substringWithRange:NSMakeRange(6, 2)].intValue + 1900;
//            if (year %4 == 0 || (year %100 == 0 && year %4 == 0)) {
//                //创建正则表达式 NSRegularExpressionCaseInsensitive：不区分字母大小写的模式
//                //测试出生日期的合法性
//                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$" options:NSRegularExpressionCaseInsensitive error:nil];
//            } else {
//                //测试出生日期的合法性
//                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"options:NSRegularExpressionCaseInsensitive error:nil];
//            }
//            //使用正则表达式匹配字符串 NSMatchingReportProgress:找到最长的匹配字符串后调用block回调
//            numberofMatch = [regularExpression numberOfMatchesInString:value options:NSMatchingReportProgress range:NSMakeRange(0, value.length)];
//            if (numberofMatch > 0) {
//                return YES;
//            } else {
//                return NO;
//            }
        case 18:
            year = [value substringWithRange:NSMakeRange(6, 4)].intValue;
            if (year %4 == 0 || (year %100 == 0 && year %4 == 0)) {
                //测试出生日期的合法性
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^((1[1-5])|(2[1-3])|(3[1-7])|(4[1-6])|(5[0-4])|(6[1-5])|71|(8[12])|91)\\d{4}(((19|20)\\d{2}(0[13-9]|1[012])(0[1-9]|[12]\\d|30))|((19|20)\\d{2}(0[13578]|1[02])31)|((19|20)\\d{2}02(0[1-9]|1\\d|2[0-8]))|((19|20)([13579][26]|[2468][048]|0[048])0229))\\d{3}(\\d|X|x)?$" options:NSRegularExpressionCaseInsensitive error:nil];
            } else {
                //测试出生日期的合法性
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^((1[1-5])|(2[1-3])|(3[1-7])|(4[1-6])|(5[0-4])|(6[1-5])|71|(8[12])|91)\\d{4}(((19|20)\\d{2}(0[13-9]|1[012])(0[1-9]|[12]\\d|30))|((19|20)\\d{2}(0[13578]|1[02])31)|((19|20)\\d{2}02(0[1-9]|1\\d|2[0-8]))|((19|20)([13579][26]|[2468][048]|0[048])0229))\\d{3}(\\d|X|x)?$" options:NSRegularExpressionCaseInsensitive error:nil];
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value options:NSMatchingReportProgress range:NSMakeRange(0, value.length)];
            
            if (numberofMatch > 0) {
                //1：校验码的计算方法 身份证号码17位数分别乘以不同的系数。从第一位到第十七位的系数分别为：7－9－10－5－8－4－2－1－6－3－7－9－10－5－8－4－2。将这17位数字和系数相乘的结果相加。
                int S = [value substringWithRange:NSMakeRange(0, 1)].intValue * 7 + [value substringWithRange:NSMakeRange(10, 1)].intValue * 7 + [value substringWithRange:NSMakeRange(1, 1)].intValue * 9 + [value substringWithRange:NSMakeRange(11, 1)].intValue * 9 + [value substringWithRange:NSMakeRange(2, 1)].intValue * 10 + [value substringWithRange:NSMakeRange(12, 1)].intValue * 10 + [value substringWithRange:NSMakeRange(3, 1)].intValue * 5 + [value substringWithRange:NSMakeRange(13, 1)].intValue * 5 + [value substringWithRange:NSMakeRange(4, 1)].intValue * 8 + [value substringWithRange:NSMakeRange(14, 1)].intValue * 8 + [value substringWithRange:NSMakeRange(5, 1)].intValue * 4 + [value substringWithRange:NSMakeRange(15,1)].intValue * 4 + [value substringWithRange:NSMakeRange(6, 1)].intValue * 2 + [value substringWithRange:NSMakeRange(16, 1)].intValue * 2 + [value substringWithRange:NSMakeRange(7, 1)].intValue * 1 + [value substringWithRange:NSMakeRange(8, 1)].intValue * 6 + [value substringWithRange:NSMakeRange(9, 1)].intValue * 3;
                //2：用加出来和除以11，看余数是多少？余数只可能有0－1－2－3－4－5－6－7－8－9－10这11个数字
                int Y = S %11;
                NSString *M = @"F";
                NSString *JYM = @"10X98765432";
                //3：获取校验位
                M = [JYM substringWithRange:NSMakeRange(Y, 1)];
                NSString *lastStr = [value substringWithRange:NSMakeRange(17, 1)];
                //4：检测ID的校验位
                if ([lastStr isEqualToString:@"x"]) {
                    if ([M isEqualToString:@"X"]) {
                        return YES;
                    } else {
                        return NO;
                    }
                } else {
                    if ([M isEqualToString:[value substringWithRange:NSMakeRange(17, 1)]]) {
                        return YES;
                    } else {
                        return NO;
                    }
                }
            } else {
                return NO;
            }
        default:
            return NO;
    }
}

// 是否是中文
+ (BOOL)ChinCharact:(NSString *)ChinCharact {
    if (ChinCharact.length <= 0) {
        return NO;
    }
    //正则规则
    NSString *strIDRegex = @"^[\u4e00-\u9fa5]{0,}$";
    NSPredicate *identityCardPredicate =
    [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strIDRegex];
    return [identityCardPredicate evaluateWithObject:ChinCharact];
}

+(BOOL)isNineKeyBoard:(NSString *)string
{
    NSString *other = @"➋➌➍➎➏➐➑➒";
    int len = (int)string.length;
    for(int i=0;i<len;i++){
        if(!([other rangeOfString:string].location != NSNotFound))
            return NO;
    }
    return YES;
}

+ (BOOL) isEmpty:(NSString *)string {
        if ((NSNull *)string == [NSNull null]) {
            return YES;
        }
        
        if (string == nil) {
            return YES;
        } else if ([string length] == 0) {
            return YES;
        } else {
            string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if ([string length] == 0) {
                return YES;
            }
        }
        
        return NO;
}

#pragma mark - 验证手机号格式
+ (BOOL)confirePhone:(NSString *)mobilePhone {
    // 编写正则表达式，验证mobilePhone是否为手机号码
    NSString *regex = @"^((13[0-9])|(14[0-9])|(15([0-3]|[5-9]))|(18[0-9])|16[6]|(17)[0-9]|(19)[0-9])\\d{8}$";
    // 创建谓词对象并设定条件表达式
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    // 字符串判断，然后BOOL值
    BOOL result = [predicate evaluateWithObject:mobilePhone];
    return result;
}

@end
