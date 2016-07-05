//
//  HLLCheckViewController.m
//  Save+
//
//  Created by Youngrocky on 16/6/27.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLCheckViewController.h"
#import <LocalAuthentication/LAContext.h>
#import <LocalAuthentication/LAError.h>
#import "FSCalendar.h"
#import "HLLBillTableViewCell.h"
#import "HLLBillSectionHeaderView.h"
#import "HLLBillManager.h"

@interface HLLCheckViewController ()<FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance,UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet FSCalendar *calendarView;
@property (weak, nonatomic) IBOutlet UITableView *billTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarViewHeightConstraint;

@property (nonatomic ,strong) IBOutlet UIView * tableHeaderView;

@property (nonatomic ,strong) IBOutlet UIView * tableFooterView;

@property (nonatomic ,strong) HLLBillManager * billManager;

@property (nonatomic ,strong) NSMutableArray * bills;
@property (nonatomic ,strong) NSDictionary * sectionData;
@end

@implementation HLLCheckViewController

- (void)loadView{

    [super loadView];
    NSString * headerTitle = [self.calendarView stringFromDate:[NSDate date]
                                                        format:@"M月 yyyy"];
    self.title = headerTitle;
    
    
    self.calendarView.scrollDirection = FSCalendarScrollDirectionVertical; // important
    self.calendarView.backgroundColor = [UIColor whiteColor];
    self.calendarView.showsScopeHandle = YES;
    self.calendarView.scope = FSCalendarScopeMonth;
    self.calendarView.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase|FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
    self.calendarView.appearance.titleFont = [UIFont fontWithName:LATO_LIGHT size:15];
    self.calendarView.appearance.weekdayFont = [UIFont fontWithName:LATO_BOLD size:15];
    
    [self.billTableView registerNib:[HLLBillTableViewCell hll_nib]
             forCellReuseIdentifier:[HLLBillTableViewCell hll_cellIdentifier]];
    self.billTableView.backgroundColor = [UIColor whiteColor];
    self.billTableView.backgroundView = nil;
    
    self.tableFooterView.backgroundColor = [UIColor clearColor];
    
    self.billManager = [[HLLBillManager alloc] init];
    
    self.bills = [NSMutableArray array];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self calendar:self.calendarView didSelectDate:[NSDate date]];
}

#pragma mark - Action

- (IBAction)settingButtonHandle:(UIBarButtonItem *)sender {
    
    [self performSegueWithIdentifier:@"settingViewControllerIdentifier" sender:nil];
}

#pragma mark - FSCalendarDataSource

/**
 * 设置最小日期
 */
- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar{

    return [calendar dateWithYear:2010 month:2 day:1];
}

/**
 * 设置最大日期
 */
- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar{

    return [calendar endOfMonthOfDate:[NSDate date]];
}
/**
 *  设置某日期下的时间圆点个数，可以支持一天的单个事件也支持某一天的多事件，但是最高支持3个
 */
- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date
{
    return [self.billManager numberOfEventsForDate:date];
}

#pragma mark - FSCalendarDelegate

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date{

    if ([calendar isDateInToday:date]) {
        
//        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    [self.bills removeAllObjects];
    NSArray * bills = [self.billManager queryBillsAtDate:date];
    if (bills.count > 0) {
        
        [self.bills addObjectsFromArray:[self.billManager queryBillsAtDate:date]];
        self.billTableView.tableFooterView = nil;
    }else{
        self.billTableView.tableFooterView = self.tableFooterView;
    }
    self.sectionData = [self.billManager queryBillDataAtDate:date];
    
    [self.billTableView reloadData];
    
    NSLog(@"%@",[self.billManager queryBillsAtDate:date]);
}

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
{
    self.calendarViewHeightConstraint.constant = CGRectGetHeight(bounds);
    [self.view layoutIfNeeded];
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar{

    NSString * headerTitle = [calendar stringFromDate:calendar.currentPage format:@"M月 yyyy"];
  
    self.title = headerTitle;
}

#pragma mark - FSCalendarDelegateAppearance

/**
 * Asks the delegate for multiple event colors for the specific date.
 */
- (nullable NSArray *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventColorsForDate:(NSDate *)date{

    return [self.billManager eventColorsForDate:date];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.bills.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    HLLBillTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[HLLBillTableViewCell hll_cellIdentifier] forIndexPath:indexPath];
    
    HLLBill * bill = [self.bills objectAtIndex:indexPath.row];
    
    [cell hll_configureCellWithData:bill];
    
    return cell;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    
    HLLBillSectionHeaderView * sectionHeaderView = [HLLBillSectionHeaderView hll_loadWithNib];
    sectionHeaderView.frame = CGRectMake(0, 0, tableView.width, height);
    [sectionHeaderView configureSectionHeaderViewWithData:self.sectionData];
    
    return sectionHeaderView;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100.0f;
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.1f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
 
    return 50.0f;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
