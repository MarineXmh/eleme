//
//  SelectionView.m
//  eleme
//
//  Created by Xu Menghua on 16/1/26.
//  Copyright © 2016年 Xu Menghua. All rights reserved.
//

#import "SelectionView.h"

@implementation SelectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithRed:(246.f / 255.f) green:(246.f / 255.f) blue:(246.f / 255.f) alpha:1.0]];
        [self setButtons];
        self.breakfastListButton.selected = YES;
    }
    return  self;
}

- (void)setButtons {
    CGFloat ButtonWidth = self.frame.size.width / 4;
    CGFloat ButtonHeight = self.frame.size.height - 2;
    CGFloat breakfastListButtonX = 0;
    CGFloat ButtonY = 0;
    _breakfastListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _breakfastListButton.frame = CGRectMake(breakfastListButtonX, ButtonY, ButtonWidth, ButtonHeight);
    [_breakfastListButton setTitle:@"早餐" forState:UIControlStateNormal];
    [_breakfastListButton setTitle:@"早餐" forState:UIControlStateSelected];
    [_breakfastListButton setTitleColor:[UIColor colorWithRed:(102.f / 255.f) green:(102.f / 255.f) blue:(102.f / 255.f) alpha:1.0] forState:UIControlStateNormal];
    [_breakfastListButton setTitleColor:[UIColor colorWithRed:(49.f / 255.f) green:(144.f / 255.f) blue:(232.f / 255.f) alpha:1.0] forState:UIControlStateSelected];
    _breakfastListButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [_breakfastListButton addTarget:self action:@selector(selectionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_breakfastListButton];
    
    CGFloat launchListButtonX = CGRectGetMaxX(_breakfastListButton.frame);
    _launchListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _launchListButton.frame = CGRectMake(launchListButtonX, ButtonY, ButtonWidth, ButtonHeight);
    [_launchListButton setTitle:@"午餐" forState:UIControlStateNormal];
    [_launchListButton setTitle:@"午餐" forState:UIControlStateSelected];
    [_launchListButton setTitleColor:[UIColor colorWithRed:(102.f / 255.f) green:(102.f / 255.f) blue:(102.f / 255.f) alpha:1.0] forState:UIControlStateNormal];
    [_launchListButton setTitleColor:[UIColor colorWithRed:(49.f / 255.f) green:(144.f / 255.f) blue:(232.f / 255.f) alpha:1.0] forState:UIControlStateSelected];
    _launchListButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [_launchListButton addTarget:self action:@selector(selectionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_launchListButton];
    
    CGFloat supperListButtonX = CGRectGetMaxX(_launchListButton.frame);
    _supperListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _supperListButton.frame = CGRectMake(supperListButtonX, ButtonY, ButtonWidth, ButtonHeight);
    [_supperListButton setTitle:@"晚餐" forState:UIControlStateNormal];
    [_supperListButton setTitle:@"晚餐" forState:UIControlStateSelected];
    [_supperListButton setTitleColor:[UIColor colorWithRed:(102.f / 255.f) green:(102.f / 255.f) blue:(102.f / 255.f) alpha:1.0] forState:UIControlStateNormal];
    [_supperListButton setTitleColor:[UIColor colorWithRed:(49.f / 255.f) green:(144.f / 255.f) blue:(232.f / 255.f) alpha:1.0] forState:UIControlStateSelected];
    _supperListButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [_supperListButton addTarget:self action:@selector(selectionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_supperListButton];
    
    CGFloat midnightSnackListButtonX = CGRectGetMaxX(_supperListButton.frame);
    _midnightSnackListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _midnightSnackListButton.frame = CGRectMake(midnightSnackListButtonX, ButtonY, ButtonWidth, ButtonHeight);
    [_midnightSnackListButton setTitle:@"夜餐" forState:UIControlStateNormal];
    [_midnightSnackListButton setTitle:@"夜餐" forState:UIControlStateSelected];
    [_midnightSnackListButton setTitleColor:[UIColor colorWithRed:(102.f / 255.f) green:(102.f / 255.f) blue:(102.f / 255.f) alpha:1.0] forState:UIControlStateNormal];
    [_midnightSnackListButton setTitleColor:[UIColor colorWithRed:(49.f / 255.f) green:(144.f / 255.f) blue:(232.f / 255.f) alpha:1.0] forState:UIControlStateSelected];
    _midnightSnackListButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [_midnightSnackListButton addTarget:self action:@selector(selectionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_midnightSnackListButton];
    
    _seperateLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, 0.5)];
    _seperateLineView.backgroundColor = [UIColor colorWithRed:(220.f / 255.f) green:(220.f / 255.f) blue:(220.f / 255.f) alpha:1.0];
    [self addSubview:_seperateLineView];
    
    _indicatorBar = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_breakfastListButton.frame), _breakfastListButton.frame.size.width, 3)];
    _indicatorBar.backgroundColor = [UIColor colorWithRed:(49.f / 255.f) green:(144.f / 255.f) blue:(232.f / 255.f) alpha:1.0];
    [self addSubview:_indicatorBar];
}

- (void)selectionButtonClick:(UIButton *)button {
    self.breakfastListButton.selected = NO;
    self.launchListButton.selected = NO;
    self.supperListButton.selected = NO;
    self.midnightSnackListButton.selected = NO;
    button.selected = YES;
    [UIView animateWithDuration:0.2 animations:^{
        self.indicatorBar.frame = CGRectMake(button.frame.origin.x, CGRectGetMaxY(button.frame), button.frame.size.width, 2);
    }];
    if ([self.delegate respondsToSelector:@selector(selectionChanged:)]) {
        [self.delegate selectionChanged:button];
    }
}

@end
