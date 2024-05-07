//
//  webViewController.h
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/10/29.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "webView.h"
#import "webModel.h"
#import "Model.h"
#import "Manager.h"
#import "commentViewController.h"
#import "FMDB.h"
NS_ASSUME_NONNULL_BEGIN

@interface webViewController : UIViewController<UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray* allArray;
@property (nonatomic, strong) NSMutableArray* topArray;
@property (nonatomic, strong) NSMutableArray* extraArray;

@property (nonatomic, assign)NSInteger nowPage;
@property (nonatomic, strong) NSString* extraID;

@property (nonatomic, strong) NSMutableArray* pastTimeArray;

@property (nonatomic, strong)webView *webView;
@property (nonatomic, strong)webModel *webModel;

- (void)loadMoreData;
@property (nonatomic, copy) NSDictionary* pastModelDictionary;
@property (nonatomic, copy) NSDictionary* extraModelDictionary;

- (void)getPastModel;
@property (nonatomic, strong) Model *homeModel;
@property (nonatomic, strong)WKWebView *moreWebView;

@property (nonatomic, assign) BOOL isLoadingMoreData;
@property (nonatomic, assign) BOOL isLoadingWebView;
@property (nonatomic, assign) BOOL isLoadingExtraData;

@property (nonatomic, strong) NSMutableSet *nowPageSet;
@property (nonatomic, strong) NSNumber *pageNumber;

- (void)pressButtonReturn;
- (void)pressComment;
- (void)getExtraModel:(NSInteger)page;
- (void)getTopExtraModel:(NSInteger)page;
- (void)getCollectionExtraModel:(NSInteger)page;

- (void)getBeginExtraModel;

@property (nonatomic, strong)commentViewController *commentVC;
@property (nonatomic, copy)NSString *nowID;
@property (nonatomic, copy)NSString *nowGood;

- (void)pressGood:(UIButton *)btn;
@property (nonatomic, strong) NSMutableArray* alreadyPressGoodArray;

- (void)createDataBase;
@property (strong, nonatomic) FMDatabase *dataBase;
@property (strong, nonatomic) NSString *webPageID;
@property (strong, nonatomic) NSString *webPageTitle;
@property (strong, nonatomic) NSString *webPageImageURL;
@property (strong, nonatomic) NSString *webURL;

- (void)insertDataBase;
- (void)traverseDataBase;
- (void)deleteDataBase;
- (void)pressCollection:(UIButton *)btn;
- (void)judgeCollectionInOrOut;

- (void)createDataBaseOfGood;
@property (strong, nonatomic) FMDatabase *dataBaseOfGood;
- (void)insertGoodToDataBase;
- (void)traverseGoodOfDataBase;
- (void)deleteDataBaseOfGood;
- (void)judgeGoodInOrOut;
@property (nonatomic, assign)BOOL goodFlag;



//collectionWebView
@property (nonatomic, strong) NSMutableArray *IDArray;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *imageURLArray;
@property (nonatomic, strong) NSMutableArray *webURLArray;
@property (nonatomic, assign) BOOL isCollectionWebView;

@end

NS_ASSUME_NONNULL_END
