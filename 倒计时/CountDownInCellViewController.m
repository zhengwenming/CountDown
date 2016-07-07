//
//  CountDownInCellViewController.m
//  倒计时
//
//  Created by Maker on 16/7/6.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "CountDownInCellViewController.h"
#import "CountDown.h"
#import "CountDownCell.h"

@interface CountDownInCellViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *dataSource;//时间数组
}
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic)  CountDown *countDown;

@end

@implementation CountDownInCellViewController
-(void)updateTimeInVisibleCells{
    NSArray  *cells = self.table.visibleCells; //取出屏幕可见ceLl
    for (CountDownCell *cell in cells) {
        cell.countDownLabel.text = [self getNowTimeWithString:dataSource[cell.tag]];
        if ([cell.countDownLabel.text isEqualToString:@"活动已经结束！"]) {
            cell.countDownLabel.textColor = [UIColor redColor];
        }else{
            cell.countDownLabel.textColor = [UIColor orangeColor];
        }
    }
}
-(NSString *)getNowTimeWithString:(NSString *)aTimeString{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* fireDate = [formater dateFromString:aTimeString];
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *d = [calendar components:unitFlags fromDate:today toDate:fireDate options:0];//计算时间差
    long hour = [d day] *24 + [d hour];
    NSString *seconds;
    NSString *minutes;
    NSString *hours;
    if([d second]<10)
        seconds = [NSString stringWithFormat:@"%ld",[d second]];
    else
        seconds = [NSString stringWithFormat:@"%ld",[d second]];
    if([d minute]<10)
        minutes = [NSString stringWithFormat:@"%ld",[d minute]];
    else
        minutes = [NSString stringWithFormat:@"%ld",[d minute]];
    if(hour < 10)
        hours = [NSString stringWithFormat:@"%ld", hour];
    else
        hours = [NSString stringWithFormat:@"%ld",hour];
    if (hour<=0||minutes<=0||seconds<=0) {
        return @"活动已经结束！";
    }
    return [NSString stringWithFormat:@"%@小时 %@分 %@秒", hours, minutes,seconds];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"cell中倒计时";
    dataSource = @[@"2016-07-06 20:23:10",@"2016-07-07 17:23:20",@"2016-07-08 13:23:30",@"2016-07-09 22:23:40",@"2016-07-10 18:23:50",@"2016-07-11 20:23:12",@"2016-07-12 10:23:22",@"2016-07-13 19:23:32",@"2016-07-14 22:23:42",@"2016-07-15 11:23:52",@"2016-07-16 20:23:26",@"2016-07-17 15:23:20",@"2016-07-18 12:23:18",@"2016-07-19 22:23:28",@"2016-07-22 19:23:33",@"2016-07-21 20:23:55",@"2016-07-22 21:20:21",@"2016-07-23 16:23:11",@"2016-07-24 22:23:49",@"2016-07-25 14:23:43",@"2016-07-26 14:23:14",@"2016-07-27 14:23:41",@"2016-07-28 14:23:46",@"2016-07-29 14:23:23",@"2016-07-30 14:23:43",@"2016-08-01 14:23:45",@"2016-08-02 14:23:22",@"2016-08-03 14:23:40",];
    self.countDown = [[CountDown alloc] init];
    __weak __typeof(self) weakSelf= self;
    ///每秒回调一次
    [self.countDown countDownWithPER_SECBlock:^{
        NSLog(@"6");
        [weakSelf updateTimeInVisibleCells];
    }];
    [_table registerNib:[UINib nibWithNibName:@"CountDownCell" bundle:nil] forCellReuseIdentifier:@"CountDownCell"];
    _table.tableFooterView = [UIView new];//去除table下面多余的分割线
    _table.rowHeight = 100;//固定行高最好用这个属性，提高效率，不用走代理方法询问每个row多高
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CountDownCell *cell = (CountDownCell *)[tableView dequeueReusableCellWithIdentifier:@"CountDownCell"];
    cell.timeLabel.text = [NSString stringWithFormat:@"活动 %@ 结束",dataSource[indexPath.row]];
    cell.timeLabel.adjustsFontSizeToFitWidth = YES;
    cell.countDownLabel.text = [self getNowTimeWithString:dataSource[indexPath.row]];
    if ([cell.countDownLabel.text isEqualToString:@"活动已经结束！"]) {
        cell.countDownLabel.textColor = [UIColor redColor];
    }else{
        cell.countDownLabel.textColor = [UIColor orangeColor];
    }
    cell.tag = indexPath.row;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)dealloc{
    NSLog(@"%s dealloc",object_getClassName(self));
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
