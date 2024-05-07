//
//  replyTableViewCell.h
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/11/6.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
NS_ASSUME_NONNULL_BEGIN

@interface replyTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView* commentHeadPhotoImageView;
@property (nonatomic, strong) UILabel* nameLabel;
@property (nonatomic, strong) UILabel* contentLabel;
@property (nonatomic, strong) UILabel* replyNameLabel;
@property (nonatomic, strong) UILabel* replyLabel;
@property (nonatomic, strong) UILabel* timeLabel;
@property (nonatomic, strong) UILabel* lineLabel;
@property (nonatomic, strong) UIButton* dianzanButton;
@property (nonatomic, strong) UIButton* pinglunButton;
@property (nonatomic, strong) UIButton* foldButton;
@property (nonatomic, strong) UILabel* likes;
@property (nonatomic, assign) BOOL isFold;


@end

NS_ASSUME_NONNULL_END
