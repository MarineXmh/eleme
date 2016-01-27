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
        self.topBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
        [self.topBarView setBackgroundColor:[UIColor colorWithRed:(225.f / 255.f) green:(225.f / 255.f) blue:(225.f / 255.f) alpha:1.0]];
        [self addSubview:self.topBarView];
        
        self.listNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 5, self.topBarView.frame.size.width / 5 * 3, self.topBarView.frame.size.height - 5 - 5)];
        self.listNameLabel.font = [UIFont systemFontOfSize:16.0];
        self.listNameLabel.text = @"已点菜单";
        [self.topBarView addSubview:self.listNameLabel];
        
        UIView *stickView = [[UIView alloc] initWithFrame:CGRectMake(6, self.listNameLabel.frame.origin.y, 3, self.listNameLabel.frame.size.height)];
        [stickView setBackgroundColor:[UIColor blueColor]];
        [self.topBarView addSubview:stickView];
        
        self.clearButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.clearButton.frame = CGRectMake(self.topBarView.frame.size.width - 38, 0, 30, 30);
        [self.clearButton setTitle:@"清空" forState:UIControlStateNormal];
        self.clearButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [self.clearButton addTarget:self action:@selector(clearCart) forControlEvents:UIControlEventTouchUpInside];
        [self.topBarView addSubview:self.clearButton];
        
        self.cartListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topBarView.frame), self.frame.size.width, self.frame.size.height - self.topBarView.frame.size.height) style:UITableViewStylePlain];
        [self.cartListTableView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.cartListTableView];
    }
    return self;
}

- (void)clearCart {
    if ([self.delegate respondsToSelector:@selector(clearCart)]) {
        [self.delegate clearCart];
    }
}

@end
