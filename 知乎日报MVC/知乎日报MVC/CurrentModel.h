//
//  ModelFirst.h
//  知乎日报
//
//  Created by 夏楠 on 2023/10/22.
//

//声明网络请求中要接受数据的两个协议
@protocol StoriesModel
@end

@protocol Top_StoriesModel
@end

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface StoriesModel : JSONModel
@property (nonatomic, copy) NSString* image_hue;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* url;
@property (nonatomic, copy) NSString* hint;
@property (nonatomic, copy) NSArray* images;
@property (nonatomic, copy) NSString* type;
@property (nonatomic, copy) NSString* id;

@end

@interface Top_StoriesModel : JSONModel
@property (nonatomic, copy) NSString* image_hue;
@property (nonatomic, copy) NSString* hint;
@property (nonatomic, copy) NSString* url;
@property (nonatomic, copy) NSString* image;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* ga_prefix;
@property (nonatomic, copy) NSString* type;
@property (nonatomic, copy) NSString* id;

@end

@interface CurrentModel : JSONModel
@property (nonatomic, copy) NSString *date;//三个同类型的
@property (nonatomic, copy) NSArray<StoriesModel>* stories;
@property (nonatomic, copy) NSArray<Top_StoriesModel>* top_stories;
@end

NS_ASSUME_NONNULL_END
