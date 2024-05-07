//
//  ViewController.m
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/10/23.
//

#import "ViewController.h"
extern long pastData;
int numbersOfLoad = 0;
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    self.homeModel = [[Model alloc] init];
    
//    self.view.backgroundColor = [UIColor whiteColor];
    
    _modelDictionary = [[NSDictionary alloc] init];
    _topURLArray = [[NSMutableArray alloc] init];
    _topIDArray = [[NSMutableArray alloc] init];
    _topPageTitleArray = [[NSMutableArray alloc] init];
    _topPageImageURLArray = [[NSMutableArray alloc] init];
    self.pastArray = [[NSMutableArray alloc] init];
    self.allArray = [[NSMutableArray alloc] init];
    self.topArray = [[NSMutableArray alloc] init];

    
    self.modelDictionary = [[NSDictionary alloc] init];
    self.pastModelDictionary = [[NSDictionary alloc] init];
    
    [self getCurrentModel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getPastModel:) name:@"reNew" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(update:) name:@"update" object:nil];

    self.isLoadingMoreData = NO;
    
    [self createDataBase];
    [self createDataBaseOfGood];
//    NSLog(@"22222222");
//    [self xiugai];
//    [self deleteAllData];
    
    //下拉刷新


}

- (void)update:(NSNotification *)send {
    NSArray *newDataArray = send.userInfo[@"key1"];
    NSArray *newPastTimeArray = send.userInfo[@"key2"];
    
    if (![self.homeView.allArray isEqualToArray:newDataArray] || ![self.homeView.pastTimeArray isEqualToArray:newPastTimeArray]) {
        self.homeView.allArray = [newDataArray mutableCopy];
        self.allArray = [newDataArray mutableCopy];
        self.homeView.pastTimeArray = [newPastTimeArray mutableCopy];
        
        [self.homeView.tableView reloadData];
    }
    
//    self.homeView.allArray = send.userInfo[@"key1"];
//    self.allArray = send.userInfo[@"key1"];
//    self.homeView.pastTimeArray = send.userInfo[@"key2"];
    //原来的这段代码让self.homeView.allArray与self.allArray同时指向了send.userInfo[@"key1"]，也就是说我之后在此对self.allArray进行修改self.homeView.allArray也会同步修改，反之亦然
}


- (void)initHomeView {
    self.homeView = [[View alloc] initWithFrame:self.view.bounds];
    self.homeView.Date.text = [self.homeModel getDate];
    self.homeView.Month.text = [self.homeModel getMonth];
    self.homeView.Tip.text = [self.homeModel getClockTip];
    self.homeView.delegateCell = self;
    [self.homeView.btn_head addTarget:self action:@selector(pressPersonal) forControlEvents:UIControlEventTouchUpInside];
//    self.homeView.delegate = self;
    //发送通知，传递请求到的网络数据给View层进行赋值
    [[NSNotificationCenter defaultCenter] postNotificationName:@"postJSONModel" object:nil userInfo:_modelDictionary];
    self.homeView.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.view addSubview:_homeView];
    
}

- (void)loadNewData {
    // 模拟网络请求加载新数据
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 加载完成后结束下拉刷新
        [self.homeView.tableView.mj_header endRefreshing];
        // 刷新 UITableView 的数据
//        [self.homeView.tableView reloadData];
    });
}

- (void)pressPersonal {
    _personalC = [[PersonalViewController alloc] init];
    [self.navigationController pushViewController:_personalC animated:YES];
}

- (void)getCurrentModel {
    [[Manager shareManager] NetWorkGetWithRecentData:^(CurrentModel *model) {
        self.modelDictionary = [model toDictionary];
        
        for (int i = 0; i < 5; i++) {
            [self->_topURLArray addObject:self.modelDictionary[@"top_stories"][i][@"url"]];
            [self->_topIDArray addObject:self.modelDictionary[@"top_stories"][i][@"id"]];
            [self.topPageTitleArray addObject:self.modelDictionary[@"top_stories"][i][@"title"]];
            [self.topPageImageURLArray addObject:self.modelDictionary[@"top_stories"][i][@"image"]];
        }
        [self.topArray addObject:[model toDictionary]];
        [self.allArray addObject:[model toDictionary]];

        // 异步执行任务创建方法
        dispatch_async(dispatch_get_main_queue(), ^{
            [self initHomeView];
            [self.homeView.allArray addObject:[model toDictionary]];

        });

    } andError:^(NSError * _Nullable error) {
            NSLog(@"失败");
        }];
//    NSLog(@"11111");
    
}

- (void)getPastModel:(NSString *)date {
    if (self.isLoadingMoreData) {
           return;
       }
    self.isLoadingMoreData = YES; // 设置加载标志
    pastData++;
    numbersOfLoad++;
    date = [self.homeModel pastDateForJson:numbersOfLoad];
    [[Manager shareManager] NetWorkGetWithPastData:^(PastModel * _Nonnull model) {
        self.pastModelDictionary = [model toDictionary];
//        [self.homeView.pastArray addObject:self.pastModelDictionary];
        [self.homeView.pastTimeArray addObject:[self.homeModel pastDate:numbersOfLoad]];
        [self.homeView.allArray addObject:[model toDictionary]];
        [self.allArray addObject:[model toDictionary]];
        
        NSLog(@"%@", self.allArray);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.homeView hideLoadMoreView];
            [self.homeView.tableView reloadData];
            self.isLoadingMoreData = NO; // 重置加载标志
        });
    } andError:^(NSError * _Nullable error) {
        NSLog(@"失败: %@", error); // 添加日志
    } andDate:date];

}

- (void)returnImageTag:(NSInteger)nowTag {
    _webViewC = [[webViewController alloc] init];


    NSLog(@"%ld", (long)nowTag);
    _webViewC.nowPage = nowTag;
//    NSLog(@"%d..", nowTag);
    _webViewC.allArray = _allArray;
    _webViewC.topArray = _topArray;
    _webViewC.pastTimeArray = self.homeView.pastTimeArray;
    if (nowTag >=5) {
        _webViewC.webPageImageURL = _allArray[(nowTag - 5) / 5][@"stories"][nowTag % 5][@"images"][0];
        _webViewC.webPageTitle = _allArray[(nowTag - 5) / 5][@"stories"][nowTag % 5][@"title"];
        _webViewC.webPageID = _allArray[(nowTag - 5) / 5][@"stories"][nowTag % 5][@"id"];
        _webViewC.webURL = _allArray[(nowTag - 5) / 5][@"stories"][nowTag % 5][@"url"];
        NSLog(@"%@", _webViewC.webURL);
    }
    else {
        _webViewC.webPageImageURL = _allArray[0][@"top_stories"][nowTag][@"image"];
        _webViewC.webPageTitle = _allArray[0][@"top_stories"][nowTag][@"title"];
        _webViewC.webPageID = _allArray[0][@"top_stories"][nowTag][@"id"];
        _webViewC.webURL = _allArray[0][@"top_stories"][nowTag][@"url"];
        NSLog(@"%@", _webViewC.webURL);

    }
    // 获取当前ID
    if (nowTag < 5) {
        _webViewC.extraID = _allArray[0][@"top_stories"][nowTag][@"id"];
    }
    // 过去的新闻id nowTag / 7 和 nowTag % 7分别代表组数和具体的下标
    else {
        _webViewC.extraID = _allArray[(nowTag - 5) / 5][@"stories"][nowTag % 5][@"id"];
    }
    
    _webViewC.isCollectionWebView = NO;

    [self.navigationController pushViewController:_webViewC animated:YES];
}

- (void)createDataBase {
    // 获取数据库文件的路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [docPath stringByAppendingPathComponent:@"DailyNews.sqlite"];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    if ([db open]) {
        BOOL result = [db executeUpdate:@"CREATE TABLE 't_DailyNews' ('webPageID' TEXT, 'webPageTitle' TEXT, 'webPageImageURL' TEXT, 'webURL' TEXT)"];
        if (result) {
            NSLog(@"创表成功");
        }
        NSLog(@"Open database Success");
    } else {
        NSLog(@"fail to open database");
    }
    [db close];
}

- (void)createDataBaseOfGood {
    // 获取数据库文件的路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [docPath stringByAppendingPathComponent:@"DailyNewsOfGood.sqlite"];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    if ([db open]) {
        BOOL result = [db executeUpdate:@"CREATE TABLE 't_DailyNewsOfGood' ('webPageID' TEXT, 'webURL' TEXT, 'countsOfGood' TEXT)"];
        if (result) {
            NSLog(@"创表成功2");
        }
        NSLog(@"Open database Success");
    } else {
        NSLog(@"fail to open database");
    }
    [db close];
}

- (void)xiugai {
    // 获取数据库文件的路径
       NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
       NSString *path = [docPath stringByAppendingPathComponent:@"DailyNewsOfGood.sqlite"];
       FMDatabase *db = [FMDatabase databaseWithPath:path];
       
    // Assuming db is your FMDatabase instance
    if ([db open]) {
        NSString *alterTableSQL = @"ALTER TABLE 't_DailyNewsOfGood' ADD COLUMN countsOfGood TEXT";
        BOOL success = [db executeUpdate:alterTableSQL];

        if (success) {
            NSLog(@"Table altered successfully");
        } else {
            NSLog(@"Error altering table: %@", [db lastErrorMessage]);
        }

        [db close];
    } else {
        NSLog(@"Error opening database: %@", [db lastErrorMessage]);
    }

}

- (void)deleteAllData {
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [docPath stringByAppendingPathComponent:@"DailyNewsOfGood.sqlite"];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    NSString *sql = @"DELETE FROM t_DailyNewsOfGood";
    if ([db open]) {
        BOOL result = [db executeUpdate:sql];
        if (result) {
            NSLog(@"删除所有数据成功");
        } else {
            NSLog(@"删除所有数据失败");
        }
        [db close];
    }
}


@end
