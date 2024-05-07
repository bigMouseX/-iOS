//
//  ArticleTableViewCell.m
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/10/25.
//

#import "ArticleTableViewCell.h"

@implementation ArticleTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    self.articleImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.articleImageView];
    
    self.articleBigLabel = [[UILabel alloc] init];
    self.articleBigLabel.font = [UIFont boldSystemFontOfSize:19];
    self.articleBigLabel.numberOfLines = 2;
    self.articleBigLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.articleBigLabel];

    self.articleSmallLabel = [[UILabel alloc] init];
    self.articleSmallLabel.font = [UIFont boldSystemFontOfSize:15];
    self.articleSmallLabel.textColor = [UIColor systemGrayColor];
    [self.contentView addSubview:self.articleSmallLabel];
    
    NSLog(@"init");
    
    return self;
}

- (void)layoutSubviews {
    self.articleBigLabel.frame = CGRectMake(20, 20, 250, 50);
    self.articleSmallLabel.frame = CGRectMake(20, 70, 250, 25);
    self.articleImageView.frame = CGRectMake(self.frame.size.width - 100, 20, 90, 85);

}

@end
