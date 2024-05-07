//
//  ScrollerTableViewCell.m
//  知乎日报
//
//  Created by 夏楠 on 2023/10/20.
//

#import "ScrollTableViewCell.h"
#import <CoreImage/CoreImage.h>
#define SIZE_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SIZE_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@implementation ScrollTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.delegate = self;
    self.scrollView.bounces = YES;
    self.scrollView.alwaysBounceHorizontal = YES;
    self.scrollView.showsVerticalScrollIndicator = YES;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:self.scrollView];
    
    self.pageControl = [[UIPageControl alloc] init];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor]; // 未选中的颜色
    self.pageControl.numberOfPages = 5; // 设置总页数
    self.pageControl.currentPage = 0; // 设置初始当前页
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor]; // 设置分页指示器颜色
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self.contentView addSubview:self.pageControl];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(scrollToNextPage) userInfo:nil repeats:YES];
    
    return self;
}

- (void)layoutSubviews {
    
    self.scrollView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 360);
    self.scrollView.contentSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width) * 7, 360);
    [self.scrollView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width, 0) animated:NO];

    CGFloat pageControlY = CGRectGetMaxY(self.scrollView.frame) - 20;
    self.pageControl.frame = CGRectMake(130, pageControlY, CGRectGetWidth(self.contentView.frame), 0);
    
}

- (void)scrollToNextPage {
    CGPoint contentOffset = self.scrollView.contentOffset;
    CGFloat screenWidth = CGRectGetWidth(self.scrollView.frame);
    NSInteger currentPage = contentOffset.x / screenWidth;
    NSInteger nextPage = currentPage + 1;
    if (nextPage > self.pageControl.numberOfPages) {
        nextPage = 1;
    }
    contentOffset.x = nextPage * screenWidth;
    [self.scrollView setContentOffset:contentOffset animated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(scrollToNextPage) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //当前滚动到的x位置
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    CGFloat screenWidth = CGRectGetWidth(scrollView.frame);
    CGFloat contentWidth = scrollView.contentSize.width;
    
    // 滚动到最后一张视图之后，将滚动位置重置到第二张图片
    if (contentOffsetX >= contentWidth - screenWidth) {
        [scrollView setContentOffset:CGPointMake(screenWidth, 0) animated:NO];
    }

    else if (contentOffsetX <= 0 ) {
        [scrollView setContentOffset:CGPointMake(5 * screenWidth, 0) animated:NO];
        self.pageControl.currentPage = 5;
        return;
    }
    CGFloat pageWidth = self.scrollView.frame.size.width;
    NSInteger currentPage = floor((scrollView.contentOffset.x) / pageWidth) - 1;
    self.pageControl.currentPage = currentPage;

}

@end
