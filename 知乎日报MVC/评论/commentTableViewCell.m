//
//  commentTableViewCell.m
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/11/5.
//

#import "commentTableViewCell.h"
#import "Masonry.h"
#define SIZE_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SIZE_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@implementation commentTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ([self.reuseIdentifier isEqualToString:@"CommentCell"]) {
        _commentHeadPhotoImageView = [[UIImageView alloc] init];
        _commentHeadPhotoImageView.layer.masksToBounds = YES;
        [_commentHeadPhotoImageView.layer setCornerRadius:SIZE_WIDTH * 0.045];
        [self.contentView addSubview:_commentHeadPhotoImageView];

        _nameLabel = [[UILabel alloc] init];
        [_nameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15.5]];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_nameLabel];

        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:15.5];
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.numberOfLines = 0;
        _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:_contentLabel];

        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textColor = [UIColor lightGrayColor]; // Fix here
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_timeLabel];
        
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_lineLabel];

        _dianzanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dianzanButton setImage:[UIImage imageNamed:@"dianzan_zhihu1.png"] forState:UIControlStateNormal];
        [_dianzanButton setImage:[UIImage imageNamed:@"dianzan_zhihu2.png"] forState:UIControlStateSelected];
        [self.contentView addSubview:_dianzanButton];
        
        _likes = [[UILabel alloc] init];
        _likes.font = [UIFont systemFontOfSize:16];
        _likes.textColor = [UIColor grayColor];
        _likes.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_likes];

        _pinglunButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pinglunButton setImage:[UIImage imageNamed:@"pinglun_zhihu.png"] forState:UIControlStateNormal];
        [self.contentView addSubview:_pinglunButton];

        [_commentHeadPhotoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@15);
            make.left.equalTo(@20);
            make.width.equalTo(@(SIZE_WIDTH * 0.09));
            make.height.equalTo(@(SIZE_WIDTH * 0.09));
        }];

        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_commentHeadPhotoImageView.mas_top).offset(5);
            make.left.equalTo(_commentHeadPhotoImageView.mas_right).offset(14);
            make.width.equalTo(@200);
            make.height.equalTo(@(0.05 * SIZE_WIDTH));
        }];
//
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_lineLabel.mas_top).offset(-20);
            make.left.equalTo(_nameLabel.mas_left);
            make.height.equalTo(@(SIZE_WIDTH * 0.05));
        }];


        [_lineLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.left.equalTo(@0);
            make.width.equalTo(@(SIZE_WIDTH));
            make.height.equalTo(@0.2);
        }];

        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
//            make.bottom.equalTo(self.timeLabel.mas_top).offset(-20);
            make.bottom.equalTo(self.timeLabel.mas_top).offset(-20);
            make.left.equalTo(self.nameLabel.mas_left);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
        }];

        //通过_contentLabel将_nameLabel与_timeLabel撑开从而使其隔开

        [_dianzanButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_timeLabel.mas_bottom);
            make.height.equalTo(@(SIZE_WIDTH * 0.05));
            make.right.equalTo(self.contentView.mas_right).offset(-80);
            make.width.equalTo(@(SIZE_WIDTH * 0.05));
        }];
        
        [_likes mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self->_timeLabel.mas_bottom).offset(2);
            make.height.equalTo(@(SIZE_WIDTH * 0.05));
            make.right.equalTo(self->_dianzanButton.mas_left);
            make.width.equalTo(@(SIZE_WIDTH * 0.05));
        }];

        [_pinglunButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_timeLabel.mas_bottom);
            make.height.equalTo(@(SIZE_WIDTH * 0.05));
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.width.equalTo(@(SIZE_WIDTH * 0.05));
        }];

        
    }
    
    return self;
}
    


@end
