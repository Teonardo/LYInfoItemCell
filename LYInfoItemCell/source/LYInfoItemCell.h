//
//  LYInfoItemCell.h
//  LYInfoItemCell
//
//  Created by Teonardo on 2019/9/20.
//  Copyright © 2019 Teonardo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LYInfoItemCell;
@protocol LYInfoItemCellDelegate <NSObject>
@optional
- (void)infoItemCellDidBeginEditing:(LYInfoItemCell *)cell;
- (void)infoItemCellDidEndEditing:(LYInfoItemCell *)cell;

@end

@interface LYInfoItemCell : UITableViewCell

@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UITextField *textField;

/**
 最右边的"附件"视图.
 默认懒加载为ImageView, 也可以赋值成自定义视图.
 */
@property (nonatomic, strong, null_resettable) UIView *ly_accessoryView;

/**
 两种情况:
 1 accessoryView 为UIImageView 类型: 直接将 image 赋值給 accessoryView 的 image 属性.
 2 accessoryView 不为UIImageView 类型: 先初始化一个ImageView对象将其赋值給 accessoryView 属性, 然后再将 image 赋值給 accessoryView 的 image 属性.
 */
@property (nonatomic, strong, nullable) UIImage *ly_image;

@property (nonatomic, assign) CGFloat titleLabelLeftMargin;
@property (nonatomic, assign) CGFloat titleLabelRightMargin;
@property (nonatomic, assign) CGFloat accessoryViewLeftMargin;
@property (nonatomic, assign) CGFloat accessoryViewRightMargin;

/**
 如果设置大于零的值, 则标题的宽度固定;
 如果设置小于零的值(如-1), 则表示标题宽度自适应
 */
@property (nonatomic, assign) CGFloat fixedTitleWidth;

/**
 在 ly_accessoryView.hide == YES 时, 是否将 textField 的右边与ly_accessoryView对齐.
 */
@property (nonatomic, assign) BOOL autoAlignment;

@property (nonatomic, weak) id<LYInfoItemCellDelegate> delegate;
@property (nonatomic, copy) void (^didBeginEditing)(UITextField *textField);
@property (nonatomic, copy) void (^didEndEditing)(UITextField *textField);

@end

NS_ASSUME_NONNULL_END
