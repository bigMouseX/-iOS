//
//  ExtraModel.h
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/11/2.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ExtraModel : JSONModel
@property (nonatomic, copy) NSString *long_comments;
@property (nonatomic, copy) NSString * popularity;
@property (nonatomic, copy) NSString * short_comments;
@property (nonatomic, copy) NSString * comments;


@end

NS_ASSUME_NONNULL_END
