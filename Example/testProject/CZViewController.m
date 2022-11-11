//
//  CZViewController.m
//  testProject
//
//  Created by chaozhi.he on 11/11/2022.
//  Copyright (c) 2022 chaozhi.he. All rights reserved.
//

#import "CZViewController.h"
#import "BRDatePickerView.h"
#define kThemeColor BR_RGB_HEX(0x2e70c2, 1.0f)

typedef NS_ENUM(NSInteger, BRTimeType) {
    BRTimeTypeBeginTime = 0,
    BRTimeTypeEndTime
};

@interface CZViewController ()
@property (nonatomic, strong) BRDatePickerView *datePickerView;

@property (nonatomic, strong) NSDate *beginSelectDate;
@property (nonatomic, strong) NSDate *endSelectDate;
@property (nonatomic, strong) UITextField *beginTimeTF;
@property (nonatomic, strong) UITextField *endTimeTF;
@property (nonatomic, strong) UIView *beginTimeLineView;
@property (nonatomic, strong) UIView *endTimeLineView;
@property (nonatomic, strong) NSDate *birthdaySelectDate;
@end

@implementation CZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 设置开始时间默认选择的值及状态
    self.beginSelectDate = [NSDate date];
    self.beginTimeTF.text = [NSDate br_stringFromDate:self.beginSelectDate dateFormat:@"yyyy-MM-dd HH"];
    self.beginTimeTF.textColor = kThemeColor;
    self.beginTimeLineView.backgroundColor = kThemeColor;
    // 设置选择器滚动到指定的日期
    self.datePickerView.selectDate = self.beginSelectDate;
    
    
    
    
    
    
    // 出生年月日
    BRDatePickerView *datePickerView = [[BRDatePickerView alloc]init];
    datePickerView.pickerMode = BRDatePickerModeYMD;
    datePickerView.title = @"请选择年月日";
    datePickerView.selectDate = self.birthdaySelectDate;
    datePickerView.minDate = [NSDate br_setYear:2018 month:3 day:10];
    datePickerView.maxDate = [NSDate br_setYear:2025 month:10 day:20];
    datePickerView.isAutoSelect = YES;
    //datePickerView.monthNames = @[@"一月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月", @"九月", @"十月", @"十一月", @"十二月"];
    //datePickerView.customUnit = @{@"year": @"Y", @"month": @"M", @"day": @"D", @"hour": @"H", @"minute": @"M", @"second": @"S"};
    // 指定不可选择的日期
    //datePickerView.nonSelectableDates = @[[NSDate br_setYear:2020 month:8 day:1], [NSDate br_setYear:2020 month:9 day:10]];
    datePickerView.keyView = self.view; // 将组件 datePickerView 添加到 self.view 上，默认是添加到 keyWindow 上
    datePickerView.resultBlock = ^(NSDate *selectDate, NSString *selectValue) {
        self.birthdaySelectDate = selectDate;
//        self.infoModel.birthdayStr = selectValue;
//        textField.text = selectValue;
        
        NSLog(@"selectValue=%@", selectValue);
        NSLog(@"selectDate=%@", selectDate);
        NSLog(@"---------------------------------");
        
    };
    
    datePickerView.resultRangeBlock = ^(NSDate * _Nullable selectStartDate, NSDate * _Nullable selectEndDate, NSString * _Nullable selectValue) {
        NSLog(@"selectValue=%@", selectValue);
        NSLog(@"selectStartDate=%@", selectStartDate);
        NSLog(@"selectStartDate=%@", selectEndDate);
        NSLog(@"---------------------------------");
    };
    
    // 设置年份背景
    UILabel *yearLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 44, self.view.bounds.size.width, 216)];
    yearLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    yearLabel.backgroundColor = [UIColor clearColor];
    yearLabel.textAlignment = NSTextAlignmentCenter;
    yearLabel.textColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2f];
    yearLabel.font = [UIFont boldSystemFontOfSize:100.0f];
    NSString *yearString = self.birthdaySelectDate ? @(self.birthdaySelectDate.br_year).stringValue : @([NSDate date].br_year).stringValue;
//    if (self.infoModel.birthdayStr && [self.infoModel.birthdayStr containsString:@"自定义"]) {
//        yearString = @"";
//    }
    yearLabel.text = yearString;
    [datePickerView.alertView addSubview:yearLabel];
    // 滚动选择器，动态更新年份
    datePickerView.changeBlock = ^(NSDate * _Nullable selectDate, NSString * _Nullable selectValue) {
        yearLabel.text = selectDate ? @(selectDate.br_year).stringValue : @"";
    };
    
    BRPickerStyle *customStyle = [[BRPickerStyle alloc]init];
    customStyle.pickerColor = [UIColor clearColor];
    customStyle.separatorColor = [UIColor clearColor];
    customStyle.selectRowTextColor = [UIColor blueColor];
//            customStyle.selectRowColor = [UIColor yellowColor];
    datePickerView.pickerStyle = customStyle;
    
    [datePickerView show];

}



}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
