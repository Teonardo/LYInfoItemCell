//
//  MyCell.m
//  LYInfoItemCell
//
//  Created by Teonardo on 2019/12/25.
//  Copyright © 2019 Teonardo. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 自定义 字体 和 文字颜色
        self.titleTextField.textColor = [UIColor blackColor];
        self.titleTextField.font = [UIFont systemFontOfSize:14.f];
        self.contentTextField.textColor = [UIColor grayColor];
        self.contentTextField.font = [UIFont systemFontOfSize:14.f];
        
        // 使用 accessoryView 显示图片
        self.ly_image = [UIImage imageNamed:@"arrow_right_gray"];
    }
    return self;
}

#pragma mark - UI


@end
