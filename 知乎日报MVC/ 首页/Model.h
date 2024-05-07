//
//  Model.h
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/10/23.
//

#import <Foundation/Foundation.h>
#import "CurrentModel.h"
#import "Manager.h"
NS_ASSUME_NONNULL_BEGIN

@interface Model : NSObject

@property NSDate *currentDate;
@property NSDateFormatter *dateFormatter;

- (NSString *)getMonth;
@property NSDictionary *monthMap;
@property NSString *currentMonth;
@property NSString *month;

- (NSString *)getDate;
@property NSString *date;

- (NSString *)getClockTip;
@property NSDictionary *hourMap;
@property NSString *hour;
@property NSString *tip;

- (NSString *)getYearMonthDate;
@property NSString *YearMonthDate;

- (NSString *)pastDate:(int)numbersOfLoad;
- (NSString *)pastDateForJson:(int)numbersOfLoad;

@end

NS_ASSUME_NONNULL_END
