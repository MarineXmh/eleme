//
//  CartView.h
//  eleme
//
//  Created by Xu Menghua on 16/1/26.
//  Copyright © 2016年 Xu Menghua. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CartViewDelegate <NSObject>

- (void)checkOut;

@end

@interface CartView : UIView

@property (nonatomic, strong) UIImageView *cartImageView;
@property (nonatomic, strong) UIButton *checkOutButton;
@property (nonatomic, strong) UILabel *cartNumberLabel;
@property (nonatomic, assign) int foodNumber;
@property (nonatomic, weak) id<CartViewDelegate> delegate;

@end
