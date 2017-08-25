//
//  ZHEmptyDataSetPlaceholderView.h
//  ZHEmptyDataSetPlaceholderViewDemo
//
//  Created by Zeaho on 2017/8/25.
//  Copyright © 2017年 Zeaho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHEmptyDataSetPlaceholderView : UIView

@property (nonatomic, strong, readonly) UIView *contentView;

@property (nonatomic, assign) UIEdgeInsets contentInsets;

+ (instancetype)placeholder;
+ (instancetype)placeholderWithImage:(UIImage *)image;
+ (instancetype)placeholderWithImage:(UIImage *)image title:(NSString *)title;
+ (instancetype)placeholderWithImage:(UIImage *)image title:(NSString *)title subtitle:(NSString *)subtitle;
+ (instancetype)placeholderWithImage:(UIImage *)image title:(NSString *)title subtitle:(NSString *)subtitle buttonTitle:(NSString *)buttonTitle;

- (instancetype)initWithImage:(UIImage *)image;
- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title;
- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title subtitle:(NSString *)subtitle;
- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title subtitle:(NSString *)subtitle buttonTitle:(NSString *)buttonTitle;

- (void)appendImage:(UIImage *)image completion:(void (^)(UIImageView *imageView, CGFloat *offset, CGFloat *height))completion;
- (void)appendTitle:(NSString *)title completion:(void (^)(UILabel *titleLabel, CGFloat *offset, CGFloat *height))completion;
- (void)appendSubTitle:(NSString *)subtitle completion:(void (^)(UILabel *subtitleLabel, CGFloat *offset, CGFloat *height))completion;
- (void)appendButtonWithTitle:(NSString *)title completion:(void (^)(UIButton *button, CGFloat *offset, CGFloat *height))completion;
- (void)appendView:(UIView *)view completion:(void (^)(UIView *view, CGFloat *offset, CGFloat *height))completion;

@end
