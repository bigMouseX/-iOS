//
//  PastModel.h
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/10/26.
//
@protocol PastStoriesModel
@end

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PastStoriesModel : JSONModel
@property (nonatomic, copy) NSString* image_hue;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* url;
@property (nonatomic, copy) NSString* hint;
@property (nonatomic, copy) NSArray* images;
@property (nonatomic, copy) NSString* type;
@property (nonatomic, copy) NSString* id;
@end

@interface PastModel : JSONModel
@property (nonatomic, copy) NSString *date;//三个同类型的
@property (nonatomic, copy) NSArray<PastStoriesModel>* stories;

@end

NS_ASSUME_NONNULL_END
