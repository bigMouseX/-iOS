//
//  View.h
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/10/23.
//

#import <UIKit/UIKit.h>
#import "CurrentModel.h"
#import "Masonry.h"
#import <CoreImage/CoreImage.h>
#import "ArticleTableViewCell.h"
#import "TimeTableViewCell.h"
#import "MJRefresh.h"
NS_ASSUME_NONNULL_BEGIN


@protocol cellDelegate <NSObject>

- (void)returnImageTag: (NSInteger) nowTag;

@end
@interface View : UIView<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property UILabel *Date;
@property UILabel *Month;
@property (nonatomic, strong)UIImage *Line;
@property (nonatomic, strong)UIImageView *LineView;
@property (nonatomic, strong)UILabel *Tip;
@property (nonatomic, strong)UIButton *btn_head;

@property (nonatomic, strong)UIImageView *topImageView;
@property (nonatomic, strong)UIColor *mainColor;
@property (nonatomic, strong)UILabel *topBigLabel;
@property (nonatomic, strong)UILabel *topSmallLabel;

@property (nonatomic, copy) NSDictionary* viewModelDictionary;


@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIActivityIndicatorView* activityIndicator;//小菊花

@property (nonatomic, strong) NSMutableArray* pastArray;
@property (nonatomic, strong) NSMutableArray* allArray;
@property (nonatomic, strong) NSMutableArray* pastTimeArray;

@property (nonatomic, weak) id<cellDelegate> delegateCell;


- (void)addTableView;
- (void)hideLoadMoreView;
- (void)showLoadMoreView;

@end

NS_ASSUME_NONNULL_END
