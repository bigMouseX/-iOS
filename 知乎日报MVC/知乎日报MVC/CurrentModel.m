//
//  ModelFirst.m
//  知乎日报
//
//  Created by 夏楠 on 2023/10/22.
//

#import "CurrentModel.h"

@implementation CurrentModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end

@implementation StoriesModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end

@implementation Top_StoriesModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end
