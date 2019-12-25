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
        
        // 使用 accessoryView 显示图片
        self.ly_image = [UIImage imageNamed:@"arrow_right_gray"];
    }
    return self;
}

#pragma mark - UI


@end
