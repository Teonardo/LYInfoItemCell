//
//  ViewController.m
//  LYInfoItemCell
//
//  Created by Teonardo on 2019/9/20.
//  Copyright © 2019 Teonardo. All rights reserved.
//

#import "ViewController.h"
#import "MyCell.h"
#import "MyCell2.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, LYInfoItemCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *titlesArr;

@end

static NSString *const kName = @"姓名";
static NSString *const kNation = @"民族";
static NSString *const kIDNumber = @"身份证号";
static NSString *const kMobile = @"手机号";
static NSString *const kEducation = @"学历";
static NSString *const kNotification = @"开启通知";

@implementation ViewController {
    NSString *_mobile; // 记录填写的手机号
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.titlesArr = @[kName, kNation, kIDNumber, kMobile, kEducation, kNotification].mutableCopy;
    
    [self addTableView];
}

#pragma mark - UI

- (void)addTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    tableView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.2];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.rowHeight = 50;
    tableView.tableFooterView = [UIView new];
    
    [tableView registerClass:[MyCell class] forCellReuseIdentifier:NSStringFromClass([MyCell class])];
    [tableView registerClass:[MyCell2 class] forCellReuseIdentifier:NSStringFromClass([MyCell2 class])];
    
    tableView.frame = self.view.bounds;
}

#pragma mark - Handle Method
- (void)handleSwitchAction:(UISwitch *)sender {
    // 处理开关状态改变
}

#pragma mark - Delegate

#pragma mark - LYInfoItemCellDelegate

- (void)infoItemCell:(LYInfoItemCell *)cell didEndEditing:(UITextField *)textField {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSString *title = self.titlesArr[indexPath.row];
    if (title == kMobile) {
        _mobile = cell.contentTextField.text;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    
    NSString *title = self.titlesArr[indexPath.row];
    if (title == kNation) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"选择名族" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alertView show];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titlesArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *title = self.titlesArr[indexPath.row];
    
    LYInfoItemCell *cell = nil;
    if (title == kNotification) {
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyCell2 class]) forIndexPath:indexPath];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyCell class]) forIndexPath:indexPath];
    }
    
    cell.delegate = self;
    
    // 注意:需要先将所有用到的存在差异的 特性/属性 统一进行重置(默认设置), 然后在针对不同的Item 进行差异设置, 以避免cell重用带来的影响.
    
    cell.ly_accessoryView.hidden = YES;
    cell.contentTextField.enabled = NO;
    cell.contentTextField.text = nil;
    cell.contentTextField.placeholder = nil;
    cell.autoAlignment = YES;
    cell.fixedTitleWidth = -1;
    cell.contentTextField.textAlignment = NSTextAlignmentRight;
    cell.titleTextField.leftView = nil;
    
    cell.titleTextField.text = title;
    
    // 差异化设置
    if (indexPath.section == 0) {
        cell.autoAlignment = NO;
    }
    
    if (title == kName) {
        cell.contentTextField.text = @"孙行者";
    }
    else if (title == kNation) {
        cell.contentTextField.placeholder = @"请选择";
        
        cell.ly_accessoryView.hidden = NO;
    }
    else if (title == kIDNumber) {
        cell.contentTextField.text = @"340823199906065555-340823199906065555-340823199906065555";
    }
    else if (title == kMobile) {
        cell.contentTextField.enabled = YES; // 打开输入
        cell.contentTextField.placeholder = @"请输入手机号";
    }
    else if (title == kEducation) {
        cell.contentTextField.text = @"未知";
    }
    else if (title == kNotification) {
        cell.contentTextField.text = @"状态";
        cell.ly_accessoryView.hidden = NO;
    }
    
    // 第三分区 固定标题宽度
    if (indexPath.section == 2) {
        cell.fixedTitleWidth = 80;
        cell.contentTextField.textAlignment = NSTextAlignmentLeft;
    }
    
    // 左边显示图片
    if (indexPath.section == 3) {
        cell.titleTextField.leftView = ({
            
            UIImageView *imgView = [UIImageView new];
            imgView.contentMode = UIViewContentModeCenter;
            imgView.image = [UIImage imageNamed:@"tag"];
            imgView.frame = CGRectMake(0, 0, 30, 30);
            imgView.layer.cornerRadius = 15;
            imgView.layer.masksToBounds = YES;
            imgView.backgroundColor = [UIColor redColor];
            UIView *view = imgView;
            
            // iOS 13 textField.leftView 适配
            if (@available(iOS 13, *)) {
                view = [UIView new];
                view.frame = imgView.bounds;
                [view addSubview:imgView];
            }
            
            view;
        });
        cell.titleTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"内容文本对齐";
    }
    else if (section == 1) {
        return @"内容整体右对齐";
    }
    else if (section == 2) {
        return @"固定标题宽度";
    }
    else if (section == 3) {
        return @"左边显示图片";
    }
    return nil;
}

#pragma mark - Getter


@end
