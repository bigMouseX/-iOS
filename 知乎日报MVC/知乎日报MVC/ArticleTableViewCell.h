//
//  ArticleTableViewCell.h
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/10/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArticleTableViewCell : UITableViewCell
@property (nonatomic, strong)UIImageView *articleImageView;
@property (nonatomic, strong)UILabel *articleBigLabel;
@property (nonatomic, strong)UILabel *articleSmallLabel;
@end

NS_ASSUME_NONNULL_END
