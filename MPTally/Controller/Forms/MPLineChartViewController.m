//
//  MPLineChartViewController.m
//  MPTally
//
//  Created by Maple on 2017/3/27.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPLineChartViewController.h"
#import "MPTally-Bridging-Header.h"
#import "SymbolsValueFormatter.h"
#import "DateValueFormatter.h"
#import "SetValueFormatter.h"

@interface MPLineChartViewController ()<ChartViewDelegate>

@property (nonatomic, strong) LineChartView *lineView;

@end

@implementation MPLineChartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  _lineView = [[LineChartView alloc] initWithFrame:CGRectMake(0, 50, kScreenW, kScreenH-200)];
  _lineView.delegate = self;//设置代理
  _lineView.backgroundColor =  [UIColor whiteColor];
  _lineView.noDataText = @"暂无数据";
  _lineView.chartDescription.enabled = YES;
  _lineView.scaleYEnabled = NO;//取消Y轴缩放
  _lineView.doubleTapToZoomEnabled = NO;//取消双击缩放
  _lineView.dragEnabled = NO;//启用拖拽图标
  _lineView.dragDecelerationEnabled = NO;//拖拽后是否有惯性效果
  _lineView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
//  _lineView.scaleYEnabled = NO; // 关闭缩放
//  _lineView.scaleXEnabled = NO;
  
  //描述及图例样式
  [_lineView setDescriptionText:@""];
  _lineView.legend.enabled = NO;
  [_lineView animateWithXAxisDuration:1.0f];
  
  
  _lineView.rightAxis.enabled = NO;//不绘制右边轴
  ChartYAxis *leftAxis = _lineView.leftAxis;//获取左边Y轴
  leftAxis.labelCount = 5;//Y轴label数量，数值不一定，如果forceLabelsEnabled等于YES, 则强制绘制制定数量的label, 但是可能不平均
  leftAxis.forceLabelsEnabled = NO;//不强制绘制指定数量的label
  // leftAxis.axisMinValue = 0;//设置Y轴的最小值
  //leftAxis.axisMaxValue = 105;//设置Y轴的最大值
  leftAxis.inverted = NO;//是否将Y轴进行上下翻转
  leftAxis.axisLineColor = [UIColor clearColor];//Y轴颜色
  leftAxis.labelPosition = YAxisLabelPositionOutsideChart;//label位置
  leftAxis.labelTextColor = [UIColor blackColor];//文字颜色
  leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];//文字字体
  leftAxis.gridColor = [UIColor grayColor];//网格线颜色
  leftAxis.gridAntialiasEnabled = NO;//开启抗锯齿
  leftAxis.valueFormatter = [[SymbolsValueFormatter alloc]init];//设置y轴的数据格
  
  ChartXAxis *xAxis = _lineView.xAxis;
  xAxis.granularityEnabled = YES;//设置重复的值不显示
  xAxis.labelPosition= XAxisLabelPositionBottom;//设置x轴数据在底部
  xAxis.gridColor = [UIColor clearColor];
  xAxis.labelTextColor = [UIColor blackColor];//文字颜色
  xAxis.axisLineColor = [UIColor grayColor];
  _lineView.maxVisibleCount = 999;//设置能够显示的数据数量
  
   _lineView.data = [self setData];  //设置折线图的数据
  
  [self.view addSubview:_lineView];
}

- (LineChartData *)setData
{
  NSInteger xVals_count = 50;//X轴上要显示多少条数据
  //X轴上面需要显示的数据
  NSMutableArray *xVals = [[NSMutableArray alloc] init];
  
  for (int i = 1; i <= xVals_count; i++) {
    if (i<30) {
      [xVals addObject: [NSString stringWithFormat:@"02-%d",i]];
    }else{
      [xVals addObject: [NSString stringWithFormat:@"03-%d",i-29]];
    }
  }
  _lineView.xAxis.valueFormatter = [[DateValueFormatter alloc]initWithArr:xVals];
  
  //对应Y轴上面需要显示的数据
  NSMutableArray *yVals = [[NSMutableArray alloc] init];
  for (int i = 0; i < xVals_count; i++) {
    int a = arc4random() % 100;
    ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:a];
    [yVals addObject:entry];
  }
  NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
  for (int i = 0; i <  xVals_count; i++) {
    int a = arc4random() % 80;
    ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:a];
    [yVals2 addObject:entry];
  }
  
  LineChartDataSet *set1 = [[LineChartDataSet alloc]initWithValues:yVals label:nil];
  //设置折线的样式
  set1.lineWidth = 2.0/[UIScreen mainScreen].scale;//折线宽度
  
  set1.drawValuesEnabled = YES;//是否在拐点处显示数据
  set1.valueFormatter = [[SetValueFormatter alloc]initWithArr:yVals];
  
  set1.valueColors = @[[UIColor brownColor]];//折线拐点处显示数据的颜色
  
  [set1 setColor:[UIColor greenColor]];//折线颜色
  set1.highlightColor = [UIColor redColor];
  set1.drawSteppedEnabled = NO;//是否开启绘制阶梯样式的折线图
  //折线拐点样式
  set1.drawCirclesEnabled = NO;//是否绘制拐点
  set1.drawFilledEnabled = NO;//是否填充颜色
  //将 LineChartDataSet 对象放入数组中
  NSMutableArray *dataSets = [[NSMutableArray alloc] init];
  [dataSets addObject:set1];
  
  //添加第二个LineChartDataSet对象
  
  yVals2 = [[NSMutableArray alloc] init];
  for (int i = 0; i <  xVals_count; i++) {
    int a = arc4random() % 80;
    ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:a];
    [yVals2 addObject:entry];
  }
  LineChartDataSet *set2 = [set1 copy];
  set2.values = yVals2;
  set2.drawValuesEnabled = NO;
  [set2 setColor:[UIColor blueColor]];
  
  [dataSets addObject:set2];
  
  //创建 LineChartData 对象, 此对象就是lineChartView需要最终数据对象
  LineChartData *data = [[LineChartData alloc]initWithDataSets:dataSets];
  
  [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11.f]];//文字字体
  [data setValueTextColor:[UIColor blackColor]];//文字颜色
  
  
  return data;
}



@end
