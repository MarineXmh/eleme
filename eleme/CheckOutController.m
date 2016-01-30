//
//  CheckOutController.m
//  eleme
//
//  Created by Xu Menghua on 16/1/27.
//  Copyright © 2016年 Xu Menghua. All rights reserved.
//

#import "CheckOutController.h"
#import "CheckOutListCell.h"

@interface CheckOutController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation CheckOutController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"确认菜单";
    
    self.checkOutListTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - 50) style:UITableViewStylePlain];
    self.checkOutListTableView.delegate = self;
    self.checkOutListTableView.dataSource = self;
    self.checkOutListTableView.separatorStyle = NO;
    [self.view addSubview:self.checkOutListTableView];
    
    UIView *bottomBarView = [[UIView alloc] initWithFrame:CGRectMake(self.checkOutListTableView.frame.origin.x, CGRectGetMaxY(self.checkOutListTableView.frame), self.view.frame.size.width, 50)];
    bottomBarView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:bottomBarView];
    
    UIButton *checkOutButton = [UIButton buttonWithType:UIButtonTypeSystem];
    checkOutButton.frame = CGRectMake(self.view.frame.size.width - 100, 0, 100, bottomBarView.frame.size.height);
    [checkOutButton setBackgroundColor:[UIColor colorWithRed:(86.f / 255.f) green:(209.f / 255.f) blue:(100.f / 255.f) alpha:1.0]];
    [checkOutButton setTitle:@"提交菜单" forState:UIControlStateNormal];
    checkOutButton.titleLabel.font = [UIFont systemFontOfSize:20.0];
    [checkOutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomBarView addSubview:checkOutButton];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.foodsInCartArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"CheckOutListCell";
    CheckOutListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[CheckOutListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = NO;
    }
    
    cell.foodNameLabel.text = self.foodsInCartArray[indexPath.row];
    cell.foodNumber = [[self.foodsInCartDictionary objectForKey:cell.foodNameLabel.text] intValue];
    
    return cell;
}

@end
