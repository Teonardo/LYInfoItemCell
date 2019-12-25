//
//  MyCell2.h
//  LYInfoItemCell
//
//  Created by Teonardo on 2019/12/25.
//  Copyright © 2019 Teonardo. All rights reserved.
//

#import "LYInfoItemCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyCell2 : LYInfoItemCell

@property (nonatomic, strong) UISwitch *swi;

@property (nonatomic, copy) void(^switchAction)(UISwitch *swi);

@end

NS_ASSUME_NONNULL_END
