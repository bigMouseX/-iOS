//
//  Manager.h
//  知乎日报
//
//  Created by 夏楠 on 2023/10/22.
//

#import <Foundation/Foundation.h>
#import "CurrentModel.h"
#import "PastModel.h"
#import "LongCommentsModel.h"
#import "ShortCommentsModel.h"
#import "ExtraModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void (^PastlBlock) (PastModel *model);
typedef void (^RecentlBlock) (CurrentModel *model);
typedef void (^ExtraBlock) (ExtraModel *model);
typedef void (^LongCommentsBlock) (LongCommentsModel *model);
typedef void (^ShortCommentsBlock) (LongCommentsModel *model);

typedef void (^ErrorBlock)(NSError * _Nullable error);//返回NSError类型的数据，ErrorBlock是该Block的名字，失败会返回该Block
@interface Manager : NSObject

@property (nonatomic, copy)Top_StoriesModel *t;

//方便其他参数获取该单例
+ (instancetype)shareManager;
- (void)NetWorkGetWithRecentData:(RecentlBlock)mainModelBolck andError:(ErrorBlock)errorBlock;
- (void)NetWorkGetWithPastData:(PastlBlock)mainModelBolck andError:(ErrorBlock)errorBlock andDate:(NSString *)date;
- (void)NetWorkGetWithExtraData:(ExtraBlock)mainModelBolck andError:(ErrorBlock)errorBlock andID:(NSString *)ID;
- (void)NetWorkGetWithLongCommentsData:(LongCommentsBlock)mainModelBolck andError:(ErrorBlock)errorBlock andID:(NSString *)ID;
- (void)NetWorkGetWithShortCommentsData:(ShortCommentsBlock)mainModelBolck andError:(ErrorBlock)errorBlock andID:(NSString *)ID;

@end

NS_ASSUME_NONNULL_END
