//
//  HLLChartViewController.m
//  Save+
//
//  Created by Youngrocky on 16/7/7.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLChartViewController.h"
#import "HLLBillManager.h"
#import "PNChartDelegate.h"
#import "PNChart.h"

@interface HLLChartViewController ()<PNChartDelegate>

@property (nonatomic ,strong) PNPieChart *pieChart;
@property (nonatomic ,strong) UIView * legendView;
@property (nonatomic ,strong) HLLBillManager * billManager;
@end

@implementation HLLChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.billManager = [HLLBillManager sharedManager];

    self.pieChart    = [[PNPieChart alloc] initWithFrame:CGRectMake(10, 25, 250, 250) items:nil];
    self.pieChart.descriptionTextColor       = [UIColor whiteColor];
    self.pieChart.descriptionTextFont        = [UIFont fontWithName:LATO_REGULAR size:11.0];
    self.pieChart.descriptionTextShadowColor = [UIColor clearColor];
    self.pieChart.showAbsoluteValues         = NO;
    self.pieChart.enableMultipleSelection    = NO;
    self.pieChart.userInteractionEnabled     = NO;
    self.pieChart.showOnlyValues             = YES;
    self.pieChart.innerCircleRadius          = 0.0f;
    self.pieChart.backgroundColor            = [UIColor clearColor];
    [self.pieChart strokeChart];

    self.pieChart.legendStyle                = PNLegendItemStyleStacked;
    self.pieChart.legendFontColor            = kTheme_Color;
    self.pieChart.legendFont                 = [UIFont fontWithName:LATO_BOLD size:12];

    [self.view addSubview:self.pieChart];
    
    CGFloat margin = 10.0f;
    self.legendView = [self.pieChart getLegendWithMaxWidth:SCREEN_WIDTH - self.pieChart.right - margin];
    [self.legendView setFrame:CGRectMake(0, 0, self.legendView.width, self.legendView.height)];
    self.legendView.center = CGPointMake(self.pieChart.right + self.legendView.width/2 + margin, self.pieChart.centerY);
    self.legendView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.legendView];
}

#pragma mark - Method

- (NSArray *) mapBillToItemAtDate:(NSDate *)date{
    
    NSArray * bills = [self.billManager queryBillsDataAtDate:date];
    
    NSMutableArray * items = [NSMutableArray arrayWithCapacity:bills.count];
    
    for (NSDictionary * bill in bills) {
        
        PNPieChartDataItem * item = [PNPieChartDataItem dataItemWithValue:[bill[@"value"] floatValue]
                                                                    color:bill[@"color"]
                                                              description:bill[@"description"]];
        [items addObject:item];
    }
    return items;
}
#pragma mark - API

- (void) reloadChartDataAtDate:(NSDate *)date animaiton:(BOOL)animation{

    self.pieChart.displayAnimated = animation;
    
    [self reloadChartDataAtDate:date];
}
- (void) reloadChartDataAtDate:(NSDate *)date{
    
    NSArray *items = [self mapBillToItemAtDate:date];

    [self.pieChart updateChartData:items];
    [self.pieChart strokeChart];
//    
//    if (self.legendView != nil) {
//        
//        for (UIView * subView in self.legendView.subviews) {
//            [subView removeFromSuperview];
//        }
//        self.legendView = nil;
//        [self.legendView removeFromSuperview];
//    }
    
    
}

#pragma mark - PNChartDelegate


#pragma mark - PieChartDataSource

- (NSInteger)numberOfValuesForPieChart{
    
    return 18;
}

- (UIColor *)colorForValueInPieChartWithIndex:(NSInteger)lineNumber{
    
    NSInteger aRedValue   = arc4random()%255;
    NSInteger aGreenValue = arc4random()%255;
    NSInteger aBlueValue  = arc4random()%255;
    UIColor *randColor    = [UIColor colorWithRed:aRedValue/255.0f green:aGreenValue/255.0f blue:aBlueValue/255.0f alpha:1.0f];
    return randColor;
}

- (NSString *)titleForValueInPieChartWithIndex:(NSInteger)index{
    
    return [NSString stringWithFormat:@"data %ld",(long)index];
}

- (NSNumber *)valueInPieChartWithIndex:(NSInteger)index{
    
    return [NSNumber numberWithLong:random() % 100];
}

#pragma mark - PieChartDelegate

- (void)didTapOnPieChartWithValue:(NSString *)value{
    
    NSLog(@"Pie Chart: %@",value);
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
