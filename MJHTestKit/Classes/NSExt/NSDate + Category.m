//
//  NSDate + Category.m
//  GyennoMHI
//
//  Created by fengwu on 15/5/14.
//  Copyright (c) 2015年 gyenno. All rights reserved.
//

#import "NSDate + Category.h"

@implementation NSDate (Category)

static NSDateFormatter *ymdFormat = NULL;
static NSDateFormatter *pointYMDFormat = NULL;
static NSDateFormatter *mdFormat = NULL;
static NSDateFormatter *hmFormat = NULL;
static NSDateFormatter *ymdhmFormat = NULL;
static NSDateFormatter *ymdhmsFormat = NULL;
static NSDateFormatter *yrFormat = NULL;
static NSDateFormatter *point_ymdhmFormat = NULL;

+ (NSDateFormatter *)ymdFormat
{
    if (ymdFormat == NULL) {
        ymdFormat = [[NSDateFormatter alloc] init];
        [ymdFormat setDateFormat:@"yyyy-MM-dd"];
    }
    return ymdFormat;
}

+ (NSDateFormatter *)pointYMDFormat
{
    if (pointYMDFormat == NULL) {
        pointYMDFormat = [[NSDateFormatter alloc] init];
        [pointYMDFormat setDateFormat:@"yyyy.MM.dd"];
    }
    return pointYMDFormat;
}
+ (NSDateFormatter *)mdFormat
{
    if (mdFormat == NULL) {
        mdFormat = [[NSDateFormatter alloc] init];
        [mdFormat setDateFormat:@"MM-dd"];
    }
    return mdFormat;
}
+ (NSDateFormatter *)hmFormat
{
    if (hmFormat == NULL) {
        hmFormat = [[NSDateFormatter alloc] init];
        [hmFormat setDateFormat:@"HH:mm"];
    }
    return hmFormat;
}
+ (NSDateFormatter *)ymdhmFormat
{
    if (ymdhmFormat == NULL) {
        ymdhmFormat = [[NSDateFormatter alloc] init];
        [ymdhmFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    }
    return ymdhmFormat;
}
+ (NSDateFormatter *)ymdhmsFormat
{
    if (ymdhmsFormat == NULL) {
        ymdhmsFormat = [[NSDateFormatter alloc] init];
        [ymdhmsFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    return ymdhmsFormat;
}
+ (NSDateFormatter *)point_ymdhmFormat
{
    if (point_ymdhmFormat == NULL) {
        point_ymdhmFormat = [[NSDateFormatter alloc] init];
        [point_ymdhmFormat setDateFormat:@"yyyy.MM.dd HH:mm"];
    }
    return point_ymdhmFormat;
}
+ (NSDateFormatter *)yrFormat
{
    if (yrFormat == NULL) {
        yrFormat = [[NSDateFormatter alloc] init];
        [yrFormat setDateFormat:@"MM月dd日"];
    }
    return yrFormat;
}

+ (NSDate *)dateFromString:(NSString *)dateString{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *destDate= [[self ymdhmsFormat] dateFromString:dateString];
    return destDate;
}

+ (NSString *)stringFromDate:(NSDate *)date{
    NSString *dateString = [[self ymdhmsFormat] stringFromDate:date];
    return dateString;
    
//    NSString *stringFormat = @"yyyy-MM-dd HH:mm:ss";
//    return [[self class] stringFromDate:date format:[self ymdhmsFormat]];
}

+ (NSString *)stringFromDate:( NSDate*)date format:(NSString *)formatString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatString];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    NSString *dateString= [dateFormatter stringFromDate:date];
    return dateString;
}

+ (NSDate*)coverIntoLocalTime:(NSDate *)destDate fromSourceTimeZone:(NSString*)sourceTimeZoneStr
{
    NSTimeZone* sourceTimeZone ,*destinationTimeZone;
    if ([sourceTimeZoneStr isEqualToString:@"UTC"]) {
        //设置源日期时区
        sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
        //设置转换后的目标日期时区
        destinationTimeZone = [NSTimeZone localTimeZone];
    }
    else
    {
        //设置源日期时区
        sourceTimeZone = [NSTimeZone localTimeZone];//或GMT
        //设置转换后的目标日期时区
        destinationTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    }
   
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:destDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:destDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:destDate];
    return destinationDateNow;
}

+ (BOOL)isDateToday:(NSDate *)compareDate{
    
    NSDate *today = [[NSDate alloc] init];
    return [NSDate isSameday:today And:compareDate];
}

+(BOOL)isBiggerToday:(NSDate*)compareDate{
    return [NSDate isBiggerday:[NSDate date] And:compareDate];
    
}

+ (BOOL)isBiggerday:(NSDate *)firstDate And:(NSDate*)secondDate;
{
    NSTimeInterval value =  [firstDate timeIntervalSinceDate:secondDate];
    if (value < 0) {
        return YES;
    }
    return NO;
}

+ (BOOL)isSameday:(NSDate *)firstDate And:(NSDate*)secondDate;
{
    NSString * firstDateString = [NSDate getYYYYMMDDStrWith:firstDate];
    NSString * secondDateString = [NSDate getYYYYMMDDStrWith:secondDate];
    if ([firstDateString isEqualToString:secondDateString])
        return YES;
    
    return NO;
}

+ (NSString *)getYYYYMMDDStrWith:(NSDate*)date
{
    NSDate *localDate = [NSDate coverIntoLocalTime:date fromSourceTimeZone:@"UTC"];
    
    // 取前十位YYYY_MM_DD格式字符串作为返回值
    NSString * localDateString = [[localDate description] substringToIndex:10];
    return localDateString;
}

+(NSDate *)getUTCDateWithYYYYMMDD:(NSString*)firstStr AndHHMMSS:(NSString*)secondStr
{
    NSString *dateStr = [NSString stringWithFormat:@"%@ %@:00",firstStr,secondStr];
    NSDate *date = [NSDate dateFromString:dateStr];

    return date;
}

+ (BOOL)date:(NSDate *)compareDate IsBetween:(NSDate*)firstDate And:(NSDate*)secondDate{
    
    NSDate *firstDateLocalDate, *compareLocalDate,*secondDateLocalDate;
    
    firstDateLocalDate = [NSDate coverIntoLocalTime:firstDate fromSourceTimeZone:@"UTC"];
    secondDateLocalDate = [NSDate coverIntoLocalTime:secondDate fromSourceTimeZone:@"UTC"];
    compareLocalDate = [NSDate coverIntoLocalTime:compareDate fromSourceTimeZone:@"UTC"];
    
//    获取目标时间与两个时间段的秒的差值
    NSTimeInterval firstInterval= [compareLocalDate timeIntervalSinceDate:firstDateLocalDate];
    NSTimeInterval secondInterval= [secondDateLocalDate timeIntervalSinceDate:compareLocalDate];
    
    if (firstInterval>0&&secondInterval>0)
        return YES;
    
    return NO;
    
}

+ (BOOL)isDateThisWeek:(NSDate *)compareDate {
    
    NSDate *start;
    NSTimeInterval extends;
    
    NSCalendar *cal=[NSCalendar autoupdatingCurrentCalendar];
    NSDate *today=[NSDate date];
    
    BOOL success= [cal rangeOfUnit:NSCalendarUnitWeekOfYear startDate:&start interval: &extends forDate:today];
    
    if(!success)
        return NO;
    
    NSTimeInterval dateInSecs = [compareDate timeIntervalSinceReferenceDate];
    NSTimeInterval dayStartInSecs= [start timeIntervalSinceReferenceDate];
    
    if(dateInSecs > dayStartInSecs && dateInSecs < (dayStartInSecs+extends)){
        return YES;
    }
    else {
        return NO;
    }
}

+ (NSUInteger)getWeekdayWithDate:(NSDate*)date
{
    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekOfYear fromDate:date];
    NSUInteger weekday = [componets weekday];
    return weekday;
}

+ (NSDictionary*)getFisrtDayAndLastDay
{
    unsigned units=NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitYear|NSCalendarUnitWeekday;
    NSCalendar *mycal=[[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *now=[NSDate date];
//    NSDateComponents *comp =[mycal components:units fromDate:now];
    
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *dateComps = [gregorian components:NSCalendarUnitWeekday fromDate:now];
    NSInteger daycount = [dateComps weekday] - 1;
    NSDate *weekdaybegin=[now dateByAddingTimeInterval:-daycount*60*60*24];
    NSDate *weekdayend  =[now  dateByAddingTimeInterval:(6-daycount)*60*60*24];
    NSDateFormatter *df1=[[NSDateFormatter alloc]init];
    NSLocale *mylocal=[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    [df1 setLocale:mylocal];

    [df1 setDateFormat:@"yyyy-MM-d"];
    now=weekdaybegin;
    NSDateComponents *comp=[mycal components:units fromDate:now];
    NSInteger month=[comp month];
    NSInteger year =[comp year];
    NSInteger day=[comp day];
    NSString *date1=[[NSString alloc]initWithFormat:@"%ld-%02ld-%02ld",(long)year,(long)month,(long)day];//所要求的周日的日期
    now=weekdayend;
    comp=[mycal components:units fromDate:now];
    month=[comp month];
    year =[comp year];
    day=[comp day];
    NSString *date2=[[NSString alloc]initWithFormat:@"%ld-%02ld-%02ld",(long)year,(long)month,(long)day];//所要求的周一的日期
  
    return @{
             @"FirstDay":date1,
             @"LastDay":date2
             };
}

+ (NSString *)getMonthBeginAndEnd:(NSString*)yyyyMM{
    NSString *dateString ;
    
    if (nil == yyyyMM) {
        dateString = [[self class] stringFromDate:[NSDate date] format:@"yyyy-MM"];
    }else{
        dateString = [yyyyMM mutableCopy];
    }
    
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM"];
    NSDate *newDate=[format dateFromString:dateString];
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:newDate];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return @"";
    }
    NSDateFormatter *yyyymmDateFormatter = [[NSDateFormatter alloc] init];
    [yyyymmDateFormatter setDateFormat:@"yyyy-MM"];
    
    NSDateFormatter *ddDateFormatter = [[NSDateFormatter alloc] init];
    [ddDateFormatter setDateFormat:@"dd"];

    
    NSString *yyyymmString = [yyyymmDateFormatter stringFromDate:beginDate];

    NSString *beginDDString = [ddDateFormatter stringFromDate:beginDate];
    NSString *endDDString = [ddDateFormatter stringFromDate:endDate];
    NSString *resultString = [NSString stringWithFormat:@"%@-%@/%@-%@",yyyymmString,beginDDString,yyyymmString,endDDString];
    return resultString;
}

+ (NSString *)getDateString:(NSString*)yyyyMM isNext:(BOOL)isnext{
    if (nil == yyyyMM) {
        return nil;
    }
    
    BOOL isCurrentMonth = [[[self class] stringFromDate:[NSDate date]] containsString:yyyyMM];

    if (isnext&&isCurrentMonth) {
        return nil;
    }
    
    NSArray *dateStringArray = [yyyyMM componentsSeparatedByString:@"-"];
    
    NSString *month = dateStringArray[1];
    NSString *year = dateStringArray[0];

    if (isnext) {
        NSInteger monthIntValue = [month integerValue];
        if (monthIntValue < 12) {
            month = [NSString stringWithFormat:@"%ld",(long)++monthIntValue];
            if (month.length == 1) {
                month = [NSString stringWithFormat:@"0%@",month];
            }
        }else{
            NSInteger yearIntValue = [year integerValue];

            year = [NSString stringWithFormat:@"%ld",(long)++yearIntValue];
            month = @"01";
        }
    }else{
        NSInteger monthIntValue = [month integerValue];
        if (monthIntValue > 1) {
            month = [NSString stringWithFormat:@"%ld",(long)--monthIntValue];
            if (month.length == 1) {
                month = [NSString stringWithFormat:@"0%@",month];
            }
        }else{
            NSInteger yearIntValue = [year integerValue];
            
            year = [NSString stringWithFormat:@"%ld",(long)--yearIntValue];
            month = @"12";
        }
    }
    
    NSString *returnString = [NSString stringWithFormat:@"%@-%@",year,month];
    return returnString;
}

+ (BOOL)isCurrentYear:(NSString*)YYYY{
    
    NSString *dateString = [[self class] stringFromDate:[NSDate date] format:@"yyyy"];
    if ([dateString isEqualToString:YYYY]) {
        return YES;
    }
    return NO;
}

+(NSString *)GetHHmmWith:(NSDate *)date {
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"HH:mm";
    NSString *selectTime = [selectDateFormatter stringFromDate:date];
    return selectTime;
}

+(NSString *)GetHHmmssWith:(NSDate *)date {
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"HH:mm:ss";
    NSString *selectTime = [selectDateFormatter stringFromDate:date];
    return selectTime;
}

+(NSString *)GetYYYYMMDddWith:(NSDate *)date {
//    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
//    selectDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *selectTime = [[self ymdhmsFormat] stringFromDate:date];
    return selectTime;
}

+(NSString *)GetYYYYMMDDddWith:(NSDate *)date {
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    [selectDateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSString *selectTime = [selectDateFormatter stringFromDate:date];
    return selectTime;
}

+(NSString *) getLocalDateString:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

+(NSString *)GetMMddWith:(NSDate *)date {
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"MM-dd";
    NSString *selectTime = [selectDateFormatter stringFromDate:date];
    return selectTime;
}

-(BOOL)biggerThanDate:(NSDate *)date{
    
    if( [self timeIntervalSinceDate:date] >= 0){
        return YES;
    }else{
        return NO;
    }
}

- (NSString *)HHmmString {
    return [NSDate stringFromDate:self withFormat:@"HH:mm"];
}

- (NSString *)yyyyMMddString {
    return [NSDate stringFromDate:self withFormat:@"yyyy-MM-dd"];
}

- (NSString *)yyyyMMddHHmmString {
    return [NSDate stringFromDate:self withFormat:@"yyyy-MM-dd HH:mm"];
}

- (NSString *)yyyyMMddHHmmssString {
    return  [NSDate stringFromDate:self withFormat:@"yyyy-MM-dd HH:mm:ss"];
}


+ (NSDate *)dateFromStringWithYYYYMMDD:(NSString *)dateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}

+(NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)formatStr{
    
    // 这里是系统时区的操作
    NSDateFormatter *format = [self dateFormat];
    format.timeZone = [NSTimeZone systemTimeZone];
    format.dateFormat = formatStr;
    return [format stringFromDate:date];
    
}

+(NSDateFormatter *)dateFormat{
    
    static NSDateFormatter *format;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        format = [[NSDateFormatter alloc] init];
    });
    
    return format;
}

//获取参考时间显示
-(NSString *)referencedDateDescription
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [NSDate date];
    NSDateComponents *componentsSelf = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay
                                                   fromDate:self];
    
    NSDateComponents *componentsNow = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay
                                                  fromDate:date];
    
    if([componentsNow year] - [componentsSelf year]>0)
        return [self dateStringWithFormat:@"yyyy-MM-dd HH:mm"];
    else if([componentsNow month] - [componentsSelf month] > 0)
        return [self dateStringWithFormat:@"MM-dd H:mm"];
    else if([componentsNow day] - [componentsSelf day] > 2)
        return [self dateStringWithFormat:@"MM-dd H:mm"];
    else if([componentsNow day] - [componentsSelf day] == 2)//前天
    {
        return [NSString stringWithFormat:NSLocalizedString(@"前天 %@", nil),[self dateStringWithFormat:@"H:mm"]];
    }
    else if([componentsNow day] - [componentsSelf day] == 1)//昨天
    {
        return [NSString stringWithFormat:NSLocalizedString(@"昨天 %@", nil),[self dateStringWithFormat:@"H:mm"]];
    }
    else //今天
        return [NSString stringWithFormat:NSLocalizedString(@"今天 %@", nil),[self dateStringWithFormat:@"H:mm"]];
    
    
    return nil;
}

-(NSString *)dateStringWithFormat:(NSString *)formatString
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:formatString];
    return [formatter stringFromDate:self];
}


+(NSTimeInterval)GetDateIntervalBy:(NSString*)strDate{
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date =  [selectDateFormatter dateFromString:strDate];
    return  date.timeIntervalSince1970*1000;
    
}
@end
