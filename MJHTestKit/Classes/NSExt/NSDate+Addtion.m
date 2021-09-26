//
//  NSDate+Addtion.m
//  GyennoDoctor
//
//  Created by lmzqm on 2018/9/6.
//  Copyright © 2018年 Gyenno. All rights reserved.
//

#import "NSDate+Addtion.h"
#import "NSDate + Category.h"

@implementation NSDate (Addtion)

+(NSCalendar *)currentCalendar{
    static NSCalendar *calendar;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        calendar = [NSCalendar currentCalendar];
    });
    
    return calendar;
}



+(NSDateComponents *)componentsFormDate:(NSDate *)date{
    
    NSCalendarUnit cmpFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *cmps = [[self currentCalendar] components:cmpFlags fromDate:date];
    
    return cmps;
    
}

#pragma mark ================= property =================

-(void)setDay:(NSUInteger)day{
    
    
}

-(NSUInteger )day{
    NSDateComponents *dateCmp =  [NSDate componentsFormDate:self];
    return dateCmp.day;
}

-(NSUInteger)month{
    NSDateComponents *dateCmp =  [NSDate componentsFormDate:self];
    return dateCmp.month;
}

- (NSUInteger)year {
    NSDateComponents *dateCmp =  [NSDate componentsFormDate:self];
    return dateCmp.year;
}
- (NSString *)weekDay {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:self];
    
    return [weekdays objectAtIndex:theComponents.weekday];
}

-(NSDate *)beginOfDate{
    return [NSDate beginOfDate:self];
}

-(NSDate *)beginOfSmesDate{
    
    NSDate *date = [NSDate beginOfDate:self];
    
    NSDateComponents *components =  [NSDate componentsFormDate:date];
    NSInteger hours = components.hour +6;
    [components setHour:hours];
    
   return  [NSDate getDateFormComponents:components];

}

-(NSDate *)addDays:(NSInteger )day{
    NSDateComponents *component =  [NSDate componentsFormDate:self];
    [component setDay:component.day+day];
    
    NSDate *date =  [[NSDate currentCalendar]dateFromComponents:component];
    
    return date;
    
}

-(NSDate *)endOFSmesDate{
    
    NSDate *date = [NSDate endOfDate:self];
    NSDateComponents *components =  [NSDate componentsFormDate:date];
    NSInteger hours = components.hour +6;
    [components setHour:hours];
    
    return  [NSDate getDateFormComponents:components];
}

// 获取分钟的数据，如果不超过60秒 就直接用秒
+(NSString *)getMinOrSecStr:(NSNumber*)timeValue{
    NSInteger value = [timeValue  integerValue];
    
    if (value == 0) {
        return @"0.0分钟";
    }
   
    CGFloat floatValue = (CGFloat)value/60.0;
    
    NSString *secValue = [self oneRoundWithNumString:[[NSNumber numberWithFloat:floatValue] stringValue]];
    
    NSString *selStr =  value/60 == 0  ?  [NSString stringWithFormat:@"%ld秒",(long)value] : [NSString stringWithFormat:@"%@分钟",secValue];
    
    
    return selStr;
}

+(NSString *)oneRoundWithNumString:(NSString *)numberString{
    
    NSLog(@"四舍五入 之前的数据 %@",numberString);
    NSString *result = @"";
    if([numberString isEqualToString:@"0"]){
        result = @"0.0";
    }else if(![numberString containsString:@"."]){
        result = [numberString stringByAppendingString:@".0"];
    }else{
        result = [self roundNumberStringWithRound:1 numberString:numberString];
    }

    NSLog(@"四舍五入 处理后的数据 %@",result);
    
    return result;
}

+(NSString *)twoRoundWithNumString:(NSString *)numberString{
    
    NSLog(@"四舍五入 之前的数据 %@",numberString);
    BOOL has1dot = NO;
    NSArray *arrays = [numberString componentsSeparatedByString:@"."];
    if (arrays.count == 2) {
        NSString *str = arrays[1];
        if(str.length == 1){
            has1dot = YES;
        }
    }
    
    NSString *result = @"";
    if([numberString isEqualToString:@"0"] || [numberString isEqualToString:@"0.0"]){
        result = @"0.00";
    }else if(![numberString containsString:@"."]){
        result = [numberString stringByAppendingString:@".00"];
    }else if( has1dot){
        result = [numberString stringByAppendingString:@"0"];
    }else{
        result = [self roundNumberStringWithRound:2 numberString:numberString];
    }

    NSLog(@"四舍五入 处理后的数据 %@",result);
    
    return result;
}

/*
 @param round 小数位 eg: 2
 @param numberString 数字 eg 0.125
 @return 四舍五入之后的 eg: 0.13
 */

+ (NSString* )roundNumberStringWithRound:(NSInteger)round numberString:(NSString *)numberString{
    
    if (numberString == nil) {
        return 0;
    }
    NSDecimalNumberHandler *roundingBehavior    = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:round raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *aDN                        = [[NSDecimalNumber alloc] initWithString:numberString];
    NSDecimalNumber *resultDN                   = [aDN decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return resultDN.stringValue;
}


-(NSTimeInterval)beginTimeIntervalOfDate{
    
    return [[self beginOfDate] timeIntervalSince1970]*1000;
}

-(NSTimeInterval)timeInverval{
    
    return [self timeIntervalSince1970]*1000;
}

//获取某天 刚开始的时间
+(NSDate *)beginOfDate:(NSDate *)date{
    
    return [[self currentCalendar] startOfDayForDate:date];
 
}

+(NSDate *)getDateFormComponents:(NSDateComponents *)cmps{
   return  [[self currentCalendar] dateFromComponents:cmps];
}


/**
 
 获取当前Date的EndDate

 @return NSDate
 */
-(NSDate *)endOfDate{
    
    return [NSDate endOfDate:self];
}

+(NSDate*)currentOfDate{
    return [NSDate currentOfDate:[NSDate date]];
}

+(NSDate*)currentOfDate:(NSDate *)date{
    
    NSDateComponents *cmps =  [self componentsFormDate:date];
    return [self getDateFormComponents:cmps];
}

+(NSTimeInterval)currentTimeInterval{
    
    return [[self currentOfDate] timeIntervalSince1970]*1000;
}


-(NSDate *)dayOffsetWithInteger:(NSInteger )offset{
    
    NSDateComponents *compinents =  [NSDate componentsFormDate:self];
    
    compinents.day += offset;
    
    return  [NSDate getDateFormComponents:compinents];
}

// 获取某天 结束的时间
+(NSDate *)endOfDate:(NSDate *)date{
    
    NSDateComponents *cmps =  [self componentsFormDate:date];
    cmps.hour = 23;
    cmps.minute = 59;
    cmps.second = 59;
    
    return [self getDateFormComponents:cmps];
}

-(NSTimeInterval)endTimeIntervalOfDate{
    
    return [[self endOfDate] timeIntervalSince1970]*1000;
}

//获取某个Date 的第一个月的时间
-(NSDate *)firstDayOfMonthByDate{
   return [NSDate firstDayOfMonthByDate:self];
}

+(NSDate *)firstDayOfMonthByDate:(NSDate *)date{
    NSDateComponents *cmps =  [self componentsFormDate:date];
    cmps.day = 1;
    NSDate *firstDay = [self getDateFormComponents:cmps];
    return [self beginOfDate:firstDay];
}

+(NSUInteger)daysOfMonth:(NSDate *)date{
    
    NSRange range = [[self currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    
    NSUInteger numberOfDaysInMonth = range.length;
    
    NSLog(@"%lu", (unsigned long)numberOfDaysInMonth);
    
    return numberOfDaysInMonth;
}

-(NSDate *)lastDayOfMonthByDate{
    
   return  [NSDate lastDayOfMonthByDate:self];
}

+(NSDate *)lastDayOfMonthByDate:(NSDate *)date{
    
    NSDateComponents *cmps =  [self componentsFormDate:date];
    cmps.day = [self daysOfMonth:date];
    NSDate *firstDay = [self getDateFormComponents:cmps];
    return [self endOfDate:firstDay];
    
}
+(NSDateFormatter *)dateFormat{
    
    static NSDateFormatter *format;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        format = [[NSDateFormatter alloc] init];
    });
    
    return format;
}
+(NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)formatStr{
    
    // 这里是系统时区的操作
    return [self stringFromDate:date withFormat:formatStr timeZone:[NSTimeZone systemTimeZone]];
    
}

-(NSString *)yyyyMMString{
    return  [NSDate stringFromDate:self withFormat:@"yyyy-MM"];
}

-(NSString *)yyyyMMddString{
   return  [NSDate stringFromDate:self withFormat:@"yyyy-MM-dd"];
}

-(NSString *)mmssString{
     return  [NSDate stringFromDate:self withFormat:@"mm:ss"];
}

-(NSString *)HHmmssString{
    
    return  [NSDate stringFromDate:self withFormat:@"HH:mm:ss" timeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
}

//-(NSTimeInterval)TimeInterval{
//    
//    NSString *timeStr =  [NSDate stringFromDate:self withFormat:@"yyyy-MM-dd HH:mm:ss"];
//    
//}

-(NSString *)HHmmString{
    
    return  [NSDate stringFromDate:self withFormat:@"HH:mm"];
}
- (NSString *)MMddString {
    return  [NSDate stringFromDate:self withFormat:@"MM/dd"];
}

-(NSString *)getHHmmOffset{
    
    return [NSDate stringFromDate:self withFormat:@"HH:mm" timeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
}

+(NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)formatStr timeZone:(NSTimeZone*)zone{
    
    NSDateFormatter *format = [self dateFormat];
    format.timeZone = zone;
    format.dateFormat = formatStr;
    return [format stringFromDate:date];
}

-(BOOL)biggerThanToday{
    
   return [self timeIntervalSinceNow] >=0 ? YES : NO;
}
-(BOOL)biggerThanDate:(NSDate *)date{
    
    if( [self timeIntervalSinceDate:date] >= 0){
        return YES;
    }else{
        return NO;
    }
}

-(NSInteger)dayOffsetWithDate:(NSDate*)date{
    
    // 返回的是 相差多少天
    NSDate *firstDate = [self beginOfDate];
    NSDateComponents *comp =  [[NSDate currentCalendar] components:NSCalendarUnitDay fromDate:firstDate toDate:date options:0];
    
    return comp.day;
    
}

+ (NSString *)durationBetweenLastTimeInterval:(NSTimeInterval)lastTimeInterVal andFirstTimeInterVal:(NSTimeInterval)firstTimeInterVal {
    NSDate *onStartDate = [NSDate dateWithTimeIntervalSince1970:firstTimeInterVal];
    
    NSDate *offEndDate = [NSDate dateWithTimeIntervalSince1970:lastTimeInterVal];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute fromDate:onStartDate];
    NSDateComponents *components2 = [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute fromDate:offEndDate];
    
    NSInteger hour = components2.hour - components1.hour;
    NSInteger minute = components2.minute - components1.minute;
    
    NSInteger totalMinute = hour * 60 + minute;
    minute = totalMinute % 60;
    hour  = totalMinute / 60;
    return [NSString stringWithFormat:@"%ld小时%ld分钟",hour, minute];
}

+(NSString *)HHmmStringWithTimeInterval:(NSNumber *)timeValue{
    NSString *resultValue = @"";
    NSInteger totalSec = [timeValue integerValue];
    if (totalSec == 0) {
        return @"0分";
    }
    
    NSNumber *num = @((CGFloat)totalSec/60);
    
    NSString *totalMin = [NSDate roundNumberStringWithRound:0 numberString:[num stringValue]];
   
    NSInteger hour = [totalMin integerValue]/60;
    NSInteger minute = [totalMin integerValue]%60;
    if (hour > 0) {
        resultValue = [resultValue stringByAppendingFormat:@"%ld小时",(long)hour];
    }
    
    if (minute > 0) {
        resultValue = [resultValue stringByAppendingFormat:@"%ld分",(long)minute];
    }
    return resultValue;
}

+(NSString *)MMSSStringWithTimeInterval:(NSNumber *)timeValue{
    
       NSString *resultValue = @"";
       NSInteger totalSec = [timeValue integerValue];
       if (totalSec == 0) {
           return @"0秒";
       }
       NSInteger hour = totalSec/60;
       NSInteger minute = totalSec%60;
       if (hour > 0) {
           resultValue = [resultValue stringByAppendingFormat:@"%ld分",(long)hour];
       }
       
       if (minute > 0) {
           resultValue =[resultValue stringByAppendingFormat:@"%ld秒",(long)minute];
       }
    
       return resultValue;
}


-(NSString *)yyyyMMddWithdotString{
    //    return  [NSDate stringFromDate:self withFormat:@"yyyy-MM-dd"];
    return [self stringWithFormat:@"yyyy.MM.dd"];
}

-(NSString *)yyyyMMddhhmmWithdotString{
    //    return  [NSDate stringFromDate:self withFormat:@"yyyy-MM-dd"];
    return [self stringWithFormat:@"yyyy.MM.dd"];
}


-(NSString *)yyyyMMddhhmmWithNullString{
    //    return  [NSDate stringFromDate:self withFormat:@"yyyy-MM-dd"];
    return [self stringWithFormat:@"yyyyMMdd"];
}

-(NSString *)yyyyMMddhhmmssWithdotString{
    //    return  [NSDate stringFromDate:self withFormat:@"yyyy-MM-dd"];
    return [self stringWithFormat:@"yyyy.MM.dd HH:mm:ss"];
}

-(NSString *)stringWithFormat:(NSString *)format{
    return [NSDate stringFromDate:self withFormat:format];
}


+(NSDate *)getDateFromTodayWithMonthOffset:(NSInteger )offset{
    
    NSDate * mydate = [NSDate date];
    NSDateComponents *component = [[self currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:mydate];
    NSDateComponents *component1 = [[NSDateComponents alloc] init];
    //    [component setYear:0];
    NSInteger month = component.month;
    [component setMonth:month+offset];
    [component setDay:0];
    [component setMinute:0];
    [component setSecond:0];
    
    NSDate *date1 =  [[self currentCalendar] dateFromComponents: component];
    //    NSLog(@"the date 1 is %@",date1);
    
    
    //    [component1 setYear:0];
    //    [component1 setMonth:offset];
    //    [component1 setDay:0];
    //    [component1 setMinute:0];
    //    [component1 setSecond:0];
    //    NSDate *date =  [[self currentCalendar] dateByAddingComponents:component1 toDate:mydate options:0];
    //    NSLog(@"the date is %@",date);
    
    return [NSDate dateFromString: [date1 yyyyMMddTotalString] ];
}

-(NSString *)yyyyMMddTotalString{
    //    return  [NSDate stringFromDate:self withFormat:@"yyyy-MM-dd"];
    return [self stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

-(NSString *)currentDateMonthOffsetWith:(NSDate*)date{
    return [self dateOffsetBewtteen:date and:[NSDate date] withBlock:^NSString *(NSDateComponents *components1, NSDateComponents *components2) {
        
        NSInteger year = components2.year - components1.year;
        NSInteger month = components2.month - components1.month;
        NSString * monthStr = @"-";
        if(year <=0){
            year = 0;
            monthStr = @"";
        }else{
            
            if(month < 0){
                year -= 1;
                month += 12;
            }
            
            monthStr = [NSString stringWithFormat:@"%ld年",(long)year];
        }
        
        if (month != 0) {
            monthStr = [monthStr stringByAppendingFormat:@"%ld月",(long)month];
        }
        return monthStr;
    }];
}

-(NSString *)currentDateYearOffsetWith:(NSDate*)date{
    return [self dateOffsetBewtteen:date and:[NSDate date] withBlock:^NSString *(NSDateComponents *components1, NSDateComponents *components2) {
        
        NSInteger year = components2.year - components1.year;
        //        NSInteger month = components2.month - components1.month;
        //
        //        month = year*12+month;
        
        return [NSString stringWithFormat:@"%ld",(long)year];
    }];
}



-(NSString * )dateOffsetBewtteen:(NSDate *)startDate and:(NSDate *)endDate withBlock:(NSString *(^)( NSDateComponents *components1, NSDateComponents *components2)) doblock{
    // 确定两个时间之间的差距
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:NSCalendarUnitYear| NSCalendarUnitMonth| NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:startDate];
    NSDateComponents *components2 = [calendar components:NSCalendarUnitYear| NSCalendarUnitMonth| NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:endDate];
    
    return doblock(components1,components2);
}

#pragma mark - 时间字符串转时间戳(带GMT)
+ (NSInteger)getNowDateTimeIntervalFromatAnDate:(NSString *)dateString WithFormat:(NSString *)timeFormat
{
//    NSDate *anyDate = [NSDate dateWithTimeIntervalSince1970:dateString/1000];
    NSDate *anyDate = [NSDate date];
    if (dateString.length > 0) {
        anyDate = [NSDate dateFromString:dateString];
    }
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:timeFormat];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSInteger interval = destinationGMTOffset - sourceGMTOffset;
    NSInteger selectInterval = [anyDate timeIntervalSince1970];
    return selectInterval * 1000;
}

#pragma mark - 时间戳转字符串(带GMT)
+ (NSString *)getNowDateFromatAnDate:(NSTimeInterval)dateString WithFormat:(NSString *)timeFormat
{
    NSDate *anyDate = [NSDate dateWithTimeIntervalSince1970:dateString/1000];
    //设置源日期时区
//    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:timeFormat];//或GMT
//    //设置转换后的目标日期时区
//    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
//    //得到源日期与世界标准时间的偏移量
//    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
//    //目标日期与本地时区的偏移量
//    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
//    //得到时间偏移量的差值
//    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
//    //转为现在时间
//    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = timeFormat;
    NSString *dateStr = [fmt stringFromDate:anyDate];
    return dateStr;
}


@end
