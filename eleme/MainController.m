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
#import "CartView.h"
#import "IndexCell.h"
#import "CartListView.h"
#import "CartListCell.h"
#import "CheckOutController.h"
#import "FoodTableViewHeader.h"

@interface MainController () <UITableViewDelegate, UITableViewDataSource, SelectionViewDelegate, FoodCellDelegate, CartViewDelegate, UIScrollViewDelegate, CartListViewDelegate, CartListCellDelegate>

@property (nonatomic, strong) UITableView *indexTableView;
@property (nonatomic, strong) UITableView *foodTableView;
@property (nonatomic, strong) SelectionView *selectionView;
@property (nonatomic, strong) CartView *cartView;
@property (nonatomic, strong) CartListView *cartListView;
@property (nonatomic, strong) UIControl *backgroundView;
@property (nonatomic, assign) int cartTotalNumber;
@property (nonatomic, strong) NSMutableArray *indexArray;
@property (nonatomic, strong) NSMutableArray *foodsArray;
@property (nonatomic, strong) NSMutableArray *foodImagesArray;
@property (nonatomic, strong) NSMutableDictionary *foodsInCartDictionary;
@property (nonatomic, strong) NSMutableArray *foodsInCartArray;
@property (nonatomic, assign) BOOL isScrollToBottom;
@property (nonatomic, assign) BOOL isCartShowing;
@property (nonatomic, assign) BOOL isIndexClicked;
@property (nonatomic, assign) double lastContentOffset;

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cartTotalNumber = 0;
    self.indexArray = [[NSMutableArray alloc] init];
    self.foodsArray =[[NSMutableArray alloc] init];
    self.foodImagesArray = [[NSMutableArray alloc] init];
    self.foodsInCartDictionary = [[NSMutableDictionary alloc] init];
    self.foodsInCartArray = [[NSMutableArray alloc] init];
    [self setNavgationBar];
    [self loadData:@"早餐"];
    [self addViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)loadData:(NSString *)type {
    [self.foodsArray removeAllObjects];
    [self.indexArray removeAllObjects];
    [self.foodImagesArray removeAllObjects];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *foodImagesPath = [NSString stringWithFormat:@"%@/FoodImages", documentPath];
    if (![type isEqualToString:@""]) {
        NSString *foodTypeListPath = [NSString stringWithFormat:@"%@/%@", foodImagesPath, [type substringToIndex:1]];
        NSArray *foodTypeArray = [fm contentsOfDirectoryAtPath:foodTypeListPath error:nil];
        for (NSString *data in foodTypeArray) {
            if ([data isEqualToString:@".DS_Store"]) {
                continue;
            }
            if (![self.indexArray containsObject:data]) {
                [self.indexArray addObject:data];
                NSArray *foodImagesArray = [fm contentsOfDirectoryAtPath:[NSString stringWithFormat:@"%@/%@", foodTypeListPath, data] error:nil];
                NSMutableArray *foodsArray = [[NSMutableArray alloc] init];
                NSMutableArray *foodImagesPathArray = [[NSMutableArray alloc] init];
                for (NSString *food in foodImagesArray) {
                    if ([food isEqualToString:@".DS_Store"]) {
                        continue;
                    }
                    [foodsArray addObject:[[food componentsSeparatedByString:@"."] objectAtIndex:0]];
                    NSString *foodImagePath = [NSString stringWithFormat:@"%@/%@/%@", foodTypeListPath, data, food];
                    [foodImagesPathArray addObject:foodImagePath];
                }
                [self.foodsArray addObject:foodsArray];
                [self.foodImagesArray addObject:foodImagesPathArray];
            }
        }
    }
    [self.indexTableView reloadData];
    [self.foodTableView reloadData];
    if (self.foodsArray.count > 0) {
        [self.indexTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        [self.foodTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}

- (void)setNavgationBar {
    self.title = @"营养食堂";
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(([self.title length] < 10 ?NSTextAlignmentCenter : NSTextAlignmentLeft), 0, 480,44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:20.0];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text=self.title;
    self.navigationItem.titleView = titleLabel;
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar setBarTintColor:[UIColor colorWithRed:(52.f / 255.f) green:(146.f / 255.f) blue:(233.f / 255.f) alpha:1.0]];
    [navigationBar setTintColor:[UIColor whiteColor]];
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSShadowAttributeName] = [[NSShadow alloc]  init];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [navigationBar setTitleTextAttributes:textAttrs];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)addViews
{
    CGFloat selectionViewY = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    CGFloat selectionViewHeight = 40;
    self.selectionView = [[SelectionView alloc] initWithFrame:CGRectMake(0, selectionViewY, self.view.frame.size.width, selectionViewHeight)];
    self.selectionView.delegate = self;
    [self.view addSubview:self.selectionView];
    
    CGFloat cartViewHeight = 50;
    CGFloat cartViewY = CGRectGetMaxY(self.view.frame) - cartViewHeight;
    self.cartView = [[CartView alloc] initWithFrame:CGRectMake(0, cartViewY, self.view.frame.size.width, cartViewHeight)];
    self.cartView.delegate = self;
    [self.view addSubview:self.cartView];
    
    CGFloat indexTableViewY = CGRectGetMaxY(self.selectionView.frame);
    CGFloat indexTableViewWidth = self.view.frame.size.width / 5;
    CGFloat indexTableViewHeight = self.view.frame.size.height - 20 - self.navigationController.navigationBar.frame.size.height - selectionViewHeight - cartViewHeight;
    self.indexTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, indexTableViewY, indexTableViewWidth, indexTableViewHeight) style:UITableViewStylePlain];
    [self.view addSubview:self.indexTableView];
    self.indexTableView.delegate = self;
    self.indexTableView.dataSource = self;
    self.indexTableView.backgroundColor = [UIColor colorWithRed:(238.f / 255.f) green:(238.f / 255.f) blue:(238.f / 255.f) alpha:1.0];
    self.indexTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.indexTableView setTableFooterView:[[UIView alloc] init]];
    UIView *seperateLineOnRightView = [[UIView alloc] initWithFrame:CGRectMake(indexTableViewWidth - 0.5, 0, 0.5, indexTableViewHeight)];
    seperateLineOnRightView.backgroundColor = [UIColor colorWithRed:(215.f / 255.f) green:(215.f / 255.f) blue:(215.f / 255.f) alpha:1.0];
    [self.indexTableView addSubview:seperateLineOnRightView];
    
    CGFloat foodTableViewWidth = self.view.frame.size.width - indexTableViewWidth;
    CGFloat foodTableViewHeight = indexTableViewHeight;
    CGFloat foodTableViewX = CGRectGetMaxX(self.indexTableView.frame);
    CGFloat foodTableViewY = indexTableViewY;
    self.foodTableView = [[UITableView alloc] initWithFrame:CGRectMake(foodTableViewX, foodTableViewY, foodTableViewWidth, foodTableViewHeight) style:UITableViewStylePlain];
    self.foodTableView.delegate = self;
    self.foodTableView.dataSource = self;
    [self.view addSubview:self.foodTableView];
    
    CGFloat cartListViewMaxHeight = 50 * 7 + 40;
    CGFloat cartListViewY = self.view.frame.size.height - self.cartView.frame.size.height;
    self.cartListView = [[CartListView alloc] initWithFrame:CGRectMake(0, cartListViewY, self.view.frame.size.width, cartListViewMaxHeight)];
    self.cartListView.hidden = YES;
    self.cartListView.delegate = self;
    self.cartListView.cartListTableView.dataSource = self;
    self.cartListView.cartListTableView.delegate = self;
    [self.cartListView.cartListTableView setTableFooterView:[[UIView alloc] init]];
    [self.view addSubview:self.cartListView];
}

#pragma mark - tableViewDatasourceAndDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.foodTableView) {
        return self.foodsArray.count;
    } else {
        return 1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == self.foodTableView) {
        FoodTableViewHeader *headerView = [[FoodTableViewHeader alloc] initWithReuseIdentifier:@"FoodTableViewHeader"];
        headerView.titleLabel.text = self.indexArray[section];
        return headerView;
    } else {
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.indexTableView) {
        return self.indexArray.count;
    } else if (tableView == self.foodTableView) {
        NSArray *array = self.foodsArray[section];
        return array.count;
    } else {
        return self.foodsInCartArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.foodTableView) {
        return 30;
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.foodTableView) {
        return 80;
    } else if (tableView == self.indexTableView) {
        return 60;
    } else {
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *indexTableViewCellIdentifier = @"IndexCell";
    static NSString *foodTableViewCellIdentifier = @"FoodCell";
    static NSString *cartTableViewCellIdentifier = @"CartListCell";
    if (tableView == self.indexTableView) {
        IndexCell *cell = [tableView dequeueReusableCellWithIdentifier:indexTableViewCellIdentifier];
        if (cell == nil) {
            cell = [[IndexCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indexTableViewCellIdentifier];
            if (indexPath.row == 0) {
                cell.seperateLineOnTopView.hidden = NO;
            }
        }
        cell.nameLabel.text = self.indexArray[indexPath.row];
        return cell;
    } else if (tableView == self.foodTableView) {
        FoodCell *cell = [tableView dequeueReusableCellWithIdentifier:foodTableViewCellIdentifier];
        if (cell == nil) {
            cell = [[FoodCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:foodTableViewCellIdentifier];
            cell.selectionStyle = NO;
        }
        cell.foodNameLabel.text = [self.foodsArray[indexPath.section] objectAtIndex:indexPath.row];
        cell.foodNumber = [[self.foodsInCartDictionary objectForKey:cell.foodNameLabel.text] intValue];
        cell.foodImageView.image = [UIImage imageWithContentsOfFile:[self.foodImagesArray[indexPath.section] objectAtIndex:indexPath.row]];
        cell.delegate = self;
        return cell;
    } else {
        CartListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil) {
            cell = [[CartListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cartTableViewCellIdentifier];
            cell.selectionStyle = NO;
        }
        cell.foodNameLabel.text = self.foodsInCartArray[indexPath.row];
        cell.foodNumber = [[self.foodsInCartDictionary objectForKey:cell.foodNameLabel.text] intValue];
        cell.delegate = self;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:indexPath.item];
    if (tableView == self.indexTableView) {
        self.isIndexClicked = YES;
        [self.foodTableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (tableView == self.foodTableView && self.isScrollToBottom == NO && self.isIndexClicked == NO) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:section inSection:0];
        [self.indexTableView selectRowAtIndexPath:index animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (tableView == self.foodTableView && self.isScrollToBottom == YES && self.isIndexClicked == NO) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:section + 1 inSection:0];
        [self.indexTableView selectRowAtIndexPath:index animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

#pragma mark - scrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.isIndexClicked = NO;
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
    [self clearCart];
    [self loadData:button.titleLabel.text];
}

#pragma mark - foodCellDelegate
- (void)addFood:(FoodCell *)cell {
    self.cartView.cartButton.enabled = YES;
    self.cartTotalNumber++;
    self.cartView.foodNumber = self.cartTotalNumber;
    [self.foodsInCartDictionary setObject:[NSNumber numberWithInt:cell.foodNumber] forKey:cell.foodNameLabel.text];
    if (![self.foodsInCartArray containsObject:cell.foodNameLabel.text]) {
        [self.foodsInCartArray addObject:cell.foodNameLabel.text];
    }
    [self.cartListView.cartListTableView reloadData];
    [self.foodTableView reloadData];
}

- (void)minusFood:(FoodCell *)cell {
    self.cartTotalNumber--;
    self.cartView.foodNumber = self.cartTotalNumber;
    [self.foodsInCartDictionary setObject:[NSNumber numberWithInt:cell.foodNumber] forKey:cell.foodNameLabel.text];
    if (cell.foodNumber <= 0) {
        [self.foodsInCartArray removeObject:cell.foodNameLabel.text];
        if (self.foodsInCartArray.count <= 0) {
            [self backgroundClick:nil];
        }
    }
    [self.cartListView.cartListTableView reloadData];
    [self.foodTableView reloadData];
    CGFloat cartListViewHeight = self.foodsInCartArray.count * 50 + 40;
    if (cartListViewHeight > 50 * 7 + 40) {
        cartListViewHeight = 50 * 7 + 40;
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.cartListView.frame = CGRectMake(0, self.view.frame.size.height - self.cartView.frame.size.height - cartListViewHeight, self.cartView.frame.size.width, cartListViewHeight);
    }];
    if (self.cartTotalNumber <= 0) {
        self.cartView.cartButton.enabled = NO;
    }
}

#pragma mark - cartViewDelegate
- (void)checkOut {
    CheckOutController *checkOutController = [[CheckOutController alloc] init];
    checkOutController.foodsInCartArray = self.foodsInCartArray;
    checkOutController.foodsInCartDictionary = self.foodsInCartDictionary;
    [self.navigationController pushViewController:checkOutController animated:YES];
}

- (void)showCart {
    self.isCartShowing = !self.isCartShowing;
    if (self.foodsInCartArray.count > 0 && self.isCartShowing == YES) {
        if (self.backgroundView == nil) {
            self.backgroundView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - self.cartView.frame.size.height)];
            [self.backgroundView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.0]];
            [self.backgroundView addTarget:self action:@selector(backgroundClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:self.backgroundView];
            [self.view bringSubviewToFront:self.cartListView];
            [self.view bringSubviewToFront:self.cartView];
            CGFloat cartListViewHeight = self.foodsInCartArray.count * 50 + 40;
            if (cartListViewHeight > 50 * 7 + 40) {
                cartListViewHeight = 50 * 7 + 40;
            }
            self.cartListView.frame = CGRectMake(0, self.view.frame.size.height - self.cartView.frame.size.height, self.view.frame.size.width, cartListViewHeight);
            [UIView animateWithDuration:0.3 animations:^{
                self.cartListView.hidden = NO;
                self.cartListView.frame = CGRectMake(0, self.view.frame.size.height - self.cartView.frame.size.height - cartListViewHeight, self.cartView.frame.size.width, cartListViewHeight);
                [self.backgroundView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
            }];
        }
    } else {
        [self backgroundClick:nil];
    }
}

- (void)backgroundClick:(UIControl *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        CGFloat cartListViewHeight = self.foodsInCartArray.count * 50 + 40;
        if (cartListViewHeight > 50 * 7 + 40) {
            cartListViewHeight = 50 * 7 + 40;
        }
        self.cartListView.frame = CGRectMake(0, self.view.frame.size.height - self.cartView.frame.size.height, self.cartView.frame.size.width, cartListViewHeight);
        [self.backgroundView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.0]];
        self.backgroundView = nil;
    } completion:^(BOOL finished) {
        self.cartListView.hidden = YES;
        [sender removeFromSuperview];
    }];
}

#pragma mark - cartListViewDelegate
- (void)clearCart {
    self.cartTotalNumber = 0;
    self.cartView.foodNumber = self.cartTotalNumber;
    [self.foodsInCartArray removeAllObjects];
    [self.foodsInCartDictionary removeAllObjects];
    [self.cartListView.cartListTableView reloadData];
    [self.foodTableView reloadData];
    [self backgroundClick:nil];
    self.cartView.cartButton.enabled = NO;
}

@end
