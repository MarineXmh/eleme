//
//  CartListCell.h
//  eleme
//
//  Created by Xu Menghua on 16/1/27.
//  Copyright © 2016年 Xu Menghua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CartListCell;

@protocol CartListCellDelegate <NSObject>

- (void)addFood:(CartListCell *)cell;
- (void)minusFood:(CartListCell *)cell;

@end

@interface CartListCell : UITableViewCell

@property (nonatomic, strong) UILabel *foodNameLabel;
@property (nonatomic, strong) UIButton *addFoodButton;
@property (nonatomic, strong) UILabel *foodNumberLabel;
@property (nonatomic, strong) UIButton *minusFoodButton;
@property (nonatomic, assign) int foodNumber;
@property (nonatomic, weak) id<CartListCellDelegate> delegate;

@end
