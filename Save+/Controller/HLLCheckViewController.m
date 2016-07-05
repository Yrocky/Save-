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

@interface HLLCheckViewController ()<FSCalendarDataSource,FSCalendarDelegate>
@property (weak, nonatomic) IBOutlet FSCalendar *calendarView;
@property (weak, nonatomic) IBOutlet UITableView *billTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarViewHeightConstraint;

@end

@implementation HLLCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString * headerTitle = [self.calendarView stringFromDate:[NSDate date]
                                                        format:@"M月 yyyy"];
    self.title = headerTitle;
    
    self.calendarView.scrollDirection = FSCalendarScrollDirectionVertical; // important
    self.calendarView.backgroundColor = [UIColor whiteColor];
    self.calendarView.showsScopeHandle = YES;
    self.calendarView.scope = FSCalendarScopeMonth;
    self.calendarView.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase|FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;

}

#pragma mark - Action

- (IBAction)settingButtonHandle:(UIBarButtonItem *)sender {
    
    [self performSegueWithIdentifier:@"settingViewControllerIdentifier" sender:nil];
}

#pragma mark - FSCalendarDataSource

/**
 * Asks the dataSource for a title for the specific date as a replacement of the day text
 */
//- (nullable NSString *)calendar:(FSCalendar *)calendar titleForDate:(NSDate *)date;

/**
 * Asks the dataSource for a subtitle for the specific date under the day text.
 */
//- (nullable NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date;

/**
 * Asks the dataSource for an image for the specific date.
 */
//- (nullable UIImage *)calendar:(FSCalendar *)calendar imageForDate:(NSDate *)date;

/**
 * Asks the dataSource the minimum date to display.
 */
- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar{

    return [calendar dateWithYear:2010 month:2 day:1];
}

/**
 * Asks the dataSource the maximum date to display.
 */
- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar{

    return [calendar endOfMonthOfDate:[NSDate date]];
}

#pragma mark - FSCalendarDelegate

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date{

    if ([date isEqual:[NSDate date]]) {
        
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
{
    self.calendarViewHeightConstraint.constant = CGRectGetHeight(bounds);
    [self.view layoutIfNeeded];
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar{

    NSLog(@"%@",calendar.currentPage);
    NSString * headerTitle = [calendar stringFromDate:calendar.currentPage format:@"M月 yyyy"];
    self.title = headerTitle;
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
