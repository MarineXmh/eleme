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
        _indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2, self.contentView.frame.size.height)];
        [_indicatorView setBackgroundColor:[UIColor blueColor]];
        _indicatorView.hidden = YES;
        [self.contentView addSubview: _indicatorView];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_indicatorView.frame) + 8, 8, self.contentView.frame.size.width - CGRectGetMaxX(_indicatorView.frame) - 8, 24)];
        [_nameLabel setTextColor:[UIColor blackColor]];
        _nameLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:_nameLabel];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    if (selected) {
        _indicatorView.hidden = NO;
    } else {
        _indicatorView.hidden = YES;
    }
}

@end
