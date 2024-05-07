//
//  View.m
//  知乎日报MVC
//
//  Created by 夏楠 on 2023/10/23.
//

#import "View.h"
#import "ViewController.h"
#define SIZE_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SIZE_HEIGHT ([UIScreen mainScreen].bounds.size.height)

long pastData = 0;

@implementation View

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    
    self.Date = [[UILabel alloc] init];
    self.Date.font = [UIFont systemFontOfSize:20];
    self.Date.frame = CGRectMake(15, 56, 30, 20);
    self.Date.textAlignment = NSTextAlignmentCenter; // 水平居中对齐
    [self addSubview:self.Date];
    
    self.Month = [[UILabel alloc] init];
    self.Month.frame = CGRectMake(15, 25 + 56, 35, 13);
    self.Month.font = [UIFont systemFontOfSize:10];
    self.Month.textAlignment = NSTextAlignmentCenter; // 水平居中对齐
    [self addSubview:self.Month];

    self.Tip = [[UILabel alloc] init];
    self.Tip.frame = CGRectMake(70, 5 + 54, 100, 30);
    self.Tip.font = [UIFont systemFontOfSize:23];
    [self addSubview:self.Tip];

    self.Line = [UIImage imageNamed:@"home_line2.png"];
    self.LineView = [[UIImageView alloc] initWithFrame:CGRectMake(55, 2 + 56, 1, 34)];
    self.LineView.image = self.Line;
    [self addSubview:self.LineView];
    
    self.btn_head = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn_head setImage:[UIImage imageNamed:@"zhihugou.jpg"] forState:UIControlStateNormal];
    self.btn_head.frame = CGRectMake(380 - 34, 2 + 55, 32, 32);
    self.btn_head.backgroundColor = [UIColor whiteColor];
    self.btn_head.layer.cornerRadius = self.btn_head.frame.size.width / 2;
    self.btn_head.layer.masksToBounds = YES;
    self.btn_head.clipsToBounds = YES;
    [self addSubview:self.btn_head];
    
    self.pastArray = [[NSMutableArray alloc] init];
    self.pastTimeArray = [[NSMutableArray alloc] init];
    self.allArray = [[NSMutableArray alloc] init];

    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleLarge)];
    //设置小菊花颜色
    self.activityIndicator.color = [UIColor blackColor];
    //设置背景颜色
    self.activityIndicator.backgroundColor = [UIColor clearColor];

//    [_tableView reloadData];
    //------------------------------主页视图---------------------------------
    
    
    
    //接收通知传回的数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveJSONModel:) name:@"postJSONModel" object:nil];
    
//    NSLog(@"%@11", _viewModelDictionary);
    

    return self;
}


- (void)receiveJSONModel:(NSNotification *)send {
    _viewModelDictionary = [send.userInfo copy];

    [self addTableView];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        ScrollTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"scroller" forIndexPath:indexPath];
        
        CGFloat imageViewWidth1 = [UIScreen mainScreen].bounds.size.width;
        CGFloat imageViewHeight1 = 360;
        
        // 遍历添加图片视图
        for (int i = 0; i < 7; i++) {
            NSString *imageURL = self.viewModelDictionary[@"top_stories"][i % 5][@"image"];
            self.topImageView = [[UIImageView alloc] init];
            [self.topImageView sd_setImageWithURL:[NSURL URLWithString:imageURL]];
            // image点击事件
            // 设置tag 值
            [self.topImageView setUserInteractionEnabled: YES];
            [_topImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressImage:)]];
            _topImageView.tag = i;

            //实现图片颜色渐变
            UIImageView* imageview = [[UIImageView alloc] init];
            NSURL *imageUrl = [NSURL URLWithString:imageURL];
            UIImage *homeScrollImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
            imageview.frame = CGRectMake(0, 180, SIZE_WIDTH, 180);
            [self.topImageView addSubview:imageview];
            [self gradientView:imageview :homeScrollImage];
            
            self.topBigLabel = [[UILabel alloc] init];
            self.topBigLabel.textColor = [UIColor whiteColor];
            self.topBigLabel.numberOfLines = 2;
            self.topBigLabel.textAlignment = NSTextAlignmentLeft;
            self.topBigLabel.font = [UIFont boldSystemFontOfSize:25];
            self.topBigLabel.text =  self.viewModelDictionary[@"top_stories"][i % 5][@"title"];
            
            self.topSmallLabel = [[UILabel alloc] init];
            self.topSmallLabel.textColor = [UIColor systemGrayColor];
            self.topSmallLabel.textAlignment = NSTextAlignmentLeft;
            self.topSmallLabel.font = [UIFont boldSystemFontOfSize:15];
            self.topSmallLabel.text =  self.viewModelDictionary[@"top_stories"][i % 5][@"hint"];

            if (i == 6) {
                self.topImageView.frame = CGRectMake(0, 0, imageViewWidth1, imageViewHeight1);
                [self.topImageView sd_setImageWithURL:[NSURL URLWithString:self.viewModelDictionary[@"top_stories"][4][@"image"]]];
                self.topBigLabel.frame = CGRectMake(20, 240, imageViewWidth1 - 40, 80);
                self.topBigLabel.text = self.viewModelDictionary[@"top_stories"][4][@"title"];
            } else {
                self.topImageView.frame = CGRectMake(imageViewWidth1 * (i + 1), 0, imageViewWidth1, imageViewHeight1);
                self.topBigLabel.frame = CGRectMake(imageViewWidth1 * (i + 1) + 20, 240, imageViewWidth1 - 40, 80);
                self.topSmallLabel.frame = CGRectMake(imageViewWidth1 * (i + 1) + 20, 320, imageViewWidth1 - 40, 20);
                
            }
            
            [cell.scrollView addSubview:self.topImageView];
            [cell.scrollView addSubview:self.topBigLabel];
            [cell.scrollView addSubview:self.topSmallLabel];

        }
        
        return cell;
    }
    else if (indexPath.section == 1) {
        ArticleTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"article" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        
        
        cell.articleBigLabel.text = self.viewModelDictionary[@"stories"][indexPath.row][@"title"];
        cell.articleSmallLabel.text = self.viewModelDictionary[@"stories"][indexPath.row][@"hint"];
        NSString *imageURL = self.viewModelDictionary[@"stories"][indexPath.row][@"images"][0];

        [cell.articleImageView sd_setImageWithURL:[NSURL URLWithString:imageURL]];
//        NSLog(@"%@", imageURL);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        if (indexPath.row == 0) {
            TimeTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"time" forIndexPath:indexPath];
            if (cell == nil) {
                cell = [[TimeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"time"];
            }
            cell.backgroundColor = [UIColor whiteColor];
            cell.timeLabel.text = self.pastTimeArray[indexPath.section - 2];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;
        } else {
            ArticleTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"article" forIndexPath:indexPath];
            if (cell == nil) {
                cell = [[ArticleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"article"];
            }
            cell.backgroundColor = [UIColor whiteColor];
            cell.articleBigLabel.text = self.allArray[indexPath.section - 1][@"stories"][indexPath.row - 1][@"title"];
            cell.articleSmallLabel.text = self.allArray[indexPath.section - 1][@"stories"][indexPath.row - 1][@"hint"];
            NSString *imageURL = self.allArray[indexPath.section - 1][@"stories"][indexPath.row - 1][@"images"][0];
            [cell.articleImageView sd_setImageWithURL:[NSURL URLWithString:imageURL]];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;
        }
    }

        
    
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    NSLog(@"%ld..", pastData);
    return 2 + pastData;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"调用heightForRowAtIndexPath %@", indexPath);
    if (indexPath.section == 0) {
        return 360;
    } else if (indexPath.section == 1){
        return 120;
    } else {
        if (indexPath.row == 0) {
            return 40;
        } else {
            return 120;
        }
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    else if (section == 1){
        return [self.viewModelDictionary[@"stories"] count];
    } else {
        return ([self.allArray[section - 1][@"stories"] count] + 1);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if ( (indexPath.section != 0 && (indexPath.row % 7 != 0)) || (indexPath.section == 1 && indexPath.row == 0) ) {
        if (indexPath.section == 1) {
            NSInteger nowCell = indexPath.row + 5;
            [_delegateCell returnImageTag:nowCell];
            NSLog(@"sectionOne nowCell = %ld", nowCell);
        } else {
            NSInteger nowCell = 5 * (indexPath.section) + (indexPath.row - 1);
//            NSLog(@"sectionTwo nowCell = %ld", nowCell);
            [_delegateCell returnImageTag:nowCell];
            NSLog(@"sectionTwo nowCell = %ld", nowCell);
        }
    }
}

- (void)addTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    _tableView.showsVerticalScrollIndicator = NO;
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.equalTo(@100);
        make.left.equalTo(@0);
        make.width.equalTo(@SIZE_WIDTH);
        make.height.equalTo(@(SIZE_HEIGHT - 100));
    }];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIColor *wechatBackgroundColor = [UIColor colorWithRed:(CGFloat)0xF7/255.0 green:(CGFloat)0xF7/255.0 blue:(CGFloat)0xF7/255.0 alpha:1.0];
    self.tableView.backgroundColor = wechatBackgroundColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self addSubview:_tableView]; // 将表格视图添加到 View 上
    [_tableView registerClass:[ScrollTableViewCell class] forCellReuseIdentifier:@"scroller"];
    [_tableView registerClass:[ArticleTableViewCell class] forCellReuseIdentifier:@"article"];
    [_tableView registerClass:[TimeTableViewCell class] forCellReuseIdentifier:@"time"];


}

- (UIColor*)mostColor:(UIImage*) Image{
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    //第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
    CGSize thumbSize = CGSizeMake(Image.size.width / 10, Image.size.height / 10);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 thumbSize.width,
                                                 thumbSize.height,
                                                 8,//bits per component
                                                 thumbSize.width * 4,
                                                 colorSpace,
                                                 bitmapInfo);
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, Image.CGImage);
    CGColorSpaceRelease(colorSpace);
    //第二步 取每个点的像素值
    unsigned char* data = CGBitmapContextGetData (context);
    if (data == NULL) {
        return nil;
    }
    NSCountedSet *cls = [NSCountedSet setWithCapacity:thumbSize.width * thumbSize.height];
    for (int x = 0; x < thumbSize.width; x++) {
        for (int y = 0; y < thumbSize.height * 0.5; y++) {
            int offset = 4*(x*y);
            int red = data[offset];
            int green = data[offset + 1];
            int blue = data[offset + 2];
            int alpha =  data[offset + 3];
            if (red > 240 || green > 240 || blue > 240) {
                
            } else if (alpha <= 0) {
                
            } else {
                NSArray *clr = @[@(red), @(green), @(blue), @(alpha)];
                [cls addObject:clr];
            }
            
        }
    }
    CGContextRelease(context);
    //第三步 找到出现次数最多的那个颜色
    NSEnumerator *enumerator = [cls objectEnumerator];
    NSArray *curColor = nil;
    NSArray *MaxColor=nil;
    NSUInteger MaxCount=0;
    while ( (curColor = [enumerator nextObject]) != nil ) {
        NSUInteger tmpCount = [cls countForObject:curColor];
        if ( tmpCount < MaxCount ) continue;
        MaxCount=tmpCount;
        MaxColor=curColor;
    }
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
    
}
- (void)gradientView:(UIView *)theView :(UIImage*) Image {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = theView.bounds;
    gradient.colors = [NSMutableArray arrayWithObjects:
                       (id)[UIColor clearColor].CGColor,
                       (id)[self mostColor:Image].CGColor,
                       (id)[self mostColor:Image].CGColor,
                       nil];
    //（0，0）表示从左上角开始变化。默认值是(0.5,0.0)表示从x轴为中间，y为顶端的开始变化
    gradient.startPoint = CGPointMake(0.5, 0.0);
    //（1，1）表示到右下角变化结束。默认值是(0.5,1.0)表示从x轴为中间，y为低端的结束变化
    gradient.endPoint = CGPointMake(0.5, 1.0);
    [theView.layer insertSublayer:gradient atIndex:0];
}

-(void)unselectCell:(id)sender{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    }

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    // 用户结束拖拽手势
    if (self.tableView.contentOffset.y + self.tableView.frame.size.height >= self.tableView.contentSize.height) {
//        self.backgroundColor = [UIColor whiteColor];
        [self showLoadMoreView];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reNew" object:nil userInfo:nil];
//        NSLog(@"%d", ([self.viewModelDictionary[@"stories"] count] + 1) * pastData);
//        [_tableView reloadData];
    }
}

- (void)showLoadMoreView {
    // 创建和配置加载动画视图
    self.activityIndicator.frame = CGRectMake(0, 0, 320, 33);
    self.activityIndicator.tag = 123; // 设置一个标记以便后续移除
    [self.activityIndicator startAnimating];
    // 将加载动画视图添加到UIScrollView的底部
    self.tableView.tableFooterView = self.activityIndicator;
}

- (void)hideLoadMoreView {
    // 停止加载动画
    UIActivityIndicatorView *activityIndicator = [self.tableView.tableFooterView viewWithTag:123];
    [activityIndicator stopAnimating];
    
    // 隐藏加载动画视图
    self.tableView.tableFooterView = nil;
}

- (void)pressImage:(UITapGestureRecognizer*)gesTrueRecognizer {
    NSInteger nowTag = gesTrueRecognizer.view.tag;
    if (nowTag == 0) {
        [_delegateCell returnImageTag:0];
    }  else {
//        NSLog(@"fuck");
        [_delegateCell returnImageTag:nowTag];
    }
}

@end
