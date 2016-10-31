//
//  HLLChartView.m
//  Save+
//
//  Created by Youngrocky on 16/7/5.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLChartView.h"
#import "DrGraphs.h"


@interface HLLChartView ()<PieChartDataSource, PieChartDelegate>

@property (nonatomic ,strong) IBOutlet PieChart * chartView;

@end

@implementation HLLChartView

- (void)awakeFromNib{

    [super awakeFromNib];
    
//    self.chartView = [[PieChart alloc] init];
    self.chartView.delegate = self;
    self.chartView.dataSource = self;
    self.chartView.legendViewType = LegendTypeHorizontal;
    [self test];
//    [self addSubview:self.chartView];

}

- (void)didMoveToSuperview{

    [super didMoveToSuperview];
    
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
}

#pragma mark - method

- (void) test{
    
    [self.chartView drawPieChart];
    self.chartView.backgroundColor = [UIColor randomColor];
}

#pragma mark - API

- (void) creatChartView{
    
    
}
#pragma mark - PieChartDataSource

- (NSInteger)numberOfValuesForPieChart{
    
    return 8;
}

- (UIColor *)colorForValueInPieChartWithIndex:(NSInteger)lineNumber{
    
    NSInteger aRedValue = arc4random()%255;
    NSInteger aGreenValue = arc4random()%255;
    NSInteger aBlueValue = arc4random()%255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue/255.0f green:aGreenValue/255.0f blue:aBlueValue/255.0f alpha:1.0f];
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


@end
