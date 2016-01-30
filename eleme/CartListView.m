//
//  CartListView.m
//  eleme
//
//  Created by Xu Menghua on 16/1/27.
//  Copyright © 2016年 Xu Menghua. All rights reserved.
//

#import "CartListView.h"

@implementation CartListView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
    }
    return self;
}

- (void)addViews {
    CGFloat topBarViewHeight = 40;
    self.topBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, topBarViewHeight)];
    [self.topBarView setBackgroundColor:[UIColor colorWithRed:(230.f / 255.f) green:(230.f / 255.f) blue:(230.f / 255.f) alpha:1.0]];
    [self addSubview:self.topBarView];
    
    self.listNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, self.topBarView.frame.size.width / 5 * 3, self.topBarView.frame.size.height)];
    self.listNameLabel.font = [UIFont systemFontOfSize:16.0];
    [self.listNameLabel setTextColor:[UIColor colorWithRed:(102.f / 255.f) green:(102.f / 255.f) blue:(102.f / 255.f) alpha:1.0]];
    self.listNameLabel.text = @"已点菜单";
    [self.topBarView addSubview:self.listNameLabel];
    
    UIView *stickView = [[UIView alloc] initWithFrame:CGRectMake(8, 10, 3, 20)];
    [stickView setBackgroundColor:[UIColor colorWithRed:(49.f / 255.f) green:(144.f / 255.f) blue:(232.f / 255.f) alpha:1.0]];
    [self.topBarView addSubview:stickView];
    
    CGFloat clearButtonWidth = 30;
    CGFloat clearButtonHeight = clearButtonWidth;
    self.clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.clearButton.frame = CGRectMake(self.topBarView.frame.size.width - 48, (self.topBarView.frame.size.height - clearButtonHeight) / 2, clearButtonWidth, clearButtonHeight);
    [self.clearButton setTitle:@"清空" forState:UIControlStateNormal];
    [self.clearButton setTitleColor:[UIColor colorWithRed:(102.f / 255.f) green:(102.f / 255.f) blue:(102.f / 255.f) alpha:1.0] forState:UIControlStateNormal];
    self.clearButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [self.clearButton addTarget:self action:@selector(clearCart) forControlEvents:UIControlEventTouchUpInside];
    [self.topBarView bringSubviewToFront:self.clearButton];
    [self.topBarView addSubview:self.clearButton];
    
    CGFloat clearButtonImageViewWidth = 30;
    CGFloat clearButtonImageViewHeight = clearButtonImageViewWidth;
    CGFloat clearButtonImageViewX = self.clearButton.frame.origin.x -clearButtonImageViewWidth + 4;
    UIImageView *clearButtonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(clearButtonImageViewX, self.clearButton.frame.origin.y, clearButtonImageViewWidth, clearButtonImageViewHeight)];
    clearButtonImageView.image = [UIImage imageNamed:@"clear_button"];
    [self.topBarView addSubview:clearButtonImageView];
    
    self.cartListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topBarView.frame), self.frame.size.width, self.frame.size.height - self.topBarView.frame.size.height) style:UITableViewStylePlain];
    [self.cartListTableView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.cartListTableView];
}

- (void)clearCart {
    if ([self.delegate respondsToSelector:@selector(clearCart)]) {
        [self.delegate clearCart];
    }
}

@end
