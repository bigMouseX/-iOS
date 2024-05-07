//
//  commentView.m
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/11/5.
//

#import "commentView.h"
#define SIZE_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SIZE_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@implementation commentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    _commentM = [[commentModel alloc] init];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setImage:[UIImage imageNamed:@"fanhui_zhihu.png"] forState:UIControlStateNormal];
    [self addSubview:_backButton];
    [_backButton mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.equalTo(@30);
        make.left.equalTo(@20);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    _lineLabel = [[UILabel alloc] init];
    _lineLabel.backgroundColor = [UIColor grayColor];
    [self addSubview:_lineLabel];
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.equalTo(_backButton.mas_bottom).offset(15);
        make.left.equalTo(@0);
        make.width.equalTo(@SIZE_WIDTH);
        make.height.equalTo(@0.2);
    }];
    
    _commentTableView = [[UITableView alloc] init];
    _commentTableView.backgroundColor = [UIColor whiteColor];
    _commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _commentTableView.delegate = self;
    _commentTableView.dataSource = self;
    
    // 步骤1：
    _commentTableView.rowHeight = UITableViewAutomaticDimension;
    // 步骤2：
    _commentTableView.estimatedRowHeight = 200.0;
    
    [_commentTableView registerClass:[commentTableViewCell class] forCellReuseIdentifier:@"CommentCell"];
    [_commentTableView registerClass:[replyTableViewCell class] forCellReuseIdentifier:@"ReplyCell"];

    [self addSubview:_commentTableView];
    [_commentTableView mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.equalTo(_lineLabel);
        make.left.equalTo(@0);
        make.width.equalTo(@SIZE_WIDTH);
        make.bottom.equalTo(self.mas_bottom);
    }];

    return self;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([_longCommentDictionary[@"comments"] count] != 0 && section == 0) {
        NSString *longComment = [NSString stringWithFormat:@"%lu条长评", [_longCommentDictionary[@"comments"] count]];
        return longComment;
    }
    if ([_shortCommentDictionary[@"comments"] count] != 0 && section == 1) {
        NSString *shortComment = [NSString stringWithFormat:@"%lu条短评", [_shortCommentDictionary[@"comments"] count]];
        return shortComment;
    }
    return nil;
}



- (void)addView {
    [_commentTableView reloadData];

    _countsOfCommentLabel = [[UILabel alloc] init];
    NSLog(@"%@", _shortCommentDictionary[@"comments"]);
//    NSLog(@"%lu",[_shortCommentDictionary[@"comments"] count] + [_longCommentDictionary[@"comments"] count]);
    _countsOfCommentLabel.text = [NSString stringWithFormat:@"%lu条评论", [_shortCommentDictionary[@"comments"] count] + [_longCommentDictionary[@"comments"] count]];
    [self addSubview:self.countsOfCommentLabel];
    [_countsOfCommentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@30);
            make.height.equalTo(@20);
            make.left.equalTo(@(SIZE_WIDTH / 2 - 50));
            make.right.equalTo(@(-SIZE_WIDTH / 2 + 50));
    }];
    _countsOfCommentLabel.textAlignment = NSTextAlignmentCenter;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([_longCommentDictionary count] != 0 && [_shortCommentDictionary count] != 0) {
        return 2;
    } else if ([_shortCommentDictionary count] != 0) {
        return 1;
    } else if ([_longCommentDictionary count] != 0) {
        return 1;
    } else {
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1)
        return [_shortCommentDictionary[@"comments"] count];
    else
        return [_longCommentDictionary[@"comments"] count];
}


- (void)pressZhanKaiLong:(UIButton *)buttom {
    NSLog(@"%ld", (long)buttom.tag);
    replyTableViewCell *cell = (replyTableViewCell *)[_commentTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:buttom.tag inSection:0]];
    if (cell.replyLabel.numberOfLines == 0) {
        NSLog(@"1");
        cell.replyLabel.numberOfLines = 2;
        [buttom setTitle:@" · 展开更多" forState:UIControlStateNormal];
    } else {
        NSLog(@"2");
        cell.replyLabel.numberOfLines = 0;
        [buttom setTitle:@" · 收起" forState:UIControlStateNormal];
    }
    
    [_commentTableView beginUpdates]; // 开始表格更新
    [_commentTableView endUpdates]; // 结束表格更新
}

- (void)pressZhanKaiShort:(UIButton *)buttom {
    NSLog(@"%ld", (long)buttom.tag);
    replyTableViewCell *cell = (replyTableViewCell *)[_commentTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:buttom.tag inSection:1]];
    if (cell.replyLabel.numberOfLines == 0) {
        NSLog(@"1");
        cell.replyLabel.numberOfLines = 2;
        [buttom setTitle:@" · 展示更多" forState:UIControlStateNormal];
    } else {
        NSLog(@"2");
        cell.replyLabel.numberOfLines = 0;
        [buttom setTitle:@" · 收起" forState:UIControlStateNormal];
    }
    
    [_commentTableView beginUpdates]; // 开始表格更新
    [_commentTableView endUpdates]; // 结束表格更新
}



- (NSString *)formattedDateStringFromTimestampString:(NSString *)timestampString {
    // 创建一个日期格式化器
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // 设置日期格式化器的格式
    [dateFormatter setDateFormat:@"MM-dd HH:mm"]; // 根据你的需要选择日期和时间的格式
    
    // 将时间戳字符串转换为时间
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timestampString doubleValue]];
    
    // 使用日期格式化器将时间转换为字符串
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    
    return formattedDate;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(7_0) {
    return 150;
}

-(CGSize)textHeightFromTextString:(NSString *)text width:(CGFloat)textWidth fontSize:(CGFloat)size {
    // 计算 label 需要的宽度和高度
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:size]};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    
     CGSize size1 = [text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:size]}];
    
    return CGSizeMake(size1.width, rect.size.height);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//
    if (indexPath.section == 0 && [_longCommentDictionary count] != 0) {
        if (!_longCommentDictionary[@"comments"][indexPath.row][@"reply_to"]) {
            commentTableViewCell *cell = [_commentTableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
            cell.contentLabel.text = _longCommentDictionary[@"comments"][indexPath.row][@"content"];
            cell.timeLabel.text = [self formattedDateStringFromTimestampString:_longCommentDictionary[@"comments"][indexPath.row][@"time"]];
            cell.nameLabel.text = _longCommentDictionary[@"comments"][indexPath.row][@"author"];
            [cell.commentHeadPhotoImageView sd_setImageWithURL:[NSURL URLWithString:_longCommentDictionary[@"comments"][indexPath.row][@"avatar"]]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.likes.text = _longCommentDictionary[@"comments"][indexPath.row][@"likes"];
            cell.dianzanButton.tag = indexPath.row *1000;
            [cell.dianzanButton addTarget:self action:@selector(pressGoodL:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        } else {
            replyTableViewCell *cell = [_commentTableView dequeueReusableCellWithIdentifier:@"ReplyCell" forIndexPath:indexPath];
            cell.contentLabel.text = _longCommentDictionary[@"comments"][indexPath.row][@"content"];
            cell.timeLabel.text = [self formattedDateStringFromTimestampString:_longCommentDictionary[@"comments"][indexPath.row][@"time"]];
            cell.nameLabel.text = _longCommentDictionary[@"comments"][indexPath.row][@"author"];
            [cell.commentHeadPhotoImageView sd_setImageWithURL:[NSURL URLWithString:_longCommentDictionary[@"comments"][indexPath.row][@"avatar"]]];
            NSString *reply = [NSString stringWithFormat:@"//%@：%@", _longCommentDictionary[@"comments"][indexPath.row][@"reply_to"][@"author"], _longCommentDictionary[@"comments"][indexPath.row][@"reply_to"][@"content"]];
            cell.replyLabel.text = reply;

//            cell.foldButton.tag = indexPath.section * 100 + indexPath.row;
            cell.foldButton.tag = indexPath.row;

            [cell.foldButton addTarget:self action:@selector(pressZhanKaiLong:) forControlEvents:UIControlEventTouchUpInside];

            NSInteger count = [self textHeightFromTextString:reply width:303.667 fontSize:15.5].height /
            cell.replyLabel.font.lineHeight;
            if (count <= 2) {
                cell.foldButton.hidden = YES;
            } else {
                cell.foldButton.hidden = NO;
            }

            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.likes.text = _longCommentDictionary[@"comments"][indexPath.row][@"likes"];

            cell.dianzanButton.tag = indexPath.row *1000;
            [cell.dianzanButton addTarget:self action:@selector(pressGoodL:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
    } else {
        if (!_shortCommentDictionary[@"comments"][indexPath.row][@"reply_to"]) {
            commentTableViewCell *cell = [_commentTableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
            cell.contentLabel.text = _shortCommentDictionary[@"comments"][indexPath.row][@"content"];
            cell.timeLabel.text = [self formattedDateStringFromTimestampString:_shortCommentDictionary[@"comments"][indexPath.row][@"time"]];
            cell.nameLabel.text = _shortCommentDictionary[@"comments"][indexPath.row][@"author"];
            [cell.commentHeadPhotoImageView sd_setImageWithURL:[NSURL URLWithString:_shortCommentDictionary[@"comments"][indexPath.row][@"avatar"]]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.likes.text = _shortCommentDictionary[@"comments"][indexPath.row][@"likes"];
            cell.dianzanButton.tag = indexPath.row *100;
            [cell.dianzanButton addTarget:self action:@selector(pressGood:) forControlEvents:UIControlEventTouchUpInside];

            
            return cell;
        } else {
            replyTableViewCell *cell = [_commentTableView dequeueReusableCellWithIdentifier:@"ReplyCell" forIndexPath:indexPath];
            cell.contentLabel.text = _shortCommentDictionary[@"comments"][indexPath.row][@"content"];
            cell.timeLabel.text = [self formattedDateStringFromTimestampString:_shortCommentDictionary[@"comments"][indexPath.row][@"time"]];
            cell.nameLabel.text = _shortCommentDictionary[@"comments"][indexPath.row][@"author"];
            [cell.commentHeadPhotoImageView sd_setImageWithURL:[NSURL URLWithString:_shortCommentDictionary[@"comments"][indexPath.row][@"avatar"]]];
            NSString *reply = [NSString stringWithFormat:@"//%@：%@", _shortCommentDictionary[@"comments"][indexPath.row][@"reply_to"][@"author"], _shortCommentDictionary[@"comments"][indexPath.row][@"reply_to"][@"content"]];
            cell.replyLabel.text = reply;

//            cell.foldButton.tag = indexPath.section * 100 + indexPath.row;
            cell.foldButton.tag = indexPath.row;

            [cell.foldButton addTarget:self action:@selector(pressZhanKaiShort:) forControlEvents:UIControlEventTouchUpInside];

            NSInteger count = [self textHeightFromTextString:reply width:303.667 fontSize:15.5].height /
            cell.replyLabel.font.lineHeight;
            if (count <= 2) {
                cell.foldButton.hidden = YES;
            } else {
                cell.foldButton.hidden = NO;
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.likes.text = _shortCommentDictionary[@"comments"][indexPath.row][@"likes"];
            
            cell.dianzanButton.tag = indexPath.row *100;
            [cell.dianzanButton addTarget:self action:@selector(pressGood:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
        }
    }
    return 0;
}

- (void)pressGood:(UIButton *)buttom {
//    NSLog(@"1");
    replyTableViewCell *cell = (replyTableViewCell *)[_commentTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:buttom.tag / 100 inSection:1]];
    // 切换按钮的选中状态
    cell.dianzanButton.selected = !cell.dianzanButton.isSelected;
    if (cell.dianzanButton.selected == YES) {
        NSString *select = [_commentM incrementStringNumber:cell.likes.text];
        cell.likes.text = select;
    } else {
        NSString *select = [_commentM reduceStringNumber:cell.likes.text];
        cell.likes.text = select;
    }
}

- (void)pressGoodL:(UIButton *)buttom {
    replyTableViewCell *cell = (replyTableViewCell *)[_commentTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:buttom.tag / 1000 inSection:0]];
    // 切换按钮的选中状态
    cell.dianzanButton.selected = !cell.dianzanButton.isSelected;
    if (cell.dianzanButton.selected == YES) {
        NSString *select = [_commentM incrementStringNumber:cell.likes.text];
        cell.likes.text = select;
    } else {
        NSString *select = [_commentM reduceStringNumber:cell.likes.text];
        cell.likes.text = select;
    }
}



@end
