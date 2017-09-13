//
//  ViewController.m
//  ZHEmptyDataSetPlaceholderViewDemo
//
//  Created by Zeaho on 2017/8/25.
//  Copyright © 2017年 Zeaho. All rights reserved.
//

#import "ViewController.h"
#import "ZHEmptyDataSetPlaceholderView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - DZNEmptyDataSetSource, DZNEmptyDataSetDelegate
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    NSMutableArray *sectionDataSource = [NSMutableArray arrayWithArray:[[self dataSource] firstObject] ?: @[]];
    return ![sectionDataSource ?: @[] count];
}

- (BOOL)emptyDataSetShouldFadeIn:(UIScrollView *)scrollView;{
    return YES;
}

- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView{
    ZHEmptyDataSetPlaceholderView *placeholderView = [ZHEmptyDataSetPlaceholderView placeholderWithImage:[UIImage imageNamed:@"图标-哭泣-(2)"] ];
    [placeholderView appendTitle:@"新功能正在开发中" completion:^(UILabel *titleLabel, CGFloat *offset, CGFloat *height) {
        titleLabel.textColor = [UIColor colorWithRed:0.62 green:0.62 blue:0.62 alpha:1.00];
        *offset = 20;
    }];
    [placeholderView appendSubTitle:@"敬请期待" completion:^(UILabel *subtitleLabel, CGFloat *offset, CGFloat *height) {
        subtitleLabel.textColor = [UIColor colorWithRed:0.62 green:0.62 blue:0.62 alpha:1.00];
        *offset = 10;
    }];
    return placeholderView;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return -self.tableView.tableHeaderView.frame.size.height/2.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
