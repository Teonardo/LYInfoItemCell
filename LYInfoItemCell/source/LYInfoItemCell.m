//
//  LYInfoItemCell.m
//  LYInfoItemCell
//
//  Created by Teonardo on 2019/9/20.
//  Copyright © 2019 Teonardo. All rights reserved.
//

#import "LYInfoItemCell.h"
#import "LYInfoItemView.h"
#import "Masonry.h"

@interface LYInfoItemCell () <LYInfoItemViewDelegate>
@property (nonatomic, weak) LYInfoItemView *itemView;
@end

@implementation LYInfoItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self iic_customUI];
    }
    return self;
}

#pragma mark - UI
- (void)iic_customUI {
    LYInfoItemView *itemView = [[LYInfoItemView alloc] init];
    [self.contentView addSubview:itemView];
    self.itemView = itemView;
    itemView.titleTextField.textColor = [UIColor blackColor];
    itemView.titleTextField.font = [UIFont systemFontOfSize:14.f];
    itemView.contentTextField.textColor = [UIColor grayColor];
    itemView.contentTextField.font = [UIFont systemFontOfSize:14.f];
    itemView.delegate = self;
    
    [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

#pragma mark - LYInfoItemViewDelegate
- (void)infoItemView:(LYInfoItemView *)itemView didBeginEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(infoItemCell:didBeginEditing:)]) {
        [self.delegate infoItemCell:self didBeginEditing:textField];
    }
}

- (void)infoItemView:(LYInfoItemView *)itemView didEndEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(infoItemCell:didEndEditing:)]) {
        [self.delegate infoItemCell:self didEndEditing:textField];
    }
}

#pragma mark - Setter
- (void)setLy_accessoryView:(UIView *)ly_accessoryView {
    self.itemView.accessoryView = ly_accessoryView;
}

- (void)setLy_image:(UIImage *)ly_image {
    self.itemView.image = ly_image;
}

- (void)setTitleTextFieldLeftMargin:(CGFloat)titleTextFieldLeftMargin {
    self.itemView.titleTextFieldLeftMargin = titleTextFieldLeftMargin;
}

- (void)setTitleTextFieldRightMargin:(CGFloat)titleTextFieldRightMargin {
    self.itemView.titleTextFieldRightMargin = titleTextFieldRightMargin;
}

- (void)setAccessoryViewLeftMargin:(CGFloat)accessoryViewLeftMargin {
    self.itemView.accessoryViewLeftMargin = accessoryViewLeftMargin;
}

- (void)setAccessoryViewRightMargin:(CGFloat)accessoryViewRightMargin {
    self.itemView.accessoryViewRightMargin = accessoryViewRightMargin;
}

- (void)setFixedTitleWidth:(CGFloat)fixedTitleWidth {
    self.itemView.fixedTitleWidth = fixedTitleWidth;
}

- (void)setAutoAlignment:(BOOL)autoAlignment {
    self.itemView.autoAlignment = autoAlignment;
}

- (void)setDidBeginEditing:(void (^)(UITextField * _Nonnull))didBeginEditing {
    self.itemView.didBeginEditing = didBeginEditing;
}

- (void)setDidEndEditing:(void (^)(UITextField * _Nonnull))didEndEditing {
    self.itemView.didEndEditing = didEndEditing;
}

#pragma mark - Getter
- (UITextField *)titleTextField {
    return self.itemView.titleTextField;
}

- (UITextField *)contentTextField {
    return self.itemView.contentTextField;
}

- (UIView *)ly_accessoryView {
    return self.itemView.accessoryView;
}

- (UIImage *)ly_image {
    return self.itemView.image;
}

- (CGFloat)titleTextFieldLeftMargin {
    return self.itemView.titleTextFieldLeftMargin;
}

- (CGFloat)titleTextFieldRightMargin {
    return self.itemView.titleTextFieldRightMargin;
}

- (CGFloat)accessoryViewLeftMargin {
    return self.itemView.accessoryViewLeftMargin;
}

- (CGFloat)accessoryViewRightMargin {
    return self.itemView.accessoryViewRightMargin;
}

- (CGFloat)fixedTitleWidth {
    return self.itemView.fixedTitleWidth;
}

- (BOOL)autoAlignment {
    return self.itemView.autoAlignment;
}

- (void (^)(UITextField * _Nonnull))didBeginEditing {
    return self.itemView.didBeginEditing;
}

- (void (^)(UITextField * _Nonnull))didEndEditing {
    return self.itemView.didEndEditing;
}

@end
