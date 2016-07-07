
//
//  CountDown.m
//  倒计时
//
//  Created by Maker on 16/7/5.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "CountDown.h"

@interface CountDown ()
@property(nonatomic,retain) dispatch_source_t timer;
@property(nonatomic,retain) NSDateFormatter *dateFormatter;

@end

@implementation CountDown
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dateFormatter=[[NSDateFormatter alloc] init];
        [self.dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
          NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
         [self.dateFormatter setTimeZone:localTimeZone];
    }
    return self;
}

-(void)countDownWithStratDate:(NSDate *)startDate finishDate:(NSDate *)finishDate completeBlock:(void (^)(NSInteger day,NSInteger hour,NSInteger minute,NSInteger second))completeBlock{
    if (_timer==nil) {
        
        NSTimeInterval timeInterval =[finishDate timeIntervalSinceDate:startDate];
        __block int timeout = timeInterval; //倒计时时间
        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    _timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completeBlock(0,0,0,0);
                    });
                }else{
                    int days = (int)(timeout/(3600*24));
                    int hours = (int)((timeout-days*24*3600)/3600);
                    int minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    int second = timeout-days*24*3600-hours*3600-minute*60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completeBlock(days,hours,minute,second);
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
        }
    }
}
-(void)countDownWithPER_SECBlock:(void (^)())PER_SECBlock{
    if (_timer==nil) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    PER_SECBlock();
                });
            });
            dispatch_resume(_timer);
    }
}
-(NSDate *)dateWithLongLong:(long long)longlongValue{
    long long value = longlongValue/1000;
    NSNumber *time = [NSNumber numberWithLongLong:value];
    //转换成NSTimeInterval
    NSTimeInterval nsTimeInterval = [time longValue];
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:nsTimeInterval];
    return date;
}
-(void)countDownWithStratTimeStamp:(long long)starTimeStamp finishTimeStamp:(long long)finishTimeStamp completeBlock:(void (^)(NSInteger day,NSInteger hour,NSInteger minute,NSInteger second))completeBlock{
    if (_timer==nil) {
        
        NSDate *finishDate = [self dateWithLongLong:finishTimeStamp];
        NSDate *startDate  = [self dateWithLongLong:starTimeStamp];
        NSTimeInterval timeInterval =[finishDate timeIntervalSinceDate:startDate];
        __block int timeout = timeInterval; //倒计时时间
        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    _timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completeBlock(0,0,0,0);
                    });
                }else{
                    int days = (int)(timeout/(3600*24));
                    int hours = (int)((timeout-days*24*3600)/3600);
                    int minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    int second = timeout-days*24*3600-hours*3600-minute*60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completeBlock(days,hours,minute,second);
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
        }
    }
}
/**
 *  获取当天的年月日的字符串
 *  @return 格式为年-月-日
 */
-(NSString *)getNowyyyymmdd{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatDay = [[NSDateFormatter alloc] init];
    formatDay.dateFormat = @"yyyy-MM-dd";
    NSString *dayStr = [formatDay stringFromDate:now];
    
    return dayStr;
    
}
/**
 *  主动销毁定时器
 *  @return 格式为年-月-日
 */
-(void)destoryTimer{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

-(void)dealloc{
    NSLog(@"%s dealloc",object_getClassName(self));
    
}
@end
