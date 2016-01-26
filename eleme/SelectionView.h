//
//  SelectionView.h
//  eleme
//
//  Created by Xu Menghua on 16/1/26.
//  Copyright © 2016年 Xu Menghua. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectionViewDelegate <NSObject>

- (void)selectionChanged:(UIButton *)button;

@end

@interface SelectionView : UIView

@property (nonatomic, strong) UIButton *breakfastListButton;
@property (nonatomic, strong) UIButton *launchListButton;
@property (nonatomic, strong) UIButton *supperListButton;
@property (nonatomic, strong) UIButton *midnightSnackListButton;
@property (nonatomic, strong) UIView *indicatorBar;
@property (nonatomic, weak) id<SelectionViewDelegate> delegate;

@end
