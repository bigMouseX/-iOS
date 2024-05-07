//
//  CollectionTableViewCell.m
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/11/11.
//

#import "CollectionTableViewCell.h"

@implementation CollectionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    self.articleImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.articleImageView];
    
    self.articleBigLabel = [[UILabel alloc] init];
    self.articleBigLabel.font = [UIFont boldSystemFontOfSize:19];
    self.articleBigLabel.numberOfLines = 2;
    self.articleBigLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.articleBigLabel];

    
    return self;
}

- (void)layoutSubviews {
    self.articleBigLabel.frame = CGRectMake(20, 20, 250, 75);
    self.articleImageView.frame = CGRectMake(self.frame.size.width - 100, 20, 90, 85);

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
