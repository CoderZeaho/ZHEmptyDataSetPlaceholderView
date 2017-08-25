//
//  ZHBaseTableViewController.m
//  ZHEmptyDataSetPlaceholderViewDemo
//
//  Created by Zeaho on 2017/8/25.
//  Copyright © 2017年 Zeaho. All rights reserved.
//

#import "ZHBaseTableViewController.h"

@interface ZHBaseTableViewController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) UITableViewStyle style;

@end

@implementation ZHBaseTableViewController {
    NSArray *_sectionIndexTitles;
}

- (instancetype)initWithStyle:(UITableViewStyle)style;{
    if (self = [self init]) {
        self.style = style;
        
        [self initialize];
        
    }
    return self;
}

- (void)initialize{
    
}

- (void)loadView{
    [super loadView];
    
    if (!_tableView) {
        [[self view] addSubview:[self tableView]];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentOffset = CGPointMake(0, - [self contentInset].top);
    self.tableView.contentInset = [self contentInset];
    self.tableView.scrollIndicatorInsets = [self contentInset];
    self.tableView.sectionIndexColor = [UIColor darkGrayColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.sectionIndexMinimumDisplayRowCount = 20;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [[self tableView] registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

#pragma mark - accessor

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[[self view] bounds] style:[self style]];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
    }
    return _tableView;
}

- (NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = @[];
    }
    return _dataSource;
}

- (NSArray *)sectionIndexTitles{
    if (!_sectionIndexTitles) {
        _sectionIndexTitles = @[];
    }
    return _sectionIndexTitles;
}

- (void)setSectionIndexTitles:(NSArray *)sectionIndexTitles{
    if (_sectionIndexTitles != sectionIndexTitles) {
        _sectionIndexTitles = sectionIndexTitles;
        
        [[self tableView] reloadData];
    }
}

- (CGFloat)topBarHeight{
    
    BOOL isNavigationbarDisplay = [self navigationController] && ![[self navigationController] isNavigationBarHidden];
    BOOL isStatusBarDisplay = ![[UIApplication sharedApplication] isStatusBarHidden];
    
    return isNavigationbarDisplay * 44 + isStatusBarDisplay * 20;
}

- (CGFloat)bottomBarHeight{
    
    BOOL isToolBarDisplay = [self navigationController] && ![[self navigationController] isToolbarHidden];
    BOOL isTabBarDisplay = [self tabBarController] && ![[[self tabBarController] tabBar] isHidden];
    
    return isToolBarDisplay * 49 + isTabBarDisplay * 49;
}

- (UIEdgeInsets)contentInset {
    return UIEdgeInsetsMake([self topBarHeight], 0, [self bottomBarHeight], 0);
}

- (void)setView:(UIView *)view {
    [super setView:view];
    if ([view isKindOfClass:UITableView.class]) {
        self.tableView = (UITableView *)view;
    }
}

#pragma mark - public

- (void)reloadData {
    [[self tableView] reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self dataSource] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self dataSource][section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section >= [[self sectionIndexTitles] count]) return nil;
    return [self sectionIndexTitles][section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [self sectionIndexTitles];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return index;
}

#pragma mark - UITableViewDelegate

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - DZNEmptyDataSetSource

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    return [[NSAttributedString alloc] initWithString:@"暂无数据"];
}

#pragma mark - DZNEmptyDataSetDelegate

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return [self dataSource] == nil;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UITableView *)tableView {
    return -([tableView contentInset].top - CGRectGetHeight([[tableView tableHeaderView] bounds]) - [tableView contentInset].bottom) / 2 - CGRectGetHeight([[tableView tableFooterView] bounds]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
