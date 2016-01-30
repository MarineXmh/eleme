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
        [self setBackgroundColor:[UIColor colorWithRed:(61.f / 255.f) green:(61.f / 255.f)  blue:(61.f / 255.f)  alpha:1.0]];
        [self addViews];
    }
    return self;
}

- (void)addViews {
    CGFloat padding = 8;
    
    CGFloat cartButtonWidth = 30;
    CGFloat cartButtonHeight = cartButtonWidth;
    CGFloat cartButtonX = padding * 2;
    CGFloat cartButtonY = (self.frame.size.height - cartButtonHeight) / 2;
    _cartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cartButton.frame = CGRectMake(cartButtonX, cartButtonY, cartButtonWidth, cartButtonHeight);
    [_cartButton setImage:[UIImage imageNamed:@"cart"] forState:UIControlStateNormal];
    [_cartButton setImage:[UIImage imageNamed:@"cart"] forState:UIControlStateDisabled];
    [_cartButton setTintColor:[UIColor whiteColor]];
    [_cartButton addTarget:self action:@selector(cartButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _cartButton.enabled = NO;
    [self addSubview:_cartButton];
    
    CGFloat cartNumberLabelWidth = 15;
    CGFloat cartNumberLabelX = CGRectGetMaxX(self.cartButton.frame) - padding * 2 + 3;
    CGFloat cartNumberLabelY = cartButtonY - 2;
    _cartNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(cartNumberLabelX, cartNumberLabelY, cartNumberLabelWidth, cartNumberLabelWidth)];
    _cartNumberLabel.font = [UIFont systemFontOfSize:10.0];
    [_cartNumberLabel setBackgroundColor:[UIColor redColor]];
    [_cartNumberLabel setTextColor:[UIColor whiteColor]];
    _cartNumberLabel.textAlignment = NSTextAlignmentCenter;
    _cartNumberLabel.layer.cornerRadius = _cartNumberLabel.bounds.size.width / 2;
    _cartNumberLabel.layer.masksToBounds = YES;
    _cartNumberLabel.hidden = YES;
    [self addSubview:_cartNumberLabel];
    
    CGFloat checkOutButtonWidth = 100;
    CGFloat checkOutButtonHeight = self.frame.size.height;
    CGFloat checkOutButtonX = self.frame.size.width - checkOutButtonWidth;
    _checkOutButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _checkOutButton.frame = CGRectMake(checkOutButtonX, 0, checkOutButtonWidth, checkOutButtonHeight);
    [_checkOutButton setBackgroundColor:[UIColor colorWithRed:(86.f / 255.f) green:(209.f / 255.f) blue:(100.f / 255.f) alpha:1.0]];
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
