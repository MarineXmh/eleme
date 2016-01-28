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
    
    self.checkOutListTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.checkOutListTableView.delegate = self;
    self.checkOutListTableView.dataSource = self;
    self.checkOutListTableView.separatorStyle = NO;
    
    [self.view addSubview:self.checkOutListTableView];
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
