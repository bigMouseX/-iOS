//
//  commentViewController.m
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/11/5.
//

#import "commentViewController.h"
#define SIZE_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SIZE_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@interface commentViewController ()

@end

@implementation commentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _commentM = [[commentModel alloc] init];
    
    _commentV = [[commentView alloc] initWithFrame:CGRectMake(0, SIZE_HEIGHT * 0.04, SIZE_WIDTH, SIZE_HEIGHT * 0.96)];

    [self.view addSubview:_commentV];
//    NSLog(@"%@..", _commentV.countsOfComment);
    [_commentV.backButton addTarget:self action:@selector(pressBack) forControlEvents:UIControlEventTouchUpInside];

    [self getLongComment];
    
    
}

- (void)getLongComment {
    NSLog(@"%@", self.ID);
    [[Manager shareManager] NetWorkGetWithLongCommentsData:^(LongCommentsModel * _Nonnull model) {
        NSDictionary *t = [model toDictionary];
        self.commentV.longCommentDictionary = t;
//        NSLog(@"%@", self.commentV.longCommentDictionary);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self getShortComment];
        });
    } andError:^(NSError * _Nullable error) {
        NSLog(@"失败: %@", error); // 添加日志
    } andID:self.ID];
}

- (void)getShortComment {
    NSLog(@"%@", _ID);
    [[Manager shareManager] NetWorkGetWithShortCommentsData:^(LongCommentsModel * _Nonnull model) {
        NSDictionary *t = [model toDictionary];
        self.commentV.shortCommentDictionary = t;
//        NSLog(@"%@11", self.commentV.shortCommentDictionary);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.commentV addView];
        });
    } andError:^(NSError * _Nullable error) {
        NSLog(@"失败: %@", error); // 添加日志
    } andID:self.ID];
}

- (void)pressBack {
    [self.navigationController popViewControllerAnimated:YES];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
