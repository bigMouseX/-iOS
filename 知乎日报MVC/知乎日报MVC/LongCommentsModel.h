//
//  LongCommentsModel.h
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/11/2.
//
//@protocol longCommentsModel
//@end
//
//@protocol replyModel1
//@end
//#import "JSONModel.h"
//
//NS_ASSUME_NONNULL_BEGIN
//
//@interface replyModel1: JSONModel
//@property (nonatomic, strong) NSString* author;
//@property (nonatomic, strong) NSString* content;
//@end
//
//@interface longCommentsModel : JSONModel
//@property (nonatomic, copy)NSString *author;
//@property (nonatomic, copy)NSString *avatar;
//@property (nonatomic, copy)NSString *content;
//@property (nonatomic, copy)NSString *time;
//@property (nonatomic, copy)NSString *likes;
//@property (nonatomic, strong) NSString* id;
//@property (nonatomic, strong)NSDictionary<replyModel1>* reply_to;
//
//@end
//
//
//@interface LongCommentsModel : JSONModel
//@property (nonatomic, copy)NSArray<longCommentsModel>* comments;
//
//@end

@protocol LongModel
@end

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShortReplyModel : JSONModel
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) long status;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *author;
@end

@interface LongModel : JSONModel
@property (nonatomic, strong) NSString* author;
@property (nonatomic, strong) NSString* content;
@property (nonatomic, strong) NSString* avatar;
@property (nonatomic, strong) NSString* time;
@property (nonatomic, strong) NSString* id;
@property (nonatomic, strong) NSString* likes;
@property (nonatomic, strong) ShortReplyModel *reply_to;

@end

@interface LongCommentsModel : JSONModel
@property (nonatomic, copy) NSArray<LongModel>* comments;
@end

NS_ASSUME_NONNULL_END
