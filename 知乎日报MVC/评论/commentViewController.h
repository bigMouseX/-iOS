//
//  commentViewController.h
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/11/5.
//

#import <UIKit/UIKit.h>
#import "commentView.h"
#import "commentModel.h"
#import "Manager.h"
NS_ASSUME_NONNULL_BEGIN

@interface commentViewController : UIViewController
@property (nonatomic, strong)commentView *commentV;
@property (nonatomic, strong)commentModel *commentM;

@property (nonatomic, copy)NSString *ID;
- (void)pressBack;

- (void)getLongComment;
- (void)getShortComment;

@end

NS_ASSUME_NONNULL_END
