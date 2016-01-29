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
    }
    return self;
}

- (void)addViews {
    CGFloat padding = 8;
    
    CGFloat indicatorViewHeight = 40;
    _indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2, indicatorViewHeight)];
    [_indicatorView setBackgroundColor:[UIColor blueColor]];
    _indicatorView.hidden = YES;
    [self.contentView addSubview: _indicatorView];
    
    CGFloat nameLabelHeight = 24;
    CGFloat nameLabelWidth = [UIScreen mainScreen].bounds.size.width / 5;
    CGFloat nameLabelX = CGRectGetMaxX(_indicatorView.frame) + padding;
    CGFloat nameLabelY = (indicatorViewHeight - nameLabelHeight) / 2;
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabelX, nameLabelY, nameLabelWidth, nameLabelHeight)];
    [_nameLabel setTextColor:[UIColor blackColor]];
    _nameLabel.font = [UIFont systemFontOfSize:14.0];
    [self.contentView addSubview:_nameLabel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        _indicatorView.hidden = NO;
    } else {
        _indicatorView.hidden = YES;
    }
}

@end
