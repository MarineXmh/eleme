//
//  IndexCell.m
//  eleme
//
//  Created by Xu Menghua on 16/1/26.
//  Copyright © 2016年 Xu Menghua. All rights reserved.
//

#import "IndexCell.h"

@implementation IndexCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setBackgroundColor:[UIColor colorWithRed:(238.f / 255.f) green:(238.f / 255.f) blue:(238.f / 255.f) alpha:1.0]];
    }
    return self;
}

- (void)addViews {
    CGFloat padding = 16;
    
    CGFloat indicatorViewHeight = 60;
    _indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 4, indicatorViewHeight)];
    [_indicatorView setBackgroundColor:[UIColor colorWithRed:(49.f / 255.f) green:(144.f / 255.f) blue:(232.f / 255.f) alpha:1.0]];
    _indicatorView.hidden = YES;
    [self.contentView addSubview: _indicatorView];
    
    CGFloat nameLabelHeight = 40;
    CGFloat nameLabelWidth = [UIScreen mainScreen].bounds.size.width / 5;
    CGFloat nameLabelX = CGRectGetMaxX(_indicatorView.frame) + padding;
    CGFloat nameLabelY = (indicatorViewHeight - nameLabelHeight) / 2;
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabelX, nameLabelY, nameLabelWidth, nameLabelHeight)];
    [_nameLabel setTextColor:[UIColor blackColor]];
    _nameLabel.font = [UIFont systemFontOfSize:14.0];
    [_nameLabel setTextColor:[UIColor colorWithRed:(102.f / 255.f) green:(102.f / 255.f) blue:(102.f / 255.f) alpha:1.0]];
    [self.contentView addSubview:_nameLabel];
    
    UIView *seperateLineView = [[UIView alloc] initWithFrame:CGRectMake(0, indicatorViewHeight - 0.5, [UIScreen mainScreen].bounds.size.width / 5, 0.5)];
    [seperateLineView setBackgroundColor:[UIColor colorWithRed:(215.f / 255.f) green:(215.f / 255.f) blue:(215.f / 255.f) alpha:1.0]];
    [self.contentView addSubview:seperateLineView];
    
    self.seperateLineOnTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width / 5, 0.5)];
    [self.seperateLineOnTopView setBackgroundColor:[UIColor colorWithRed:(215.f / 255.f) green:(215.f / 255.f) blue:(215.f / 255.f) alpha:1.0]];
    [self.contentView addSubview:self.seperateLineOnTopView];
    self.seperateLineOnTopView.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        _indicatorView.hidden = NO;
        [self setBackgroundColor:[UIColor whiteColor]];
    } else {
        _indicatorView.hidden = YES;
        [self setBackgroundColor:[UIColor colorWithRed:(238.f / 255.f) green:(238.f / 255.f) blue:(238.f / 255.f) alpha:1.0]];
    }
}

@end
