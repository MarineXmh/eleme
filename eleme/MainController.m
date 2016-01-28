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
#import "CartListView.h"
#import "CartListCell.h"
#import "CheckOutController.h"

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
    [self addTableView];
    [self loadData:@"早餐"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData:(NSString *)type {
    [self.foodsArray removeAllObjects];
    [self.indexArray removeAllObjects];
    [self.foodImagesArray removeAllObjects];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *foodImagesPath = [NSString stringWithFormat:@"%@/FoodImages", documentPath];
    if ([type isEqualToString:@"夜餐"]) {
        NSString *midnightSnackListPath = [NSString stringWithFormat:@"%@/夜", foodImagesPath];
        NSArray *midnightSnackArray = [fm subpathsAtPath:midnightSnackListPath];
        for (NSString *data in midnightSnackArray) {
            NSString *index = [[data componentsSeparatedByString:@"/"] objectAtIndex:0];
            if ([index isEqualToString:@".DS_Store"]) {
                continue;
            }
            if (![self.indexArray containsObject:index]) {
                [self.indexArray addObject:index];
                NSArray *foodImagesArray = [fm subpathsAtPath:[NSString stringWithFormat:@"%@/%@", midnightSnackListPath, index]];
                NSMutableArray *foodsArray = [[NSMutableArray alloc] init];
                NSMutableArray *foodImagesPathArray = [[NSMutableArray alloc] init];
                for (NSString *food in foodImagesArray) {
                    [foodsArray addObject:[[food componentsSeparatedByString:@"."] objectAtIndex:0]];
                    NSString *foodImagePath = [NSString stringWithFormat:@"%@/%@/%@", midnightSnackListPath, index, food];
                    [foodImagesPathArray addObject:foodImagePath];
                }
                [self.foodsArray addObject:foodsArray];
                [self.foodImagesArray addObject:foodImagesPathArray];
            }
        }
    }
    if ([type isEqualToString:@"早餐"]) {
        NSString *breakfastListPath = [NSString stringWithFormat:@"%@/早", foodImagesPath];
        NSArray *breakfastArray = [fm subpathsAtPath:breakfastListPath];
        for (NSString *data in breakfastArray) {
            NSString *index = [[data componentsSeparatedByString:@"/"] objectAtIndex:0];
            if ([index isEqualToString:@".DS_Store"]) {
                continue;
            }
            if (![self.indexArray containsObject:index]) {
                [self.indexArray addObject:index];
                NSArray *foodImagesArray = [fm subpathsAtPath:[NSString stringWithFormat:@"%@/%@", breakfastListPath, index]];
                NSMutableArray *foodsArray = [[NSMutableArray alloc] init];
                NSMutableArray *foodImagesPathArray = [[NSMutableArray alloc] init];
                for (NSString *food in foodImagesArray) {
                    [foodsArray addObject:[[food componentsSeparatedByString:@"."] objectAtIndex:0]];
                    NSString *foodImagePath = [NSString stringWithFormat:@"%@/%@/%@", breakfastListPath, index, food];
                    [foodImagesPathArray addObject:foodImagePath];
                }
                [self.foodsArray addObject:foodsArray];
                [self.foodImagesArray addObject:foodImagesPathArray];
            }
        }
    }
    if ([type isEqualToString:@"午餐"]) {
        NSString *launchListPath = [NSString stringWithFormat:@"%@/午", foodImagesPath];
        NSArray *launchArray = [fm subpathsAtPath:launchListPath];
        for (NSString *data in launchArray) {
            NSString *index = [[data componentsSeparatedByString:@"/"] objectAtIndex:0];
            if ([index isEqualToString:@".DS_Store"]) {
                continue;
            }
            if (![self.indexArray containsObject:index]) {
                [self.indexArray addObject:index];
                NSArray *foodImagesArray = [fm subpathsAtPath:[NSString stringWithFormat:@"%@/%@", launchListPath, index]];
                NSMutableArray *foodsArray = [[NSMutableArray alloc] init];
                NSMutableArray *foodImagesPathArray = [[NSMutableArray alloc] init];
                for (NSString *food in foodImagesArray) {
                    [foodsArray addObject:[[food componentsSeparatedByString:@"."] objectAtIndex:0]];
                    NSString *foodImagePath = [NSString stringWithFormat:@"%@/%@/%@", launchListPath, index, food];
                    [foodImagesPathArray addObject:foodImagePath];
                }
                [self.foodsArray addObject:foodsArray];
                [self.foodImagesArray addObject:foodImagesPathArray];
            }
        }
    }
    if ([type isEqualToString:@"晚餐"]) {
        NSString *supperListPath = [NSString stringWithFormat:@"%@/晚", foodImagesPath];
        NSArray *supperArray = [fm subpathsAtPath:supperListPath];
        for (NSString *data in supperArray) {
            NSString *index = [[data componentsSeparatedByString:@"/"] objectAtIndex:0];
            if ([index isEqualToString:@".DS_Store"]) {
                continue;
            }
            if (![self.indexArray containsObject:index]) {
                [self.indexArray addObject:index];
                NSArray *foodImagesArray = [fm subpathsAtPath:[NSString stringWithFormat:@"%@/%@", supperListPath, index]];
                NSMutableArray *foodsArray = [[NSMutableArray alloc] init];
                NSMutableArray *foodImagesPathArray = [[NSMutableArray alloc] init];
                for (NSString *food in foodImagesArray) {
                    [foodsArray addObject:[[food componentsSeparatedByString:@"."] objectAtIndex:0]];
                    NSString *foodImagePath = [NSString stringWithFormat:@"%@/%@/%@", supperListPath, index, food];
                    [foodImagesPathArray addObject:foodImagePath];
                }
                [self.foodsArray addObject:foodsArray];
                [self.foodImagesArray addObject:foodImagesPathArray];
            }
        }
    }
    [self.indexTableView reloadData];
    [self.foodTableView reloadData];
    [self.indexTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    [self.foodTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
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
    [self.indexTableView setTableFooterView:[[UIView alloc] init]];
    
    self.foodTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 5 , CGRectGetMaxY(self.selectionView.frame), self.view.frame.size.width / 5 * 4, self.view.frame.size.height  - 20 - self.navigationController.navigationBar.frame.size.height - 100) style:UITableViewStylePlain];
    self.foodTableView.delegate = self;
    self.foodTableView.dataSource = self;
    self.foodTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.foodTableView];
    
    self.cartView = [[CartView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame) - 50, self.view.frame.size.width, 50)];
    self.cartView.delegate = self;
    [self.view addSubview:self.cartView];
    
    self.cartListView = [[CartListView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - self.cartView.frame.size.height, self.view.frame.size.width, 280)];
    self.cartListView.hidden = YES;
    self.cartListView.delegate = self;
    self.cartListView.cartListTableView.dataSource = self;
    self.cartListView.cartListTableView.delegate = self;
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
    } else if (tableView == self.foodTableView) {
        NSArray *array = self.foodsArray[section];
        return array.count;
    } else {
        return self.foodsInCartArray.count;
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
    } else if (tableView == self.indexTableView) {
        return 40;
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
        }
        
        cell.nameLabel.text = self.indexArray[indexPath.row];
        
        return cell;
    } else if (tableView == self.foodTableView) {
        FoodCell *cell = [tableView dequeueReusableCellWithIdentifier:foodTableViewCellIdentifier];
        
        if (cell == nil) {
            cell = [[FoodCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:foodTableViewCellIdentifier];
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
        [self.foodTableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionTop animated:NO];
    } else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (tableView == self.foodTableView && self.isScrollToBottom == NO) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:section inSection:0];
        [self.indexTableView selectRowAtIndexPath:index animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (tableView == self.foodTableView && self.isScrollToBottom == YES) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:section + 1 inSection:0];
        [self.indexTableView selectRowAtIndexPath:index animated:NO scrollPosition:UITableViewScrollPositionNone];
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
    }
    [self.cartListView.cartListTableView reloadData];
    [self.foodTableView reloadData];
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
    if (self.foodsInCartArray.count > 0) {
        if (self.backgroundView == nil) {
            self.backgroundView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - self.cartView.frame.size.height)];
            [self.backgroundView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.0]];
            [self.backgroundView addTarget:self action:@selector(backgroundClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:self.backgroundView];
            [self.view bringSubviewToFront:self.cartListView];
            [UIView animateWithDuration:0.3 animations:^{
                self.cartListView.hidden = NO;
                self.cartListView.frame = CGRectMake(0, self.view.frame.size.height - self.cartView.frame.size.height - 280, self.cartView.frame.size.width, 280);
                [self.backgroundView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
            }];
        }
    }
}

- (void)backgroundClick:(UIControl *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.cartListView.frame = CGRectMake(0, self.view.frame.size.height - self.cartView.frame.size.height, self.cartView.frame.size.width, 280);
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
