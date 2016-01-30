//
//  FoodTableViewHeader.m
//  eleme
//
//  Created by Xu Menghua on 16/1/29.
//  Copyright © 2016年 Xu Menghua. All rights reserved.
//

#import "FoodTableViewHeader.h"

@implementation FoodTableViewHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView setBackgroundColor:[UIColor colorWithRed:(230.f / 255.f) green:(230.f / 255.f) blue:(230.f / 255.f) alpha:1.0]];
        
        CGFloat padding = 8;
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, 0, 100, 30)];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        [self.titleLabel setTextColor:[UIColor colorWithRed:(102.f / 255.f) green:(102.f / 255.f) blue:(102.f / 255.f) alpha:1.0]];
        [self addSubview:self.titleLabel];
        
        CGFloat foodTableViewWidth = [UIScreen mainScreen].bounds.size.width / 5 * 4;
        _seperateLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 30 - 0.5, foodTableViewWidth, 0.5)];
        _seperateLineView.backgroundColor = [UIColor colorWithRed:(210.f / 255.f) green:(210.f / 255.f) blue:(210.f / 255.f) alpha:1.0];
        [self addSubview:_seperateLineView];

        UIView *seperateLineOnTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, foodTableViewWidth, 0.5)];
        seperateLineOnTop.backgroundColor = [UIColor colorWithRed:(210.f / 255.f) green:(210.f / 255.f) blue:(210.f / 255.f) alpha:1.0];
        [self addSubview:seperateLineOnTop];
    }
    return self;
}

@end
