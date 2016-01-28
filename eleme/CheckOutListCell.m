//
//  CheckOutListCell.m
//  eleme
//
//  Created by Xu Menghua on 16/1/27.
//  Copyright © 2016年 Xu Menghua. All rights reserved.
//

#import "CheckOutListCell.h"

@implementation CheckOutListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addViews];
    }
    return self;
}

- (void)addViews {
    _foodNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.contentView.frame.size.width - 100 , 20)];
    [_foodNameLabel setTextColor:[UIColor blackColor]];
    _foodNameLabel.font = [UIFont systemFontOfSize:16.0];
    [self.contentView addSubview:_foodNameLabel];
    
    _foodNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width - 30, 10, 30, 20)];
    _foodNumberLabel.font = [UIFont systemFontOfSize:16.0];
    _foodNumberLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_foodNumberLabel];
}

- (void)setFoodNumber:(int)foodNumber {
    _foodNumber = foodNumber;
    self.foodNumberLabel.text = [NSString stringWithFormat:@"*%d", self.foodNumber];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
