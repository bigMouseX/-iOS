//
//  webView.m
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/10/29.
//

#import "webView.h"
extern BOOL isLoadingWebView;
#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
#define wechatBackgroundColor [UIColor colorWithRed:(CGFloat)0xF7/255.0 green:(CGFloat)0xF7/255.0 blue:(CGFloat)0xF7/255.0 alpha:1.0]
@implementation webView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.bounces = YES;
    self.scrollView.alwaysBounceHorizontal = NO;
    self.scrollView.alwaysBounceVertical = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
//    self.scrollView.delegate = self;
    [self addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(0);
            make.left.equalTo(self).offset(0);
            make.width.equalTo(@(Width));
            make.height.equalTo(@(Height * 0.92));
    }];
    
    self.buttonReturn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.buttonReturn setImage:[UIImage imageNamed:@"fanhui_zhihu.png"] forState:UIControlStateNormal];
    [self addSubview:self.buttonReturn];
    [self.buttonReturn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0.94 * Height);
            make.left.mas_equalTo(25);
            make.width.mas_equalTo(0.025 * Height);
            make.height.mas_equalTo(0.025 * Height);
    }];
    
    self.Line = [[UIImage alloc] init];
    self.LineView = [[UIImageView alloc] init];
    self.Line = [UIImage imageNamed:@"home_line2.png"];
    self.LineView.image = self.Line;
    [self addSubview:self.LineView];
    [self.LineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0.935 * Height);
            make.left.mas_equalTo(70);
            make.width.mas_equalTo(0.5);
            make.height.mas_equalTo(0.037 * Height);
    }];
    
    self.buttonComment = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.buttonComment setImage:[UIImage imageNamed:@"pinglun_zhihu.png"] forState:UIControlStateNormal];
    [self addSubview:self.buttonComment];
    [self.buttonComment mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0.94 * Height);
            make.left.mas_equalTo(110);
            make.width.mas_equalTo(0.025 * Height);
            make.height.mas_equalTo(0.025 * Height);
    }];
    
    self.countsOfComment = [[UILabel alloc] init];
    self.countsOfComment.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.countsOfComment];
    self.countsOfComment.font = [UIFont systemFontOfSize:11];
    [self.countsOfComment mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0.94 * Height);
            make.left.mas_equalTo(110 + 0.029 * Height);
            make.width.mas_equalTo(0.02 * Height);
            make.height.mas_equalTo(0.015 * Height);
    }];
//    self.countsOfComment.text = @"10";
    
    self.buttonGood = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.buttonGood setImage:[UIImage imageNamed:@"dianzan_zhihu1.png"] forState:UIControlStateNormal];
    [self.buttonGood setImage:[UIImage imageNamed:@"dianzan_zhihu2.png"] forState:UIControlStateSelected];

    [self addSubview:self.buttonGood];
    [self.buttonGood mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0.94 * Height);
            make.left.mas_equalTo(190);
            make.width.mas_equalTo(0.025 * Height);
            make.height.mas_equalTo(0.025 * Height);
    }];
    
    self.countsOfGood = [[UILabel alloc] init];
    self.countsOfGood.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.countsOfGood];
    self.countsOfGood.font = [UIFont systemFontOfSize:11];
    [self.countsOfGood mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0.94 * Height);
            make.left.mas_equalTo(190 + 0.027 * Height);
            make.width.mas_equalTo(0.03 * Height);
            make.height.mas_equalTo(0.015 * Height);
    }];
//    self.countsOfGood.text = @"10";
    
    self.buttonCollection = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.buttonCollection setImage:[UIImage imageNamed:@"collected1.png"] forState:UIControlStateNormal];
    [self.buttonCollection setImage:[UIImage imageNamed:@"collected2.png"] forState:UIControlStateSelected];
    [self addSubview:self.buttonCollection];
    [self.buttonCollection mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0.938 * Height);
            make.left.mas_equalTo(270);
            make.width.mas_equalTo(0.03 * Height);
            make.height.mas_equalTo(0.03 * Height);
    }];
    
    self.buttonShare = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.buttonShare setImage:[UIImage imageNamed:@"fenxiang_zhihu.png"] forState:UIControlStateNormal];
    [self addSubview:self.buttonShare];
    [self.buttonShare mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0.937 * Height);
            make.left.mas_equalTo(350);
            make.width.mas_equalTo(0.03 * Height);
            make.height.mas_equalTo(0.032 * Height);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(layoutNewScrollView) name:@"layoutNewScrollView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(layoutNewWebView) name:@"newPage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateExtra:) name:@"updateExtra" object:nil];

    return self;
}

- (void)updateExtra:(NSNotification *)notification {
    NSDictionary *send = notification.userInfo;
    self.countsOfGood.text = send[@"popularity"];
    self.countsOfComment.text = send[@"comments"];
}

- (void)layoutNewScrollView {
    self.scrollView.contentSize = CGSizeMake(Width * [self.allArray count] * 5 + Width, 0);
    CGPoint newContentOffset = CGPointMake(Width * (self.allArray.count - 1) * 5, -59); // 设置x为200，y为0

//    [self.scrollView setContentOffset:newContentOffset animated:YES];

}

- (void)layoutNewWebView {
    _webView = [[WKWebView alloc] init];
    NSURL* urlWeb = [NSURL URLWithString:_allArray[(_nowPage - 5) / 5][@"stories"][_nowPage % 5][@"url"]];
    NSURLRequest* webRequest = [[NSURLRequest alloc] initWithURL:urlWeb];
    [_webView loadRequest:webRequest];
    _webView.frame = CGRectMake(Width * (_nowPage - 5), 0, Width, Height * 0.875);
    [self.scrollView addSubview:_webView];
    isLoadingWebView = NO;
}

- (void)addView {
//    NSLog(@"%@111",_allArray);
    if (_isCollectionWebView == YES) {
        _scrollView.tag = 55;
        _scrollView.contentOffset = CGPointMake(Width * _nowPage, 0);
        self.scrollView.contentSize = CGSizeMake(Width * [_webURLArray count], 0);
        NSLog(@"%@111", _webURLArray);
        for (int i = 0; i < [_webURLArray count]; i++) {
            _webView = [[WKWebView alloc] init];
            NSURL* urlWeb = [NSURL URLWithString:_webURLArray[i]];
            NSURLRequest* webRequest = [[NSURLRequest alloc] initWithURL:urlWeb];
            [_webView loadRequest:webRequest];
            _webView.frame = CGRectMake(Width * i, 0, Width, Height * 0.92);
            [self.scrollView addSubview:_webView];
        }
    } else {
        if (_nowPage < 5) {
            _scrollView.tag = 66;
            _scrollView.contentOffset = CGPointMake(Width * _nowPage, 0);
            self.scrollView.contentSize = CGSizeMake(Width * 5, 0);
            for (int i = 0; i < 5; i++) {
                _webView = [[WKWebView alloc] init];
                NSURL* urlWeb = [NSURL URLWithString:_allArray[0][@"top_stories"][i][@"url"]];
                NSURLRequest* webRequest = [[NSURLRequest alloc] initWithURL:urlWeb];
                [_webView loadRequest:webRequest];
                _webView.frame = CGRectMake(Width * i, 0, Width, Height * 0.92);
                [self.scrollView addSubview:_webView];
            }
        } else {
            _scrollView.tag = 77;
            self.scrollView.contentSize = CGSizeMake(Width * [self.allArray count] * 5 + Width, 0);
            _scrollView.contentOffset = CGPointMake(Width * (_nowPage - 5), 0);
            _webView = [[WKWebView alloc] init];
            NSURL* urlWeb = [NSURL URLWithString:_allArray[(_nowPage - 5) / 5][@"stories"][_nowPage % 5][@"url"]];
            NSURLRequest* webRequest = [[NSURLRequest alloc] initWithURL:urlWeb];
            [_webView loadRequest:webRequest];
            _webView.frame = CGRectMake(Width * (_nowPage - 5), 0, Width, Height * 0.875);
            [self.scrollView addSubview:_webView];
        }
    }

}

@end
