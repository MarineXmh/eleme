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
    CGFloat padding = 10;
    
    CGFloat foodNameLabelHeight = 20;
    CGFloat foodNameLabelY = (40 - foodNameLabelHeight) / 2;
    CGFloat foodNameLabelWidth = [UIScreen mainScreen].bounds.size.width;
    _foodNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, foodNameLabelY, foodNameLabelWidth, foodNameLabelHeight)];
    [_foodNameLabel setTextColor:[UIColor blackColor]];
    _foodNameLabel.font = [UIFont systemFontOfSize:16.0];
    [self.contentView addSubview:_foodNameLabel];
    
    CGFloat foodNumberLabelHeight = 20;
    CGFloat foodNumberLabelWidth = 30;
    CGFloat foodNumberLabelX = foodNameLabelWidth - foodNumberLabelWidth - padding;
    CGFloat foodNumberLabelY = (40 - foodNumberLabelHeight) / 2;
    _foodNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(foodNumberLabelX, foodNumberLabelY, foodNumberLabelWidth, foodNumberLabelHeight)];
    _foodNumberLabel.font = [UIFont systemFontOfSize:16.0];
    _foodNumberLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_foodNumberLabel];
}

- (void)setFoodNumber:(int)foodNumber {
    _foodNumber = foodNumber;
    self.foodNumberLabel.text = [NSString stringWithFormat:@"× %d", self.foodNumber];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
