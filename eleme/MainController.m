//
//  MainController.m
//  eleme
//
//  Created by Xu Menghua on 16/1/26.
//  Copyright © 2016年 Xu Menghua. All rights reserved.
//

#import "MainController.h"
#import "SelectionView.h"
#import "FoodCell.h"
#import "Food.h"
#import "CartView.h"
#import "IndexCell.h"

@interface MainController () <UITableViewDelegate, UITableViewDataSource, SelectionViewDelegate, FoodCellDelegate, CartViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *indexTableView;
@property (nonatomic, strong) UITableView *foodTableView;
@property (nonatomic, strong) SelectionView *selectionView;
@property (nonatomic, strong) CartView *cartView;
@property (nonatomic, assign) int cartTotalNumber;
@property (nonatomic, strong) NSMutableArray *indexArray;
@property (nonatomic, strong) NSMutableArray *sectionsArray;
@property (nonatomic, strong) NSMutableArray *foodsArray;
@property (nonatomic, assign) BOOL isScrollToBottom;
@property (nonatomic, assign) double lastContentOffset;

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cartTotalNumber = 0;
    self.indexArray = [[NSMutableArray alloc] init];
    self.sectionsArray = [[NSMutableArray alloc] init];
    self.foodsArray =[[NSMutableArray alloc] init];
    [self setNavgationBar];
    [self addTableView];
    [self makeData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)makeData {
    self.indexArray = [NSMutableArray arrayWithArray:@[@"套餐", @"小吃", @"饮料"]];
    for (int j = 0; j < 3; j++) {
        for (int i = 0; i < 20; i++) {
            [self.foodsArray addObject:[NSString stringWithFormat:@"食物%d", i] ];
        }
        [self.sectionsArray addObject:self.foodsArray];
        self.foodsArray= nil;
        self.foodsArray = [[NSMutableArray alloc] init];
    }
}

- (void)setNavgationBar {
    self.title = @"营养食堂";
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar setBarTintColor:[UIColor colorWithRed:(60.f / 255.f) green:(120.f / 255.f) blue:(255.f / 255.f) alpha:1.0]];
    [navigationBar setTintColor:[UIColor whiteColor]];
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSShadowAttributeName] = [[NSShadow alloc]  init];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [navigationBar setTitleTextAttributes:textAttrs];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)addTableView
{
    self.selectionView = [[SelectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), self.view.frame.size.width, 50)];
    self.selectionView.delegate = self;
    [self.view addSubview:self.selectionView];
    
    self.indexTableView = [[UITableView alloc] initWithFrame:CGRectMake(0 , CGRectGetMaxY(self.selectionView.frame), self.view.frame.size.width / 5, self.view.frame.size.height - 20 - self.navigationController.navigationBar.frame.size.height - 100) style:UITableViewStylePlain];
    [self.view addSubview:self.indexTableView];
    self.indexTableView.delegate = self;
    self.indexTableView.dataSource = self;
    self.indexTableView.backgroundColor = [UIColor whiteColor];
    
    self.foodTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 5 , CGRectGetMaxY(self.selectionView.frame), self.view.frame.size.width / 5 * 4, self.view.frame.size.height  - 20 - self.navigationController.navigationBar.frame.size.height - 100) style:UITableViewStylePlain];
    self.foodTableView.delegate = self;
    self.foodTableView.dataSource = self;
    self.foodTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.foodTableView];
    
    self.cartView = [[CartView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame) - 50, self.view.frame.size.width, 50)];
    self.cartView.delegate = self;
    [self.view addSubview:self.cartView];
}

#pragma mark - tableViewDatasourceAndDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.indexTableView) {
        return 1;
    } else {
        return self.sectionsArray.count;
    }
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == self.foodTableView) {
        return self.indexArray[section];
    } else {
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.indexTableView) {
        return self.indexArray.count;
    } else {
        NSArray *array = self.sectionsArray[section];
        return array.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.foodTableView) {
        return 25;
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.foodTableView) {
        return 80;
    } else {
        return 40;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *leftTableViewCellIdentifier = @"IndexCell";
    static NSString *rightTableViewCellIdentifier = @"FoodCell";
    if (tableView == self.indexTableView) {
        IndexCell *cell = [tableView dequeueReusableCellWithIdentifier:leftTableViewCellIdentifier];
        
        if (!cell) {
            cell = [[IndexCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:leftTableViewCellIdentifier];
        }
        
        cell.nameLabel.text = self.indexArray[indexPath.row];
        
        return cell;
    } else {
        FoodCell *cell = [tableView dequeueReusableCellWithIdentifier:rightTableViewCellIdentifier];
        
        if (cell == nil) {
            cell = [[FoodCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rightTableViewCellIdentifier];
        }
        
        cell.foodNameLabel.text = [self.sectionsArray[indexPath.section] objectAtIndex:indexPath.row];
        cell.foodImageView.image = [UIImage imageNamed:@"food"];
        cell.delegate = self;
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:indexPath.item];
    if (tableView == self.indexTableView) {
        [self.foodTableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionTop animated:YES];
    } else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (tableView == self.foodTableView && self.isScrollToBottom == NO) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:section inSection:0];
        [self.indexTableView selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (tableView == self.foodTableView && self.isScrollToBottom == YES) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:section + 1 inSection:0];
        [self.indexTableView selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
}

#pragma mark - scrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.lastContentOffset = scrollView.contentOffset.y;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if (self.lastContentOffset < scrollView.contentOffset.y) {
        self.isScrollToBottom = YES;
    }else{
        self.isScrollToBottom = NO;
    }
}

#pragma mark - selectionViewDelegate
- (void)selectionChanged:(UIButton *)button {
    NSLog(@"%@", button.titleLabel.text);
}

#pragma mark - foodCellDelegate
- (void)addFood {
    self.cartTotalNumber++;
    self.cartView.foodNumber = self.cartTotalNumber;
}

- (void)minusFood {
    self.cartTotalNumber--;
    self.cartView.foodNumber = self.cartTotalNumber;
}

#pragma mark - cartViewDelegate
- (void)checkOut {
    NSLog(@"check out");
}

@end
