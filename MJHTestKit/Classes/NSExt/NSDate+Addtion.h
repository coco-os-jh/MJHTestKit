//
//  NSDate+Addtion.h
//  GyennoDoctor
//
//  Created by lmzqm on 2018/9/6.
//  Copyright © 2018年 Gyenno. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Addtion)

@property (nonatomic ,assign) NSUInteger day;
@property (nonatomic ,assign) NSUInteger month;
@property (nonatomic ,assign) NSUInteger year;
@property (nonatomic, copy)NSString *weekDay;

+(NSDate *)endOfDate:(NSDate *)date;
+(NSDate *)beginOfDate:(NSDate *)date;

+(NSDate *)firstDayOfMonthByDate:(NSDate *)date;
+(NSDate *)lastDayOfMonthByDate:(NSDate *)date;

-(NSDate *)endOfDate;
-(NSDate *)beginOfDate;

-(NSDate *)beginOfSmesDate;
-(NSDate *)endOFSmesDate;

-(NSDate *)addDays:(NSInteger )day;

-(NSTimeInterval)beginTimeIntervalOfDate;
-(NSTimeInterval)endTimeIntervalOfDate;
+(NSTimeInterval)currentTimeInterval;

-(NSDate *)firstDayOfMonthByDate;
-(NSDate *)lastDayOfMonthByDate;

-(BOOL)biggerThanDate:(NSDate *)date;
-(BOOL)biggerThanToday;

-(NSInteger)dayOffsetWithDate:(NSDate*)date;

-(NSString *)mmssString;
-(NSString *)HHmmssString;


/**
    NSDate To String Method
 */

+(NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format;
-(NSString *)yyyyMMddHHmmString;
-(NSString *)yyyyMMddHHmmssString;
-(NSString *)yyyyMMddString;
-(NSString *)yyyyMMString;
-(NSString *)HHmmString;
-(NSString *)MMddString;

-(NSString *)getHHmmOffset;

/**
 获取单例的NSDateFormatter;

 @return NSDateFormatter单例对象
 */
+(NSDateFormatter *)dateFormat;


/**
 返回同一天里的某两个时刻之间的时间间隔, 例如:10月9日  09:35 到  10: 14, 这里返回的就是00:39(小时:分钟)的格式,秒之间的差距忽略不计
 
 @param lastTimeInterVal 后面时间的时间戳(距离1970)
 @param firstTimeInterVal 前面时间的时间戳(距离1970)
 @return 计算好的时间间隔字符串
 */
+ (NSString *)durationBetweenLastTimeInterval:(NSTimeInterval )lastTimeInterVal andFirstTimeInterVal:(NSTimeInterval)firstTimeInterVal;


+(NSString *)getMinOrSecStr:(NSNumber*)timeValue;

-(NSString *)yyyyMMddWithdotString;
-(NSString *)yyyyMMddhhmmWithdotString;
-(NSString *)yyyyMMddhhmmssWithdotString;

-(NSString *)yyyyMMddhhmmWithNullString;


-(NSTimeInterval)timeInverval;

+(NSDate *)getDateFromTodayWithMonthOffset:(NSInteger )offset;

-(NSString *)currentDateMonthOffsetWith:(NSDate*)date;

-(NSString *)currentDateYearOffsetWith:(NSDate*)date;

-(NSString *)stringWithFormat:(NSString *)format;

-(NSDate *)dayOffsetWithInteger:(NSInteger )offset;

+(NSString *)HHmmStringWithTimeInterval:(NSNumber *)timeValue;

+(NSString *)MMSSStringWithTimeInterval:(NSNumber *)timeValue;

+(NSString *)oneRoundWithNumString:(NSString *)numberString;

+(NSString *)twoRoundWithNumString:(NSString *)numberString;

+ (NSString* )roundNumberStringWithRound:(NSInteger)round numberString:(NSString *)numberString;

/// 时间字符串转时间戳(带GMT)
+ (NSInteger)getNowDateTimeIntervalFromatAnDate:(NSString *)dateString WithFormat:(NSString *)timeFormat;

/// 时间戳转字符串(带GMT)
+ (NSString *)getNowDateFromatAnDate:(NSTimeInterval)dateString WithFormat:(NSString *)timeFormat;
@end
