//
//  NSDictionary+GYEUtility.m
//  GyennoDoctor
//
//  Created by HeJida on 2018/9/10.
//  Copyright © 2018年 Gyenno. All rights reserved.
//

#import "NSDictionary+GYEUtility.h"

@implementation NSDictionary (GYEUtility)

-(int64_t)longLongValueForKey:(id)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]])
    {
        return [obj longLongValue];
    }
    return 0;
}
-(int32_t)intValueForKey:(id)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]])
    {
        return [obj intValue];
    }
    return 0;
}

- (NSInteger)integerForKey:(NSString *)key
{
    return [self longLongValueForKey:key];
}

-(int16_t)shortValueForKey:(id)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSNumber class]])
    {
        return [obj shortValue];
    }else if ([obj isKindOfClass:[NSString class]]){
        return (int16_t)[(NSString *)obj intValue];
    }
    return 0;
}
-(int8_t)charValueForKey:(id)key
{
    id obj = [self objectForKey:key];
    if ( [obj isKindOfClass:[NSNumber class]])
    {
        return [obj charValue];
    }else if ([obj isKindOfClass:[NSString class]]){
        return (int8_t)[(NSString *)obj intValue];
    }
    return 0;
}

- (uint8_t)unsignedCharValueForKey:(id)key
{
    id obj = [self objectForKey:key];
    if ( [obj isKindOfClass:[NSNumber class]])
    {
        return [obj unsignedCharValue];
    }else if ([obj isKindOfClass:[NSString class]]){
        return (uint8_t)[(NSString *)obj intValue];
    }
    return 0;
    
}
-(BOOL)boolValueForKey:(id)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]])
    {
        return [obj boolValue];
    }
    return 0;
}

-(double)doubleValueForKey:(id)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]])
    {
        return [obj doubleValue];
    }
    return 0;
}

-(float)floatValueForKey:(id)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]])
    {
        return [obj floatValue];
    }
    return 0;
}

-(NSString *)stringForKey:(id)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSNull class]]) {
        return nil;
    }
    if ([obj isKindOfClass:[NSString class]]) {
        return obj;
    }
    if ([obj isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@",obj];
    }
    return nil;
}

-(NSArray *)arrayForKey:(id)key;
{
    id obj = [self objectForKey:key];
    
    if ([obj isKindOfClass:[NSArray class]]) {
        if ([(NSArray *) obj containsObject:[NSNull null]]) {
            return nil;
        }
        return obj;
    }
    
    return nil;
}


-(NSString *)jsonString
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:nil];
    if (! jsonData)
        return nil;
    else
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}


+(NSDictionary *)parametersFromQuery:(NSString *)query{
    
    NSArray * parameterStringArray = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary * paramDict = [[NSMutableDictionary alloc] initWithCapacity:parameterStringArray.count];
    for (NSString * paramString in parameterStringArray) {
        
        NSScanner *scanner = [NSScanner scannerWithString:paramString];
        
        NSString *key, *value;
        [scanner scanUpToString:@"=" intoString:&key];
        [scanner scanString:@"=" intoString:nil];
        [scanner scanUpToString:@"" intoString:&value];
        if(key && value)
            [paramDict setObject:value forKey:key];
    }
    return paramDict;
}

//通过json字符串获取字典
+(NSDictionary *)dictWithJsonString:(NSString *)string
{
    if (string == nil || ![string isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    
    if(err) {
        NSLog(@"json解析失败：%@",err);
        
        return nil;
    }
    
    return dic;
}

@end


#pragma mark -
@implementation NSMutableDictionary (Utility)

- (void)xtxSetObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (!anObject || !aKey) {
        return;
    }
    
    [self setObject:anObject forKey:aKey];
}

@end

