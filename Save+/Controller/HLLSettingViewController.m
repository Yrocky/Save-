//
//  HLLSettingViewController.m
//  Save+
//
//  Created by Youngrocky on 16/6/27.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLSettingViewController.h"
#import "HLLSettingDataSource.h"
#import "NSString+Size.h"
#import "HLLSetting.h"


@interface HLLSettingViewController ()<UITableViewDelegate>

@property (nonatomic ,weak) IBOutlet UITableView * settingTableView;

@property (nonatomic ,strong) HLLSettingDataSource * dataSource;

@end
@implementation HLLSettingViewController

- (void)viewDidLoad{

    [super viewDidLoad];

    [self setupSettingUI];
    
    _dataSource = [[HLLSettingDataSource alloc] init];
    [self.dataSource configureTableView:self.settingTableView];
    self.settingTableView.dataSource = self.dataSource;
    self.settingTableView.delegate = self;
    self.settingTableView.tableHeaderView = [self tableViewHeaderView];
        
}

- (void)viewDidDisappear:(BOOL)animated{

    [super viewDidDisappear:animated];
    
    RLMResults<HLLSetting *> * result = [HLLSetting allObjects];
    
    HLLSetting * setting        = [result firstObject];
    
    if (!setting.verifyForTouchID && !setting.verifyForPassword) {
        RLMRealm * defaultRealm = [RLMRealm defaultRealm];
        
        [defaultRealm beginWriteTransaction];
        
        setting.verify = NO;
        [defaultRealm commitWriteTransaction];
    }
    
}
#pragma mark - Method

- (void) setupSettingUI{
    

}

- (UIView *) tableViewHeaderView{
    
    UIView * headerView = [UIView new];
    headerView.backgroundColor = [UIColor randomColor];
    headerView.frame = CGRectMake(0, 0, self.view.width, 0.1f);
    return headerView;
}
#pragma mark - UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.section == 0 && indexPath.row == 3) {
        NSLog(@"修改分类");
    }
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        NSLog(@"备份数据至iCloud");
    }
    
    if (indexPath.section == 3 && indexPath.row == 0) {
        NSLog(@"从iCloud更新数据");
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    [self.view endEditing:YES];
}
- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    if (section == 1) {
        CGFloat height = [self tableView:tableView heightForFooterInSection:section];
        UIView * sectionFooterView = [[UIView alloc] init];
        sectionFooterView.frame = CGRectMake(0, 0, tableView.width, height);
        sectionFooterView.backgroundColor = [UIColor clearColor];
        
        NSString * text = @"为账单添加安全设置，当数字验证以及Touch ID共同设置的时候以Touch ID为主（如果您的设备支持Touch ID）";
        CGFloat width = sectionFooterView.width - 40.0f;
        CGFloat textHeight = [text heightWithFontSize:13 forViewWidth:width];
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(20, 10, width, textHeight);
        label.text = text;
        label.numberOfLines = 0;
        label.font = [UIFont fontWithName:LATO_LIGHT size:13];
        label.textColor = [UIColor colorWithHexString:@"#999999"];
        [sectionFooterView addSubview:label];
        
        return sectionFooterView;
    }
    return nil;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    if (section == 1) {
        return 70.0f;
    }
    if (section == 2) {
        return 10.f;
    }
    return 30.f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0.1f;
}
@end
