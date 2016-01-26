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
        [self setButtons];
    }
    return  self;
}

- (void)setButtons {
    _breakfastListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _breakfastListButton.frame = CGRectMake(0, 0, self.frame.size.width / 4, self.frame.size.height - 2);
    [_breakfastListButton setTitle:@"早餐" forState:UIControlStateNormal];
    [_breakfastListButton setTitle:@"早餐" forState:UIControlStateSelected];
    [_breakfastListButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_breakfastListButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [_breakfastListButton addTarget:self action:@selector(selectionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_breakfastListButton];
    
    _launchListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _launchListButton.frame = CGRectMake(CGRectGetMaxX(_breakfastListButton.frame), 0, self.frame.size.width / 4, self.frame.size.height - 2);
    [_launchListButton setTitle:@"午餐" forState:UIControlStateNormal];
    [_launchListButton setTitle:@"午餐" forState:UIControlStateSelected];
    [_launchListButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_launchListButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [_launchListButton addTarget:self action:@selector(selectionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_launchListButton];
    
    _supperListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _supperListButton.frame = CGRectMake(CGRectGetMaxX(_launchListButton.frame), 0, self.frame.size.width / 4, self.frame.size.height - 2);
    [_supperListButton setTitle:@"晚餐" forState:UIControlStateNormal];
    [_supperListButton setTitle:@"晚餐" forState:UIControlStateSelected];
    [_supperListButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_supperListButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [_supperListButton addTarget:self action:@selector(selectionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_supperListButton];
    
    _midnightSnackListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _midnightSnackListButton.frame = CGRectMake(CGRectGetMaxX(_supperListButton.frame), 0, self.frame.size.width / 4, self.frame.size.height - 2);
    [_midnightSnackListButton setTitle:@"夜餐" forState:UIControlStateNormal];
    [_midnightSnackListButton setTitle:@"夜餐" forState:UIControlStateSelected];
    [_midnightSnackListButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_midnightSnackListButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [_midnightSnackListButton addTarget:self action:@selector(selectionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_midnightSnackListButton];
    
    _indicatorBar = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_breakfastListButton.frame), _breakfastListButton.frame.size.width, 2)];
    _indicatorBar.backgroundColor = [UIColor blueColor];
    [self addSubview:_indicatorBar];
    
    _breakfastListButton.selected = YES;
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
