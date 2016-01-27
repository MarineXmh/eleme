//
//  CartView.h
//  eleme
//
//  Created by Xu Menghua on 16/1/26.
//  Copyright © 2016年 Xu Menghua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartListView.h"

@class CartListView;

@protocol CartViewDelegate <NSObject>

- (void)checkOut;
- (void)showCart;

@end

@interface CartView : UIView

@property (nonatomic, strong) UIButton *cartButton;
@property (nonatomic, strong) UIButton *checkOutButton;
@property (nonatomic, strong) UILabel *cartNumberLabel;
@property (nonatomic, strong) UIControl *backgroundView;
@property (nonatomic, assign) int foodNumber;
@property (nonatomic, weak) id<CartViewDelegate> delegate;

@end
