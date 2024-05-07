//
//  PresonalView.m
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/11/10.
//

#import "PersonalView.h"
#define SIZE_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SIZE_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@implementation PersonalView

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
    
    self.head = [[UIImage alloc] init];
    self.headView = [[UIImageView alloc] init];
    self.head = [UIImage imageNamed:@"zhihugou.jpg"];
    self.headView.image = self.head;
    self.headView.layer.masksToBounds = YES;
    self.headView.clipsToBounds = YES;
    self.headView.layer.cornerRadius = 30;
    [self addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(60);
        make.top.mas_equalTo(70);
        make.left.mas_equalTo(SIZE_WIDTH / 2 - 30);
    }];
    
    self.nameLabel = [[UILabel alloc] init];
    _nameLabel.text = @"孙笑川";
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0]; // 使用Helvetica-Bold字体
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.mas_equalTo(self.headView.mas_bottom).offset(10);
       make.height.mas_equalTo(30);
       make.left.mas_equalTo(SIZE_WIDTH / 2 - 50);
       make.width.mas_equalTo(100);
    }];
    
    _tableView = [[UITableView alloc] init];
    _tableView.separatorStyle = 0;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(15);
       make.width.mas_equalTo(SIZE_WIDTH);
       make.height.mas_equalTo(100);
       make.left.mas_equalTo(self.mas_left);

    }];
    [_tableView registerClass:[PersonalTableViewCell class] forCellReuseIdentifier:@"personal"];
    
    _set = [UIButton buttonWithType:UIButtonTypeCustom];
    [_set setImage:[UIImage imageNamed:@"shezhi.png"] forState:UIControlStateNormal];
    [_set setTitle:@"设置" forState:UIControlStateNormal];
    [self addSubview:_set];
    [_set mas_makeConstraints:^(MASConstraintMaker *make) {
       make.bottom.mas_equalTo(self.mas_bottom).offset(-80);
       make.height.mas_equalTo(40);
       make.width.mas_equalTo(40);
       make.left.mas_equalTo(SIZE_WIDTH / 2 - 20);
    }];

    _setLable = [[UILabel alloc] init];
    _setLable.text = @"设置";
    _setLable.textColor = [UIColor grayColor];
    _setLable.textAlignment = NSTextAlignmentCenter;
    _setLable.font = [UIFont systemFontOfSize:14];// 使用Helvetica-Bold字体
    [self addSubview:_setLable];
    [_setLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.set.mas_bottom).offset(10);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(40);
            make.left.mas_equalTo(SIZE_WIDTH / 2 - 20);

    }];
    
    
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonalTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"personal" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.content.text = @"我的收藏";
    } else {
        cell.content.text = @"消息中心";
    }
    cell.selectionStyle = 0;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"toCollection" object:nil userInfo:nil];
    }
}

@end
