//
//  CartListView.h
//  eleme
//
//  Created by Xu Menghua on 16/1/27.
//  Copyright © 2016年 Xu Menghua. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CartListViewDelegate <NSObject>

- (void)clearCart;

@end

@interface CartListView : UIView

@property (nonatomic, strong) UITableView *cartListTableView;
@property (nonatomic, strong) UIView *topBarView;
@property (nonatomic, strong) UILabel *listNameLabel;
@property (nonatomic, strong) UIButton *clearButton;
@property (nonatomic, weak) id<CartListViewDelegate> delegate;

@end
