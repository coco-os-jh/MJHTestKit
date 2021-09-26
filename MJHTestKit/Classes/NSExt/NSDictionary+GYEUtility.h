//
//  NSDictionary+GYEUtility.h
//  GyennoDoctor
//
//  Created by HeJida on 2018/9/10.
//  Copyright © 2018年 Gyenno. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (GYEUtility)

- (int64_t)longLongValueForKey:(id)key;
- (int32_t)intValueForKey:(id)key;
- (NSInteger)integerForKey:(NSString *)key;
- (int16_t)shortValueForKey:(id)key;
- (int8_t)charValueForKey:(id)key;
- (uint8_t)unsignedCharValueForKey:(id)key;
- (BOOL)boolValueForKey:(id)key;
- (double)doubleValueForKey:(id)key;
- (float)floatValueForKey:(id)key;
- (NSString *)stringForKey:(id)key;
- (NSArray *)arrayForKey:(id)key;

- (NSString *)jsonString;

+ (NSDictionary *)parametersFromQuery:(NSString *)query;

///通过json字符串获取字典
+ (NSDictionary *)dictWithJsonString:(NSString *)string;

@end


@interface NSMutableDictionary (Utility)

///安全的setObject (如果object为空则不设置)
- (void)xtxSetObject:(id)anObject forKey:(id<NSCopying>)aKey;

@end


