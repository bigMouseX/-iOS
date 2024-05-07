//
//  webView.h
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/10/29.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface webView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray* allArray;
@property (nonatomic, strong) NSMutableArray* topArray;
@property (nonatomic, assign)NSInteger nowPage;
@property (nonatomic, strong) UIScrollView* scrollView;

@property (nonatomic, strong)WKWebView *webView;

@property (nonatomic, strong)UIImage *Line;
@property (nonatomic, strong)UIImageView *LineView;
@property (nonatomic, strong) UIButton* buttonReturn;
@property (nonatomic, strong) UIButton* buttonComment;
@property (nonatomic, strong) UILabel* countsOfComment;
@property (nonatomic, strong) UIButton* buttonGood;
@property (nonatomic, strong) UILabel* countsOfGood;
@property (nonatomic, strong) UIButton* buttonCollection;
@property (nonatomic, strong) UIButton* buttonShare;
- (void)addView;
- (void)layoutNewScrollView;
- (void)layoutNewWebView;
- (void)updateExtra:(NSNotification *)notification;

//collectionWebView
@property (nonatomic, strong) NSMutableArray *IDArray;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *imageURLArray;
@property (nonatomic, strong) NSMutableArray *webURLArray;
@property (nonatomic, assign) BOOL isCollectionWebView;



@end

NS_ASSUME_NONNULL_END
