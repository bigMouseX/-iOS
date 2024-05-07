//
//  ScrollerTableViewCell.h
//  知乎日报
//
//  Created by 夏楠 on 2023/10/20.
//

#import <UIKit/UIKit.h>
#import "Manager.h"
#import "CurrentModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Masonry.h"
NS_ASSUME_NONNULL_BEGIN

@interface ScrollTableViewCell : UITableViewCell<UIScrollViewDelegate>
@property(nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;


@property (nonatomic, copy) NSDictionary* viewModelDictionary;

@end

NS_ASSUME_NONNULL_END
