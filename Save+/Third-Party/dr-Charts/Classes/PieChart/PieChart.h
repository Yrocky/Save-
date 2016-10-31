//
//  PieChart.h
//  dr-charts
//
//  Created by DHIREN THIRANI on 4/5/16.
//  Copyright © 2016 Product. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LegendView.h"

@protocol PieChartDelegate <NSObject>

- (void)didTapOnPieChartWithValue:(NSString *)value;

@end

@protocol PieChartDataSource <NSObject>

- (NSInteger)numberOfValuesForPieChart;
//Set number of items to be shown on the Pie Chart

- (UIColor *)colorForValueInPieChartWithIndex:(NSInteger)index;
//Set Color for each item in a Pie Chart
//Default Color is Black Color

- (NSString *)titleForValueInPieChartWithIndex:(NSInteger)index;
//Set Title for each item in a Pie Chart
//Default Title is Empty String

- (NSNumber *)valueInPieChartWithIndex:(NSInteger)index;
//Set Value for each item in a Pie Chart
//Default Value is 0

@end

@interface PieChart : UIView

@property (nonatomic, weak) id<PieChartDataSource> dataSource;
@property (nonatomic, weak) id<PieChartDelegate> delegate;

//set FONT property for the graph
@property (nonatomic, strong) UIFont *textFont; //Default is [UIFont systemFontOfSize:textFontSize];
@property (nonatomic, strong) UIColor *textColor; //Default is [UIColor blackColor]
@property (nonatomic) CGFloat textFontSize; //Default is 12

//show LEGEND with the graph
@property (nonatomic) BOOL showLegend; //Default is TRUE

//show Value on Pie Slice with the graph
@property (nonatomic) BOOL showValueOnPieSlice; //Default is TRUE

//Set LEGEND TYPE Horizontal or Vertical
@property (nonatomic) LegendType legendViewType; //Default is LegendTypeVertical i.e. VERTICAL

//show MARKER when interacting with graph
@property (nonatomic) BOOL showMarker; //Default is TRUE

//To draw the graph
- (void)drawPieChart;

//To reload data on the graph
- (void)reloadPieChart;

@end
