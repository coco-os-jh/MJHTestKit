//
//  NSString + filte.m
//  GyennoMedical
//
//  Created by fengwu on 5/13/16.
//  Copyright © 2016 Gyenno. All rights reserved.
//

#import "NSString + filte.h"
#import "GlobalHeader.h"

@implementation NSString (filte)
+ (NSString *)flattenHTML:(NSString *)htmlString{
    
    NSScanner *theScanner;
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:htmlString];
    
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        htmlString = [htmlString stringByReplacingOccurrencesOfString:
                [NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
    } // while //
    
    //NSLog(@"-----===%@",htmlString);
    return htmlString;
}

-(NSAttributedString*)getAttributeStringWithLabel:(UILabel *)label{
    return [self getAttributeStringWithLabel:label lineSpace:6];
}

-(NSAttributedString*)getAttributeString:(NSString *)str{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 6;
    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName:SystemTitleColor,
                                 NSFontAttributeName: TINEFONT(16.0f*WIDTHSCALE),
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    return [[NSAttributedString alloc] initWithString:str attributes:attributes];
}

-(NSAttributedString*)getAttributeStringWithLabel:(UILabel *)label lineSpace:(CGFloat)lineSpace{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName:label.textColor,
                                 NSFontAttributeName: label.font,
                                 
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 
                                 };
    return [[NSAttributedString alloc] initWithString:self attributes:attributes];
}

//拼接attributedText
- (NSMutableAttributedString *)attrStrFromStringWithColor:(UIColor *)color{
    
    NSMutableAttributedString *attributedText = [NSMutableAttributedString new];
    
    NSArray *items = [self componentsSeparatedByString:@"："];
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:[items[0] stringByAppendingString:@"："] attributes:@{NSForegroundColorAttributeName : SystemTitleColor}]];
    if (items.count > 1) {
       [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:items[1] attributes:@{NSForegroundColorAttributeName : color}]];
    }
    return attributedText;
}

//是否包含有效的字符串（如果只包含空格字符，返回NO）
- (BOOL)isEffectCharacters
{
    if (self.length) {
        if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] != 0) {
            return YES;
        }
    }
    return NO;
}

-(NSString *)cleanSpace{
    
    NSString *str  = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return str;
}

- (BOOL)isEmptyString {
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    BOOL result = NO;
    NSString *str = [self cleanSpace];
    if (!str || [str length] == 0) {
        result = YES;
    }
    return result;
}

#pragma mark - 获取手机号隐藏内容
+ (NSString *)getTextWithPhone:(NSString *)phone {
    NSString *str = @"";
    if (phone.length >= 4) {
        NSString *str1 = [phone substringToIndex:3];
        NSString *str2 = [phone substringFromIndex:phone.length - 4];
        str = [NSString stringWithFormat:@"%@****%@", str1, str2];
    }
    return str;
}

#pragma mark - 获取身份证号隐藏内容
+ (NSString *)getTextWithCard:(NSString *)card {
    NSString *str = @"";
    if (card.length >= 4) {
        NSString *str1 = [card substringToIndex:4];
        NSString *str2 = [card substringFromIndex:card.length - 4];
        str = [NSString stringWithFormat:@"%@**********%@", str1, str2];
    }
    return str;
}

#pragma mark - 判断手机号是否正确
- (BOOL)confirePhone {
    NSString *mobilePhone = self;
    // 编写正则表达式，验证mobilePhone是否为手机号码
    NSString *regex = @"^[1][0-9]{10}$";
    // 创建谓词对象并设定条件表达式
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    // 字符串判断，然后BOOL值
    BOOL result = [predicate evaluateWithObject:mobilePhone];
    return result;
}

@end



