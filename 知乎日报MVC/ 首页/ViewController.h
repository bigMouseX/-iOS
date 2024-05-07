//
//  ViewController.h
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/10/23.
//

#import <UIKit/UIKit.h>
#import "View.h"
#import "Model.h"
#import "CurrentModel.h"
#import "ScrollTableViewCell.h"
#import "webViewController.h"
#import "PersonalViewController.h"
#import "FMDB.h"
#import "MJRefresh.h"

@interface ViewController : UIViewController<cellDelegate>

@property (nonatomic, strong) View *homeView;
@property (nonatomic, strong) Model *homeModel;
@property (nonatomic, copy) NSDictionary* modelDictionary;
@property (nonatomic, copy) NSDictionary* pastModelDictionary;

@property (nonatomic, copy) NSMutableArray* topURLArray;
@property (nonatomic, copy) NSMutableArray* topIDArray;
@property (nonatomic, strong) NSMutableArray* topPageTitleArray;
@property (nonatomic, strong) NSMutableArray* topPageImageURLArray;

- (void)initHomeView;
- (void)getCurrentModel;
- (void)getPastModel:(NSString *)date;

@property (nonatomic, strong) NSMutableArray* pastArray;
@property (nonatomic, strong) NSMutableArray* allArray;
@property (nonatomic, strong) NSMutableArray* topArray;

@property (nonatomic, strong) webViewController* webViewC;
@property (nonatomic, strong) PersonalViewController* personalC;

@property (nonatomic, assign) BOOL isLoadingMoreData;

- (void)pressPersonal;

- (void)createDataBase;

- (void)createDataBaseOfGood;

- (void)xiugai;

- (void)deleteAllData;

- (void)loadNewData;

@end

