//
//  PersonalViewController.h
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/11/10.
//

#import <UIKit/UIKit.h>
#import "PersonalView.h"
#import "collectionViewController.h"
#define SIZE_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SIZE_HEIGHT ([UIScreen mainScreen].bounds.size.height)
NS_ASSUME_NONNULL_BEGIN

@interface PersonalViewController : UIViewController
@property (nonatomic, strong) PersonalView *PersonalV;
@property (nonatomic, strong) collectionViewController *collectionVC;
- (void)toCollection;
@end

NS_ASSUME_NONNULL_END
