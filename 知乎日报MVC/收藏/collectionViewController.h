//
//  collectionViewController.h
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/11/10.
//

#import <UIKit/UIKit.h>
#import "FMDB.h"
#import "collectionView.h"
#import "webViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface collectionViewController : UIViewController<collectionCellDelegate>
- (void)createDataBase;
@property (nonatomic, strong) FMDatabase *dataBase;
@property (nonatomic, strong) NSMutableArray *IDArray;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *imageURLArray;
@property (nonatomic, strong) NSMutableArray *webURLArray;

@property (nonatomic, strong) collectionView *collectionV;
- (void)loadCollectionCenter;
- (void)addView;
@property (nonatomic, strong) webViewController* webViewC;

@end

NS_ASSUME_NONNULL_END
