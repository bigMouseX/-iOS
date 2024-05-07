//
//  ShortCommentsModel.h
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/11/2.
//

@protocol shortCommentsModel
@end
@protocol replyModel2
@end
#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface replyModel2: JSONModel
@property (nonatomic, strong) NSString* author;
@property (nonatomic, strong) NSString* content;
@end

@interface shortCommentsModel : JSONModel
@property (nonatomic, copy)NSString *author;
@property (nonatomic, copy)NSString *avatar;
@property (nonatomic, copy)NSString *content;
@property (nonatomic, copy)NSString *time;
@property (nonatomic, copy)NSString *likes;
@property (nonatomic, strong)NSDictionary<replyModel2>* reply_to;

@end

@interface ShortCommentsModel : JSONModel
@property (nonatomic, copy)NSArray<shortCommentsModel> *comments;
@end

NS_ASSUME_NONNULL_END
