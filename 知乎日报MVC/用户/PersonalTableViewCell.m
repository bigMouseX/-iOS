//
//  PersonalTableViewCell.m
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/11/10.
//

#import "PersonalTableViewCell.h"

@implementation PersonalTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    _content = [[UILabel alloc] init];
    _content.textColor = [UIColor lightGrayColor];
    _content.font = [UIFont systemFontOfSize:15];
    _content.frame = CGRectMake(13, 4, 100, 42);
    [self.contentView addSubview:_content];
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
