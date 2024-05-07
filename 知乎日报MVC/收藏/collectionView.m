//
//  collectionView.m
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/11/10.
//

#import "collectionView.h"

@implementation collectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setImage:[UIImage imageNamed:@"fanhui_zhihu.png"] forState:UIControlStateNormal];
    [self addSubview:_backButton];
    [_backButton mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.equalTo(@30);
        make.left.equalTo(@20);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    _title = [[UILabel alloc] init];
    _title.text = @"我的收藏";
    [self addSubview:self.title];
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@30);
        make.height.equalTo(@20);
        make.left.equalTo(@(SIZE_WIDTH / 2 - 50));
        make.right.equalTo(@(-SIZE_WIDTH / 2 + 50));
    }];
    _title.textAlignment = NSTextAlignmentCenter;
    
    _lineLabel = [[UILabel alloc] init];
    _lineLabel.backgroundColor = [UIColor grayColor];
    [self addSubview:_lineLabel];
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.equalTo(_backButton.mas_bottom).offset(15);
        make.left.equalTo(@0);
        make.width.equalTo(@SIZE_WIDTH);
        make.height.equalTo(@0.2);
    }];
    
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.equalTo(_lineLabel);
        make.left.equalTo(@0);
        make.width.equalTo(@SIZE_WIDTH);
        make.bottom.equalTo(self.mas_bottom);
    }];
    [_tableView registerClass:[CollectionTableViewCell class] forCellReuseIdentifier:@"collection"];

    return self;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_IDArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CollectionTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"collection"];
    cell.articleBigLabel.text = _titleArray[indexPath.row];
    NSString *imageURL = _imageURLArray[indexPath.row];
    [cell.articleImageView sd_setImageWithURL:[NSURL URLWithString:imageURL]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_delegateCell returnNowPage:indexPath.row];
}



@end
