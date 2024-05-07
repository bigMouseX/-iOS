//
//  PastModel.m
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/10/26.
//

#import "PastModel.h"

@implementation PastModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end

@implementation PastStoriesModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end
