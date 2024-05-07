//
//  commentView.h
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/11/5.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "commentTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "replyTableViewCell.h"
#import "commentModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface commentView : UIView<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIButton* backButton;
@property (nonatomic, strong) UILabel* lineLabel;
@property (nonatomic, strong)UILabel *countsOfCommentLabel;
@property (nonatomic, strong) NSDictionary *longCommentDictionary;
@property (nonatomic, strong) NSDictionary *shortCommentDictionary;
@property (nonatomic, strong) UITableView* commentTableView;
@property (nonatomic, strong) UILabel* cellLongNumberLabel;
@property (nonatomic, strong) UILabel* cellShortNumberLabel;
@property (nonatomic, strong) commentModel* commentM;
- (void)addView;
- (NSString *)formattedDateStringFromTimestampString:(NSString *)timestampString;
-(CGSize)textHeightFromTextString:(NSString *)text width:(CGFloat)textWidth fontSize:(CGFloat)size;
- (void)pressZhanKaiShort:(UIButton *)buttom;
- (void)pressZhanKaiLong:(UIButton *)buttom;
- (void)pressGood:(UIButton *)buttom;
- (void)pressGoodL:(UIButton *)buttom;


@end

NS_ASSUME_NONNULL_END
