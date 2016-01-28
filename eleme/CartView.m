//
//  CartView.m
//  eleme
//
//  Created by Xu Menghua on 16/1/26.
//  Copyright © 2016年 Xu Menghua. All rights reserved.
//

#import "CartView.h"

@implementation CartView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor darkGrayColor]];
        [self addViews];
    }
    return self;
}

- (void)addViews {
    _cartButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _cartButton.frame = CGRectMake(8, 5, 40, 40);
    [_cartButton setImage:[UIImage imageNamed:@"e_no_cart"] forState:UIControlStateNormal];
    [_cartButton setTintColor:[UIColor whiteColor]];
    [_cartButton addTarget:self action:@selector(cartButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _cartButton.enabled = NO;
    [self addSubview:_cartButton];
    
    _cartNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(32, 6, 15, 15)];
    _cartNumberLabel.font = [UIFont systemFontOfSize:10.0];
    [_cartNumberLabel setBackgroundColor:[UIColor redColor]];
    [_cartNumberLabel setTextColor:[UIColor whiteColor]];
    _cartNumberLabel.textAlignment = NSTextAlignmentCenter;
    _cartNumberLabel.layer.cornerRadius = _cartNumberLabel.bounds.size.width / 2;
    _cartNumberLabel.layer.masksToBounds = YES;
    _cartNumberLabel.hidden = YES;
    [self addSubview:_cartNumberLabel];
    
    _checkOutButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _checkOutButton.frame = CGRectMake(self.frame.size.width - 100, 0, 100, self.frame.size.height);
    [_checkOutButton setBackgroundColor:[UIColor colorWithRed:(100.f / 255.f) green:(225.f / 255.f) blue:(100.f / 255.f) alpha:1.0]];
    [_checkOutButton setTitle:@"去结算" forState:UIControlStateNormal];
    _checkOutButton.titleLabel.font = [UIFont systemFontOfSize:20.0];
    [_checkOutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_checkOutButton addTarget:self action:@selector(checkOutButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _checkOutButton.hidden = YES;
    [self addSubview:_checkOutButton];
    
    _foodNumber = 0;
}

- (void)setFoodNumber:(int)foodNumber {
    _foodNumber = foodNumber;
    self.cartNumberLabel.text = [NSString stringWithFormat:@"%d", _foodNumber];
    if (_foodNumber > 0) {
        self.cartNumberLabel.hidden = NO;
        self.checkOutButton.hidden = NO;
    } else {
        self.cartNumberLabel.hidden = YES;
        self.checkOutButton.hidden = YES;
    }
}

- (void)cartButtonClick:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(showCart)]) {
        [self.delegate showCart];
    }
}

- (void)checkOutButtonClick:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(checkOut)]) {
        [self.delegate checkOut];
    }
}

@end
