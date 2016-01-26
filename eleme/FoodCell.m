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
        _foodImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 10, 60, 60)];
        [self.contentView addSubview:_foodImageView];
        
        _foodNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_foodImageView.frame) + 8, 25, self.contentView.frame.size.width - CGRectGetMaxX(_foodImageView.frame) - 8 * 2 , 30)];
        [_foodNameLabel setTextColor:[UIColor blackColor]];
        _foodNameLabel.font = [UIFont systemFontOfSize:16.0];
        [self.contentView addSubview:_foodNameLabel];
        
        _addFoodButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _addFoodButton.frame = CGRectMake(CGRectGetMaxX(self.contentView.frame) - 48, 30, 20, 20);
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
        
        _foodNumber = 0;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
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
    if ([self.delegate respondsToSelector:@selector(addFood)]) {
        [self.delegate addFood];
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
    if ([self.delegate respondsToSelector:@selector(minusFood)]) {
        [self.delegate minusFood];
    }
}

@end
