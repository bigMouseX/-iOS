//
//  PersonalViewController.m
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/11/10.
//

#import "PersonalViewController.h"

@interface PersonalViewController ()

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _PersonalV = [[PersonalView alloc] initWithFrame:CGRectMake(0, SIZE_HEIGHT * 0.04, SIZE_WIDTH, SIZE_HEIGHT * 0.96)];
    [_PersonalV.backButton addTarget:self action:@selector(pressBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_PersonalV];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toCollection) name:@"toCollection" object:nil];
}

- (void)pressBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)toCollection {
    _collectionVC = [[collectionViewController alloc] init];
    [self.navigationController pushViewController:_collectionVC animated:YES];
}

@end
