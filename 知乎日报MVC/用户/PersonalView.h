//
//  PresonalView.h
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/11/10.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "PersonalTableViewCell.h"
#import "collectionViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface PersonalView : UIView<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIButton* backButton;
@property (nonatomic, strong)UIImage *head;
@property (nonatomic, strong)UIImageView *headView;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIButton *set;
@property (nonatomic, strong)UILabel *setLable;


@end

NS_ASSUME_NONNULL_END
