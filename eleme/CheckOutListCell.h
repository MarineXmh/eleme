//
//  CheckOutListCell.h
//  eleme
//
//  Created by Xu Menghua on 16/1/27.
//  Copyright © 2016年 Xu Menghua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckOutListCell : UITableViewCell

@property (nonatomic, strong) UILabel *foodNameLabel;
@property (nonatomic, strong) UILabel *foodNumberLabel;
@property (nonatomic, assign) int foodNumber;

@end
