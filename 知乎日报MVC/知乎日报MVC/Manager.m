//
//  Manager.m
//  知乎日报
//
//  Created by 夏楠 on 2023/10/22.
//

#import "Manager.h"
#import "AFNetworking.h"
#import "CurrentModel.h"

static Manager *managerSington = nil;

@implementation Manager

+ (instancetype)shareManager {
    if (!managerSington) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            managerSington = [[Manager alloc] init];
        });
    }
    return managerSington;
}

- (void)NetWorkGetWithRecentData:(RecentlBlock)mainModelBolck andError:(ErrorBlock)errorBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *url = @"https://news-at.zhihu.com/api/4/news/latest";

    [manager GET:url parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        CurrentModel *testModel = [[CurrentModel alloc] initWithDictionary:responseObject error:nil];
        mainModelBolck(testModel);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)NetWorkGetWithPastData:(PastlBlock)mainModelBolck andError:(ErrorBlock)errorBlock andDate:(NSString *)date {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    NSString *url = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/news/before/%@", date];
    
    [manager GET:url parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        PastModel *testModel = [[PastModel alloc] initWithDictionary:responseObject error:nil];
        mainModelBolck(testModel);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)NetWorkGetWithExtraData:(ExtraBlock)mainModelBolck andError:(ErrorBlock)errorBlock andID:(NSString *)ID {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    NSString *url = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/story-extra/%@", ID];
    
    [manager GET:url parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ExtraModel *testModel = [[ExtraModel alloc] initWithDictionary:responseObject error:nil];
        mainModelBolck(testModel);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)NetWorkGetWithLongCommentsData:(LongCommentsBlock)mainModelBolck andError:(ErrorBlock)errorBlock andID:(NSString *)ID {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    NSString *url = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/story/%@/long-comments", ID];
    
    [manager GET:url parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        LongCommentsModel *testModel = [[LongCommentsModel alloc] initWithDictionary:responseObject error:nil];
        mainModelBolck(testModel);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)NetWorkGetWithShortCommentsData:(ShortCommentsBlock)mainModelBolck andError:(ErrorBlock)errorBlock andID:(NSString *)ID {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    NSString *url = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/story/%@/short-comments", ID];
    
    [manager GET:url parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        LongCommentsModel *testModel = [[LongCommentsModel alloc] initWithDictionary:responseObject error:nil];
        mainModelBolck(testModel);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
