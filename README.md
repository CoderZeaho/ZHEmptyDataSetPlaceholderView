# ZHEmptyDataSetPlaceholderView
封装的空白页,结合DZNEmptyDataSet使用,可以初始化不同样式的空白页界面,可以追加文字,图片,按钮等,不同效果图如下:

![不同样式](https://i.loli.net/2017/09/13/59b8ae010f776.jpg)
## Features
调用 - (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView;
添加自定义视图到空白集,进行一些延展;

## How to use
DZNEmptyDataSet具体用方详见: 
<https://github.com/dzenbot/DZNEmptyDataSet>
### Installation
```
pod 'DZNEmptyDataSet'
```

### Improt

```
#import "ZHEmptyDataSetPlaceholderView.h"
```
### Protocol Conformance
```
@interface ZHBaseTableViewController : UIViewController<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

self.tableView.emptyDataSetSource = self;
self.tableView.emptyDataSetDelegate = self;
```

### Delegate Implementation
```
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    NSMutableArray *sectionDataSource = [NSMutableArray arrayWithArray:[[self dataSource] firstObject] ?: @[]];
    return ![sectionDataSource ?: @[] count];
}
```

### Data Source Implementation
```
- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView{
    ZHEmptyDataSetPlaceholderView *placeholderView = [ZHEmptyDataSetPlaceholderView placeholderWithImage:[UIImage imageNamed:@"图标-哭泣-(2)"] ];
    // 追加主标题
    [placeholderView appendTitle:@"新功能正在开发中" completion:^(UILabel *titleLabel, CGFloat *offset, CGFloat *height) {
        titleLabel.textColor = [UIColor colorWithRed:0.62 green:0.62 blue:0.62 alpha:1.00];
        *offset = 20;
    }];
    // 追加子标题
    [placeholderView appendSubTitle:@"敬请期待" completion:^(UILabel *subtitleLabel, CGFloat *offset, CGFloat *height) {
        subtitleLabel.textColor = [UIColor colorWithRed:0.62 green:0.62 blue:0.62 alpha:1.00];
        *offset = 10;
    }];
    // 也可以按钮
    return placeholderView;
}
```
## Thank you for reviewing


