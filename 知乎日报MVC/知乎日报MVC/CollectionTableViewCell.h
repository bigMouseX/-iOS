//
//  CollectionTableViewCell.h
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/11/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionTableViewCell : UITableViewCell
@property (nonatomic, strong)UIImageView *articleImageView;
@property (nonatomic, strong)UILabel *articleBigLabel;
@end

NS_ASSUME_NONNULL_END
