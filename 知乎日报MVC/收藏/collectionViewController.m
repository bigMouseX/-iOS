//
//  collectionViewController.m
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/11/10.
//

#import "collectionViewController.h"

@interface collectionViewController ()

@end

@implementation collectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self createDataBase];
    [self loadCollectionCenter];
    [self addView];
}

- (void)addView {
    _collectionV = [[collectionView alloc] initWithFrame:CGRectMake(0, SIZE_HEIGHT * 0.04, SIZE_WIDTH, SIZE_HEIGHT * 0.96)];
    _collectionV.IDArray = [_IDArray copy];
    _collectionV.titleArray = [_titleArray copy];
    _collectionV.imageURLArray = [_imageURLArray copy];
    _collectionV.webURLArray = [_webURLArray copy];
    _collectionV.delegateCell = self;
    [_collectionV.backButton addTarget:self action:@selector(pressBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_collectionV];
}

- (void)createDataBase {
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
       NSString *path = [docPath stringByAppendingPathComponent:@"DailyNews.sqlite"];
    _dataBase = [FMDatabase databaseWithPath:path];

}

- (void)loadCollectionCenter {
    [_dataBase open];
    NSString *selectSql = @"select * from t_DailyNews";
    FMResultSet *rs = [_dataBase executeQuery:selectSql];
    //FMResultSet专门用来进行查询操作
    _IDArray = [NSMutableArray new];
    _titleArray = [NSMutableArray new];
    _imageURLArray = [NSMutableArray new];
    _webURLArray = [NSMutableArray new];
    while ([rs next]) {
        NSString *webPageID = [rs stringForColumn:@"webPageID"];
        NSString *webPageTitle = [rs stringForColumn:@"webPageTitle"];
        NSString *webPageImageURL = [rs stringForColumn:@"webPageImageURL"];
        NSString *webURL = [rs stringForColumn:@"webURL"];
        [_IDArray addObject:webPageID];
        [_titleArray addObject:webPageTitle];
        [_imageURLArray addObject:webPageImageURL];
        [_webURLArray addObject:webURL];
        
    }
    [_dataBase close];
}

- (void)pressBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)returnNowPage: (NSInteger) nowPage {
    _webViewC = [[webViewController alloc] init];


    NSLog(@"%ld", (long)nowPage);
    _webViewC.nowPage = nowPage;
//    NSLog(@"%d..", nowTag);
    _webViewC.IDArray = _IDArray;
    _webViewC.webURLArray = _webURLArray;
    _webViewC.imageURLArray = _imageURLArray;
    _webViewC.titleArray = _titleArray;
    
    _webViewC.webPageID = _IDArray[nowPage];
    _webViewC.webURL = _webURLArray[nowPage];
    _webViewC.webPageImageURL = _imageURLArray[nowPage];
    _webViewC.webPageTitle = _titleArray[nowPage];
    _webViewC.extraID = _IDArray[nowPage];
    NSLog(@"%@", _webViewC.webURL);

    // 获取当前ID

    _webViewC.extraID = _IDArray[nowPage];

    _webViewC.isCollectionWebView = YES;
    
    NSLog(@"1234");
    
    [self.navigationController pushViewController:_webViewC animated:YES];
}

@end
