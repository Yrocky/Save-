//
//  HLLSettingDataSource.m
//  Save+
//
//  Created by Youngrocky on 16/6/29.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLSettingDataSource.h"
#import "HLLSettingTableViewCell.h"
#import "HLLToggle.h"
#import "HLLSetting.h"
#import "HLLTouchIDHelper.h"

@interface HLLSettingDataSource ()

@property (nonatomic ,weak) UITableView * tableView;

@property (nonatomic ,strong) NSString * budget;
@property (nonatomic ,assign) BOOL remarks;
@property (nonatomic ,assign) BOOL location;

@property (nonatomic ,assign) BOOL verify;
@property (nonatomic ,assign) BOOL verifyForPassword;
@property (nonatomic ,assign) BOOL verifyForTouchID;

@end

@implementation HLLSettingDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        RLMResults<HLLSetting *> * result = [HLLSetting allObjects];
        
        HLLSetting * setting        = [result firstObject];
        self.budget                 = setting.budget;
        self.remarks                = setting.remarks;
        self.location               = setting.location;
        self.verify                 = setting.verify;
        self.verifyForPassword      = setting.verifyForPassword;
        self.verifyForTouchID       = setting.verifyForTouchID;

    }
    return self;
}

#pragma mark - Method

- (void) updateRealm{
    
    RLMRealm * defaultRealm = [RLMRealm defaultRealm];
    
    RLMResults<HLLSetting *> * result = [HLLSetting allObjects];
    
    HLLSetting * setting = [result firstObject];
    
    [defaultRealm beginWriteTransaction];
    
    setting.budget              = self.budget;
    setting.remarks             = self.remarks;
    setting.location            = self.location;
    setting.verify              = self.verify;
    setting.verifyForPassword   = self.verifyForPassword;
    setting.verifyForTouchID    = self.verifyForTouchID;
    
    [defaultRealm commitWriteTransaction];
}
#pragma mark - API

- (void)configureTableView:(UITableView *)tableView{

    self.tableView = tableView;
    
    [self.tableView registerNib:[HLLSettingTableViewCell hll_nib]
         forCellReuseIdentifier:[HLLSettingTableViewCell hll_cellIdentifier]];

    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        return 4;
    }
    if (section == 1) {
        if (self.verify) {
            
            __block NSInteger rows = 3;
            
//            [HLLTouchIDHelper canEvaluatePolicy:^(BOOL success, NSError *error) {
//               
//                if (success) {
//                    rows = 3;
//                }else{
//                    rows = 2;
//                }
//            }];
            return rows;
        }else{
            return 1;
        }
    }
    if (section == 2) {
        return 1;
    }
    if (section == 3) {
        return 1;
    }
    return 0;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{

    return 4;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    HLLSettingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[HLLSettingTableViewCell hll_cellIdentifier] forIndexPath:indexPath];
    cell.textLabel.font = [UIFont fontWithName:LATO_REGULAR size:16];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.textColor = [UIColor colorWithHexString:@"333333"];
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            cell.textLabel.text = @"每月消费预算(元)";
            UITextField * budgetTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
            budgetTextField.text = self.budget;
            budgetTextField.font = [UIFont fontWithName:LATO_REGULAR size:15];
            budgetTextField.keyboardType = UIKeyboardTypeNumberPad;
            budgetTextField.textAlignment = NSTextAlignmentRight;
            budgetTextField.textColor = [UIColor colorWithHexString:@"21AF73"];
            budgetTextField.tintColor = [UIColor colorWithHexString:@"21AF73"];
            budgetTextField.placeholder = @"预算金额";
            [budgetTextField addTarget:self action:@selector(budgetChangeTextHandle:) forControlEvents:UIControlEventEditingChanged];
            cell.accessoryView = budgetTextField;
        }
        if (indexPath.row == 1) {
            cell.textLabel.text = @"记账备注";
            HLLToggle * toggle = [[HLLToggle alloc] init];
            toggle.on = self.remarks;
            [toggle addTarget:self action:@selector(remarksSwitchHandle:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView = toggle;
        }
        if (indexPath.row == 2) {
            cell.textLabel.text = @"记账位置";
            HLLToggle * toggle = [[HLLToggle alloc] init];
            toggle.on = self.location;
            [toggle addTarget:self action:@selector(locationSwitchHandle:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView = toggle;
        }
        if (indexPath.row == 3) {
            cell.textLabel.text = @"修改记账分类";
            UIImageView * arrowImageView = [[UIImageView alloc] init];
            arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
            arrowImageView.image = [UIImage imageNamed:@"right4.png"];
            arrowImageView.bounds = CGRectMake(0, 0, 20, 30);
            cell.accessoryView = arrowImageView;
        }
    }
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            cell.textLabel.text = @"安全设置";
            HLLToggle * toggle = [[HLLToggle alloc] init];
            toggle.on = self.verify;
            [toggle addTarget:self action:@selector(verifySwithHandle:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView = toggle;
        }
        if (indexPath.row == 1) {
            cell.textLabel.text = @"数字验证";
            HLLToggle * toggle = [[HLLToggle alloc] init];
            toggle.on = self.verifyForPassword;
            [toggle addTarget:self action:@selector(verifyForPasswordSwithHandle:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView = toggle;
        }
        if (indexPath.row == 2) {
            cell.textLabel.text = @"Touch ID";
            HLLToggle * toggle = [[HLLToggle alloc] init];
            toggle.on = self.verifyForTouchID;
            [toggle addTarget:self action:@selector(verifyForTouchIDSwithHandle:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView = toggle;
        }
    }
    if (indexPath.section == 2) {
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = @"备份数据至iCloud";
        cell.accessoryView = nil;
        cell.textLabel.textColor = [UIColor colorWithHexString:@"21AF73"];
    }
    if (indexPath.section == 3) {
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = @"从iCloud更新数据";
        cell.accessoryView = nil;
        cell.textLabel.textColor = [UIColor colorWithHexString:@"d20020"];
    }
    
    return cell;
}

#pragma mark - Action

// 每月预算
- (void) budgetChangeTextHandle:(UITextField *)textField{
    
    self.budget = textField.text;
    
    [self updateRealm];
}

// 记账的备注信息
- (void) remarksSwitchHandle:(HLLToggle *)toggle{
    
    self.remarks = toggle.on;
    
    [self updateRealm];
}

// 记账的位置信息
- (void) locationSwitchHandle:(HLLToggle *)toggle{
    
    self.location = toggle.on;
    
    [self updateRealm];
}

// 记账安全
- (void) verifySwithHandle:(HLLToggle *)toggle{
    
    self.verify = toggle.on;
    
    if (!toggle.on) {
        self.verifyForPassword = NO;
        self.verifyForTouchID = NO;
    }

    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1]
                  withRowAnimation:UITableViewRowAnimationFade];
    
    [self updateRealm];
}

// 密码安全设置
- (void) verifyForPasswordSwithHandle:(HLLToggle *)toggle{
    
    self.verifyForPassword = toggle.on;
    
    if (!self.verifyForTouchID && !self.verifyForPassword) {
        
        [self verifySwithHandle:toggle];
    }else{
    
        [self updateRealm];
    }
    
}

// Touch ID安全
- (void) verifyForTouchIDSwithHandle:(HLLToggle *)toggle{
    
    self.verifyForTouchID = toggle.on;
    
    if (!self.verifyForTouchID && !self.verifyForPassword) {
        
        [self verifySwithHandle:toggle];
    }else{
    
        [self updateRealm];
    }
    
}
@end
