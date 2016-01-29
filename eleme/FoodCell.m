//
//  FoodCell.m
//  eleme
//
//  Created by Xu Menghua on 16/1/26.
//  Copyright © 2016年 Xu Menghua. All rights reserved.
//

#import "FoodCell.h"

@implementation FoodCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addViews];
    }
    return self;
}

- (void)addViews {
    CGFloat padding = 8;
    
    CGFloat foodImageViewWidth = 60;
    CGFloat foodImageViewHeight = 60;
    CGFloat foodImageViewY = (80 - foodImageViewHeight) / 2;
    _foodImageView = [[UIImageView alloc] initWithFrame:CGRectMake(padding, foodImageViewY, foodImageViewWidth, foodImageViewHeight)];
    [self.contentView addSubview:_foodImageView];
    
    CGFloat foodNameLabelWidth =  self.contentView.frame.size.width;
    CGFloat foodNameLabelHeight = 30;
    CGFloat foodNameLabelX = CGRectGetMaxX(_foodImageView.frame) + padding;
    CGFloat foodNameLabelY = (80 - foodNameLabelHeight) / 2;
    _foodNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(foodNameLabelX, foodNameLabelY, foodNameLabelWidth, foodNameLabelHeight)];
    [_foodNameLabel setTextColor:[UIColor blackColor]];
    _foodNameLabel.font = [UIFont systemFontOfSize:16.0];
    [self.contentView addSubview:_foodNameLabel];
    
    CGFloat addFoodButtonWidth = 30;
    CGFloat addFoodButtonHeight = addFoodButtonWidth;
    CGFloat addFoodButtonX = [UIScreen mainScreen].bounds.size.width / 5 * 4 - addFoodButtonWidth - padding;
    CGFloat addFoodButtonY = (80 - addFoodButtonHeight) / 2;
    _addFoodButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _addFoodButton.frame = CGRectMake(addFoodButtonX, addFoodButtonY, addFoodButtonWidth, addFoodButtonHeight);
    [_addFoodButton setImage:[UIImage imageNamed:@"cart_add"] forState:UIControlStateNormal];
    [_addFoodButton addTarget:self action:@selector(addFoodButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_addFoodButton];
    
    _minusFoodButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _minusFoodButton.frame = _addFoodButton.frame;
    [_minusFoodButton setImage:[UIImage imageNamed:@"cart_minus"] forState:UIControlStateNormal];
    [self.contentView addSubview:_minusFoodButton];
    [_minusFoodButton addTarget:self action:@selector(minusFoodButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _minusFoodButton.hidden = YES;
    
    CGFloat foodNumberLabelWidth = 20;
    CGFloat foodNumberLabelHeight = 30;
    _foodNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(addFoodButtonX - foodNumberLabelWidth, addFoodButtonY, foodNumberLabelWidth, foodNumberLabelHeight)];
    _foodNumberLabel.font = [UIFont systemFontOfSize:14.0];
    _foodNumberLabel.textAlignment = NSTextAlignmentCenter;
    _foodNumberLabel.hidden = YES;
    [self.contentView addSubview:_foodNumberLabel];
    
    _foodNumber = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setFoodNumber:(int)foodNumber {
    _foodNumber = foodNumber;
    if (self.foodNumber > 0) {
        self.foodNumberLabel.text = [NSString stringWithFormat:@"%d", self.foodNumber];
        self.foodNumberLabel.hidden = NO;
        self.minusFoodButton.hidden = NO;
        CGFloat minusFoodButtonWidth = 30;
        CGFloat minusFoodButtonHeight = minusFoodButtonWidth;
        self.minusFoodButton.frame = CGRectMake(self.foodNumberLabel.frame.origin.x - minusFoodButtonWidth, self.addFoodButton.frame.origin.y, minusFoodButtonWidth, minusFoodButtonHeight);
    } else {
        self.foodNumberLabel.text = [NSString stringWithFormat:@"%d", self.foodNumber];
        self.foodNumberLabel.hidden = YES;
        self.minusFoodButton.frame = self.addFoodButton.frame;
        self.minusFoodButton.hidden = YES;
    }
}

- (void)addFoodButtonClick:(UIButton *)button {
    self.foodNumber++;
    if (self.foodNumber > 0) {
        self.foodNumberLabel.text = [NSString stringWithFormat:@"%d", self.foodNumber];
        self.foodNumberLabel.hidden = NO;
        [UIView animateWithDuration:0.2 animations:^{
            self.minusFoodButton.hidden = NO;
            CGFloat minusFoodButtonWidth = 30;
            CGFloat minusFoodButtonHeight = minusFoodButtonWidth;
            self.minusFoodButton.frame = CGRectMake(self.foodNumberLabel.frame.origin.x - minusFoodButtonWidth, self.addFoodButton.frame.origin.y, minusFoodButtonWidth, minusFoodButtonHeight);
        }];
    }
    if ([self.delegate respondsToSelector:@selector(addFood:)]) {
        [self.delegate addFood:self];
    }
}

- (void)minusFoodButtonClick:(UIButton *)button {
    self.foodNumber--;
    self.foodNumberLabel.text = [NSString stringWithFormat:@"%d", self.foodNumber];
    if (self.foodNumber < 1) {
        self.foodNumberLabel.hidden = YES;
        [UIView animateWithDuration:0.2 animations:^{
            self.minusFoodButton.frame = self.addFoodButton.frame;
        } completion:^(BOOL finished) {
            self.minusFoodButton.hidden = YES;
        }];
    }
    if ([self.delegate respondsToSelector:@selector(minusFood:)]) {
        [self.delegate minusFood:self];
    }
}

@end
