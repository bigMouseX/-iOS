//
//  commentModel.m
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/11/5.
//

#import "commentModel.h"

@implementation commentModel
- (NSString *)incrementStringNumber:(NSString *)inputString {
    // 使用 NSNumberFormatter 将字符串转换为整数
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *number = [formatter numberFromString:inputString];

        // 如果成功将字符串转换为整数，加1
        NSInteger incrementedValue = [number integerValue] + 1;
        
        // 将增加后的整数转换为字符串
        NSString *resultString = [NSString stringWithFormat:@"%ld", (long)incrementedValue];
        return resultString;
}

- (NSString *)reduceStringNumber:(NSString *)inputString {
    // 使用 NSNumberFormatter 将字符串转换为整数
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *number = [formatter numberFromString:inputString];

        // 如果成功将字符串转换为整数，加1
        NSInteger incrementedValue = [number integerValue] - 1;
        
        // 将增加后的整数转换为字符串
        NSString *resultString = [NSString stringWithFormat:@"%ld", (long)incrementedValue];
        return resultString;
}

@end
