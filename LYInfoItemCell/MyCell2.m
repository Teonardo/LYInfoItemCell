//
//  MyCell2.m
//  LYInfoItemCell
//
//  Created by Teonardo on 2019/12/25.
//  Copyright © 2019 Teonardo. All rights reserved.
//

#import "MyCell2.h"

@implementation MyCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 自定义 accessoryView
        UISwitch *swi = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        [swi addTarget:self action:@selector(handleSwitchAction:) forControlEvents:UIControlEventValueChanged];
        self.ly_accessoryView = swi;
        self.swi = swi;
    }
    return self;
}

#pragma mark - Action
- (void)handleSwitchAction:(UISwitch *)sender {
    // 处理开关状态改变
    !self.switchAction ? : self.switchAction(sender);
}

@end
