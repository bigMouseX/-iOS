//
//  webViewController.m
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/10/29.
//

#import "webViewController.h"
extern long pastData;
extern int numbersOfLoad;
BOOL isLoadingWebView = NO;
#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
#define wechatBackgroundColor [UIColor colorWithRed:(CGFloat)0xF7/255.0 green:(CGFloat)0xF7/255.0 blue:(CGFloat)0xF7/255.0 alpha:1.0]
@interface webViewController ()

@end

@implementation webViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = wechatBackgroundColor;
    self.isLoadingMoreData = NO;
    self.isLoadingWebView = NO;
    self.isLoadingExtraData = NO;
    self.homeModel = [[Model alloc] init];
    self.alreadyPressGoodArray = [[NSMutableArray alloc] init];
    self.nowPageSet = [[NSMutableSet alloc] init];
    _pageNumber = [NSNumber numberWithInteger:self.nowPage];
    [self.nowPageSet addObject:_pageNumber];
    self.extraArray = [[NSMutableArray alloc] init];

    _webModel = [[webModel alloc] init];
    
    _webView = [[webView alloc] initWithFrame:self.view.bounds];
    _webView.topArray = _topArray;
    _webView.allArray = _allArray;
    _webView.nowPage = _nowPage;
    
    _webView.IDArray = _IDArray;
    _webView.imageURLArray = _imageURLArray;
    _webView.titleArray = _titleArray;
    _webView.webURLArray = _webURLArray;
    _webView.isCollectionWebView = _isCollectionWebView;
    
    [self getBeginExtraModel];
    
    [_webView addView];
    _webView.scrollView.delegate = self;
    
    [_webView.buttonReturn addTarget:self action:@selector(pressButtonReturn) forControlEvents:UIControlEventTouchUpInside];
    [_webView.buttonComment addTarget:self action:@selector((pressComment)) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_webView];
    
    [_webView.buttonGood addTarget:self action:@selector(pressGood:) forControlEvents:UIControlEventTouchUpInside];
    
    [_webView.buttonCollection addTarget:self action:@selector(pressCollection:) forControlEvents:UIControlEventTouchUpInside];
    //FMDB
    
    [self createDataBase];
    [self createDataBaseOfGood];
    [self judgeCollectionInOrOut];
    [self judgeGoodInOrOut];
    
}

- (void)pressGood:(UIButton *)btn {
    // 切换按钮的选中状态
    if (btn.selected == NO) {
        if ([_dataBaseOfGood open]) {
            //        NSString *select = self.extraModelDictionary[@"popularity"];
            NSString *select = [_webModel incrementStringNumber:self.extraModelDictionary[@"popularity"]];
            _nowGood = select;
            _webView.countsOfGood.text = select;
            btn.selected = YES;
            [self insertGoodToDataBase];
        }
    } else {
        if (btn.selected == YES) {
            //        NSString *select = [_webModel incrementStringNumber:self.extraModelDictionary[@"popularity"]];
            NSString *select = self.extraModelDictionary[@"popularity"];
            _webView.countsOfGood.text = select;
            btn.selected = NO;
            [self deleteDataBaseOfGood];

        }
    }
}

- (void)pressCollection:(UIButton *)btn {
    if (_webView.buttonCollection.selected == NO) {
        //打开数据库
        if ([_dataBase open]) {
            [self insertDataBase];
            _webView.buttonCollection.selected = YES;
        }
    } else {
        if ([_dataBase open]) {
            [self deleteDataBase];
            _webView.buttonCollection.selected = NO;
        }
    }
}

- (void)judgeCollectionInOrOut {
    [_dataBase open];
    NSString *selectSql = @"select * from t_DailyNews";
    FMResultSet *rs = [_dataBase executeQuery:selectSql];
    //FMResultSet专门用来进行查询操作
    while ([rs next]) {
        NSString *webPageID = [rs stringForColumn:@"webPageID"];
        NSString *webPageTitle = [rs stringForColumn:@"webPageTitle"];
        NSString *webURL = [rs stringForColumn:@"webURL"];
        if ([webPageID isEqualToString:_webPageID] && [webPageTitle isEqualToString:_webPageTitle] && [webURL isEqualToString:_webURL]) {
            _webView.buttonCollection.selected = YES;
            [_dataBase close];
            return;
        }
    }
    _webView.buttonCollection.selected = NO;
    NSLog(@"111");
    [_dataBase close];
    return;
}

- (void)judgeGoodInOrOut {
    [_dataBaseOfGood open];
    NSString *selectSql = @"select * from t_DailyNewsOfGood";
    FMResultSet *rs = [_dataBaseOfGood executeQuery:selectSql];
    //FMResultSet专门用来进行查询操作
    while ([rs next]) {
        NSString *webPageID = [rs stringForColumn:@"webPageID"];
        NSString *webURL = [rs stringForColumn:@"webURL"];
        NSString *countsOfGood = [rs stringForColumn:@"countsOfGood"];
        if ([webPageID isEqualToString:_webPageID] && [webURL isEqualToString:_webURL]) {
            _webView.buttonGood.selected = YES;
            NSLog(@"%@..", countsOfGood);
            _webView.countsOfGood.text = countsOfGood;
            _nowGood = countsOfGood;
            [_dataBaseOfGood close];
            return;
        }
    }
    _webView.buttonGood.selected = NO;
    [_dataBaseOfGood close];
    return;
}


- (void)pressButtonReturn {
    if (_isCollectionWebView == NO) {
        NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
        userInfo[@"key1"] = self.allArray;
        userInfo[@"key2"] = self.pastTimeArray;
        [self.navigationController popViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"update" object:nil userInfo:userInfo];
//        [self traverseGoodOfDataBase];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)pressComment {
    _commentVC = [[commentViewController alloc] init];
    _commentVC.ID = self.nowID;
    
    [self.navigationController pushViewController:_commentVC animated:YES];
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger currentPage = (scrollView.contentOffset.x / Width) + 0.5;
    _pageNumber = [NSNumber numberWithInteger:currentPage + 5];
    
    //滑动cell只加载当前webview，不加载多余webView
    if (scrollView.tag == 77) {

        // 当滚动视图向右滚动且快接近画布右边缘时，触发加载数据的操作
        if (scrollView.contentOffset.x >  ([_allArray count] * 5 * Width  - Width) && self.isLoadingMoreData == NO) {
            self.isLoadingMoreData = YES;
            
            [self loadMoreData];
        } else {
            if (currentPage != (_webView.nowPage - 5) && isLoadingWebView == NO && self.isLoadingMoreData == NO && ![self.nowPageSet containsObject:_pageNumber]) {
                NSLog(@"%ld", (long)currentPage);
                isLoadingWebView = YES;
                _webView.nowPage = currentPage + 5;
                [self.nowPageSet addObject:_pageNumber];
                NSLog(@"%ld..", (long)_webView.nowPage);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"newPage" object:nil userInfo:nil];
            }
        }
    }

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger currentPage = (scrollView.contentOffset.x / Width) + 0.5;
    _pageNumber = [NSNumber numberWithInteger:currentPage + 5];
    if (scrollView.tag == 77) {
        if (isLoadingWebView == NO && self.isLoadingMoreData == NO) {
            [self getExtraModel:currentPage + 5];
        }
        _webPageImageURL = _allArray[(currentPage) / 5][@"stories"][(currentPage + 5) % 5][@"images"][0];
        _webPageID = _allArray[(currentPage) / 5][@"stories"][(currentPage + 5) % 5][@"id"];
        _webPageTitle = _allArray[(currentPage) / 5][@"stories"][(currentPage + 5) % 5][@"title"];
        _webURL = _allArray[(currentPage) / 5][@"stories"][(currentPage + 5) % 5][@"url"];

        [self judgeCollectionInOrOut];
        [self judgeGoodInOrOut];
        //    NSLog(@"%@  %@  %@", _webPageImageURL, _webPageID, _webPageTitle);
    }
    if (scrollView.tag == 66) {
        if (isLoadingWebView == NO && self.isLoadingMoreData == NO) {
            [self getTopExtraModel:currentPage];
        }
        _webPageImageURL = _allArray[0][@"top_stories"][currentPage][@"image"];
        _webPageID = _allArray[0][@"top_stories"][currentPage][@"id"];
        _webPageTitle = _allArray[0][@"top_stories"][currentPage][@"title"];
        _webURL = _allArray[0][@"top_stories"][currentPage][@"url"];

        [self judgeCollectionInOrOut];
        [self judgeGoodInOrOut];

        //    NSLog(@"%@  %@  %@", _webPageImageURL, _webPageID, _webPageTitle);
    }
    if (scrollView.tag == 55) {
        if (isLoadingWebView == NO && self.isLoadingMoreData == NO) {
            [self getCollectionExtraModel:currentPage];
        }
        _webPageImageURL = _imageURLArray[currentPage];
        _webPageID = _IDArray[currentPage];
        _webPageTitle = _titleArray[currentPage];
        _webURL = _webURLArray[currentPage];

        [self judgeCollectionInOrOut];
        [self judgeGoodInOrOut];
            NSLog(@"%@  %@  %@", _webPageImageURL, _webPageID, _webPageTitle);
    }
}


    
- (void)loadMoreData {
    [self getPastModel];
}

- (void)getPastModel {
    pastData++;
    numbersOfLoad++;
    NSString *date = [self.homeModel pastDateForJson:numbersOfLoad];
    
    NSLog(@"pastD = %ld NM = %d", pastData, numbersOfLoad);
    NSLog(@"滑动");

    [[Manager shareManager] NetWorkGetWithPastData:^(PastModel * _Nonnull model) {
        self.pastModelDictionary = [model toDictionary];
        [self.allArray addObject:[model toDictionary]];
        [self.pastTimeArray addObject:[self.homeModel pastDate:numbersOfLoad]];
//        NSLog(@"%@", self.allArray);
        dispatch_async(dispatch_get_main_queue(), ^{
//            [self layoutNewScrollView];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"layoutNewScrollView" object:nil userInfo:nil];
            self.isLoadingMoreData = NO; // 重置加载标志
        });

    } andError:^(NSError * _Nullable error) {
        NSLog(@"失败: %@", error); // 添加日志
    } andDate:date];
}

- (void)getExtraModel:(NSInteger)page {
    NSString *ID = _allArray[(page - 5) / 5][@"stories"][page % 5][@"id"];
    self.nowID = ID;

    [[Manager shareManager] NetWorkGetWithExtraData:^(ExtraModel * _Nonnull model) {
        self.extraModelDictionary = [model toDictionary];
        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"dddd");
            if (self.webView.buttonGood.selected == YES) {
                self.webView.countsOfGood.text = [self->_webModel incrementStringNumber:self.extraModelDictionary[@"popularity"]];
            } else {
                self.webView.countsOfGood.text = self.extraModelDictionary[@"popularity"];
            }
            self.webView.countsOfComment.text = self.extraModelDictionary[@"comments"];
            self.isLoadingExtraData = NO;
        });
    } andError:^(NSError * _Nullable error) {
        NSLog(@"失败: %@", error); // 添加日志
        self.isLoadingExtraData = NO; // 请求失败时也要重置标志
    } andID:ID];
}

- (void)getTopExtraModel:(NSInteger)page {
    NSString *ID = _allArray[page/ 5][@"top_stories"][page % 5][@"id"];
    self.nowID = ID;

    [[Manager shareManager] NetWorkGetWithExtraData:^(ExtraModel * _Nonnull model) {
        self.extraModelDictionary = [model toDictionary];
        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"dddd");
            if (self.webView.buttonGood.selected == YES) {
                self.webView.countsOfGood.text = [self->_webModel incrementStringNumber:self.extraModelDictionary[@"popularity"]];
            } else {
                self.webView.countsOfGood.text = self.extraModelDictionary[@"popularity"];
            }
            self.webView.countsOfComment.text = self.extraModelDictionary[@"comments"];
            self.isLoadingExtraData = NO;
        });
    } andError:^(NSError * _Nullable error) {
        NSLog(@"失败: %@", error); // 添加日志
        self.isLoadingExtraData = NO; // 请求失败时也要重置标志
    } andID:ID];
}

- (void)getCollectionExtraModel:(NSInteger)page {
    NSString *ID = _IDArray[page];
    self.nowID = ID;

    [[Manager shareManager] NetWorkGetWithExtraData:^(ExtraModel * _Nonnull model) {
        self.extraModelDictionary = [model toDictionary];
        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"dddd");
            self.webView.countsOfGood.text = self.extraModelDictionary[@"popularity"];
            self.webView.countsOfComment.text = self.extraModelDictionary[@"comments"];
            self.isLoadingExtraData = NO;
        });
    } andError:^(NSError * _Nullable error) {
        NSLog(@"失败: %@", error); // 添加日志
        self.isLoadingExtraData = NO; // 请求失败时也要重置标志
    } andID:ID];
}

- (void)getBeginExtraModel {
    NSString *ID = self.extraID;
    self.nowID = ID;

    [[Manager shareManager] NetWorkGetWithExtraData:^(ExtraModel * _Nonnull model) {
        self.extraModelDictionary = [model toDictionary];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.webView.buttonGood.selected == YES) {
                self.webView.countsOfGood.text = [self->_webModel incrementStringNumber:self.extraModelDictionary[@"popularity"]];
            } else {
                self.webView.countsOfGood.text = self.extraModelDictionary[@"popularity"];
            }
            self.webView.countsOfComment.text = self.extraModelDictionary[@"comments"];
            self.isLoadingExtraData = NO;
        });
    } andError:^(NSError * _Nullable error) {
        NSLog(@"失败: %@", error); // 添加日志
        self.isLoadingExtraData = NO; // 请求失败时也要重置标志
    } andID:ID];
}

//- (void)pressComment {
//    if (_webView.buttonCollection.selected == NO) {
//        
//    }
//}

- (void)createDataBase {
    // 获取数据库文件的路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [docPath stringByAppendingPathComponent:@"DailyNews.sqlite"];
    _dataBase = [FMDatabase databaseWithPath:path];
    if ([_dataBase open]) {
            // do something
        NSLog(@"Open database Success");

    } else {
        NSLog(@"fail to open database");
    }
}

- (void)createDataBaseOfGood {
    // 获取数据库文件的路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [docPath stringByAppendingPathComponent:@"DailyNewsOfGood.sqlite"];
    _dataBaseOfGood = [FMDatabase databaseWithPath:path];
    if ([_dataBaseOfGood open]) {
            // do something
        NSLog(@"Open database Success2");

    } else {
        NSLog(@"fail to open database");
    }
}

- (void)insertDataBase {
    if ([_dataBase open]) {
        NSString *insertSql = @"insert into 't_DailyNews'(webPageID,webPageTitle,webPageImageURL, webURL) values(?,?,?,?)";
        BOOL result = [_dataBase executeUpdate:insertSql, _webPageID, _webPageTitle, _webPageImageURL, _webURL];
        if (result) {
            NSLog(@"添加数据成功");
        } else {
            NSLog(@"添加数据失败");
        }
    }
}

- (void)insertGoodToDataBase {
    if ([_dataBaseOfGood open]) {
        NSString *insertSql = @"insert into 't_DailyNewsOfGood'(webPageID, webURL, countsOfGood) values(?,?,?)";
        BOOL result = [_dataBaseOfGood executeUpdate:insertSql, _webPageID, _webURL, _nowGood];
        if (result) {
            NSLog(@"添加数据成功2");
            NSLog(@"%@", _nowGood);
        } else {
            NSLog(@"添加数据失败");
        }
    }
}

- (void)traverseDataBase {
    [_dataBase open];
    NSString *selectSql = @"select * from t_DailyNews";
    FMResultSet *rs = [_dataBase executeQuery:selectSql];
    //FMResultSet专门用来进行查询操作
    while ([rs next]) {
        NSString *webPageID = [rs stringForColumn:@"webPageID"];
        NSString *webPageTitle = [rs stringForColumn:@"webPageTitle"];
        NSString *webPageImageURL = [rs stringForColumn:@"webPageImageURL"];
        NSString *webURL = [rs stringForColumn:@"webURL"];
        NSLog(@"webPageID = %@, webPageTitle = %@, webPageImageURL = %@, webURL = %@",webPageID,webPageTitle,webPageImageURL,webURL);
//        NSMutableDictionary *dic = [self dictionaryWithJsonString:courseInfo];
//        NSLog(@"%@",dic);
    }
    [_dataBase close];
}

- (void)traverseGoodOfDataBase {
    [_dataBaseOfGood open];
    NSString *selectSql = @"select * from t_DailyNewsOfGood";
    FMResultSet *rs = [_dataBaseOfGood executeQuery:selectSql];
    //FMResultSet专门用来进行查询操作
    while ([rs next]) {
        NSString *webPageID = [rs stringForColumn:@"webPageID"];
        NSString *webURL = [rs stringForColumn:@"webURL"];
        NSString *countsOfGood = [rs stringForColumn:@"countsOfGood"];
        NSLog(@"webPageID = %@, webURL = %@, countsOfGood = %@", webPageID, webURL, countsOfGood);
//        NSMutableDictionary *dic = [self dictionaryWithJsonString:courseInfo];
//        NSLog(@"%@",dic);
    }
    [_dataBaseOfGood close];
}

- (void)deleteDataBase {
    NSString *sql = @"delete from t_DailyNews where (webPageID) = (?) and (webPageTitle) = (?) and (webURL) = (?)";
    if ([_dataBase open]) {
        BOOL result = [_dataBase executeUpdate:sql, _webPageID, _webPageTitle, _webURL];
        if (result) {
            NSLog(@"删除数据成功");
        } else {
            NSLog(@"删除数据失败");
        }
    }
}

- (void)deleteDataBaseOfGood {
    
    NSString *sql = @"delete from t_DailyNewsOfGood where (webPageID) = (?) and (webURL) = (?) and (countsOfGood) = (?)";
    if ([_dataBaseOfGood open]) {
        BOOL result = [_dataBaseOfGood executeUpdate:sql, _webPageID, _webURL, _nowGood];
        if (result) {
            NSLog(@"删除数据成功2");
        } else {
            NSLog(@"删除数据失败");
        }
    }
}



@end
