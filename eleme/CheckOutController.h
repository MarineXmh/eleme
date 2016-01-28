//
//  CheckOutController.h
//  eleme
//
//  Created by Xu Menghua on 16/1/27.
//  Copyright © 2016年 Xu Menghua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckOutController : UIViewController

@property (nonatomic, strong) UITableView *checkOutListTableView;
@property (nonatomic, strong) NSMutableDictionary *foodsInCartDictionary;
@property (nonatomic, strong) NSMutableArray *foodsInCartArray;

@end
