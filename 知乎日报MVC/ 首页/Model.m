//
//  Model.m
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/10/23.
//

#import "Model.h"

@implementation Model

- (NSString *)getMonth {
    // 创建一个表示当前日期和时间的NSDate对象
    self.currentDate = [NSDate date];

    // 创建一个NSDateFormatter对象来格式化日期
    self.dateFormatter = [[NSDateFormatter alloc] init];

    // 设置日期的格式
    [self.dateFormatter setDateFormat:@"MM"]; // 获取月份
    // 创建一个字典来映射数字月份到中文月份名称
    self.monthMap = @{
        @"01": @"一月",
        @"02": @"二月",
        @"03": @"三月",
        @"04": @"四月",
        @"05": @"五月",
        @"06": @"六月",
        @"07": @"七月",
        @"08": @"八月",
        @"09": @"九月",
        @"10": @"十月",
        @"11": @"十一月",
        @"12": @"十二月"
    };

    // 获取当前的月份
    self.currentMonth = [self.dateFormatter stringFromDate:self.currentDate];

    // 使用字典映射获取中文月份名称
    self.month = self.monthMap[self.currentMonth];
    
    
    return self.month;
}

- (NSString *)getClockTip {
    
    // 创建一个表示当前日期和时间的NSDate对象
    self.currentDate = [NSDate date];
    // 创建一个NSDateFormatter对象来格式化日期
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"HH"]; // 获取日期
    self.hourMap = @{
        @"01": @"早点休息",
        @"02": @"早点休息",
        @"03": @"早点休息",
        @"04": @"早点休息",
        @"05": @"早上好",
        @"06": @"早上好",
        @"07": @"早上好",
        @"08": @"早上好",
        @"09": @"早上好",
        @"10": @"早上好",
        @"11": @"早上好",
        @"12": @"中午好",
        @"13": @"中午好",
        @"14": @"下午好",
        @"15": @"下午好",
        @"16": @"下午好",
        @"17": @"下午好",
        @"18": @"下午好",
        @"19": @"晚上好",
        @"20": @"晚上好",
        @"21": @"晚上好",
        @"22": @"晚上好",
        @"23": @"早点休息",
        @"00": @"早点休息"
    };
    self.hour = [self.dateFormatter stringFromDate:self.currentDate];
    self.tip = self.hourMap[self.hour];

    return self.tip;
}

- (NSString *)getDate {
    // 创建一个表示当前日期和时间的NSDate对象
    self.currentDate = [NSDate date];
    
    // 创建一个NSDateFormatter对象来格式化日期
    self.dateFormatter = [[NSDateFormatter alloc] init];

    [self.dateFormatter setDateFormat:@"dd"]; 
    self.date = [self.dateFormatter stringFromDate:self.currentDate];
    return self.date;
}

- (NSString *)getYearMonthDate {
    self.currentDate = [NSDate date];
    
    // 创建一个NSDateFormatter对象来格式化日期
    self.dateFormatter = [[NSDateFormatter alloc] init];

    [self.dateFormatter setDateFormat:@"YYYYMMdd"];
    self.YearMonthDate = [self.dateFormatter stringFromDate:self.currentDate];
    return self.YearMonthDate;
}

- (NSString *)pastDate:(int)numbersOfLoad {
    // 获取当前日期
    NSDate *currentDate = [NSDate date];

    // 创建一个日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];

    // 创建一个NSDateComponents对象并设置days属性为负数
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = -numbersOfLoad; // 使用传入的numbersOfLoad来计算前N天的日期

    // 使用calendar对象来计算前N天的日期
    NSDate *previousDate = [calendar dateByAddingComponents:dateComponents toDate:currentDate options:0];

    // 创建一个日期格式化器以便格式化日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM月dd日"; // 日期格式可以根据你的需求进行调整

    // 格式化前N天的日期
    NSString *formattedDate = [dateFormatter stringFromDate:previousDate];

    return formattedDate;
}

- (NSString *)pastDateForJson:(int)numbersOfLoad {
    NSDate *today = [NSDate date]; // 获取今天的日期
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];

    // 计算前一天的日期
    dateComponents.day = -numbersOfLoad + 1; // 加 1，因为 loadNumber 从 1 开始
    NSDate *targetDate = [calendar dateByAddingComponents:dateComponents toDate:today options:0];

    // 创建日期格式化器
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMdd"; // 日期格式

    // 格式化日期为字符串
    NSString *formattedDate = [dateFormatter stringFromDate:targetDate];

    return formattedDate;
}
@end
