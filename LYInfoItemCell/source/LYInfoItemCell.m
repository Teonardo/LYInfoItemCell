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
    itemView.titleLabel.textColor = [UIColor blackColor];
    itemView.titleLabel.font = [UIFont systemFontOfSize:14.f];
    itemView.textField.textColor = [UIColor grayColor];
    itemView.textField.font = [UIFont systemFontOfSize:14.f];
    itemView.delegate = self;
    
    [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

#pragma mark - LYInfoItemViewDelegate
- (void)infoItemViewDidBeginEditing:(LYInfoItemView *)itemView {
    if ([self.delegate respondsToSelector:@selector(infoItemCellDidBeginEditing:)]) {
        [self.delegate infoItemCellDidBeginEditing:self];
    }
}

- (void)infoItemViewDidEndEditing:(LYInfoItemView *)itemView {
    if ([self.delegate respondsToSelector:@selector(infoItemCellDidEndEditing:)]) {
        [self.delegate infoItemCellDidEndEditing:self];
    }
}

#pragma mark - Setter
- (void)setLy_accessoryView:(UIView *)ly_accessoryView {
    self.itemView.accessoryView = ly_accessoryView;
}

- (void)setLy_image:(UIImage *)ly_image {
    self.itemView.image = ly_image;
}

- (void)setTitleLabelLeftMargin:(CGFloat)titleLabelLeftMargin {
    self.itemView.titleLabelLeftMargin = titleLabelLeftMargin;
}

- (void)setTitleLabelRightMargin:(CGFloat)titleLabelRightMargin {
    self.itemView.titleLabelRightMargin = titleLabelRightMargin;
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
- (UILabel *)titleLabel {
    return self.itemView.titleLabel;
}

- (UITextField *)textField {
    return self.itemView.textField;
}

- (UIView *)ly_accessoryView {
    return self.itemView.accessoryView;
}

- (UIImage *)ly_image {
    return self.itemView.image;
}

- (CGFloat)titleLabelLeftMargin {
    return self.itemView.titleLabelLeftMargin;
}

- (CGFloat)titleLabelRightMargin {
    return self.itemView.titleLabelRightMargin;
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
