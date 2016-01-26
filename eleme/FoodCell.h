//
//  FoodCell.h
//  eleme
//
//  Created by Xu Menghua on 16/1/26.
//  Copyright © 2016年 Xu Menghua. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FoodCellDelegate <NSObject>

- (void)addFood;
- (void)minusFood;

@end

@interface FoodCell : UITableViewCell

@property (nonatomic, strong) UILabel *foodNameLabel;
@property (nonatomic, strong) UIImageView *foodImageView;
@property (nonatomic, strong) UIButton *addFoodButton;
@property (nonatomic, strong) UILabel *foodNumberLabel;
@property (nonatomic, strong) UIButton *minusFoodButton;
@property (nonatomic, assign) int foodNumber;
@property (nonatomic, weak) id<FoodCellDelegate> delegate;

@end
