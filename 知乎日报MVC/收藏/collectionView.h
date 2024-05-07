//
//  collectionView.h
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/11/10.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "CollectionTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@protocol collectionCellDelegate <NSObject>

- (void)returnNowPage: (NSInteger) nowPage;

@end
#define SIZE_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SIZE_HEIGHT ([UIScreen mainScreen].bounds.size.height)
NS_ASSUME_NONNULL_BEGIN

@interface collectionView : UIView<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *IDArray;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *imageURLArray;
@property (nonatomic, strong) NSMutableArray *webURLArray;
@property (nonatomic, strong) UIButton* backButton;
@property (nonatomic, strong) UILabel* lineLabel;
@property (nonatomic, strong)UILabel *title;

@property (nonatomic, strong)id <collectionCellDelegate> delegateCell;
@end

NS_ASSUME_NONNULL_END
