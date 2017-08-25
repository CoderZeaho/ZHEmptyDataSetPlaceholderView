//
//  ZHEmptyDataSetPlaceholderView.m
//  ZHEmptyDataSetPlaceholderViewDemo
//
//  Created by Zeaho on 2017/8/25.
//  Copyright © 2017年 Zeaho. All rights reserved.
//

#import "ZHEmptyDataSetPlaceholderView.h"

@interface _ZHEmptyDataSetPlaceholderViewButton : UIButton
@end

@implementation _ZHEmptyDataSetPlaceholderViewButton

- (CGSize)intrinsicContentSize{
    NSString *title = [self titleForState:[self state]];
    CGSize contentSize = [title sizeWithAttributes:@{NSFontAttributeName: [[self titleLabel] font]}];
    contentSize.width += 26 * 2;
    contentSize.height += (6.5 * 2 + 4);
    return contentSize;
}

@end

@interface _ZHOffsetView : UIView
@end

@implementation _ZHOffsetView
@end

@interface ZHEmptyDataSetPlaceholderView ()

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) NSMutableArray<UIView *> *mutableItemViews;

@end

@interface UIView (ZHEmptyDataSetPlaceholderViewOffset)
@property (nonatomic, assign) CGFloat emptyDataSetPlaceholderViewOffset;
@property (nonatomic, assign) CGFloat emptyDataSetPlaceholderViewContentHeight;
@end

@implementation UIView (ZHEmptyDataSetPlaceholderViewOffset)

- (CGFloat)emptyDataSetPlaceholderViewOffset{
    return [objc_getAssociatedObject(self, @selector(emptyDataSetPlaceholderViewOffset)) floatValue];
}

- (void)setEmptyDataSetPlaceholderViewOffset:(CGFloat)emptyDataSetPlaceholderViewOffset{
    objc_setAssociatedObject(self, @selector(emptyDataSetPlaceholderViewOffset), @(emptyDataSetPlaceholderViewOffset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)emptyDataSetPlaceholderViewContentHeight{
    return [objc_getAssociatedObject(self, @selector(emptyDataSetPlaceholderViewContentHeight)) floatValue];
}

- (void)setEmptyDataSetPlaceholderViewContentHeight:(CGFloat)emptyDataSetPlaceholderViewContentHeight{
    objc_setAssociatedObject(self, @selector(emptyDataSetPlaceholderViewContentHeight), @(emptyDataSetPlaceholderViewContentHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation ZHEmptyDataSetPlaceholderView

+ (instancetype)placeholder;{
    return [self placeholderWithImage:0];
}

+ (instancetype)placeholderWithImage:(UIImage *)image;{
    return [self placeholderWithImage:image title:nil];
}

+ (instancetype)placeholderWithImage:(UIImage *)image title:(NSString *)title;{
    return [self placeholderWithImage:image title:title subtitle:nil];
}

+ (instancetype)placeholderWithImage:(UIImage *)image title:(NSString *)title subtitle:(NSString *)subtitle;{
    return [self placeholderWithImage:image title:title subtitle:subtitle buttonTitle:nil];
}

+ (instancetype)placeholderWithImage:(UIImage *)image title:(NSString *)title subtitle:(NSString *)subtitle buttonTitle:(NSString *)buttonTitle;{
    return [[self alloc] initWithImage:image title:title subtitle:subtitle buttonTitle:buttonTitle];
}

- (instancetype)initWithImage:(UIImage *)image;{
    return [self initWithImage:image title:nil];
}

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title;{
    return [self initWithImage:image title:title subtitle:nil];
}

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title subtitle:(NSString *)subtitle;{
    return [self initWithImage:image title:title subtitle:subtitle buttonTitle:nil];
}

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title subtitle:(NSString *)subtitle buttonTitle:(NSString *)buttonTitle;{
    if (self = [self init]) {
        if (image) {
            [self appendImage:image completion:nil];
        }
        if (title) {
            [self appendTitle:title completion:nil];
        }
        if (subtitle) {
            [self appendSubTitle:subtitle completion:nil];
        }
        if (buttonTitle) {
            [self appendButtonWithTitle:buttonTitle completion:nil];
        }
    }
    return self;
}

- (instancetype)init{
    if (self = [super init]) {
        [self _initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self _initialize];
    }
    return self;
}

- (void)appendImage:(UIImage *)image completion:(void (^)(UIImageView *imageView, CGFloat *offset, CGFloat *height))completion;{
    UIImageView *imageView = [self defaultImageView];
    imageView.image = image;
    
    [self _appendView:imageView offset:10 completion:(id)completion];
}

- (void)appendTitle:(NSString *)title completion:(void (^)(UILabel *titleLabel, CGFloat *offset, CGFloat *height))completion;{
    UILabel *titleLabel = [self defaultTitleLabel];
    titleLabel.text = title;
    
    [self _appendView:titleLabel offset:9 completion:(id)completion];
}

- (void)appendSubTitle:(NSString *)subtitle completion:(void (^)(UILabel *subtitleLabel, CGFloat *offset, CGFloat *height))completion;{
    UILabel *subtitleLabel = [self defaultSubtitleLabel];
    subtitleLabel.text = subtitle;
    
    [self _appendView:subtitleLabel offset:4 completion:(id)completion];
}

- (void)appendButtonWithTitle:(NSString *)title completion:(void (^)(UIButton *button, CGFloat *offset, CGFloat *height))completion;{
    UIButton *button = [self defaultButton];
    [button setTitle:title forState:UIControlStateNormal];
    
    [self _appendView:button offset:10 completion:(id)completion];
}

- (void)appendView:(UIView *)view completion:(void (^)(UIView *view, CGFloat *offset, CGFloat *height))completion{
    [self _appendView:view offset:0 completion:completion];
}

- (void)_appendView:(UIView *)view offset:(CGFloat)offset completion:(void (^)(UIView *view, CGFloat *offset, CGFloat *height))completion{
    CGFloat contentHeight = 0;
    if (completion) {
        completion(view, &offset, &contentHeight);
    }
    view.emptyDataSetPlaceholderViewOffset = offset;
    view.emptyDataSetPlaceholderViewContentHeight = contentHeight;
    
    [[self contentView] addSubview:view];
    [[self mutableItemViews] addObject:view];
    
    [self _updateItemViewslayout];
}

#pragma mark - accessor

- (void)setContentInsets:(UIEdgeInsets)contentInsets{
    _contentInsets = contentInsets;
    
    [self _updateContentViewLayout];
}

- (UIImageView *)defaultImageView{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    
    return imageView;
}

- (UILabel *)defaultTitleLabel{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    return titleLabel;
}

- (UILabel *)defaultSubtitleLabel{
    UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    subtitleLabel.font = [UIFont systemFontOfSize:14];
    subtitleLabel.textColor = [UIColor blackColor];
    subtitleLabel.textAlignment = NSTextAlignmentCenter;
    return subtitleLabel;
}

- (UIButton *)defaultButton{
    UIButton *button = [[_ZHEmptyDataSetPlaceholderViewButton alloc] initWithFrame:CGRectZero];
    button.userInteractionEnabled = NO;
    button.layer.masksToBounds = YES;
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    return button;
}

- (_ZHOffsetView *)defaultOffsetView{
    _ZHOffsetView *offsetView = [[_ZHOffsetView alloc] initWithFrame:CGRectZero];
    offsetView.userInteractionEnabled = NO;
    return offsetView;
}

- (UIView *)DZNEmptyDataSetView{
    UIView *superview = self;
    while (superview && ![superview isKindOfClass:NSClassFromString(@"DZNEmptyDataSetView")]){
        superview = [superview superview];
    };
    return superview;
}

#pragma mark - protected

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self _updateContentSize];
}

- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    
    [self _updateContentSize];
}

#pragma mark - private

- (void)_initialize{
    
    self.mutableItemViews = [NSMutableArray array];
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:[self contentView]];
    
    self.contentInsets = UIEdgeInsetsMake(CGFLOAT_MAX, CGFLOAT_MAX, CGFLOAT_MAX, CGFLOAT_MAX);
}

- (void)_updateContentViewLayout{
    
    [[self contentView] mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (self.contentInsets.top != CGFLOAT_MAX || self.contentInsets.bottom != CGFLOAT_MAX) {
            if (self.contentInsets.top != CGFLOAT_MAX) {
                make.top.equalTo(self).offset(self.contentInsets.top);
            }
            if (self.contentInsets.bottom != CGFLOAT_MAX) {
                make.bottom.equalTo(self).offset(self.contentInsets.bottom);
            }
        } else {
            make.centerY.equalTo(self);
        }
        if (self.contentInsets.left != CGFLOAT_MAX || self.contentInsets.right != CGFLOAT_MAX) {
            if (self.contentInsets.left != CGFLOAT_MAX) {
                make.left.equalTo(self).offset(self.contentInsets.left);
            }
            if (self.contentInsets.right != CGFLOAT_MAX) {
                make.right.equalTo(self).offset(self.contentInsets.right);
            }
        } else {
            make.centerX.equalTo(self);
        }
    }];
    
    
}

- (void)_updateItemViewslayout{
    
    NSArray *itemViews = [[self mutableItemViews] copy];
    [itemViews enumerateObjectsUsingBlock:^(UIView *itemView, NSUInteger index, BOOL *stop) {
        [itemView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.greaterThanOrEqualTo(self.contentView);
            make.right.lessThanOrEqualTo(self.contentView);
            make.centerX.equalTo(self.contentView);
            CGFloat offset = [itemView emptyDataSetPlaceholderViewOffset];
            if (!index) {
                make.top.equalTo(self.contentView).offset(offset);
            } else {
                UIView *previousItemView = itemViews[index - 1];
                make.top.equalTo(previousItemView.mas_bottom).offset(offset);
            }
            if (index == [itemViews count] - 1) {
                make.bottom.equalTo(self.contentView);
            }
            if (itemView.emptyDataSetPlaceholderViewContentHeight > 0) {
                make.height.mas_equalTo(itemView.emptyDataSetPlaceholderViewContentHeight);
            }
        }];
    }];
}

- (void)_updateContentSize{
    UIView *DZNEmptyDataSetView = [self DZNEmptyDataSetView];
    if (DZNEmptyDataSetView) {
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.DZNEmptyDataSetView.bounds.size);
        }];
    }
}

@end
