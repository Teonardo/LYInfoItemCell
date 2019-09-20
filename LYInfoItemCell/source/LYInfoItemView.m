//
//  LYInfoItemView.m
//  ExpertDatabase
//
//  Created by Teonardo on 2019/7/26.
//  Copyright © 2019 Teonardo. All rights reserved.
//

#import "LYInfoItemView.h"
#import "Masonry.h"

@interface LYInfoItemView () <UITextFieldDelegate>

@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, strong, readwrite) UITextField *textField;

@end

@implementation LYInfoItemView
@synthesize accessoryView = _accessoryView;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 默认设置
        _titleLabelLeftMargin = 18;
        _titleLabelRightMargin = 8;
        _accessoryViewLeftMargin = 8;
        _accessoryViewRightMargin = 18;
        _fixedTitleWidth = -1;
    }
    return self;
}

#pragma mark - Override Method

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(self.titleLabelLeftMargin);
        make.centerY.equalTo(self);
        
        if (self->_textField == nil) {
            if (self->_accessoryView) {
                make.right.lessThanOrEqualTo(self->_accessoryView.mas_left).offset(self.accessoryViewLeftMargin);
            } else {
                make.right.lessThanOrEqualTo(self).offset(self.accessoryViewRightMargin);
            }
        }
        
        if (self.fixedTitleWidth > 0) {
            make.width.mas_equalTo(self.fixedTitleWidth);
        }
        
    }];
    
    [_textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        if (self->_titleLabel) {
            make.left.equalTo(self->_titleLabel.mas_right).offset(self.titleLabelRightMargin);
        } else {
            make.left.equalTo(self).offset(self.titleLabelLeftMargin);
        }
        
        make.top.bottom.equalTo(self);
        
        if (self->_accessoryView) {
            if (self->_accessoryView.hidden && self.autoAlignment) {
                make.right.equalTo(self->_accessoryView);
            } else {
                make.right.equalTo(self->_accessoryView.mas_left).offset(-self.accessoryViewLeftMargin);
            }
        } else {
            make.right.equalTo(self).offset(-self.accessoryViewRightMargin);
        }
        
    }];
    
    [_accessoryView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo([self accessoryViewSize]);
        make.right.equalTo(self).offset(-self.accessoryViewRightMargin);
        make.centerY.equalTo(self);
    }];
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(UIViewNoIntrinsicMetric, 50);
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    !self.didBeginEditing ? : self.didBeginEditing(textField);
    if ([self.delegate respondsToSelector:@selector(infoItemViewDidBeginEditing:)]) {
        [self.delegate infoItemViewDidBeginEditing:self];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    !self.didEndEditing ? : self.didEndEditing(textField);
    if ([self.delegate respondsToSelector:@selector(infoItemViewDidEndEditing:)]) {
        [self.delegate infoItemViewDidEndEditing:self];
    }
}

#pragma mark - Setter
- (void)setAccessoryView:(UIView *)accessoryView {
    if (_accessoryView != accessoryView) {
        [_accessoryView removeFromSuperview];
        [self addSubview:accessoryView];
        _accessoryView = accessoryView;
        [self setNeedsLayout];
    }
}

- (void)setImage:(UIImage *)image {
    if (_image != image) {
        _image = image;
        if (![self.accessoryView isKindOfClass:[UIImageView class]]) {
            self.accessoryView = [UIImageView new];
        }
        [(UIImageView *)self.accessoryView setImage:image];
        [self setNeedsLayout];
    }
}

- (void)setTitleLabelLeftMargin:(CGFloat)titleLabelLeftMargin {
    if (titleLabelLeftMargin < 0) {
        return;
    }
    if (_titleLabelLeftMargin != titleLabelLeftMargin) {
        _titleLabelLeftMargin = titleLabelLeftMargin;
        [self setNeedsLayout];
    }
}

- (void)setTitleLabelRightMargin:(CGFloat)titleLabelRightMargin {
    if (titleLabelRightMargin < 0) {
        return;
    }
    if (_titleLabelRightMargin != titleLabelRightMargin) {
        _titleLabelRightMargin = titleLabelRightMargin;
        [self setNeedsLayout];
    }
}

- (void)setAccessoryViewLeftMargin:(CGFloat)accessoryViewLeftMargin {
    if (accessoryViewLeftMargin < 0) {
        return;
    }
    if (_accessoryViewLeftMargin != accessoryViewLeftMargin) {
        _accessoryViewLeftMargin = accessoryViewLeftMargin;
        [self setNeedsLayout];
    }
}

- (void)setAccessoryViewRightMargin:(CGFloat)accessoryViewRightMargin {
    if (accessoryViewRightMargin < 0) {
        return;
    }
    if (_accessoryViewRightMargin != accessoryViewRightMargin) {
        _accessoryViewRightMargin = accessoryViewRightMargin;
        [self setNeedsLayout];
    }
}

- (void)setFixedTitleWidth:(CGFloat)fixedTitleWidth {
    if (_fixedTitleWidth != fixedTitleWidth) {
        _fixedTitleWidth = fixedTitleWidth;
        [self setNeedsLayout];
    }
}

#pragma mark - Getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15.0];
        //_titleLabel.backgroundColor = [UIColor orangeColor];
        [_titleLabel setContentHuggingPriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.textAlignment = NSTextAlignmentRight;
        //_textField.backgroundColor = [UIColor cyanColor];
        _textField.font = [UIFont systemFontOfSize:15.0];
        [_textField setContentHuggingPriority:999 forAxis:UILayoutConstraintAxisHorizontal];
        _textField.delegate = self;
        [self addSubview:_textField];
    }
    return _textField;
}

- (UIView *)accessoryView {
    if (!_accessoryView) {
        _accessoryView = [[UIImageView alloc] init];
        [self addSubview:_accessoryView];
    }
    return _accessoryView;
}

- (CGSize)accessoryViewSize {
    if (!_accessoryView) {
        return CGSizeZero;
    }
    
    // 如果设置了大小(不为CGSizeZero), 直接取size
    if (!CGSizeEqualToSize(_accessoryView.bounds.size, CGSizeZero)) {
        return _accessoryView.bounds.size;
    }
    
    // 没有设置尺寸
    // 1> accessoryView 为 ImageView
    if ([_accessoryView isKindOfClass:[UIImageView class]]) {
        UIImage *image = [(UIImageView *)_accessoryView image];
        return image.size;
    }
    // 2> accessoryView 不为 ImageView
    else {
        return CGSizeMake(30, 30);
    }
}

@end
