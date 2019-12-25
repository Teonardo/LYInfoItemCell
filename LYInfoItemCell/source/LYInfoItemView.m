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

@property (nonatomic, strong, readwrite) UITextField *titleTextField;
@property (nonatomic, strong, readwrite) UITextField *contentTextField;

@end

@implementation LYInfoItemView {
    CGSize _accessoryViewSizeForSwitch;
}
@synthesize accessoryView = _accessoryView;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 默认设置
        _titleTextFieldLeftMargin = 18;
        _titleTextFieldRightMargin = 8;
        _accessoryViewLeftMargin = 8;
        _accessoryViewRightMargin = 18;
        _fixedTitleWidth = -1;
    }
    return self;
}

#pragma mark - Override Method

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_titleTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(self.titleTextFieldLeftMargin);
        make.centerY.equalTo(self);
        
        if (self->_contentTextField == nil) {
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
    
    [_contentTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        if (self->_titleTextField) {
            make.left.equalTo(self->_titleTextField.mas_right).offset(self.titleTextFieldRightMargin);
        } else {
            make.left.equalTo(self).offset(self.titleTextFieldLeftMargin);
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
    if ([self.delegate respondsToSelector:@selector(infoItemView:didBeginEditing:)]) {
        [self.delegate infoItemView:self didBeginEditing:textField];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    !self.didEndEditing ? : self.didEndEditing(textField);
    if ([self.delegate respondsToSelector:@selector(infoItemView:didEndEditing:)]) {
        [self.delegate infoItemView:self didEndEditing:textField];
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
        if (![_accessoryView isKindOfClass:[UIImageView class]]) {
            self.accessoryView = [UIImageView new];
        }
        [(UIImageView *)self.accessoryView setImage:image];
        [self setNeedsLayout];
    }
}

- (void)setTitleTextFieldLeftMargin:(CGFloat)titleTextFieldLeftMargin {
    if (titleTextFieldLeftMargin < 0) {
        return;
    }
    if (_titleTextFieldLeftMargin != titleTextFieldLeftMargin) {
        _titleTextFieldLeftMargin = titleTextFieldLeftMargin;
        [self setNeedsLayout];
    }
}

- (void)setTitleTextFieldRightMargin:(CGFloat)titleTextFieldRightMargin {
    if (titleTextFieldRightMargin < 0) {
        return;
    }
    if (_titleTextFieldRightMargin != titleTextFieldRightMargin) {
        _titleTextFieldRightMargin = titleTextFieldRightMargin;
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
- (UITextField *)titleTextField {
    if (!_titleTextField) {
        _titleTextField = [[UITextField alloc] init];
        _titleTextField.font = [UIFont systemFontOfSize:15.0];
        //_titleTextField.backgroundColor = [UIColor orangeColor];
        [_titleTextField setContentHuggingPriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
        _titleTextField.delegate = self;
        _titleTextField.enabled = NO;
        [self addSubview:_titleTextField];
    }
    return _titleTextField;
}

- (UITextField *)contentTextField {
    if (!_contentTextField) {
        _contentTextField = [[UITextField alloc] init];
        _contentTextField.textAlignment = NSTextAlignmentRight;
        //_contentTextField.backgroundColor = [UIColor cyanColor];
        _contentTextField.font = [UIFont systemFontOfSize:15.0];
        [_contentTextField setContentHuggingPriority:999 forAxis:UILayoutConstraintAxisHorizontal];
        _contentTextField.delegate = self;
        _contentTextField.enabled = NO;
        [self addSubview:_contentTextField];
    }
    return _contentTextField;
}

- (CGSize)accessoryViewSize {
    if (!_accessoryView) {
        return CGSizeZero;
    }
    
    // ???: 如果是 UISwitch, 必须记录第一获取到的size, 不然每次获取时 size 都会变大
    if ([_accessoryView isKindOfClass:[UISwitch class]]) {
        if (CGSizeEqualToSize(_accessoryViewSizeForSwitch, CGSizeZero)) {
            _accessoryViewSizeForSwitch = _accessoryView.bounds.size;
        }
        return _accessoryViewSizeForSwitch;
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
