//
//  NSDate + Category.h
//  GyennoMHI
//
//  Created by fengwu on 15/5/14.
//  Copyright (c) 2015年 gyenno. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Category)

//把一个string转化为nsdate
+ (NSDate *)dateFromString:(NSString *)dateString;

//把一个nsdate转化为string
+ (NSString *)stringFromDate:( NSDate*)date;

+ (NSString *)stringFromDate:( NSDate*)date format:(NSString *)formatString;

//把一个时间转化为本地时间
+ (NSDate*)coverIntoLocalTime:(NSDate *)destDate fromSourceTimeZone:(NSString*)sourceTimeZoneStr;

//判断一个NSDate是不是今天的
+ (BOOL)isDateToday:(NSDate *)compareDate;

//未来日期
+(BOOL)isBiggerToday:(NSDate*)compareDate;

//判断两个NSDate是不是同一天
+ (BOOL)isSameday:(NSDate *)firstDate And:(NSDate*)secondDate;

//判断一个NSDate是不是本周的
+ (BOOL)isDateThisWeek:(NSDate *)compareDate ;

//判断一个日期是否在一个时间段
+ (BOOL)date:(NSDate *)compareDate IsBetween:(NSDate*)firstDate And:(NSDate*)secondDate;

//利用YYYY_MM_DD格式的时间串与HH_MM_SS的字符串拼接后得到世界时间
+(NSDate *)getUTCDateWithYYYYMMDD:(NSString*)firstStr AndHHMMSS:(NSString*)secondStr;

//获取YYYY_MM_DD格式的时间串
+ (NSString *)getYYYYMMDDStrWith:(NSDate*)date;

//获取日期的EEEE信息
+ (NSUInteger)getWeekdayWithDate:(NSDate*)date;

//获取本周的第一天和最后一天
+ (NSDictionary*)getFisrtDayAndLastDay;

//获取本月的第一天和最后一天
+ (NSString *)getMonthBeginAndEnd:(NSString*)yyyyMM;

//获取上个月或者下个月的YYYY-MM的字符串
+ (NSString *)getDateString:(NSString*)yyyyMM isNext:(BOOL)isnext;

//判断参数传的是不是本年
+ (BOOL)isCurrentYear:(NSString*)YYYY;

+(NSString *)GetYYYYMMDddWith:(NSDate *)date;

+(NSString *)GetHHmmWith:(NSDate *)date;

+(NSString *)GetYYYYMMDDddWith:(NSDate *)date;

+(NSString *) getLocalDateString:(NSDate *)date;

+(NSString *)GetMMddWith:(NSDate *)date;

-(NSString *)referencedDateDescription;

+(NSTimeInterval)GetDateIntervalBy:(NSString*)strDate;

+ (NSDate *)dateFromStringWithYYYYMMDD:(NSString *)dateString;

+(NSString *)GetHHmmssWith:(NSDate *)date;

- (NSString *)HHmmString;

- (NSString *)yyyyMMddString;

- (NSString *)yyyyMMddHHmmString;

- (NSString *)yyyyMMddHHmmssString;

- (NSString *)dateStringWithFormat:(NSString *)formatString;


+ (NSDateFormatter *)ymdFormat;
+ (NSDateFormatter *)pointYMDFormat;
+ (NSDateFormatter *)mdFormat;
+ (NSDateFormatter *)hmFormat;
+ (NSDateFormatter *)ymdhmFormat;
+ (NSDateFormatter *)ymdhmsFormat;
+ (NSDateFormatter *)point_ymdhmFormat;
+ (NSDateFormatter *)yrFormat;

@end
