//
//  CountDownViewController.m
//  倒计时
//
//  Created by Maker on 16/7/5.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "CountDownViewController.h"
#import "Masonry.h"
#import "UIView+ArrangeSubview.h"
#import "CountDown.h"

@interface CountDownViewController ()

@property (strong, nonatomic)  UILabel *dayLabel;
@property (strong, nonatomic)  UILabel *hourLabel;
@property (strong, nonatomic)  UILabel *minuteLabel;
@property (strong, nonatomic)  UILabel *secondLabel;
@property (strong, nonatomic)  UIView *contentView;
@property (strong, nonatomic)  UIButton *timeBtn;
@property (strong, nonatomic)  CountDown *countDownForBtn;

@property (strong, nonatomic)  CountDown *countDownForLabel;
@end

@implementation CountDownViewController

/**
 *  获取当天的年月日的字符串
 *  这里测试用
 *  @return 格式为年-月-日
 */
-(NSString *)getyyyymmdd{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatDay = [[NSDateFormatter alloc] init];
    formatDay.dateFormat = @"yyyy-MM-dd";
    NSString *dayStr = [formatDay stringFromDate:now];
    
    return dayStr;
    
}
///布局UI
-(void)initUI{
    CGFloat label_width = 40;
    CGFloat label_Height = 40;

    self.contentView = [UIView new];
    self.contentView.backgroundColor = [UIColor magentaColor];
    [self.view addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(4*label_width, label_Height));
        make.center.equalTo(self.view);
    }];
    
    self.dayLabel = [UILabel new];
    self.dayLabel.textAlignment = NSTextAlignmentCenter;
    self.dayLabel.backgroundColor = [UIColor cyanColor];
    self.dayLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.dayLabel];
    
    
    self.hourLabel = [UILabel new];
    self.hourLabel.textAlignment = NSTextAlignmentCenter;
    self.hourLabel.font = [UIFont systemFontOfSize:15];
    self.hourLabel.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:self.hourLabel];
    
    
    self.minuteLabel = [UILabel new];
    self.minuteLabel.textAlignment = NSTextAlignmentCenter;
    self.minuteLabel.font = [UIFont systemFontOfSize:15];
    self.minuteLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.minuteLabel];
    
    
    self.secondLabel = [UILabel new];
    self.secondLabel.textAlignment = NSTextAlignmentCenter;
    self.secondLabel.font = [UIFont systemFontOfSize:15];
    self.secondLabel.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:self.secondLabel];
    
    
    [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@[self.hourLabel,self.minuteLabel,self.secondLabel]);
        make.top.equalTo(self.contentView);
        make.width.mas_equalTo(label_width);
        make.height.equalTo(self.contentView);
        
    }];
    [self.hourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.dayLabel);
    }];
    [self.minuteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.dayLabel);
    }];
    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.dayLabel);
    }];
    
   [self.contentView arrangeSubviewWithSpacingHorizontally:@[self.dayLabel,self.hourLabel,self.minuteLabel,self.secondLabel]];
    
    
    
    self.timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.timeBtn.backgroundColor = [UIColor redColor];
    [self.timeBtn setTitle:@"点击获取验证码" forState:UIControlStateNormal];

    [self.timeBtn addTarget:self action:@selector(fetchCoder:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.timeBtn];
    
    [self.timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView.mas_top).offset(-40);
    }];
    
    
    UIButton *nextPageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextPageBtn.backgroundColor = [UIColor redColor];
    [nextPageBtn setTitle:@"push到下一页" forState:UIControlStateNormal];
    
    [nextPageBtn addTarget:self action:@selector(nextPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextPageBtn];
    
    [nextPageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.timeBtn);
        make.left.mas_equalTo(self.timeBtn);
        make.bottom.mas_equalTo(self.timeBtn.mas_top).offset(-40);
    }];
    
}
-(void)nextPage:(UIButton *)sender{
    UIViewController *aVC = [[UIViewController alloc]init];
    aVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:aVC animated:YES];
}
-(void)fetchCoder:(UIButton *)sender{
    //    60s的倒计时
    NSTimeInterval aMinutes = 60;
    
    //    1个小时的倒计时
    //    NSTimeInterval anHour = 60*60;
    
    //     1天的倒计时
    //    NSTimeInterval aDay = 24*60*60;
    [self startWithStartDate:[NSDate date] finishDate:[NSDate dateWithTimeIntervalSinceNow:aMinutes]];
}
#pragma mark 
#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.view.backgroundColor = [UIColor whiteColor];
    

    _countDownForLabel = [[CountDown alloc] init];
    _countDownForBtn = [[CountDown alloc] init];

   ///方法一倒计时测试
    long long startLongLong = 1467713971000;
    long long finishLongLong = 1467714322000;
    [self startLongLongStartStamp:startLongLong longlongFinishStamp:finishLongLong];
    

    

    
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* startDate = [formater dateFromString:@"2015-12-31 19:23:20"];
    NSDate* finishDate = [formater dateFromString:@"2015-12-31 19:24:20"];
//    [self startWithStartDate:startDate finishDate:finishDate];
}
-(void)refreshUIDay:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second{
    if (day==0) {
        self.dayLabel.text = @"0天";
    }else{
        self.dayLabel.text = [NSString stringWithFormat:@"%ld天",(long)day];
    }
    if (hour<10&&hour) {
        self.hourLabel.text = [NSString stringWithFormat:@"0%ld小时",(long)hour];
    }else{
        self.hourLabel.text = [NSString stringWithFormat:@"%ld小时",(long)hour];
    }
    if (minute<10) {
        self.minuteLabel.text = [NSString stringWithFormat:@"0%ld分",(long)minute];
    }else{
        self.minuteLabel.text = [NSString stringWithFormat:@"%ld分",(long)minute];
    }
    if (second<10) {
        self.secondLabel.text = [NSString stringWithFormat:@"0%ld秒",(long)second];
    }else{
        self.secondLabel.text = [NSString stringWithFormat:@"%ld秒",(long)second];
    }
}
///此方法用两个时间戳做参数进行倒计时
-(void)startLongLongStartStamp:(long long)strtLL longlongFinishStamp:(long long)finishLL{
    __weak __typeof(self) weakSelf= self;

    [_countDownForLabel countDownWithStratTimeStamp:strtLL finishTimeStamp:finishLL completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
        NSLog(@"666");
        [weakSelf refreshUIDay:day hour:hour minute:minute second:second];
    }];
}
//此方法用两个NSDate对象做参数进行倒计时
-(void)startWithStartDate:(NSDate *)strtDate finishDate:(NSDate *)finishDate{
    __weak __typeof(self) weakSelf= self;

    [_countDownForBtn countDownWithStratDate:strtDate finishDate:finishDate completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
        NSLog(@"second = %li",second);
        NSInteger totoalSecond =day*24*60*60+hour*60*60 + minute*60+second;
        if (totoalSecond==0) {
            weakSelf.timeBtn.enabled = YES;
            [weakSelf.timeBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        }else{
            weakSelf.timeBtn.enabled = NO;
            [weakSelf.timeBtn setTitle:[NSString stringWithFormat:@"%lis后重新获取",totoalSecond] forState:UIControlStateNormal];
        }
        
        }];
}


-(void)dealloc{
    [_countDownForLabel destoryTimer];
    [_countDownForBtn destoryTimer];
    NSLog(@"%s dealloc",object_getClassName(self));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
