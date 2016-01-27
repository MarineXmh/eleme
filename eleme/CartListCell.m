//
//  CartListCell.m
//  eleme
//
//  Created by Xu Menghua on 16/1/27.
//  Copyright © 2016年 Xu Menghua. All rights reserved.
//

#import "CartListCell.h"

@implementation CartListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _foodNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, self.contentView.frame.size.width - 150 , 30)];
        [_foodNameLabel setTextColor:[UIColor blackColor]];
        _foodNameLabel.font = [UIFont systemFontOfSize:16.0];
        [self.contentView addSubview:_foodNameLabel];
        
        _addFoodButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _addFoodButton.frame = CGRectMake(CGRectGetMaxX(self.contentView.frame), 15, 20, 20);
        [_addFoodButton setImage:[UIImage imageNamed:@"cart_add"] forState:UIControlStateNormal];
        [_addFoodButton addTarget:self action:@selector(addFoodButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_addFoodButton];
        
        _minusFoodButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _minusFoodButton.frame = _addFoodButton.frame;
        [_minusFoodButton setImage:[UIImage imageNamed:@"cart_minus"] forState:UIControlStateNormal];
        [self.contentView addSubview:_minusFoodButton];
        [_minusFoodButton addTarget:self action:@selector(minusFoodButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _minusFoodButton.hidden = YES;
        
        _foodNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(_addFoodButton.frame.origin.x - 8 - 20, _addFoodButton.frame.origin.y, 20, 20)];
        _foodNumberLabel.font = [UIFont systemFontOfSize:16.0];
        _foodNumberLabel.textAlignment = NSTextAlignmentCenter;
        _foodNumberLabel.hidden = YES;
        [self.contentView addSubview:_foodNumberLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setFoodNumber:(int)foodNumber {
    _foodNumber = foodNumber;
    if (self.foodNumber > 0) {
        self.foodNumberLabel.text = [NSString stringWithFormat:@"%d", self.foodNumber];
        self.foodNumberLabel.hidden = NO;
        self.minusFoodButton.hidden = NO;
        self.minusFoodButton.frame = CGRectMake(self.foodNumberLabel.frame.origin.x - 8 - 20, self.addFoodButton.frame.origin.y, 20, 20);
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
            self.minusFoodButton.frame = CGRectMake(self.foodNumberLabel.frame.origin.x - 8 - 20, self.addFoodButton.frame.origin.y, 20, 20);
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
