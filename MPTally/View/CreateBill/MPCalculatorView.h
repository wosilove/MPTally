//
//  MPCalculatorView.h
//  MPTally
//
//  Created by Maple on 2017/3/7.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MPCalculatorView;

@protocol MPCalculatorViewDelegate <NSObject>

@optional
/// 点击了日历
- (void)calculatorViewDidClickCalendar:(MPCalculatorView *)view;
/// 点击了账本
- (void)calculatorViewDidClickAccount:(MPCalculatorView *)view;
/// 点击了备注
- (void)calculatorViewDidClickRemark:(MPCalculatorView *)view;
/// 点击了计算器按钮时，传递结果值
- (void)calculatorView:(MPCalculatorView *)view passTheResult:(NSString *)result;

@end

/// 计算器View
@interface MPCalculatorView : UIView

@property (nonatomic, weak) id<MPCalculatorViewDelegate> delegate;
@property (nonatomic, strong) NSDate *selectedDate;

@end