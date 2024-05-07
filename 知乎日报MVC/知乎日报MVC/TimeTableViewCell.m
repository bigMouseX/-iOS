//
//  TimeTableViewCell.m
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/10/26.
//

#import "TimeTableViewCell.h"

@implementation TimeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textColor = [UIColor grayColor];
    self.timeLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.timeLabel];
    
    
    self.grayLine = [[UILabel alloc] init];
    self.grayLine.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.grayLine];
    return self;
}

- (void)layoutSubviews {
    self.timeLabel.frame = CGRectMake(20, 10, 200, 20);
    self.grayLine.frame = CGRectMake(105, 19.5, self.bounds.size.width - 105, 1);
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
