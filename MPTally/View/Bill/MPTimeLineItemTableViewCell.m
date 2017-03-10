 //
//  MPBillTableViewCell.m
//  MPTally
//
//  Created by Maple on 2017/3/9.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPTimeLineItemTableViewCell.h"

@interface MPTimeLineItemTableViewCell ()

/// 类型按钮
@property (nonatomic, weak) UIButton *categoryButton;
/// 支出类型TitleLabel
@property (nonatomic, weak) UILabel *outComeCateTitleLabel;
/// 收入类型TitleLabel
@property (nonatomic, weak) UILabel *inComeCateTitleLabel;
/// 支出类型备注
@property (nonatomic, weak) UILabel *outComeRemarkLabel;
/// 收入类型备注
@property (nonatomic, weak) UILabel *inComeRemarkLabel;
/// 收入
@property (nonatomic, weak) UILabel *inComeNumLabel;
/// 支出
@property (nonatomic, weak) UILabel *outComeNumLabel;

@end

@implementation MPTimeLineItemTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
  {
    [self setup];
  }
  return self;
}

- (void)setup
{
  [self.categoryButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(self.contentView);
    make.top.equalTo(self.contentView);
    make.width.height.mas_equalTo(25);
  }];
  // 支出
  [self.outComeCateTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(self.categoryButton);
    make.leading.equalTo(self.categoryButton.mas_trailing).offset(10);
  }];
  [self.outComeNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.outComeCateTitleLabel);
    make.leading.equalTo(self.outComeCateTitleLabel.mas_trailing).offset(5);
  }];
  [self.outComeRemarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.outComeCateTitleLabel.mas_bottom).offset(5);
    make.leading.equalTo(self.outComeCateTitleLabel);
    make.trailing.equalTo(self.contentView).offset(-10);
  }];
  
  // 收入
  [self.inComeCateTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(self.categoryButton);
    make.trailing.equalTo(self.categoryButton.mas_leading).offset(-10);
  }];
  [self.inComeNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.inComeCateTitleLabel);
    make.trailing.equalTo(self.inComeCateTitleLabel.mas_leading).offset(-5);
  }];
  [self.inComeRemarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.inComeCateTitleLabel.mas_bottom).offset(5);
    make.trailing.equalTo(self.inComeCateTitleLabel);
    make.leading.equalTo(self.contentView).offset(10);
  }];
}

- (void)setBill:(MPBillModel *)bill
{
  _bill = bill;
  [self.categoryButton setImage:[UIImage imageNamed:bill.category.categoryImageFileName] forState:UIControlStateNormal];
  self.outComeCateTitleLabel.text = bill.category.categoryName;
  self.outComeNumLabel.text = [NSString stringWithFormat:@"%.02lf", bill.money];
  self.outComeRemarkLabel.text = bill.remark;
  self.inComeCateTitleLabel.text = bill.category.categoryName;
  self.inComeNumLabel.text = [NSString stringWithFormat:@"%.02lf", bill.money];
  self.inComeRemarkLabel.text = bill.remark;
}

#pragma mark - getter
- (UIButton *)categoryButton
{
  if(_categoryButton == nil)
  {
    UIButton *button = [[UIButton alloc] init];
    _categoryButton = button;
    [self.contentView addSubview:button];
  }
  return _categoryButton;
}

- (UILabel *)outComeNumLabel
{
  if(_outComeNumLabel == nil)
  {
    UILabel *label = [[UILabel alloc] init];
    _outComeNumLabel = label;
    [self.contentView addSubview:label];
  }
  return _outComeNumLabel;
}

- (UILabel *)outComeCateTitleLabel
{
  if(_outComeCateTitleLabel == nil)
  {
    UILabel *label = [[UILabel alloc] init];
    _outComeCateTitleLabel = label;
    [self.contentView addSubview:label];
  }
  return _outComeCateTitleLabel;
}

- (UILabel *)outComeRemarkLabel
{
  if(_outComeRemarkLabel == nil)
  {
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 2;
    _outComeRemarkLabel = label;
    [self.contentView addSubview:label];
  }
  return _outComeRemarkLabel;
}

- (UILabel *)inComeNumLabel
{
  if(_inComeNumLabel == nil)
  {
    UILabel *label = [[UILabel alloc] init];
    _inComeNumLabel = label;
    [self.contentView addSubview:label];
  }
  return _inComeNumLabel;
}

- (UILabel *)inComeCateTitleLabel
{
  if(_inComeCateTitleLabel == nil)
  {
    UILabel *label = [[UILabel alloc] init];
    _inComeCateTitleLabel = label;
    [self.contentView addSubview:label];
  }
  return _inComeCateTitleLabel;
}

- (UILabel *)inComeRemarkLabel
{
  if(_inComeRemarkLabel == nil)
  {
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentRight;
    label.numberOfLines = 2;
    _inComeRemarkLabel = label;
    [self.contentView addSubview:label];
  }
  return _inComeRemarkLabel;
}


@end
